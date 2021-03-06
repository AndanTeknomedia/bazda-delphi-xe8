unit u_terima_zis;

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
  JvExtComponent, JvCaptionPanel, JvButton, JvTransparentButton, PersenDanNilai;

type
  TFTerimaZIS = class(TForm)
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    acClose: TAction;
    dsAdd: TDataSource;
    Panel7: TPanel;
    pmAdd: TPopupMenu;
    HapusSemua1: TMenuItem;
    acNew: TAction;
    acSave: TAction;
    Panel2: TPanel;
    Bevel2: TBevel;
    Button3: TButton;
    Button4: TButton;
    vtAdd: TVirtualTable;
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
    cap1: TJvCaptionPanel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label1: TLabel;
    eTanggal: TDateTimePicker;
    eUraian: TMemo;
    eVia: TButtonedEdit;
    QDetnama: TStringField;
    Panel1: TPanel;
    QKel: TUniQuery;
    QKelkode: TStringField;
    QKelnama: TStringField;
    Label3: TLabel;
    dsKel: TDataSource;
    qUPZ: TUniQuery;
    dsUpz: TDataSource;
    eAlamat: TEdit;
    qUPZjenis: TStringField;
    qUPZnpwz: TStringField;
    qUPZnama: TStringField;
    qUPZalamat: TMemoField;
    qUPZkelurahan: TStringField;
    Label4: TLabel;
    eTerima: TJvCalcEdit;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    ePersenAmil: TJvCalcEdit;
    Label9: TLabel;
    eHakAmilBaznas: TPersenDanNilai;
    geAdd: TDBGridEh;
    vtAddKode: TStringField;
    vtAddKodeAkun: TStringField;
    vtAddJenisPenerimaan: TStringField;
    vtAddJumlah: TFloatField;
    eMZK: TButtonedEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acCloseExecute(Sender: TObject);
    procedure HapusSemua1Click(Sender: TObject);
    procedure acNewExecute(Sender: TObject);
    procedure acSaveExecute(Sender: TObject);
    procedure eViaRightButtonClick(Sender: TObject);
    procedure vtAddAfterDelete(DataSet: TDataSet);
    procedure eTerimaChange(Sender: TObject);
    procedure eMZKRightButtonClick(Sender: TObject);
  private
    { Private declarations }
    function sqlSelectVia: String;
  public
    { Public declarations }
    BaseRek,
    KodeMuzakki : String;
    JenisDana,
    JenisZIS: tperkiraan;
  end;

var
  FTerimaZIS: TFTerimaZIS;

implementation

uses u_display_text, u_select_master_detail, umain, u_login_otf,
  u_select_kode_name, u_pilih_opsi, u_new_muzaki, u_get_jenis_distribusi_dana;

{$R *.dfm}

procedure TFTerimaZIS.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFTerimaZIS.acNewExecute(Sender: TObject);
var
  jj: integer;
begin
  eMZK.Clear;
  eVia.Clear;
  eAlamat.SetValues('', '');
  eUraian.Clear;
  BaseRek := '4';
  FocusTo(eTanggal);
  HapusSemua1.Click;
end;

