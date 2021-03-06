unit u_gl_old;

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
  TFGLOld = class(TForm)
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    acClose: TAction;
    acRefresh: TAction;
    acPrint: TAction;
    QKas: TUniQuery;
    DataSource1: TDataSource;
    Panel1: TPanel;
    frxReport1: TfrxReport;
    ButtonedEdit1: TButtonedEdit;
    Label1: TLabel;
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
    Label2: TLabel;
    lKet: TLabel;
    Button1: TButton;
    acDetJurnal: TAction;
    PopupMenu1: TPopupMenu;
    DetailJurnal1: TMenuItem;
    Label10: TLabel;
    dpStart: TDateTimePicker;
    Label3: TLabel;
    dpBs: TDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure acRefreshExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acCloseExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbBulanChange(Sender: TObject);
    procedure acPrintExecute(Sender: TObject);
    procedure ButtonedEdit1RightButtonClick(Sender: TObject);
    procedure gerekKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure frxReport1Preview(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure acDetJurnalExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FGLOld: TFGLOld;
function ShowGL(
  aKodeRek: string;
  Tgl1,
  Tgl2: TDateTime
): TFGLOld;

implementation

uses u_display_text, u_select_kode_name, u_frutils, u_select_master_detail,
  u_jurnal;

{$R *.dfm}

function ShowGL;
var
  i: integer;
begin
  Result := TFGL.Create(Application);
  Result.dpStart.Date := Tgl1;
  Result.dpBs.Date := Tgl2;
  if aKodeRek <> '' then
  begin
    with ExecSQL('SELECT kode, rekening, vkode FROM v_coa_2 where kode = '+_q(aKodeRek)+' order by kode asc') do
    begin
      if not IsEmpty then
      begin
        first;
        Result.ButtonedEdit1.HiddenText := aKodeRek;
        Result.ButtonedEdit1.Text := Fields[2].AsString+' - '+Fields[1].AsString;
      end
      else
        Result.ButtonedEdit1.Clear;
      Free;
    end;
  end
  else
  begin
    Result.ButtonedEdit1.HiddenText := GetOption(CurrentUser.KodeCabang+'-FGLdefkoderek', true);
    Result.ButtonedEdit1.Text := GetOption(CurrentUser.KodeCabang+'-FGLdefnamarek', true);
  end;
  Result.SHow;
  Result.acRefresh.Execute;
end;

procedure TFGLOld.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFGLOld.acDetJurnalExecute(Sender: TObject);
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

procedure TFGLOld.acPrintExecute(Sender: TObject);
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
    FRMemo(frxReport1, 'MNamaAkun').Text := ButtonedEdit1.Text;
    FRMemo(frxReport1, 'MTgl').Text := DateIndo(dpStart.Date)+ ' s.d. '+ DateIndo(dpBs.Date);

    frxReport1.ShowReport();
  finally
    if QKas.BookmarkValid(bm) then
      QKas.GotoBookmark(bm);
    QKas.EnableControls;
  end;
end;

procedure TFGLOld.acRefreshExecute(Sender: TObject);
var
  tgl1, tgl2: TDateTime;
  d1, d2, d3,
  k1, k2, k3,
  s1, s2, s3: Double;
  tipe: String;
  akunReal: boolean;
begin
  if ButtonedEdit1.HiddenText = '' then
  begin
    Inform('Pilih akun yang akan ditampilkan.');
    FocusTo(ButtonedEdit1);
    exit;
  end;
  d1 := 0;
  d2 := 0;
  d3 := 0;
  k1 := 0;
  k2 := 0;
  k3 := 0;
  s1 := 0;
  s2 := 0;
  s3 := 0;
  SetOption(CurrentUser.KodeCabang+'-FGLdefkoderek', ButtonedEdit1.HiddenText, true);
  SetOption(CurrentUser.KodeCabang+'-FGLdefnamarek', ButtonedEdit1.Text, true);
  if QKas.Active then
    QKas.Close;
  ScreenBussy;
  QKas.DisableControls;
  tgl1 := dpStart.Date;
  tgl2 := dpBs.Date;
  akunReal := ButtonedEdit1.HiddenText[1] in ['1', '2', '3'];
  tipe := ExecSQLAndFetchOneValueAsString('select tipe from v_coa_2 where full_kode = '+_q(Rpad( ButtonedEdit1.HiddenText, 8, '0')));
  if tipe = '' then
  begin
    Warn('Gagal Mengambil Tipe Akun. Jumlah perhitungan mungkin salah...');
    tipe := 'D';
  end;
  if _l(tipe) = 'd' then
    lket.Caption := 'Saldo = Debet-Kredit'
  else
    lket.Caption := 'Saldo = Kredit-Debet';
  try
    QKas.ParamByName('cabang').AsString := CurrentUser.KodeCabang;
    QKas.ParamByName('tgl1').AsDateTime := tgl1;
    QKas.ParamByName('tgl2').AsDateTime:= tgl2;
    QKas.ParamByName('akun').AsString := ButtonedEdit1.HiddenText;
    QKas.Open;
    with ExecSQL('select debet, kredit, saldo from get_saldo_rek('+_q(CurrentUser.KodeCabang)+', '+
      _Q(ButtonedEdit1.HiddenText)+', '+
      _q(
        _iif(akunReal,'1799-01-01', DateToSql(AwalTahun(tgl1)))
      )+', '+
      _q(DateToSQL(Tgl1-1))+', '+
      _q('N')+
    ');') do
    begin
      First;
      d1 := Fields[0].AsFloat;
      k1 := Fields[1].AsFloat;
      s1 := Fields[2].AsFloat;
      Free;
    end;
    with ExecSQL('select debet, kredit, saldo from get_saldo_rek('+_q(CurrentUser.KodeCabang)+', '+
      _Q(ButtonedEdit1.HiddenText)+', '+
      _q(DateToSQL(Tgl1))+', '+
      _q(DateToSQL(Tgl2))+', '+
      _q('N')+
    ');') do
    begin
      First;
      d2 := Fields[0].AsFloat;
      k2 := Fields[1].AsFloat;
      if akunReal then
      begin
        d2 := d2 - d1;
        k2 := k2 - k1;
      end;
      if _l(tipe) = 'd' then
      begin
        s2 := d2-k2;
      end
      else
      begin
        s2 := k2-d2;
      end;
      Free;
    end;
    with gerek do
    begin
      SumList.RecalcAll;
      if _l(tipe) = 'd' then
      begin
        d3 := d1+d2;
        k3 := k1+k2;
        s3 := s1+s2;
      end
      else
      begin
        d3 := d1+d2;
        k3 := k1+k2;
        s3 := s1+s2;
      end;
      {
      showtext(
        #13#10'd1='+ FloatToFinance(d1, false)+
        #9#9'k1='+ FloatToFinance(k1, false)+
        #9#9's1='+ FloatToFinance(s1, false)+

        #13#10'd2='+ FloatToFinance(d2, false)+
        #9#9'k2='+ FloatToFinance(k2, false)+
        #9#9's2='+ FloatToFinance(s2, false)+

        #13#10'd3='+ FloatToFinance(d3, false)+
        #9#9'k3='+ FloatToFinance(k3, false)+
        #9#9's3='+ FloatToFinance(s3, false)
      );
      }
      Columns[4].Footers[0].Value := FloatToFinance(d1, false);
      Columns[4].Footers[1].Value := FloatToFinance(d2, false);
      Columns[4].Footers[2].Value := FloatToFinance(d3, false);
      // -----------------------------
      Columns[5].Footers[0].Value := FloatToFinance(k1, false);
      Columns[5].Footers[1].Value := FloatToFinance(k2, false);
      Columns[5].Footers[2].Value := FloatToFinance(k3, false);
      // -----------------------------
      Columns[6].Footers[0].Value := FloatToFinance(s1, false);
      Columns[6].Footers[1].Value := FloatToFinance(s2, false);
      Columns[6].Footers[2].Value := FloatToFinance(s3, false);
    end;
  finally
    QKas.First;
    QKas.EnableControls;
    ScreenIdle;
  end;
end;

procedure TFGLOld.Button1Click(Sender: TObject);
begin
  FMain.JurnalUmum1.Click;
end;

procedure TFGLOld.ButtonedEdit1RightButtonClick(Sender: TObject);
var
  res: TStringList;
begin

  res := SelectMasterDetail(
    GetGlobalConnection,
    'SELECT tingkat, pkode, kode, rekening, tipe, full_kode, vkode FROM v_coa_2 order by kode asc',
    ['tingkat','vkode','rekening', 'kode'],
    'pkode', 'kode',
    5,
    ['Level', 'Kode', 'Rekening', ''],
    [30,90,300, 0],
    true, 500, 350, 'Pilih Akun'
  );
  if res.Count>0 then
  begin
    ButtonedEdit1.SetValues(res[1]+' - '+res[2], res[3]);
    acRefresh.Execute;
  end; 
  res.free; 
end;

procedure TFGLOld.cbBulanChange(Sender: TObject);
begin
  acRefresh.Execute;
end;

procedure TFGLOld.gerekKeyDown(Sender: TObject; var Key: Word;
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

procedure TFGLOld.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TFGLOld.FormCreate(Sender: TObject);
var
  i: integer;
begin
  ButtonedEdit1.Clear;
end;

procedure TFGLOld.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key <> VK_F3 then
    exit;
  key := 0;
  SendCtrlF;
end;

procedure TFGLOld.frxReport1Preview(Sender: TObject);
begin
  AddMDIReport(TFrxReport(Sender), 'Report - GL');
end;

end.
