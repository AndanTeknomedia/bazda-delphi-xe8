unit u_jurnal_pb_kas_bank;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ToolWin, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  ExtCtrls, StdCtrls, DBGridEhGrouping, GridsEh, DBGridEh, DB, MemDS,
  DBAccess, Menus, ToolCtrlsEh,
  DBGridEhToolCtrls, DBAxisGridsEh, DynVarsEh, Uni, u_utils, u_dbgrideh_dac_helper,
  DBCtrls, MemTableDataEh, MemTableEh, frxClass, frxPreview, Mask, JvExMask,
  JvToolEdit, JvBaseEdits, ComCtrls, JvExControls, JvEnterTab, VirtualTable,
  Grids, DBGrids, frxDBSet, System.Actions, EhLibVCL, JvExExtCtrls,
  JvExtComponent, JvCaptionPanel;

type
  TFJurnalPinbukKasBank = class(TForm)
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    acClose: TAction;
    acNew: TAction;
    acSave: TAction;
    QDet: TUniQuery;
    QDetkode: TStringField;
    QDetref_jurnal: TStringField;
    QDetskode: TIntegerField;
    QDetkode_rek: TStringField;
    QDetdebet: TFloatField;
    QDetkredit: TFloatField;
    QDeturaian: TMemoField;
    QDetref_table: TStringField;
    QDetref_kode: TStringField;
    Panel7: TPanel;
    Panel2: TPanel;
    Bevel2: TBevel;
    Button3: TButton;
    Button4: TButton;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    eTanggal: TDateTimePicker;
    eBukti: TEdit;
    eUraian: TMemo;
    gb1: TGroupBox;
    gb2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    cbJenis: TComboBox;
    Label3: TLabel;
    eBank: TButtonedEdit;
    eKas: TButtonedEdit;
    eTerima: TJvCalcEdit;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acCloseExecute(Sender: TObject);
    procedure acNewExecute(Sender: TObject);
    procedure acSaveExecute(Sender: TObject);
    procedure cbJenisChange(Sender: TObject);
    procedure eBankRightButtonClick(Sender: TObject);
  private
    { Private declarations }
    BankMasuk: Boolean;
  public
    { Public declarations }
  end;

var
  FJurnalPinbukKasBank: TFJurnalPinbukKasBank;

implementation

uses u_display_text, u_select_master_detail, umain, u_login_otf;

{$R *.dfm}

procedure TFJurnalPinbukKasBank.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFJurnalPinbukKasBank.acNewExecute(Sender: TObject);
var
  jj: integer;
  baseBank: String;
begin
  cbJenis.ItemIndex := -1;
  eBukti.Clear;
  eUraian.Clear;
  FocusTo(eTanggal);
  cbJenisChange(cbJenis);
end;

procedure TFJurnalPinbukKasBank.acSaveExecute(Sender: TObject);
var
  sjur: String;
  kdjur: String;
  e: integer;
  tglSvr,
  tglJur: TDate;
  approvedByAdmin: Boolean;
  jml: Double;
