unit u_print_bs_lr_cf_ec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ToolWin, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  ExtCtrls, StdCtrls, DBGridEhGrouping, GridsEh, DBGridEh, DB, MemDS,
  DBAccess, Menus, ToolCtrlsEh,
  DBGridEhToolCtrls, DBAxisGridsEh, DynVarsEh, Uni, umain, u_utils,
  frxClass, frxDBSet, Grids, DBGrids, ComCtrls, Buttons, frxPreview,
  System.Actions,

  u_dbgrideh_dac_helper, frxExportPDF;

type
  TFPrintBsLrCfEc = class(TForm)
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    acClose: TAction;
    QBS: TUniQuery;
    DataSource1: TDataSource;
    frBS: TfrxReport;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    QLr: TUniQuery;
    QCf: TUniQuery;
    QEc: TUniQuery;
    fxDBBs: TfrxDBDataset;
    fxDBLr: TfrxDBDataset;
    fxDBCf: TfrxDBDataset;
    fxDBEc: TfrxDBDataset;
    QLrkode_rek: TMemoField;
    QLrvkode: TMemoField;
    QLrnama_rek: TMemoField;
    QLrsaldo_n: TFloatField;
    QLrlvl: TIntegerField;
    QLrtipe: TMemoField;
    QBStingkat: TIntegerField;
    QBSnomor: TMemoField;
    QBSkode_rek: TMemoField;
    QBSvkode: TMemoField;
    QBSnama_rek: TMemoField;
    QBSsaldo: TFloatField;
    QBSsaldo_n: TFloatField;
    QLrnomor: TMemoField;
    QBs2: TUniQuery;
    IntegerField1: TIntegerField;
    MemoField1: TMemoField;
    MemoField2: TMemoField;
    MemoField3: TMemoField;
    MemoField4: TMemoField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    fxDBBs2: TfrxDBDataset;
    QBSDet: TUniQuery;
    fxDBBsDet: TfrxDBDataset;
    QLRDet: TUniQuery;
    fxDBLrDet: TfrxDBDataset;
    QCfDet: TUniQuery;
    fxDBCfDet: TfrxDBDataset;
    QECDet: TUniQuery;
    fxDBecDet: TfrxDBDataset;
    QBSDet2: TUniQuery;
    fxDBBsDet2: TfrxDBDataset;
    QBSDettingkat: TIntegerField;
    QBSDetnomor: TMemoField;
    QBSDetkode_rek: TMemoField;
    QBSDetvkode: TMemoField;
    QBSDetnama_rek: TMemoField;
    QBSDetsaldo: TFloatField;
    QBSDet2tingkat: TIntegerField;
    QBSDet2nomor: TMemoField;
    QBSDet2kode_rek: TMemoField;
    QBSDet2vkode: TMemoField;
    QBSDet2nama_rek: TMemoField;
    QBSDet2saldo: TFloatField;
    QLRDetnomor: TMemoField;
    QLRDetkode_rek: TMemoField;
    QLRDetvkode: TMemoField;
    QLRDetnama_rek: TMemoField;
    QLRDetsaldo_n: TFloatField;
    QLRDetlvl: TIntegerField;
    QLRDettipe: TMemoField;
    QCftingkat: TIntegerField;
    QCfkode: TMemoField;
    QCfuraian: TMemoField;
    QCfjumlah: TFloatField;
    Panel1: TPanel;
    Label10: TLabel;
    dpBs: TDateTimePicker;
    ckDetail: TCheckBox;
    frLR: TfrxReport;
    frCF: TfrxReport;
    frEC: TfrxReport;
    acTampilkan: TAction;
    frxDBDataset1: TfrxDBDataset;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acCloseExecute(Sender: TObject);
    procedure acTampilkanExecute(Sender: TObject);
    procedure frBSPreview(Sender: TObject);
    procedure frLRPreview(Sender: TObject);
    procedure frCFPreview(Sender: TObject);
    procedure frECPreview(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure PrintBS;
    procedure PrintLR;
    procedure PrintCF;
    procedure PrintEC;

  public
    { Public declarations }
  end;

var
  FPrintBsLrCfEc: TFPrintBsLrCfEc;

implementation

uses u_display_text, u_select_kode_name, u_frutils, u_select_master_detail;

{$R *.dfm}

procedure TFPrintBsLrCfEc.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFPrintBsLrCfEc.acTampilkanExecute(Sender: TObject);
begin
  case PageControl1.ActivePageIndex of
    0: begin
      PrintBS;
    end;
    1: begin
      PrintLR;
    end;
    2: begin
      PrintCF;
    end;
    3: begin
      PrintEC;
    end;
  end;
end;

procedure TFPrintBsLrCfEc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TFPrintBsLrCfEc.FormCreate(Sender: TObject);
var
  i: integer;
begin
  dpBs.Date := Date();
  PageControl1.ActivePageIndex := 0;
end;

procedure TFPrintBsLrCfEc.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  c: char;
  num: integer;
begin
  if not ([ssShift] = Shift) then
    exit;
  c := chr(key);
  if not (c in ['1'..'9'])then
    exit;
  num := _i(c,0);
  if not (num in[1..PageControl1.PageCount]) then
    exit;
  PageControl1.ActivePageIndex := num-1;

end;

procedure TFPrintBsLrCfEc.frBSPreview(Sender: TObject);
var
   frmPreview: TfrxPreviewForm;
begin
   frBS.PreviewOptions.Modal := False;
   frmPreview := TfrxPreviewForm(frBS.PreviewForm);
   frmPreview.BorderStyle := bsNone;
   frmPreview.Parent:=PageControl1.ActivePage;
   frmPreview.Align := alClient;
end;

procedure TFPrintBsLrCfEc.frCFPreview(Sender: TObject);
var
   frmPreview: TfrxPreviewForm;
begin
   frCf.PreviewOptions.Modal := False;
   frmPreview := TfrxPreviewForm(frCf.PreviewForm);
   frmPreview.BorderStyle := bsNone;
   frmPreview.Parent:=PageControl1.ActivePage;
   frmPreview.Align := alClient;
end;

procedure TFPrintBsLrCfEc.frECPreview(Sender: TObject);
var
   frmPreview: TfrxPreviewForm;
begin
   frEc.PreviewOptions.Modal := False;
   frmPreview := TfrxPreviewForm(frEc.PreviewForm);
   frmPreview.BorderStyle := bsNone;
   frmPreview.Parent:=PageControl1.ActivePage;
   frmPreview.Align := alClient;
end;

procedure TFPrintBsLrCfEc.frLRPreview(Sender: TObject);
var
   frmPreview: TfrxPreviewForm;
begin
   frLR.PreviewOptions.Modal := False;
   frmPreview := TfrxPreviewForm(frLR.PreviewForm);
   frmPreview.BorderStyle := bsNone;
   frmPreview.Parent:=PageControl1.ActivePage;
   frmPreview.Align := alClient;
end;

procedure TFPrintBsLrCfEc.PrintBS;
var
  tgl1, tgl2: TDateTime;
  rpt: String;
begin
  tgl1 := AwalTahun(dpBs.Date);
  tgl2 := dpBs.Date;
  // ShowText(FMain.KodeCabang+#13#10+DateToSQL(tgl1)+#13#10+DateToSQL(tgl2)+#13#10+ButtonedEdit1.HiddenText);
  if ckDetail.Checked then
    rpt := FMain.ReportsDir+'\pjss_bs_det.fr3'
  else
    rpt := FMain.ReportsDir+'\pjss_bs.fr3';
  if not FileExists(rpt) then
  begin
    Warn('File laporan "'+rpt+'" tidak ditemukan!');
    exit;
  end;
  if QBS.Active then
    QBS.Close;
  if QBs2.Active then
    QBS2.Close;
  if QBSDet.Active then
    QBSDet.Close;
  if QBSDet2.Active then
    QBSDet2.Close;
  ScreenBussy;
  QBS.DisableControls;
  try
    if ckDetail.Checked then
    begin
      QBSDet.ParamByName('cabang').AsString := CurrentUser.KodeCabang;
      QBSDet.ParamByName('tgl1').AsDateTime := tgl1;
      QBSDet.ParamByName('tgl2').AsDateTime := tgl2;
      QBSDet.Open;
      QBSDet2.ParamByName('cabang').AsString := CurrentUser.KodeCabang;
      QBSDet2.ParamByName('tgl1').AsDateTime := tgl1;
      QBSDet2.ParamByName('tgl2').AsDateTime := tgl2;
      QBSDet2.Open;
    end
    else
    begin
      QBS.ParamByName('cabang').AsString := CurrentUser.KodeCabang;
      QBS.ParamByName('tgl1').AsDateTime := tgl1;
      QBS.ParamByName('tgl2').AsDateTime := tgl2;
      QBS.ParamByName('level').AsInteger := 3;
      QBS.ParamByName('thn1').AsString := 'N';
      QBS.Open;
      QBS2.ParamByName('cabang').AsString := CurrentUser.KodeCabang;
      QBS2.ParamByName('tgl1').AsDateTime := tgl1;
      QBS2.ParamByName('tgl2').AsDateTime := tgl2;
      QBS2.ParamByName('level').AsInteger := 3;
      QBS2.ParamByName('thn1').AsString := 'N';
      QBS2.Open;
    end;
    frBS.LoadFromFile(rpt);
    // FRMemo(frxReport1, 'MTahun').Text := 'TAHUN '+cbTahunBs.Items[cbTahunBs.ItemIndex];
    FRMemo(frBS, 'MTanggal').Text := _u(DateIndo(tgl2));
    // FRMemo(frxReport1, 'MTahun2').Text := 'TAHUN '+cbTahunBs.Items[cbTahunBs.ItemIndex];
    FRMemo(frBS, 'MTanggal2').Text := _u(DateIndo(tgl2));
    with frBS do
    begin
      // PrepareReport();
      ShowReport();
      {
      PreviewForm.Tag      := 6589;
      PreviewForm.Caption  := 'Neraca Tahun '+cbTahunBs.Items[cbTahunBs.ItemIndex];
      PreviewForm.OnCreate := FMain.OnReportCreated;
      PreviewForm.OnCreate(PreviewForm);
      }
      // PreviewForm.OnActivate(PreviewForm);
    end;
  finally
    ScreenIdle;
  end;
end;

procedure TFPrintBsLrCfEc.PrintCF;
var
  tgl1, tgl2: TDateTime;
  rpt: String;
begin
  if ckDetail.Checked then
  begin
    Inform('Arus Kas detail tidak tersedia...');
    exit;
  end;
  tgl1 := AwalBulan(dpBs.Date);
  tgl2 := dpBs.Date;
  // ShowText(FMain.KodeCabang+#13#10+DateToSQL(tgl1)+#13#10+DateToSQL(tgl2)+#13#10+ButtonedEdit1.HiddenText);
  if ckDetail.Checked then
    rpt := FMain.ReportsDir+'\pjss_cf_det.fr3'
  else
    rpt := FMain.ReportsDir+'\pjss_cf.fr3';
  if not FileExists(rpt) then
  begin
    Warn('File laporan "'+rpt+'" tidak ditemukan!');
    exit;
  end;
  if QCf.Active then
    QCf.Close;
  if QCfDet.Active then
    QCfDet.Close;
  ScreenBussy;
  QCf.DisableControls;
  try
    if ckDetail.Checked then
    begin
      QCfDet.ParamByName('cabang').AsString := CurrentUser.KodeCabang;
      QCfDet.ParamByName('tgl1').AsDateTime := tgl1;
      QCfDet.ParamByName('tgl2').AsDateTime := tgl2;
      QCfDet.Open;
    end
    else
    begin
      QCf.ParamByName('cabang').AsString := CurrentUser.KodeCabang;
      QCf.ParamByName('tgl1').AsDateTime := tgl1;
      QCf.ParamByName('tgl2').AsDateTime := tgl2;
      QCf.Open;
    end;
    frCF.LoadFromFile(rpt);
    FRMemo(frCF, 'MTanggal').Text := _u(DateIndo(AwalTahun(tgl1))) +' SAMPAI '+_u(DateIndo(tgl2));
    with frCF do
    begin
      ShowReport();
    end;
  finally
    ScreenIdle;
  end;

end;

procedure TFPrintBsLrCfEc.PrintEC;
begin
  //
end;

procedure TFPrintBsLrCfEc.PrintLR;
var
  tgl1, tgl2: TDateTime;
  rpt: String;
  report: TfrxReport;
begin
  tgl1 := AwalTahun(dpBs.Date);
  tgl2 := dpBs.Date;
  // ShowText(FMain.KodeCabang+#13#10+DateToSQL(tgl1)+#13#10+DateToSQL(tgl2)+#13#10+ButtonedEdit1.HiddenText);
  if ckDetail.Checked then
    rpt := FMain.ReportsDir+'\pjss_lr_det.fr3'
  else
    rpt := FMain.ReportsDir+'\pjss_lr.fr3';
  if not FileExists(rpt) then
  begin
    Warn('File laporan "'+rpt+'" tidak ditemukan!');
    exit;
  end;
  QLr.DisableControls;
  QLRDet.DisableControls;
  if QLr.Active then
    QLr.Close;
  if QLRDet.Active then
    QLRDet.Close;
  ScreenBussy;
  report := frLR;
  try
    if ckDetail.Checked then
    begin
      QLRDet.ParamByName('cabang').AsString := CurrentUser.KodeCabang;
      QLRDet.ParamByName('tgl1').AsDateTime := tgl1;
      QLRDet.ParamByName('tgl2').AsDateTime := tgl2;
      QLr.Open;
    end
    else
    begin
      QLr.ParamByName('cabang').AsString := CurrentUser.KodeCabang;
      QLr.ParamByName('tgl1').AsDateTime := tgl1;
      QLr.ParamByName('tgl2').AsDateTime := tgl2;
      QLr.Open;
    end;
    frLR.LoadFromFile(rpt);
    FRMemo(frLR, 'MTanggal').Text := _u(DateIndo(AwalTahun(tgl2))) +' SAMPAI '+_u(DateIndo(tgl2));
    // FRMemo(frxReport1, 'MTahun').Text := _u(NamaBulan(tgl2))+' '+ _s(Tahun(tgl2));
    with frLR do
    begin
      // PrepareReport();
      ShowReport();
      {
      PreviewForm.Tag      := 6589;
      PreviewForm.Caption  := 'Laba (Rugi) Periode '+_u(DateIndo(AwalTahun(tgl2))) +' Sampai '+_u(DateIndo(tgl2));
      PreviewForm.OnCreate := FMain.OnReportCreated;
      PreviewForm.OnCreate(PreviewForm);
      // PreviewForm.OnActivate(PreviewForm);
      }
    end;
  finally
    ScreenIdle;
  end;
end;

end.
