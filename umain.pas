unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBAccess, MemDS, Grids, StrUtils,
  DBGrids, Menus, DBGridEhGrouping, GridsEh,
  DBGridEh, StdCtrls, ButtonGroup,
  MDIButtonGroup, ImgList, ExtCtrls, DBCtrls, VirtualTable, ComCtrls,
  JvExComCtrls, JvStatusBar, Mask, DBCtrlsEh, DBLookupEh, frxClass, u_utils,
  DASQLMonitor, Uni,
  PlatformDefaultStyleActnCtrls, ActnList, ActnMan, frxDMPExport, frxDBSet,
  frxRich, frxBarcode, JvComponentBase, frxExportCSV,
  frxExportRTF, UniProvider, PostgreSQLUniProvider, DADump, UniDump,
  frxExportBIFF, frxExportXML, frxExportXLS, frxExportHTML, frxExportPDF,
  Buttons, UniSQLMonitor,
  JvExControls, JvImageTransform, frxDesgn,
  ActnCtrls,
  JvNavigationPane, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, DBAxisGridsEh, Printers, ActiveX, ComObj,
  JvBaseEdits, pngimage,
   MemTableDataEh,
  MemTableEh, ShellAPI, ToolWin, memData, JvGIF, JvAnimatedImage, JvGIFCtrl,
  System.Actions, System.ImageList, Vcl.Themes, EhLibVCL, System.Math,


  u_dbgrideh_dac_helper, PersenDanNilai;


