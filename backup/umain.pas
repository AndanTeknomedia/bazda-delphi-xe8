unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls, ActnList,
  ImgList, JvComponentBase, JvTrayIcon, DB,
  Menus, GridsEh, DBGridEh, MemDS,
  VirtualTable, MemTableDataEh, MemTableEh, StdCtrls, ExtCtrls, uExpMod,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, System.ImageList,
  System.Actions, EhLibVCL, DBAxisGridsEh, DBAccess, Uni, UniProvider,
  PostgreSQLUniProvider;

type
  {
  TConnectionProperties = record
    HostName,
    UserName,
    Password,
    Database: String[75];
    Port: Word;
  end;
  }
  TConnectionProperties = TConProps;
  TFMain = class(TForm)
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    ImageList1: TImageList;
    acBackup: TAction;
    acRestore: TAction;
    acHapus: TAction;
    acExport: TAction;
    acSetting: TAction;
    acExit: TAction;
    acGoToTray: TAction;
    acReLoad: TAction;
    jti: TJvTrayIcon;
    PopupMenu1: TPopupMenu;
    ShowForm1: TMenuItem;
    acRestoreFromTray: TAction;
    Backup1: TMenuItem;
    Pengaturan1: TMenuItem;
    N1: TMenuItem;
    Keluar1: TMenuItem;
    DBG: TDBGridEh;
    vt: TVirtualTable;
    DataSource1: TDataSource;
    Label1: TLabel;
    Timer1: TTimer;
    Label3: TLabel;
    Label2: TLabel;
    vtID: TIntegerField;
    vtTanggal: TDateField;
    vtBackup: TStringField;
    vtStatus: TStringField;
    PopupMenu2: TPopupMenu;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    Hapus1: TMenuItem;
    N2: TMenuItem;
    ZCon: TUniConnection;
    UniQuery1: TUniQuery;
    PostgreSQLUniProvider1: TPostgreSQLUniProvider;
    procedure acExitExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acRestoreFromTrayExecute(Sender: TObject);
    procedure acSettingExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure acBackupExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure acRestoreExecute(Sender: TObject);
    procedure acHapusExecute(Sender: TObject);
    procedure acReLoadExecute(Sender: TObject);
  private
    { Private declarations }
    SavedDate : TDate;
    procedure GotoTray(const Trayed: Boolean = False);
    procedure OnRead(AText: String);
    procedure CreateCOnfigFile;
  public
    { Public declarations }
    ConfigFile:String;
    ConfigData: TStringList;
    BackupListFile: STring;
    DatabaseName: String;
    _backupTime: TTime;
    TodaysDone: Boolean;
    function ExpandConstant(const AConstantedString: STring):String;
    function TestConnection(const ConProp: TConnectionProperties): Boolean;
  end;

var
  FMain: TFMain;

implementation

uses ubackupSettings;

{$R *.dfm}

procedure TFMain.acBackupExecute(Sender: TObject);
var
  backupName,
  backupStatus : string;
  Backupdate   : TDate;
  cp: TConnectionProperties;
  BackupFile, stes  : String;
  i:integer;
  function BuildSPref(const idx: Integer): string;
  begin
    Result := IntToStr(idx);
    while length(Result) < 4 do Result :='0'+ Result;

  end;
begin
  i:=1;
  with ConfigData do
  begin
    backupFile := Trim(Values['BackupDir'])+'\'+ExpandConstant(Trim(Values['BackupNameFormat']));
    stes   := BackupFile + '.' + BuildSPref(i);
    while FileExists(stes) do
    begin
      inc(i);
      stes := BackupFile + '.' + BuildSPref(i);
    end;
    backupFile := stes;
    cp := CreateConProp(
                        Trim(Values['Host']),
                        Trim(Values['User']),
                        Trim(Values['Pass']),
                        Trim(Values['DB']),
                        StrToInt(Trim(Values['Port']))
                       );
  end;
  Timer1.Enabled := False;
  Label2.Caption := 'Backing up '+ BackupFile+'...';
  try
    DoBackup(cp, backupFile);
    if FileExists(BackupFile) then
      backupStatus := 'Success'
    else
      backupStatus := 'Fail';
    Backupdate := Date;
    backupName := BackupFile;
    if not vt.Active then
    begin
      vt.Open;
      vt.LoadFromFile(BackupListFile);
    end;
    vt.Append;
    vt.FieldByName('ID').AsInteger := i;
    vt.FieldByName('Tanggal').AsDateTime := Backupdate;
    vt.FieldByName('Backup').AsString := backupName;
    vt.FieldByName('Status').AsString := backupStatus;
    try
      vt.Post;
    except
    end;
  finally
    Label2.Caption := 'Idle.';
    Timer1.Enabled := True;
    Refresh;
  end;
end;

procedure TFMain.acExitExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFMain.acHapusExecute(Sender: TObject);
var
  src: String;
