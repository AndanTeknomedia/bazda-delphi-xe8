unit ubackupSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, JvExMask, JvSpin, StdCtrls, ActnList,
  PlatformDefaultStyleActnCtrls, ActnMan, JvExControls, JvXPCore, JvXPButtons,
  ExtCtrls, AdvPageControl, ComCtrls, umain, FileCtrl, DBAccess, UNI,
  System.Actions;

type
  TFBackupSettings = class(TForm)
    AdvPageControl1: TAdvPageControl;
    AdvTabSheet1: TAdvTabSheet;
    AdvTabSheet2: TAdvTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edDir: TLabeledEdit;
    JvXPButton1: TJvXPButton;
    Tmedit: TJvTimeEdit;
    edFormat: TLabeledEdit;
    JvXPButton2: TJvXPButton;
    ActionManager1: TActionManager;
    acBrowse: TAction;
    acResetFormat: TAction;
    Action3: TAction;
    eHost: TLabeledEdit;
    eUser: TLabeledEdit;
    ePassword: TLabeledEdit;
    ePort: TLabeledEdit;
    eDatabase: TLabeledEdit;
    JvXPButton3: TJvXPButton;
    JvXPButton4: TJvXPButton;
    JvXPButton5: TJvXPButton;
    procedure FormCreate(Sender: TObject);
    procedure edFormatChange(Sender: TObject);
    procedure acResetFormatExecute(Sender: TObject);
    procedure JvXPButton3Click(Sender: TObject);
    procedure JvXPButton4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acBrowseExecute(Sender: TObject);
    procedure JvXPButton5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FBackupSettings: TFBackupSettings;

const
  __DEFAULT_BACKUP_NAME_FORMAT = 'Postgre_%db%_backup_%year%-%month%-%date%';
  __DEFAULT_BACKUP_TIME        =  '00:00';

function CreateConProp(const HostName, UserName, Password, Database: String; const Port: Word): TConnectionProperties; overload;
function CreateConProp(const Connection: TUniConnection): TConnectionProperties; overload;


implementation


{$R *.dfm}

var
  OK: Boolean;

function CreateConProp(const HostName, UserName, Password, Database: String; const Port: Word): TConnectionProperties; overload;
begin
  Result.Host     := HostName;
  Result.User     := UserName;
  Result.Password := Password;
  Result.Database := Database;
  Result.Port     := Port;
end;

function CreateConProp(const Connection: TUniConnection): TConnectionProperties; overload;
begin
  with Connection do
  begin
    Result.Host     := Server;
    Result.User     := Username;
    Result.Password := Password;
    Result.Database := Database;
    Result.Port     := Port;
  end;
end;


procedure TFBackupSettings.acBrowseExecute(Sender: TObject);
var
  s: String;
begin
  if SelectDirectory('Select Backup Directory', '', s, [sdNewFolder, sdNewUI], Self) then
    edDir.Text := s;
end;

procedure TFBackupSettings.acResetFormatExecute(Sender: TObject);
begin
  edFormat.Text := __DEFAULT_BACKUP_NAME_FORMAT;
  edFormatChange(edFormat);
end;

procedure TFBackupSettings.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
end;

procedure TFBackupSettings.FormCreate(Sender: TObject);
begin
  DoubleBuffered := True;
  acResetFormat.Execute;
  eHost.Text := Trim(FMain.ConfigData.Values['Host']);
  ePort.Text := Trim(FMain.ConfigData.Values['Port']);
  eUser.Text := Trim(FMain.ConfigData.Values['User']);
  ePassword.Text := Trim(FMain.ConfigData.Values['Pass']);
  eDatabase.Text := Trim(FMain.ConfigData.Values['DB']);
  edDir.Text     := Trim(FMain.ConfigData.Values['BackupDir']);
  Tmedit.Time    := StrToTime(Trim(FMain.ConfigData.Values['BackupTime']));
  edFormat.Text  := Trim(FMain.ConfigData.Values['BackupNameFormat']);
end;

procedure TFBackupSettings.JvXPButton3Click(Sender: TObject);
var
  cp: TConnectionProperties;
begin
  cp := CreateConProp(eHost.Text, eUser.Text, ePassword.Text, eDatabase.Text, StrToInt(ePort.Text));
  OK := FMain.TestConnection(cp);
  if not OK then
  begin
    MessageBox(Handle, 'Maaf. Tidak dapat terkoneksi.','Error', MB_ICONHAND);
    exit;
  end
  else
  begin
    MessageBox(Handle, 'Koneksi berhasil.','Information', MB_ICONINFORMATION or MB_OK);
  end;
end;

procedure TFBackupSettings.JvXPButton4Click(Sender: TObject);
var
  cp: TConnectionProperties;
begin
  cp := CreateConProp(eHost.Text, eUser.Text, ePassword.Text, eDatabase.Text, StrToInt(ePort.Text));
  FMain.ConfigData.Values['Host']:= cp.Host;
  FMain.ConfigData.Values['Port']:= IntToStr(cp.Port);
  FMain.ConfigData.Values['User']:= cp.User;
  FMain.ConfigData.Values['Pass']:= cp.Password;
  FMain.ConfigData.Values['DB']  := cp.Database;
  FMain.ConfigData.Values['BackupDir']:= edDir.Text;
  if not DirectoryExists(edDir.Text) then
    ForceDirectories(edDir.Text);
  FMain.ConfigData.Values['BackupNameFormat']:= edFormat.Text;
  FMain.ConfigData.Values['BackupTime']  := TimeToStr( Tmedit.Time );
  FMain.ConfigData.SaveToFile(FMain.ConfigFile);
  FMain.ConfigData.Clear;
  FMain.ConfigData.LoadFromFile(FMain.ConfigFile);
  FMain._backupTime := StrToTime(trim(FMain.ConfigData.Values['BackupTime']));
  MessageBox(Handle, 'Settings saved.','Information', MB_ICONINFORMATION or MB_OK);
  Close;
end;

procedure TFBackupSettings.JvXPButton5Click(Sender: TObject);
begin
  Close;
end;

procedure TFBackupSettings.edFormatChange(Sender: TObject);
begin
  Label2.Caption := FMain.ExpandConstant(edFormat.Text);
end;

end.