procedure TFTerimaZIS.acSaveExecute(Sender: TObject);
var
  sjur: String;
  kdjur: String;
  i, e: integer;
  tglSvr,
  tglJur: TDate;
  approvedByAdmin: Boolean;
  jml: Double;
  tipeUPZ,
  NPWZ,
  Uraian,
  RekVia,
  Kelurahan,
  InputCode: string;
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
  if eMZK.HiddenText = '' then
  begin
    Warn('Muzakki masih kosong.');
    FocusTo(eMZK);
    exit;
  end;
  if eVia.WarnForEmpty('Rekening Penerimaan Dana masih kosong.') then
    exit;
  if length(eUraian.Text)=0 then
  begin
    Warn('Keterangan masih kosong.');
    FocusTo(eUraian);
    exit;
  end;
  if vtAdd.IsEmpty then
  begin
    Warn('Rincian Penerimaan masih kosong.');
    FocusTo(geAdd);
    exit;
  end;
  tglJur := eTanggal.Date;
  NPWZ    := eMZK.HiddenText;
  Uraian := eUraian.Text;
  RekVia := eVia.HiddenText;
  Randomize;
  InputCode := 'IBZ'+MD5(RandomPassword(32)+DateTimeToSQL(now)+IntToStr(Random(3883672)));
  // create transaction for multiple insertions:
  e := 0;
  StartTrans;
  if not QDet.Active then
    QDet.Open;
  // Save data penerimaan:
  sjur := 'INSERT INTO acc_jurnal_u( '+
    'jenis_jurnal, branch_kode, '+
    'tahun, user_id, ref_table, ref_kode, '+
    'tanggal, no_bukti, uraian, '+
    'jenis_trans, npwz, nama, input_code ) VALUES ('+
    _q('JIBZ')+', '+
    _q(CurrentUser.KodeCabang)+', '+
    _s(Tahun(tglJur))+', '+
    _s(CurrentUser.ID)+', '+
    _q('')+', '+
    _q('')+', '+
    _q(DateToSQL(tglJur))+', '+
    _q('JIBZ/'+NPWZ)+', '+
    _q('Transaksi '+JenisZIS.rekening+' Dari Muzakki: '+NPWZ+'/'+
      qUPZnama.AsString+', Ket.: '+Uraian)+ ', '+
    _q(copy(JenisDana.kode,1,4))+', '+
    _q(NPWZ)+', '+
    _q(qUPZnama.AsString)+ ', '+
    _q(InputCode)+
    ') returning kode';
  try
    kdjur := ExecSQLAndFetchOneValueAsString(sjur, '');
    if kdjur <> '' then
    begin
      // insert Kas/Bank penerima:
      jml := eTerima.Value;
      QDet.Append;
      QDetref_jurnal.AsString := kdjur;
      QDetkode_rek.AsString := eVia.HiddenText;
      QDeturaian.AsString := copy(eVia.Text, 16, length(eVia.Text)-15);
      QDetdebet.AsFloat := jml;
      QDetkredit.AsFloat := 0;
      QDetnama.AsString := NPWZ+' ('+ qUPZnama.AsString +')';
      try QDet.Post ; except inc(e) end;
      // insert rekening penerimaan zakat
      vtAdd.DisableControls;
      try
        vtAdd.First;
        while not vtAdd.Eof do
        begin
          if e>0 then break;
          if vtAddJumlah.AsFloat<>0 then
          begin
            QDet.Append;
            QDetref_jurnal.AsString := kdjur;
            QDetkode_rek.AsString := vtAddKode.AsString;
            QDeturaian.AsString := vtAddJenisPenerimaan.AsString;
            QDetdebet.AsFloat := 0;
            QDetkredit.AsFloat := vtAddJumlah.AsFloat;
            QDetnama.AsString := NPWZ +' ('+ qUPZnama.AsString +')';
            QDetref_kode.AsString := NPWZ;
            try QDet.Post ; except inc(e) end;
          end;
          vtAdd.Next;
        end;
      finally
        vtAdd.First;
        vtAdd.EnableControls;
      end;
      // kolorari dana hak amil:
      QDet.Append;
      QDetref_jurnal.AsString := kdjur;
      QDetkode_rek.AsString   := FMain.rekDanaAmil;
      QDeturaian.AsString     := 'Bagian Hak Amil';
      QDetdebet.AsFloat       := 0;
      QDetkredit.AsFloat      := eHakAmilBaznas.Nilai;
      QDetnama.AsString       := 'Amil';
      try QDet.Post ; except inc(e) end;
      QDet.Append;
      QDetref_jurnal.AsString := kdjur;
      QDetkode_rek.AsString   := JenisDana.kode;
      QDeturaian.AsString     := 'Potongan Bagian Amil';
      QDetdebet.AsFloat       := eHakAmilBaznas.Nilai;
      QDetkredit.AsFloat      := 0;
      QDetnama.AsString       := 'Amil';
      try QDet.Post ; except inc(e) end;
    end
    else
      inc(e);
  except
    inc(e);
  end;
  // cek transaksi:
  if e>0 then
  begin
    RollBackTrans;
    Deny('Penerimaan '+JenisDana.Rekening+' gagal.');
  end
  else
  begin
    CommitTrans;
    MsgBoxTimeout('Sukses', 'Penerimaan Dana Selesai.', 3);
    acNew.Execute;
  end;
end;

procedure TFTerimaZIS.eMZKRightButtonClick(Sender: TObject);
var
  sl: TStringList;
  b: TButtonedEdit;
begin
  b := TButtonedEdit(Sender);
  sl := FMain.PilihMuzaki('ORG');
  if sl.Count>0 then
  begin
    b.SetValues(sl[1], sl[0]);
    eAlamat.SetValues(sl[2], sl[4]);
  end
  else
  begin
    b.Clear;
    eAlamat.Clear;
  end;
  sl.Free;
end;

procedure TFTerimaZIS.eTerimaChange(Sender: TObject);
begin
  eHakAmilBaznas.NilaiDasar := eTerima.Value;
  eHakAmilBaznas.Persen := ePersenAmil.Value;
end;

procedure TFTerimaZIS.eViaRightButtonClick(Sender: TObject);
var
  sl: TStringList;
begin
  sl := SelectMasterDetail(
    GetGlobalConnection,
    sqlSelectVia(),
    ['full_kode', 'vkode', 'rekening'],
    'pkode','kode',
    2,
    ['','Kode','Uraian'],
    [0,80,280],
    false,700, 400, 'Pilih Akun Penerimaan'
  );
  if sl.Count>0 then
  begin
    eVia.SetValues( sl[1]+' - '+sl[2], sl[0] );
  end;
  sl.Free;
end;

procedure TFTerimaZIS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TFTerimaZIS.FormCreate(Sender: TObject);
var
  q: TUniQuery;
  i: integer;
  ceh: TColumnEh;
  fn: string;
  f: TFieldDef;
  sl: TStringList;