begin
  if vt.IsEmpty then exit;
  if MessageBox(Handle, 'Anda yakin menghapus backup ini?'#13, 'Konfirmasi', MB_YESNO or MB_ICONWARNING) = ID_NO then
    exit;
  Src := vt.FieldByName('Backup').AsString;
  vt.Delete;
  if not FileExists(Src) then
  begin
    MessageBox(Handle, PChar('Maaf, file '+ Src+' tidak ditemukan. Mungkin sudah dihapus.'), 'Error', MB_ICONHAND);
    exit;
  end;
  DeleteFile(src);
end;

procedure TFMain.acReLoadExecute(Sender: TObject);
begin
  vt.Close;
  vt.Open;
  vt.LoadFromFile(BackupListFile);
end;

procedure TFMain.acRestoreExecute(Sender: TObject);
var
  Src: String;
  cp: TConnectionProperties;
begin
  if vt.IsEmpty then exit;
  if MessageBox(Handle, 'Anda yakin merestore database ini?'#13'Database yang sudah ada AKAN DIHAPUS!!!'#13'Lanjutkan?', 'Konfirmasi', MB_YESNO or MB_ICONWARNING) = ID_NO then
    exit;
  Src := vt.FieldByName('Backup').AsString;
  if not FileExists(Src) then
  begin
    MessageBox(Handle, PChar('Maaf, file '+ Src+' tidak ditemukan. Mungkin sudah dihapus.'), 'Error', MB_ICONHAND);
    exit;
  end;
  with ConfigData do
  begin
    cp := CreateConProp(
            Trim(Values['Host']),
            Trim(Values['User']),
            Trim(Values['Pass']),
            Trim(Values['DB']),
            StrToInt(Trim(Values['Port']))
          );
  end;
  label2.Caption := 'Restoring '+ Src+'...';
  Application.ProcessMessages;
  Refresh;
  Timer1.Enabled := False;
  try
    DoRestore(cp, Src);
  finally
    Label2.Caption := 'Idle.';
    Refresh;
    Timer1.Enabled := True;
  end;
  Application.ProcessMessages;
end;

procedure TFMain.acRestoreFromTrayExecute(Sender: TObject);
begin
  GotoTray(False);
end;

procedure TFMain.acSettingExecute(Sender: TObject);
begin
  FBackupSettings := TFBackupSettings.Create(Application);
  FBackupSettings.ShowModal;
  FBackupSettings.Free;
end;

procedure TFMain.CreateCOnfigFile;
var
  s: String;
begin
  s:= ExtractFileDir(ParamStr(0))+'\Backups';
  if not DirectoryExists(s ) then
    ForceDirectories(s);
  ConfigData := TStringList.Create;
  ConfigData.NameValueSeparator := ':';
  if not FileExists(ConfigFile) then
  begin
    with ConfigData do
    begin
      Add('MIT POSTGRE DATABASE AUTO BACKUP');
      Add('');
      Add('Connection Settings: ');
      Add('Host: localhost');
      Add('Port: 5432');
      Add('User: Postgre');
      Add('Pass: unknown');
      Add('DB: postgres');
      Add('');
      Add('Backup Settings: ');
      Add('BackupDir: '+ s);
      Add('BackupNameFormat: '+__DEFAULT_BACKUP_NAME_FORMAT);
      add('BackupTime: '+ __DEFAULT_BACKUP_TIME);
      SaveToFile(ConfigFile);
      Clear;
    end;
  end;
  ConfigData.LoadFromFile(ConfigFile);
end;

function TFMain.ExpandConstant(const AConstantedString: STring): String;
begin
  Result := StringReplace(AConstantedString, '%db%',    DatabaseName, [rfReplaceAll , rfIgnoreCase]);
  Result := StringReplace(Result, '%year%',  FormatDateTime('yyyy', Date), [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '%month%', FormatDateTime('MM', Date)  , [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '%date%',  FormatDateTime('dd', Date)  , [rfReplaceAll, rfIgnoreCase]);
end;

procedure TFMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caNone;
  GotoTray(True);
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  ConfigFile := ChangeFileExt(Application.ExeName, '.settings');
  BackupListFile := ExtractFilePath(Application.ExeName)+'Data1.vtd';
  CreateCOnfigFile;
  _backupTime := StrToTime(Trim(ConfigData.Values['BackupTime']));
  if not vt.Active then
    vt.Open;
  if not FileExists(BackupListFile) then
    vt.SaveToFile(BackupListFile)
  else
    vt.LoadFromFile(BackupListFile);
  TodaysDone := False;
  SavedDate  := Date -1 ;
  Timer1.Enabled := True;
end;

procedure TFMain.FormDestroy(Sender: TObject);
begin
  ConfigData.Free;
  vt.SaveToFile(BackupListFile);
end;

procedure TFMain.GotoTray(const Trayed: Boolean);
begin
  jti.Active  := Trayed;
  jti.ApplicationVisible
              := not Trayed;
end;

procedure TFMain.OnRead(AText: String);
begin

end;

function TFMain.TestConnection(const ConProp: TConnectionProperties): Boolean;
begin
  if ZCon.Connected then ZCon.Disconnect;
  Result := False;
  ZCon.Server := ConProp.Host;
  ZCon.Port     := ConProp.Port;
  ZCon.Username     := ConProp.User;
  ZCon.Password := ConProp.Password;
  ZCon.Database := ConProp.Database;
  try
    ZCon.Connect;
    Result:= ZCon.Connected;
    ZCon.Disconnect;
  except
    Result := False;
  end;
end;

procedure TFMain.Timer1Timer(Sender: TObject);
begin
  Label3.Caption := TimeToStr(_backupTime);
  if SavedDate >= Date then exit;
  if FormatDateTime('hh:nn',Time) = FormatDateTime('hh:nn',_backupTime) then
  begin
    SavedDate := Date;
    acBackup.Execute;
  end;
end;

end.
