unit u_backup_settings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, u_utils, StdCtrls, ExtCtrls, ComCtrls, Mask, JvExMask,
  JvToolEdit, ActnList, PlatformDefaultStyleActnCtrls, ActnMan, Menus, umain,
  FileCtrl;

type
  TFBackupSettings = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    ckStart: TCheckBox;
    ckEnd: TCheckBox;
    ActionManager1: TActionManager;
    acSave: TAction;
    Label2: TLabel;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    cbStart: TListBox;
    cbEnd: TListBox;
    bOpsi: TButton;
    PopupMenu1: TPopupMenu;
    Restore1: TMenuItem;
    Hapus1: TMenuItem;
    N1: TMenuItem;
    Clear1: TMenuItem;
    procedure Button2Click(Sender: TObject);
    procedure acSaveExecute(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Hapus1Click(Sender: TObject);
  private
    { Private declarations }
    _defdir_start,
    _defdir_end: String;
  public
    { Public declarations }
  end;

var
  FBackupSettings: TFBackupSettings;

procedure ShowBackupSettings;
procedure LoadDirFiles(ADir: String; List: TStrings);

implementation

{$R *.dfm}

function _GetDefDir: String;
begin
  Result := IncludeTrailingPathDelimiter(_appDataPath())+'\_autobackup_dir';
  if not DirectoryExists(Result) then
    ForceDirectories(Result);
end;

procedure LoadDirFiles;
var
  F: TSearchRec;
begin
  if FindFirst(ExcludeTrailingPathDelimiter(ADir)+'\*.dbf', faAnyFile, f) <> 0 then
    exit;
  List.Clear;
  repeat
    List.Add(F.Name);
  until FindNext(F)<>0;
  FindClose(F);
end;

procedure ShowBackupSettings;
var
  defdir: String;
  s: String;
begin
  with TFBackupSettings.Create(Application) do
  begin
    try
      defdir := _GetDefDir();
      _defdir_start := defdir+'\program_start';
      _defdir_end := defdir+'\program_end';
      ForceDirectories(_defdir_start);
      ForceDirectories(_defdir_end);
      ckStart.Checked := StrToBoolDef(GetOption('_autobackup_start', True), False);
      ckEnd.Checked := StrToBoolDef(GetOption('_autobackup_end', True), False);
      //
      if DirectoryExists(_defdir_start) then
      begin        
        LoadDirFiles(_defdir_start, cbStart.Items);
      end;
      if DirectoryExists(_defdir_end) then
      begin
        LoadDirFiles(_defdir_end, cbEnd.Items);
      end;
      PageControl1.ActivePageIndex := 0;
      PageControl2.ActivePageIndex := 0;
      PageControl1Change(PageControl1);
      tag := mrNone;
      ShowModal;
      if Tag = mrOk then
      begin
        SetOption('_autobackup_start', BoolToStr(ckStart.Checked, True), true);
        SetOption('_autobackup_end', BoolToStr(ckStart.Checked, True), true);
      end;
    finally
      Free;
    end;
  end;
end;

procedure TFBackupSettings.acSaveExecute(Sender: TObject);
begin

  Tag := mrOK;
  Close;  
end;

procedure TFBackupSettings.Button2Click(Sender: TObject);
begin
  Tag := mrCancel;
  Close;
end;

procedure TFBackupSettings.Hapus1Click(Sender: TObject);
var
  f: String;
begin
  if PageControl2.ActivePageIndex = 0 then
  begin
    if cbStart.ItemIndex > 0 then
    begin
      f := ExcludeTrailingPathDelimiter( _defdir_start) +'\'+cbStart.Items[cbStart.ItemIndex];
      if DeleteFile(F) then
        cbStart.Items.Delete(cbStart.ItemIndex);
    end;
  end
  else
  begin
    if cbEnd.ItemIndex > 0 then
    begin
      f := ExcludeTrailingPathDelimiter( _defdir_end) +'\'+cbEnd.Items[cbEnd.ItemIndex];
      if DeleteFile(F) then
        cbEnd.Items.Delete(cbEnd.ItemIndex);
    end;
  end;
end;

procedure TFBackupSettings.PageControl1Change(Sender: TObject);
begin
  bOpsi.Visible := PageControl1.ActivePageIndex = 1;
end;

end.
