unit u_upz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ToolWin, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  ExtCtrls, StdCtrls, DBGridEhGrouping, GridsEh, DBGridEh, DB, MemDS,
  DBAccess, Menus, ToolCtrlsEh,
  DBGridEhToolCtrls, DBAxisGridsEh, DynVarsEh, Uni, umain, u_utils,
  frxClass, frxDBSet, Grids, DBGrids, System.Actions, EhLibVCL,
  Vcl.ComCtrls,
  u_dbgrideh_dac_helper;

type
  TFUPZ = class(TForm)
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    acClose: TAction;
    acRefresh: TAction;
    acPrint: TAction;
    QKas: TUniQuery;
    DataSource1: TDataSource;
    Panel1: TPanel;
    frxReport1: TfrxReport;
    QKaskode: TMemoField;
    QKaskode_jenis_jurnal: TMemoField;
    QKasbranch_kode: TMemoField;
    QKastanggal: TDateField;
    QKasno_bukti: TMemoField;
    QKasuraian: TMemoField;
    QKaskode_detail: TMemoField;
    QKaskode_rek: TMemoField;
    QKasdebet: TFloatField;
    QKaskredit: TFloatField;
    QKassaldo: TFloatField;
    QKasuraian_detail: TMemoField;
    gerek: TDBGridEh;
    frxGLList: TfrxDBDataset;
    lKet: TLabel;
    acDetJurnal: TAction;
    PopupMenu1: TPopupMenu;
    DetailJurnal1: TMenuItem;
    Label10: TLabel;
    dpStart: TDateTimePicker;
    Label3: TLabel;
    dpBs: TDateTimePicker;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acCloseExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbBulanChange(Sender: TObject);
    procedure acPrintExecute(Sender: TObject);
    procedure gerekKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure frxReport1Preview(Sender: TObject);
    procedure acDetJurnalExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FUPZ: TFUPZ;


implementation

uses u_display_text, u_select_kode_name, u_frutils, u_select_master_detail,
  u_jurnal;

{$R *.dfm}


procedure TFUPZ.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFUPZ.acDetJurnalExecute(Sender: TObject);
var
  AksesCheck,
  AksesApprove: Boolean;
begin
  AksesCheck :=  AccessibleBy(CurrentUser, 'check_jurnal');
  AksesApprove :=  AccessibleBy(CurrentUser, 'approve_jurnal');
  if not (AksesCheck or AksesApprove) then
  begin
    Inform('Anda perlu salah satu hak akses berikut: '#13'* Check/Verifikasi Jurnal'#13'* Approve Jurnal');
    exit;
  end;
  if QKas.IsEmpty then
  begin
    Inform('Tidak ada data untuk diprint.');
    exit;
  end;
  SHowJurnal(QKaskode.AsString);
end;

procedure TFUPZ.acPrintExecute(Sender: TObject);
var
  rpt: String;
  bm: TBookmark;
  codes: TStringList;
  i: integer;
  wherecode: String;
begin
  if QKas.IsEmpty then
  begin
    Inform('Tidak ada data untuk diprint.');
    exit;
  end;
  rpt := FMain.ReportsDir+'\pjss_daftar_jurnal.fr3';
  if not FileExists(rpt) then
  begin
    Warn('File laporan "'+rpt+'" tidak ditemukan!');
    exit;
  end;

  bm := QKas.GetBookmark;
  QKas.DisableControls;
  try
    frxReport1.LoadFromFile(rpt);

    frxReport1.ShowReport();
  finally
    if QKas.BookmarkValid(bm) then
      QKas.GotoBookmark(bm);
    QKas.EnableControls;
  end;
end;

procedure TFUPZ.cbBulanChange(Sender: TObject);
begin
  acRefresh.Execute;
end;

procedure TFUPZ.gerekKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if chr(key) in ['a'..'z','A'..'Z','0'..'9'] then
  begin
    SendCtrlF;
  end
  else
  if Key = VK_UP then
  begin
    if QKas.Bof then
      SendCtrlF;
  end
  else
  if Key = VK_Down then
  begin
    if QKas.Eof then
      SendCtrlF;
  end;
end;

procedure TFUPZ.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TFUPZ.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key <> VK_F3 then
    exit;
  key := 0;
  SendCtrlF;
end;

procedure TFUPZ.frxReport1Preview(Sender: TObject);
begin
  AddMDIReport(TFrxReport(Sender), 'Report - GL');
end;

end.