begin
  jml := 0;
  tglSvr := ServerDate();
  tglJur := eTanggal.Date;
  approvedByAdmin := true;
  if tglJur < awalBulan(tglSvr) then
  begin
    approvedByAdmin := LoginOTF('Transaksi di bulan-bulan yang lalu perlu approval Admin.'#13'Persilahkan Admin login:');
  end;
  if not approvedByAdmin then
    exit;
  // Inform('Start..');
  if eBukti.WarnForEmpty('Bukti transaksi masih kosong.') then
    exit;
  if length(eUraian.Text)=0 then
  begin
    Warn('Keterangan transaksi masih kosong.');
    FocusTo(eUraian);
    exit;
  end;
  if eKas.WarnForEmpty() then exit;
  if eBank.WarnForEmpty() then exit;
  if not QDet.Active then
    QDet.Open;

  sjur := 'INSERT INTO acc_jurnal_u( '+
    'jenis_jurnal, branch_kode, tahun, user_id, ref_table,ref_kode, tanggal, no_bukti, uraian'+
    ', jenis_trans) VALUES ('+
    _iif(cbJenis.ItemIndex=0, '''BMKK''', '''BKMM''')+', '+
    _q(CurrentUser.KodeCabang)+', '+
    _s(Tahun(tglJur))+', '+
    _s(CurrentUser.ID)+', '+
    _q('')+', '+
    _q('')+', '+
    _q(DateToSQL(tglJur))+', '+
    _q(eBukti.Text)+', '+
    _q(eUraian.Text)+ ', ''1101'') returning kode';
  e := 0;
  QDet.Connection.StartTransaction;
  try
    try
      with ExecSQL(sjur) do
      begin
        kdjur := Fields[0].AsString;
        Free;
      end;
    except
      inc(e);
    end;
    if e>0 then
    begin
      ShowDefaultError;
      exit;
    end;
    if cbJenis.ItemIndex = 0 then
    begin
      QDet.Append;
      QDetref_jurnal.AsString := kdjur;
      QDetkode_rek.AsString   := eBank.HiddenText;
      QDeturaian.AsString     := copy(eBank.Text, 16, length(eBank.Text)-15);
      QDetdebet.AsFloat       := eTerima.Value;
      QDetkredit.AsFloat      := 0;
      try QDet.Post ; except inc(e) end;
      QDet.Append;
      QDetref_jurnal.AsString := kdjur;
      QDetkode_rek.AsString   := ekas.HiddenText;
      QDeturaian.AsString     := copy(eKas.Text, 16, length(eKas.Text)-15);
      QDetdebet.AsFloat       := 0;
      QDetkredit.AsFloat      := eTerima.Value;
      try QDet.Post ; except inc(e) end;
    end
    else
    begin
      QDet.Append;
      QDetref_jurnal.AsString := kdjur;
      QDetkode_rek.AsString   := ekas.HiddenText;
      QDeturaian.AsString     := copy(eKas.Text, 16, length(eKas.Text)-15);
      QDetdebet.AsFloat       := eTerima.Value;
      QDetkredit.AsFloat      := 0;
      try QDet.Post ; except inc(e) end;
      QDet.Append;
      QDetref_jurnal.AsString := kdjur;
      QDetkode_rek.AsString   := eBank.HiddenText;
      QDeturaian.AsString     := copy(eBank.Text, 16, length(eBank.Text)-15);
      QDetdebet.AsFloat       := 0;
      QDetkredit.AsFloat      := eTerima.Value;
      try QDet.Post ; except inc(e) end;
    end;
  finally
    if e > 0 then
    begin
      QDet.Connection.Rollback;
      ShowDefaultError;
    end
    else
    begin
      QDet.Connection.Commit;
      MsgBoxTimeout('Sukses', 'Jurnal tersimpan...', 3);
      acNew.Execute;
    end;
  end;
end;

procedure TFJurnalPinbukKasBank.cbJenisChange(Sender: TObject);
begin
  if cbJenis.ItemIndex = 0 then
  begin
    eKas.SetEnabled(true);
    eBank.SetEnabled(true);
    gb1.Caption := 'DISETOR KE:  ';
    gb2.Caption := 'DISETOR DARI:  ';
  end
  else
  if cbJenis.ItemIndex = 1 then
  begin
    eKas.SetEnabled(true);
    eBank.SetEnabled(true);
    gb1.Caption := 'DITARIK DARI:  ';
    gb2.Caption := 'MASUK KE:  ';
  end
  else
  begin
    eKas.SetEnabled(false);
    eBank.SetEnabled(false);
    gb1.Caption := 'JENIS TIDAK VALID';
    gb2.Caption := 'JENIS TIDAK VALID';
  end;
end;

procedure TFJurnalPinbukKasBank.eBankRightButtonClick(Sender: TObject);
var
  be: TButtonedEdit;
  sl: TStringList;
  s: string;
begin
  be := TButtonedEdit(Sender);
  if be = eKas then
    s :=
      'select pkode, kode, full_kode, vkode, rekening from v_coa_2 where '+
      ' (kode like '+_q(Fmain.BaseKas+'%')+ ') '+
      ' order by full_kode asc'
  else
    s :=
      'select pkode, kode, full_kode, vkode, rekening from v_coa_2 where '+
      ' (kode like '+_q(Fmain.BaseBank+'%')+ ') '+
      ' order by full_kode asc';
  sl := SelectMasterDetail(
    GetGlobalConnection,
    s,
    ['full_kode', 'vkode', 'rekening'],
    'pkode','kode',
    2,
    ['','Kode','Uraian'],
    [0,80,280],
    false,700, 400, 'Pilih Akun Penerimaan'
  );
  if sl.Count>0 then
  begin
    be.SetValues( sl[1]+' - '+sl[2], sl[0] );
  end;
  sl.Free;
end;

procedure TFJurnalPinbukKasBank.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TFJurnalPinbukKasBank.FormCreate(Sender: TObject);
begin
  eTanggal.Date := Date();
  acNew.Execute;
end;

end.