type

  TSettingKoneksi = record
    Host: String[50];
    Port: word;
    User,
    Password,
    Database: string[50];
    procedure Clear;
    procedure Save;
    procedure Load;
  end;

  TFMain = class(TForm)
    MainMenu1: TMainMenu;
    System1: TMenuItem;
    Exit1: TMenuItem;
    WinBarMenu: TPopupMenu;
    pmTitle: TMenuItem;
    N5: TMenuItem;
    pmRestore: TMenuItem;
    pmMinimize: TMenuItem;
    pmMaximize: TMenuItem;
    N3: TMenuItem;
    pmMinimizeAll: TMenuItem;
    pmCloseAll: TMenuItem;
    N4: TMenuItem;
    pmClose: TMenuItem;
    ilWin: TImageList;
    Bevel1: TBevel;
    JvStatusBar1: TJvStatusBar;
    VirtualTable1: TVirtualTable;
    frxBarCodeObject1: TfrxBarCodeObject;
    OpenDialog1: TOpenDialog;
    Shape1: TShape;
    Koneksi: TUniConnection;
    UniDump1: TUniDump;
    UniDataSource1: TUniDataSource;
    PostgreSQLUniProvider1: TPostgreSQLUniProvider;
    mnuPrint: TMenuItem;
    RealisasiAPBDSemester11: TMenuItem;
    frxDBDataset3: TfrxDBDataset;
    Panel2: TPanel;
    MDIButtonGroup1: TMDIButtonGroup;
    Panel1: TPanel;
    Bevel3: TBevel;
    SpeedButton1: TSpeedButton;
    BitBtn1: TBitBtn;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    acConnectToServer: TAction;
    DaftarJurnal1: TMenuItem;
    LaporanKeuangan1: TMenuItem;
    pProgress: TPanel;
    acRefreshReport: TAction;
    mnuData: TMenuItem;
    SaveDialog1: TSaveDialog;
    Button1: TButton;
    SaveDialogExcel: TSaveDialog;
    SaveDialogWord: TSaveDialog;
    imMain: TImage;
    JvGIFAnimator1: TJvGIFAnimator;
    mnuView: TMenuItem;
    Style1: TMenuItem;
    frxPDFExport1: TfrxPDFExport;
    frxReport1: TfrxReport;
    JurnalUmum1: TMenuItem;
    JurnalKasMain: TMenuItem;
    JurnalBankMain: TMenuItem;
    ChartOfAccounts1: TMenuItem;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    miUsers: TMenuItem;
    SettingKoneksi1: TMenuItem;
    PenerimaanZakat1: TMenuItem;
    Penyaluran1: TMenuItem;
    mnuPengelolaan: TMenuItem;
    N2: TMenuItem;
    Muzakki1: TMenuItem;
    UnitPengumpulZakat1: TMenuItem;
    SetoranUPZ1: TMenuItem;
    N1: TMenuItem;
    PenyaluranOperasional1: TMenuItem;
    PenerimaanKolektifUPZ1: TMenuItem;
    PenerimaanZakatFitrah1: TMenuItem;
    esbNilaiJaminan: TPersenDanNilai;
    N6: TMenuItem;
    PersentaseBagianAmil1: TMenuItem;
    Mustahuk1: TMenuItem;
    NeracaSaldo1: TMenuItem;
    SaldoDana1: TMenuItem;
    MiIkhtisarSaldo: TMenuItem;
    PindahBukuKasBank1: TMenuItem;
    procedure pmTitleClick(Sender: TObject);
    procedure pmMinimizeClick(Sender: TObject);
    procedure pmRestoreClick(Sender: TObject);
    procedure pmMaximizeClick(Sender: TObject);
    procedure pmMinimizeAllClick(Sender: TObject);
    procedure pmCloseAllClick(Sender: TObject);
    procedure pmCloseClick(Sender: TObject);
    procedure MDIButtonGroup1HotButton(Sender: TObject; Index: Integer);
    procedure MDIButtonGroup1ButtonClicked(Sender: TObject; Index: Integer);
    procedure Exit2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WinBarMenuPopup(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure KoneksiBeforeConnect(Sender: TObject);
    procedure KoneksiAfterConnect(Sender: TObject);
    procedure KoneksiError(Sender: TObject; E: EDAError; var Fail: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure RealisasiAPBDSemester11Click(Sender: TObject);
    procedure acConnectToServerExecute(Sender: TObject);
    procedure KoneksiConnectionLost(Sender: TObject; Component: TComponent;
      ConnLostCause: TConnLostCause; var RetryMode: TRetryMode);
    procedure KoneksiAfterDisconnect(Sender: TObject);
    procedure DaftarJurnal1Click(Sender: TObject);
    procedure LaporanKeuangan1Click(Sender: TObject);
    procedure acRefreshReportExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure JurnalUmum1Click(Sender: TObject);
    procedure JurnalKasMainClick(Sender: TObject);
    procedure JurnalBankMainClick(Sender: TObject);
    procedure ChartOfAccounts1Click(Sender: TObject);
    procedure SettingKoneksi1Click(Sender: TObject);
    procedure miUsersClick(Sender: TObject);
    procedure PenerimaanZakat1Click(Sender: TObject);
    procedure SetoranUPZ1Click(Sender: TObject);
    procedure Penyaluran1Click(Sender: TObject);
    procedure PenyaluranOperasional1Click(Sender: TObject);
    procedure PenerimaanZakatFitrah1Click(Sender: TObject);
    procedure Muzakki1Click(Sender: TObject);
    procedure UnitPengumpulZakat1Click(Sender: TObject);
    procedure PersentaseBagianAmil1Click(Sender: TObject);
    procedure Mustahuk1Click(Sender: TObject);
    procedure NeracaSaldo1Click(Sender: TObject);
    procedure MiIkhtisarSaldoClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure PindahBukuKasBank1Click(Sender: TObject);

  private
    { Private declarations }
    _status: TStringList;
    procedure InitStyles;
    procedure OnSelectStyle(Sender: TObject);

  public
    const
      rekZF             = '41010101';
      rekAmilUPZZakat   = '51010301';
      rekAmilUPZInfak   = '52010301';
      rekDanaAmil       = '31040101';
      rekPiutangAmilUPZ = '11030501';
      rekUtangAmilUPZ   = '21010301';
  var
      BaseKas,
      BaseBank            : string;
      SettingKoneksi      : TSettingKoneksi;
      PersenAmilDanaZakat,
      PersenAmilDanaInfak,
      PersenAmilDanaDSKL,
      PersenAmilDanaCSR,
      PersenAmilDanaHibah,
      PersenAmilDanaAPBD  : Double;

    { Public declarations }
    procedure RefreshPersenAmil;
    function  PilihMustahik(tipe: string = '*'): TStringList;
    function  PilihMuzaki(tipe: string = '*'): TStringList;
    procedure AturKoneksi;
    function isConnected: Boolean;
    procedure CloseAllSubForm;
    procedure AddChildForm(Form:TForm);
    function CreateChildForm(FormClass: TFormClass): TForm;
    function  ReportsDir: String;
    procedure StartProgress(Text: String=''; proc: TOnProgressProc = nil);
    procedure StartProgress2(Text: String=''; proc: TOnProgressProc = nil);
    procedure StopProgress;
    procedure StopProgress2;

    function  GetSaveFileName(const AFIlter: String; const OverwritePrompt: Boolean = False): String;
    function  GetOpenFileName(const AFIlter: String): String;

    procedure OnReportCreated(Sender: TObject);
    procedure UpdateReport;

    procedure Logout;
    procedure Login;

    procedure PreviewMsWordDocument(const AFile: String);

    procedure deleteTmpReportFiles;
    function  GetTmpReportFile(BaseReport: String):String;
    procedure AddStatus(ASTatus: String);
    procedure EndStatus;
    function _AddMDIReport(Report: TFrxReport; const Title: String): Tform;
    //
    procedure AppOnException(Sender: TObject; E: Exception);
  end;

var
  FMain: TFMain;



implementation

uses u_display_text, ui_utils, u_select_kode_name, u_select_master_detail, u_gl,
  u_daftar_jurnal, u_print_bs_lr_cf_ec, u_login,
  httpsend, u_pembuat_dokumen,
  u_progress, u_jurnal,
  u_jurnal_kas, u_jurnal_bank, u_coa, u_koneksi, u_terima_zis,
  u_salur_zis, u_salur_non_zis, u_terima_upz_fitrah, u_user_akses,
  u_terima_upz_zis, u_setting_persentase_bagian_amil, u_new_mustahik,
  u_new_muzaki, u_upz, u_neraca_saldo, u_muzaki, uexch, u_mustahik,
  u_jurnal_pb_kas_bank;

{$R *.dfm}



procedure TFMain.UnitPengumpulZakat1Click(Sender: TObject);
begin
  if not CurrentUser.Accessible('Mengakses Data UPZ') then
  begin
    Inform('Anda tidak memiliki Akses.'#13'Akses diperlukan:'#13'* Mengakses Data UPZ');
    exit;
  end;
  AddChildForm(TFUPZ.Create(Application));
end;

procedure TFMain.UpdateReport;
var
  p,i: Integer;
  s: string;
  stream: TMemoryStream;
  folder: string;
  res: TStringList;
begin
  // folder := _HOST+'/desktop-utils/print/_reports/';
  res := TStringList.Create;
  res.Clear;
  HttpGetText(folder, res);
  // ShowText(res.Text);
  //FR3
  for i:=res.count-1 downto 0 do
  begin
    s := res[i];
    if pos('.fr3',s)>=1 then
    begin
      p := pos('.fr3',s);
      delete(s,p+4, 1024);
      repeat
        dec(p);
      until (s[p]='>') or (s[p]='"') or (p=0) ;
      s := copy(s,p+1,1024);
      res[i]:=s;
    end
    else
    if pos('.docx',s)>=1 then
    begin
      p := pos('.docx',s);
      delete(s,p+5, 1024);
      repeat
        dec(p);
      until (s[p]='>') or (s[p]='"') or (p=0) ;
      s := copy(s,p+1,1024);
      res[i]:=s;
    end
    else
    if pos('.xlsx',s)>=1 then
    begin
      p := pos('.xlsx',s);
      delete(s,p+5, 1024);
      repeat
        dec(p);
      until (s[p]='>') or (s[p]='"') or (p=0) ;
      s := copy(s,p+1,1024);
      res[i]:=s;
    end
    else
      res.Delete(i);
  end;

  s := ExtractFileDir(Application.ExeName)+'\reports';
  if not DirectoryExists(s) then
    ForceDirectories(s);
  stream := TMemoryStream.Create;
  try
    for i:=0 to res.count-1 do
    begin
      stream.Clear;
      // ShowText(folder+res[i]);
      if HttpGetBinary(folder+res[i], stream) then
      begin
        if FileExists(s+'\'+res[i]) then
          DeleteFile(s+'\'+res[i]);
        stream.SaveToFile(s+'\'+res[i]);
      end;
      Application.ProcessMessages;
    end;
  finally
    stream.Free;
  end;
  res.Free;
  EndProgress;
end;

procedure TFMain.miUsersClick(Sender: TObject);
begin
  if not CurrentUser.Accessible('manageusers') then
  begin
    Inform('Anda tidak memiliki Akses.'#13'Akses diperlukan:'#13'* Mengatur data dan hak akses user');
    exit;
  end;
  AddChildForm(TFUserAccessControl.Create(Application));
end;

procedure TFMain.Mustahuk1Click(Sender: TObject);
begin
  if not CurrentUser.Accessible('Mengakses Data Mustahik') then
  begin
    Inform('Anda tidak memiliki Akses.'#13'Akses diperlukan:'#13'* Mengakses Data Mustahik');
    exit;
  end;
  AddChildForm(TFMustahik.Create(Application));
end;

procedure TFMain.Muzakki1Click(Sender: TObject);
begin
  if not CurrentUser.Accessible('Mengakses Data Muzaki') then
  begin
    Inform('Anda tidak memiliki Akses.'#13'Akses diperlukan:'#13'* Mengakses Data Muzaki');
    exit;
  end;
  AddChildForm(TFMuzaki.Create(Application));
end;

procedure TFMain.NeracaSaldo1Click(Sender: TObject);
begin
  if not CurrentUser.Accessible('Mengakses Neraca Saldo') then
  begin
    Inform('Anda tidak memiliki Akses.'#13'Akses diperlukan:'#13'* Mengakses Neraca Saldo');
    exit;
  end;
  AddChildForm(TForm(TFNeracaSaldo.Create(Application)));
end;

procedure TFMain.acConnectToServerExecute(Sender: TObject);
var
  res: TStringList;
begin
  if TAction(Sender).ImageIndex = 6 then
  begin
    if Koneksi.Connected then
      Koneksi.Disconnect;
    Koneksi.Server := SettingKoneksi.Host;
    Koneksi.Username := SettingKoneksi.User;
    Koneksi.Password:= SettingKoneksi.Password;
    Koneksi.Database := SettingKoneksi.Database;
    JvStatusBar1.Panels[0].Text := SettingKoneksi.User+'@'+SettingKoneksi.Host;
    JvStatusBar1.Panels[1].Text := SettingKoneksi.Database;
    try
      Koneksi.Connect;
    except
      Deny('Gagal menyambungkan ke server'#13'Periksa koneksi jaringan dengan server.');
    end;
  end
  else
  begin
    if Ask('Seluruh form akan ditutup. Lanjutkan?')= mrYes then
    begin
      if Koneksi.Connected then
        Koneksi.Disconnect;
      // TAction(Sender).ImageIndex := 6;
    end;
  end;
end;

procedure TFMain.acRefreshReportExecute(Sender: TObject);
begin
  // BeginProgress('Mengunduh File-File Report...', UpdateReport);
end;

procedure TFMain.AddChildForm(Form: TForm);
begin
  FMain.MDIButtonGroup1.AddButton(Form, -1, Form.Caption);
  MDIButtonGroup1HotButton(MDIButtonGroup1, MDIButtonGroup1.ItemIndex);
  MDIButtonGroup1.Items[MDIButtonGroup1.ItemIndex].Hint := Form.Caption;
end;

function TFMain._AddMDIReport(Report: TFrxReport; const Title: String): Tform;
var
  i: integer;
begin
  // for i:= 0 MDIButtonGroup1.Items.Count
  Result := nil;
  Report.PreviewForm.Caption := Title;
  if (not Report.PreviewOptions.Modal)
  and (Report.PreviewOptions.MDIChild) then
  begin
    result := Report.PreviewForm;
    AddChildForm(Report.PreviewForm);
  end;
end;

procedure TFMain.AddStatus(ASTatus: String);
begin
  _status.Add(ASTatus);
  JvStatusBar1.Panels[2].Text := ASTatus;
end;

procedure TFMain.AppOnException(Sender: TObject; E: Exception);
begin
  ShowException(Sender, E);
end;

procedure TFMain.AturKoneksi;
begin
  with TFKoneksi.Create(Application) do
  begin
    try
      tag := mrNone;
      eHost.Text := SettingKoneksi.Host;
      ePort.Value:= SettingKoneksi.Port;
      eUser.Text:= SettingKoneksi.User;
      eDatabase.Text:= SettingKoneksi.Database;
      ePassword.Text:= SettingKoneksi.Password;

      ShowModal;
      if tag = mrOk then
      begin
        SettingKoneksi.Host := eHost.Text;
        SettingKoneksi.Port := ePort.Value;
        SettingKoneksi.User := eUser.Text;
        SettingKoneksi.Database:= eDatabase.Text;
        SettingKoneksi.Password:= ePassword.Text;
        SettingKoneksi.Save;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TFMain.Button1Click(Sender: TObject);
begin
  MsgBoxTimeout('TES', 'hanya test');
end;

procedure TFMain.Button2Click(Sender: TObject);
begin
  with MDIButtonGroup1 do autosize := not autosize;
end;

procedure TFMain.ChartOfAccounts1Click(Sender: TObject);
begin
  if not AccessibleBy(CurrentUser,'Mengakses Chart Of Account') then
  begin
    Warn('Anda tidak memiliki hak Mengakses Chart Of Account!');
    exit;
  end;
  AddChildForm(TFCoa.Create(Application));
end;

procedure TFMain.CloseAllSubForm;
var
  i: integer;
begin
  for i := MDIChildCount -1 downto 0 do
  begin
    MDIChildren[i].Close;
    (*
    if Assigned(MDIChildren[i]) then
      MDIChildren[i].Free;
    *)
  end;
end;


function TFMain.CreateChildForm(FormClass: TFormClass): TForm;
var
  f: TForm;
begin
  f := TForm(FormClass.Create(Application));
  AddChildForm(F);
  result := f;
end;

procedure TFMain.DaftarJurnal1Click(Sender: TObject);
begin
  if not CurrentUser.Accessible('Mengakses Daftar Jurnal') then
  begin
    Inform('Anda tidak memiliki Akses.'#13'Akses diperlukan:'#13'* Mengakses Daftar Jurnal');
    exit;
  end;
  AddChildForm(TForm(TFDaftarJurnal.Create(Application)));
end;

procedure TFMain.deleteTmpReportFiles;
var
  i: integer;
  d: string;
begin
  d := AppPath()+'\tmp';
  if not DirectoryExists(d) then
    exit;
  with ListFilesInFolder(d, '*.*') do
  begin
    for i := 0 to Count-1 do
      DeleteFile(Strings[i]);
    Free;
  end;
  {
  with ListFilesInFolder(d, '*.doc*') do
  begin
    // ShowMessage(Text);
    for i := 0 to Count-1 do
      DeleteFile(Strings[i]);
    Free;
  end;
  with ListFilesInFolder(d, '*.xls*') do
  begin
    for i := 0 to Count-1 do
      DeleteFile(Strings[i]);
    Free;
  end;
  with ListFilesInFolder(d, '*.fr3') do
  begin
    for i := 0 to Count-1 do
      DeleteFile(Strings[i]);
    Free;
  end;
  }
end;

procedure TFMain.StopProgress;
begin
  pProgress.hide;
  acRefreshReport.enabled := true;
  acConnectToServer.enabled := true;
  mnuData.Visible := true;
  mnuPrint.Visible := true;
  mnuPengelolaan.Visible := true;
  miUsers.Visible := true;
  mnuView.Visible := true;
  if not imMain.Visible then
  begin
    imMain.Align := alClient;
    imMain.Show;
  end;
  JvGIFAnimator1.Animate := false;
end;

procedure TFMain.StopProgress2;
begin
  acRefreshReport.enabled := true;
  acConnectToServer.enabled := true;
  mnuData.Visible := true;
  mnuPengelolaan.Visible := true;
  miUsers.Visible := true;
  mnuPrint.Visible := true;
  mnuView.Visible := true;
  with FProgress do
  begin
    CLose;
    pProgress.hide;
    JvGIFAnimator1.Animate := false;
  end;
end;

procedure TFMain.EndStatus;
begin
  if _status.Count>0 then
    _status.Delete(_status.Count-1);
  if _status.Count>0 then
    JvStatusBar1.Panels[2].Text := _status[_status.Count-1]
  else
    JvStatusBar1.Panels[2].Text := 'Idle';
end;

procedure TFMain.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TFMain.Exit2Click(Sender: TObject);
begin
  Close;
end;

procedure TFMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {
  Action := caNone;
  if Ask('Tutup aplikasi?', Handle) = ID_NO then
    exit;
  }
  CloseAllSubForm;
  Koneksi.Disconnect;

  Action := caFree;
  // PostMessage(FindWindow('TFSelectApp',nil), WM_CLOSE, 0, 0);
end;

procedure TFMain.FormCreate(Sender: TObject);
var
  bgImg: string;
begin
  Application.OnException := AppOnException;
  {
  SettingKoneksi.Host := 'localhost';
  SettingKoneksi.Port := 5432;
  SettingKoneksi.User := 'postgres';
  SettingKoneksi.Database:= 'baz-adesal';
  SettingKoneksi.Password:= 'b3vjhzxx';
  SettingKoneksi.Save;
  Inform('Data saved.');
  Close;
  Application.Terminate;
  halt;
  }
  pprogress.align := alClient;
  bgImg := AppPath()+'\images\SiBaz-main.png';
  if FileExists(bgImg) then
  begin
    try imMain.picture.LoadFromFile(bgImg); except end;
  end;
  SettingKoneksi.Load;
  // cek koneksi:
  if SettingKoneksi.Host = '' then
  begin
    Inform('Setting koneksi perlu diatur...');
    AturKoneksi;
  end;
  if SettingKoneksi.Host = '' then
  begin
    Application.Terminate;
    Close;
  end;
  BeginProgress := StartProgress;
  EndProgress   := StopProgress;
  AddMDIReport := _AddMDIReport;
  InitStyles;
  _status := TStringList.Create;
  EndProgress;
  mnuPrint.Enabled := False;
  mnuData.Enabled := False;
  mnuPengelolaan.Enabled := false;
  miUsers.Enabled := false;
  acRefreshReport.Enabled := False;
  MDIButtonGroup1.Items.Clear;
  Application.Title := APP_NAME_LONG;
  Caption := Application.Title;
  SetGlobalConnection(Koneksi);
  {
  edit1.Text := FloatToIndo   (827387237823.3893);
  edit2.Text := FloatToEnglish(82738237823.3893);
  }
end;

procedure TFMain.FormDestroy(Sender: TObject);
begin
  deleteTmpReportFiles;
  if Assigned(_status) then
    FreeAndNil(_status);
end;

function TFMain.GetOpenFileName;
begin
  Result := '';
  with TOpenDialog.Create(self) do
  begin
    try
      Filter := AFIlter;
      Options := Options - [ofAllowMultiSelect];
      if Execute(Handle) then
        Result := FileName;
    finally
      Free;
    end;
  end;
end;

function TFMain.GetSaveFileName;
begin
  Result := '';
  with TSaveDialog.Create(self) do
  begin
    try
      Filter := AFIlter;
      Options := Options - [ofOverwritePrompt];
      Options := Options - [ofAllowMultiSelect];
      if OverwritePrompt then
        Options := Options + [ofOverwritePrompt];
      if Execute(Handle) then
        Result := FileName;
    finally
      Free;
    end;
  end;
end;

function TFMain.GetTmpReportFile(BaseReport: String): String;
begin
  Result := TempFile(ReportsDir, ExtractFileExt(BaseReport));
  while FileExists(Result) do
    Result := TempFile(ReportsDir, ExtractFileExt(BaseReport));
  CopyFile(Pchar(BaseReport), pchar(Result), false);
end;

procedure TFMain.InitStyles;
var
  style,
  defStyle: String;
  mi: TMenuItem;
begin
  defStyle := _d(GetOption('Appearance.defaultStyle', true), 'Windows');
  for style in TStyleManager.StyleNames do
  begin
    mi := TMenuItem.Create(self);
    with mi do
    begin
      Caption := style;
      OnClick := onSelectStyle;
      GroupIndex := 1;
      AutoCheck := true;
      RadioItem := true;
      Visible:= true;
      Checked := style = defStyle;
    end;
    Style1.Add(mi);
  end;
  TStyleManager.TrySetStyle(defStyle, false);
end;

function TFMain.isConnected: Boolean;
begin
  Result := Koneksi.Connected;
end;

procedure TFMain.JurnalBankMainClick(Sender: TObject);
begin
  if not AccessibleBy(CurrentUser,'Menginput Jurnal Bank') then
  begin
    Warn('Anda tidak memiliki akses Menginput Jurnal Bank!');
    exit;
  end;
  AddChildForm(TFJurnalBank.Create(Application));
end;

procedure TFMain.JurnalKasMainClick(Sender: TObject);
begin
  if not AccessibleBy(CurrentUser,'Menginput Jurnal Kas') then
  begin
    Warn('Anda tidak memiliki akses Menginput Jurnal Kas!');
    exit;
  end;
  AddChildForm(TFJurnalKas.Create(Application));
end;

procedure TFMain.JurnalUmum1Click(Sender: TObject);
begin
  if not AccessibleBy(CurrentUser,'menginput jurnal umum') then
  begin
    Warn('Anda tidak memiliki akses Menginput Jurnal Umum!');
    exit;
  end;
  AddChildForm(TFJurnal.Create(Application));
end;

procedure TFMain.KoneksiAfterConnect(Sender: TObject);
var
  res: TStringList;
begin
  acConnectToServer.ImageIndex := 21;
  acConnectToServer.Caption := 'Putuskan Koneksi';
  Login;
  if CurrentUser.ID>0 then
  begin
    res := SelectKodeName(Koneksi, 'select kode, vkode, branch_name, alamat from sys_branches order by kode asc',
      ['kode', 'branch_name', 'alamat'],
      ['Kode', 'Cabang','Alamat'],
      [70, 200, 300],
      550, 300, 'Pilih Cabang');
    if res.Count>0 then
    begin
      CurrentUser.KodeCabang := res[0];
      CurrentUser.NamaCabang := res[1];
      CurrentUser.AlamatCabang:= res[2];
      JvStatusBar1.Panels[2].Text := res[0]+' - '+res[1];
      // BeginProgress('Mengunduh File-File Report...', UpdateReport);
      mnuPrint.Enabled := True;
      mnuData.Enabled := true;
      mnuPengelolaan.enabled := true;
      miUsers.Enabled := true;
      acRefreshReport.Enabled := true;
      RefreshPersenAmil;
    end
    else
    begin
      Koneksi.Disconnect;
    end;
    res.Free;
  end
  else
  begin
    Koneksi.Disconnect;
  end;
  ScreenIdle;
end;

procedure TFMain.KoneksiAfterDisconnect(Sender: TObject);
begin
  acConnectToServer.ImageIndex := 6;
  acConnectToServer.Caption := 'Hubungkan Ke Server';

  CloseAllSubForm;
  mnuPrint.Enabled := False;
  mnuData.Enabled := false;
  mnuPengelolaan.enabled := false;
  miUsers.Enabled := false;
  acRefreshReport.Enabled := false;
  Logout;
  EndProgress;
end;

procedure TFMain.KoneksiBeforeConnect(Sender: TObject);
begin
  ScreenBussy;
end;

procedure TFMain.KoneksiConnectionLost(Sender: TObject; Component: TComponent;
  ConnLostCause: TConnLostCause; var RetryMode: TRetryMode);
begin
  acConnectToServer.ImageIndex := 6;
  acConnectToServer.Caption := 'Hubungkan Ke Server';
  Inform('Koneksi terputus!');
  CloseAllSubForm;
  mnuPrint.Enabled := False;
  mnuData.Enabled := false;
  mnuPengelolaan.Enabled:= false;
  miUsers.Enabled := false;
  acRefreshReport.Enabled := false;
  Logout;
  EndProgress;
end;

procedure TFMain.KoneksiError(Sender: TObject; E: EDAError; var Fail: Boolean);
begin
  {
  acConnectToServer.ImageIndex := 6;
  acConnectToServer.Caption := 'Hubungkan Ke Server';
  mnuPrint.Enabled := False;
  mnuData.Enabled := False;
  mnuPengelolaan.enabled := false;
  miUsers.Enabled := false;
  acRefreshReport.Enabled := False;
  CloseAllSubForm;
  Logout;
  EndProgress;
  ScreenIdle;
  }
end;

procedure TFMain.LaporanKeuangan1Click(Sender: TObject);
begin
  if not CurrentUser.Accessible('Mengakses Laporan Keuangan') then
  begin
    Inform('Anda tidak memiliki Akses.'#13'Akses diperlukan:'#13'* Mengakses Laporan Keuangan');
    exit;
  end;
  AddChildForm(TForm(TFPrintBsLrCfEc.Create(Application)));
end;

procedure TFMain.Login;
begin
  CurrentUser.Clear;
  with TFLogin.Create(Application) do
  begin
    try
      Tag := mrNone;
      ShowModal;
    finally
      FRee;
    end;
  end;
end;

procedure TFMain.Logout;
begin
  CurrentUser.Clear;
end;

procedure TFMain.MDIButtonGroup1ButtonClicked(Sender: TObject; Index: Integer);
var
  i: Integer;
begin
  exit;
  for i:= 0 to TMDIButtonGroup(Sender).Items.Count-1 do
  begin
    if i = index then
      TMDIButtonGroup(Sender).Items[i].ImageIndex := 3
    else
      TMDIButtonGroup(Sender).Items[i].ImageIndex := 2;
  end;
end;

procedure TFMain.MDIButtonGroup1HotButton(Sender: TObject; Index: Integer);
var
  i: Integer;
begin
  //exit;
  for i:= 0 to TMDIButtonGroup(Sender).Items.Count-1 do
  begin
    if i = index then
      TMDIButtonGroup(Sender).Items[i].ImageIndex := 3
    else
      TMDIButtonGroup(Sender).Items[i].ImageIndex := 2;
  end;
end;

procedure TFMain.MiIkhtisarSaldoClick(Sender: TObject);
begin
  //
end;

procedure TFMain.OnReportCreated(Sender: TObject);
begin
  if Tag = Tform(Sender).Tag then exit;
  // TForm(Sender).Caption := 'Report '+ ReportName(CurrentReport) +' - '+ prmTAnggaran;
  AddChildForm(TForm(Sender));
end;

procedure TFMain.OnSelectStyle(Sender: TObject);
begin
  SetOption('Appearance.defaultStyle', StripHotkey(TMenuItem(Sender).Caption), true);
  TStyleManager.TrySetStyle(StripHotkey(TMenuItem(Sender).Caption));
end;

procedure TFMain.PenerimaanZakat1Click(Sender: TObject);
var
  F: TFTerimaZis;
begin
  if not CurrentUser.Accessible('Mencatat Penerimaan ZIS Langsung') then
  begin
    Inform('Anda tidak memiliki Akses.'#13'Akses diperlukan:'#13'* Mencatat Penerimaan ZIS Langsung');
    exit;
  end;
  F := TFTerimaZis.Create(Application);
  F.KodeMuzakki := '';
  F.acNew.Execute;
  AddChildForm(F);
end;

procedure TFMain.PenerimaanZakatFitrah1Click(Sender: TObject);
begin
  if not CurrentUser.Accessible('Mencatat Penerimaan UPZ - Zakat Fitrah') then
  begin
    Inform('Anda tidak memiliki Akses.'#13'Akses diperlukan:'#13'* Mencatat Penerimaan UPZ - Zakat Fitrah');
    exit;
  end;
  AddChildForm(TFTerimaUPZFitrah.Create(Application));
end;

procedure TFMain.Penyaluran1Click(Sender: TObject);
begin
  if not CurrentUser.Accessible('Mencatat Penyaluran Dana ZIS') then
  begin
    Inform('Anda tidak memiliki Akses.'#13'Akses diperlukan:'#13'* Mencatat Penyaluran Dana ZIS');
    exit;
  end;
  AddChildForm(TFSalurZis.Create(Application));
end;

procedure TFMain.PenyaluranOperasional1Click(Sender: TObject);
begin
  if not CurrentUser.Accessible('Mencatat Penyaluran Dana Amil, CSR, DSKL') then
  begin
    Inform('Anda tidak memiliki Akses.'#13'Akses diperlukan:'#13'* Mencatat Penyaluran Dana Amil, CSR, DSKL');
    exit;
  end;
  AddChildForm(TFSalurNonZis.Create(Application));
end;

procedure TFMain.PersentaseBagianAmil1Click(Sender: TObject);
begin
  if not AccessibleBy(CurrentUser,'Mengatur Persentase Bagian Amil') then
  begin
    Warn('Anda tidak memiliki hak Mengatur Persentase Bagian Amil!');
    exit;
  end;
  ShowSettingPersentaseBagianAmil;
end;

function TFMain.PilihMustahik(tipe: string): TStringList;
var
  j: string;
begin
  {
  0 - NPWZ
  1 - Nama
  2 - Alamat
  3 - Jenis
  4 - Kode Kelurahan
  }
  if _u(tipe) = 'ORG' then
    j := ' (m.tipe = ''01'') '
  else
  if _u(tipe) = 'UPZ' then
    j := ' (not (m.tipe in (''00'',''01''))) '
  else
    j := ' (m.tipe<>''00'') ';
  j := 'select m.npwm, m.nama, (s.nama||'', ''||s.kecamatan) alamat, '+
    'b.uraian jenis, m.kelurahan from baz_mustahik m '+
    'inner join v_kelurahan s on s.kode = m.kelurahan '+
    'inner join baz_jenis_mustahik b on b.kode = m.tipe '+
    'where '+j+' '+
    'order by m.nama asc';

  Result := SelectKodeName(
    GetGlobalConnection,
    j,
    ['npwm', 'nama', 'alamat','jenis','kelurahan'],
    ['NPM','Nama','Alamat','Jenis','Kelurahan'],
    [100,180,280,100, 0],
    600, 450,
    'Pilih Mustahik',procedure begin InputMustahikBaru(tipe);end, 'Tambah'
  );
end;

function TFMain.PilihMuzaki(tipe: string): TStringList;
var
  j: string;
begin
  {
  0 - NPWZ
  1 - Nama
  2 - Alamat
  3 - Jenis
  4 - Kode Kelurahan
  }
  if _u(tipe) = 'ORG' then
    j := ' (m.tipe = ''01'') '
  else
  if _u(tipe) = 'UPZ' then
    j := ' (not (m.tipe in (''00'',''01''))) '
  else
    j := ' (m.tipe<>''00'') ';
  j := 'select m.npwz, m.nama, (s.nama||'', ''||s.kecamatan) alamat, '+
    'b.uraian jenis, m.kelurahan from baz_muzakki m '+
    'inner join v_kelurahan s on s.kode = m.kelurahan '+
    'inner join baz_jenis_muzakki b on b.kode = m.tipe '+
    'where '+j+' '+
    'order by m.nama asc';

  Result := SelectKodeName(
    GetGlobalConnection,
    j,
    ['npwz', 'nama', 'alamat', 'jenis', 'kelurahan'],
    ['NPWZ','Nama','Alamat', 'Jenis', 'Kelurahan'],
    [100,180,280, 100, 0],
    600, 450,
    'Pilih Muzaki',procedure begin InputmuzakiBaru(tipe);end, 'Tambah'
  );
end;

procedure TFMain.PindahBukuKasBank1Click(Sender: TObject);
begin
  if not AccessibleBy(CurrentUser,'Menginput Jurnal Pindah Buku Kas-Bank') then
  begin
    Warn('Anda tidak memiliki akses Menginput Jurnal Pindah Buku Kas-Bank!');
    exit;
  end;
  AddChildForm(TFJurnalPinbukKasBank.Create(Application));
end;

procedure TFMain.pmCloseAllClick(Sender: TObject);
begin
  if Ask('Tutup Semua Form?', Handle) = ID_YES then
    MDIButtonGroup1.CloseAll;
end;

procedure TFMain.pmCloseClick(Sender: TObject);
begin
  if MDIButtonGroup1.HotButtonIndex = -1 then exit;
  MDIButtonGroup1.MDIChildren[MDIButtonGroup1.HotButtonIndex].Close;
end;

procedure TFMain.pmMaximizeClick(Sender: TObject);
begin
  if MDIButtonGroup1.HotButtonIndex = -1 then exit;
  MDIButtonGroup1.MDIChildren[MDIButtonGroup1.HotButtonIndex].WindowState := wsMaximized;
end;

procedure TFMain.pmMinimizeAllClick(Sender: TObject);
begin
  MDIButtonGroup1.MinimizeAll;
end;

procedure TFMain.pmMinimizeClick(Sender: TObject);
begin
  if MDIButtonGroup1.HotButtonIndex = -1 then exit;
  MDIButtonGroup1.MDIChildren[MDIButtonGroup1.HotButtonIndex].WindowState := wsNormal;
end;

procedure TFMain.pmRestoreClick(Sender: TObject);
begin
  if MDIButtonGroup1.HotButtonIndex = -1 then exit;
  MDIButtonGroup1.MDIChildren[MDIButtonGroup1.HotButtonIndex].WindowState := wsMinimized;
end;

procedure TFMain.pmTitleClick(Sender: TObject);
begin
  if MDIButtonGroup1.HotButtonIndex = -1 then exit;
  with MDIButtonGroup1.MDIChildren[MDIButtonGroup1.HotButtonIndex] do
  begin
    Setfocus;
    BringToFront;
  end;
end;

procedure TFMain.PreviewMsWordDocument(const AFile: String);
const
  wdFindContinue = 1;
  wdReplaceOne = 1;
  wdReplaceAll = 2;
  wdDoNotSaveChanges = 0;
var
  wordapp:olevariant;
  WordDoc : OLEVariant;
  tmpFile: String;
begin
  tmpFile := TempFile(ExtractFileDir(AFile), '.docx');
  CopyFile(PChar(AFile), PChar(tmpFile), false);
  {
  try
    WordApp := GetActiveOleObject('Word.Application');
  except on exception do
  }  WordApp := CreateOleObject('Word.Application');
  {end;}
  // wordapp.displayAlerts := false;
  wordapp.Visible:=false;
  WordDoc:=WordApp.Documents.Open(tmpFile);
  // WordDoc.Content.Find.Execute('', true, false, false, false, false,,,,'replace_with_string', SearchAll);
  // WordDoc.Content.Find.Execute(FindText := 'Penjamin', ReplaceWith := '--+++Penjamin+++--', Replace := wdReplaceAll);
  WordDoc.PrintPreview;
  // worddoc.close(wdDoNotSaveChanges);
  // wordapp.activeWIndow.close;
  // wordapp.quit({OleVariant(False)});
  WordApp := Unassigned;
end;

procedure TFMain.RealisasiAPBDSemester11Click(Sender: TObject);
var
  F: TForm;
begin
  if not CurrentUser.Accessible('Mengakses General Ledger') then
  begin
    Inform('Anda tidak memiliki Akses.'#13'Akses diperlukan:'#13'* Mengakses General Ledger');
    exit;
  end;
  F := TForm(ShowGL('', AwalBulan(date), date));
  AddChildForm(F);
end;

procedure TFMain.RefreshPersenAmil;
begin
  BaseKas:=GetOption(CurrentUser.KodeCabang+'defsetkas');
  BaseBank:=GetOption(CurrentUser.KodeCabang+'defsetbank');

  PersenAmilDanaZakat := _f(GetOption(CurrentUser.KodeCabang+'persen-amil-zakat'), 0.125)*100;
  PersenAmilDanaInfak := _f(GetOption(CurrentUser.KodeCabang+'persen-amil-infak-sedekah'),    0.200)*100;
  PersenAmilDanaDSKL  := _f(GetOption(CurrentUser.KodeCabang+'persen-amil-dskl'),  0.200)*100;
  PersenAmilDanaCSR   := _f(GetOption(CurrentUser.KodeCabang+'persen-amil-csr'),   0.100)*100;
  PersenAmilDanaHibah := _f(GetOption(CurrentUser.KodeCabang+'persen-amil-hibah'), 0.200)*100;
  PersenAmilDanaAPBD:= _f(GetOption(CurrentUser.KodeCabang+'persen-amil-apbd'), 0.00)*100;
end;

function TFMain.ReportsDir: String;
begin
  // Result := IncludeTrailingPathDelimiter(_appDataPath())+'reports';
  Result := _path(Application.ExeName)+'_reports';
end;


procedure TFMain.SetoranUPZ1Click(Sender: TObject);
begin
  if not CurrentUser.Accessible('Mencatat Penerimaan UPZ - ZIS') then
  begin
    Inform('Anda tidak memiliki Akses.'#13'Akses diperlukan:'#13'* Mencatat Penerimaan UPZ - ZIS');
    exit;
  end;
  AddChildForm(TFTerimaUPZNonFitrah.Create(Application));
  {
  if not CurrentUser.Accessible('Mencatat Penerimaan ZIS Selain Fitrah') then
  begin
    Inform('Anda tidak memiliki Akses.'#13'Akses diperlukan:'#13'* Mencatat Penerimaan ZIS Selain Fitrah');
    exit;
  end;
  F := TFTerimaZisKolektif.Create(Application);
  F.KodeMuzakki := '';
  F.acNew.Execute;
  AddChildForm(F);
  }
end;

procedure TFMain.SettingKoneksi1Click(Sender: TObject);
begin
  AturKoneksi;
end;

procedure TFMain.StartProgress;
begin
  if imMain.Visible then
  begin
    imMain.Hide;
    imMain.Align := alNone;
  end;
  JvGIFAnimator1.Animate := true;
  pProgress.Caption := Text;
  pProgress.Show;
  mnuData.Visible := false;
  mnuPrint.Visible := false;
  mnuPengelolaan.Visible := false;
  miUsers.Visible := false;
  mnuView.Visible := false;
  acRefreshReport.enabled := false;
  acConnectToServer.enabled := false;

  // Application.ProcessMessages;
  proc;
end;


procedure TFMain.StartProgress2(Text: String; proc: TOnProgressProc);
begin
  mnuData.Visible := false;
  mnuPengelolaan.Visible := false;
  miUsers.Visible := false;
  mnuPrint.Visible := false;
  mnuView.Visible := false;
  acRefreshReport.enabled := false;
  acConnectToServer.enabled := false;
  if not Assigned(FProgress) then
    FProgress := TFProgress.Create(Application);
  with FProgress do
  begin
    JvGIFAnimator1.Animate := true;
    pProgress.Caption := Text;
    pProgress.Show;
    ProcedureToRun := proc;
    // ShowModal;
    // Show;
  end;
end;

procedure TFMain.WinBarMenuPopup(Sender: TObject);
begin
  if MDIButtonGroup1.Items.Count = 0 then
    abort;

end;

// defaults:

{ TSettingKoneksi }

procedure TSettingKoneksi.Clear;
begin
  self.Host := '';
  self.Port := 5432;
  Self.User := 'postgres';
  self.Password := '';
  self.Database := '';
end;

procedure TSettingKoneksi.Load;
begin
  self.Host := GetOption('conn.host', true);
  self.Port := _i(GetOption('conn.port', true), 5432);
  Self.User := GetOption('conn.user', true);
  self.Password := GetOption('conn.password', true);
  self.Database := GetOption('conn.database', true);
end;

procedure TSettingKoneksi.Save;
begin
   SetOption('conn.host',     self.Host, true);
   SetOption('conn.port',     _s(self.Port), true);
   SetOption('conn.user',     Self.User, true);
   SetOption('conn.password', self.Password, true);
   SetOption('conn.database', self.Database, true);
end;

initialization

DBGridEhEmptyDataInfoText := 'Belum ada data.';

end.