begin
  eTanggal.Date := date;
  FMain.RefreshPersenAmil;
  JenisZIS.kode := '';
  JenisZIS.vkode := '';
  JenisZIS.Rekening := '';
  sl := TStringList.Create;
  try
    sl := SelectMasterDetail(
      GetGlobalConnection,
      'select pkode, kode, full_kode, format_vkode(full_kode) vkode, rekening from v_coa_2 where '+
        '(kode like ''4%'') and (tingkat in (1,2)) and (not (substr(kode,1,2) in (''49''))) order by full_kode asc',
      ['kode', 'vkode', 'rekening'],
      'pkode','kode',
      2,
      ['','Kode','Uraian'],
      [0,80,280],
      false,700, 400, 'Pilih Jenis Penerimaan'
    );
    if sl.Count<>0 then
    begin
      JenisZIS.kode := sl[0];
      JenisZIS.vkode := sl[1];
      JenisZIS.Rekening := sl[2];
    end;
  finally
    sl.Free;
  end;
  if JenisZIS.kode  = '' then
  begin
    close;
    exit;
  end;
  if copy(JenisZIS.kode,1,2) = '41' then
  begin
    jenisDana.kode  := '31010101';
    ePersenAmil.Value := FMain.PersenAmilDanaZakat;
  end
  else
  if copy(JenisZIS.kode,1,2) = '42' then
  begin
    jenisDana.kode  := '31020101';
    ePersenAmil.Value := FMain.PersenAmilDanaInfak;
  end
  else
  if copy(JenisZIS.kode,1,2) = '43' then
  begin
    jenisDana.kode  := '31030101';
    ePersenAmil.Value := FMain.PersenAmilDanaDSKL;
  end
  else
  if copy(JenisZIS.kode,1,2) = '44' then
  begin
    jenisDana.kode  := '31050101';
    ePersenAmil.Value := FMain.PersenAmilDanaCSR;
  end
  else
  if copy(JenisZIS.kode,1,2) = '45' then
  begin
    jenisDana.kode  := '31070101';
    ePersenAmil.Value := FMain.PersenAmilDanaHibah;
  end
  else
  if copy(JenisZIS.kode,1,2) = '46' then
  begin
    jenisDana.kode  := '31080101';
    // ePersenAmil.Value := FMain.PersenAmilDanaHibah;
    ePersenAmil.Value := 0;
  end
  else
  if copy(JenisZIS.kode,1,2) = '49' then
  begin
    jenisDana.kode  := '31090101';
    ePersenAmil.Value := 0;
  end;



  GroupBox1.Caption := 'Persentase Bagian Amil';
  Label8.Caption := 'Bagian Amil atas '+JenisZIS.Rekening+':';


  cap1.Caption := JenisZIS.vkode+' - '+JenisZIS.Rekening;
  eTanggal.Date := Date();
  acNew.Execute;
  if not QKel.Active then
    QKel.Open
  else
    QKel.Refresh;

  if not vtAdd.Active then
    vtAdd.Open;
  q := Query;
  // generate rekening penerimaan:
  if not vtAdd.Active then
    vtAdd.Open;
  q .sql.Text := 'select full_kode, vkode, '+
    'replace(replace(rekening, ''Penerimaan '',''''), ''Zakat Mal - '',''ZM - '') '+
    'rekening from v_coa_2 where (kode like '+_q(JenisZIS.kode+'%')+') '+
    'and (tingkat=5)  '+
    'order by full_kode asc';
  // ShowText(q .sql.Text);
  q.Open;
  if q.IsEmpty then
  begin
    Deny('Akun-Akun level 5 untuk '+JenisZIS.Rekening+' belum ada.');
    q.Free;
    Close;
    exit;
  end;
  q.First;
  while not q.Eof do
  begin
    vtAdd.AppendRecord([
      q.Fields[0].AsString,
      q.Fields[1].AsString,
      q.Fields[2].AsString,
      0
    ]);
    q.Next;
  end;
  q.Free;
  eTanggal.Date := Date();
  acNew.Execute;
end;

procedure TFTerimaZIS.HapusSemua1Click(Sender: TObject);
begin
  if not vtAdd.IsEmpty then
  begin
    vtAdd.DisableControls;
    try
      vtAdd.First;
      while not vtAdd.Eof do
      begin
        vtAdd.Edit;
        vtAddJumlah.AsFloat := 0;
        vtAdd.Post;
        vtAdd.Next;
      end;
    finally
      vtAdd.EnableControls;
    end;
  end;
end;

function TFTerimaZIS.sqlSelectVia: String;
begin
  Result :=
    'select pkode, kode, full_kode, vkode, rekening from v_coa_2 where '+
    ' ((kode like '+_q(Fmain.BaseKas+'%')+ ') or (kode like '+_q(Fmain.BaseBank+'%')+ ')) '+
    ' order by full_kode asc'
end;

procedure TFTerimaZIS.vtAddAfterDelete(DataSet: TDataSet);
begin
  eTerima.Value := geAdd.Columns[2].Footer.SumValue;
end;

end.
