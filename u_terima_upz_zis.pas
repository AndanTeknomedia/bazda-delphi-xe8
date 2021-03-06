unit u_terima_upz_zis;

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
  JvExtComponent, JvCaptionPanel, JvButton, JvTransparentButton, PersenDanNilai,
  System.Math;

type
  TFTerimaUPZNonFitrah = class(TForm)
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    acClose: TAction;
    dsAdd: TDataSource;
    Panel7: TPanel;
    pmAdd: TPopupMenu;
    Add1: TMenuItem;
    N1: TMenuItem;
    Hapus1: TMenuItem;
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
    vtAddNama: TStringField;
    Panel1: TPanel;
    eDisetor: TJvCalcEdit;
    Label2: TLabel;
    QKel: TUniQuery;
    QKelkode: TStringField;
    QKelnama: TStringField;
    vtAddKelurahan: TStringField;
    pmDist: TPopupMenu;
    ambahMustahik1: TMenuItem;
    N2: TMenuItem;
    Hapus2: TMenuItem;
    HapusSemua2: TMenuItem;
    Label3: TLabel;
    dsKel: TDataSource;
    vtAddNPWZ: TStringField;
    eAlamat: TEdit;
    Label4: TLabel;
    eTerima: TJvCalcEdit;
    Bevel1: TBevel;
    Label7: TLabel;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    ePersenAmil: TJvCalcEdit;
    Label9: TLabel;
    eUPZTerbayar: TJvCalcEdit;
    Label10: TLabel;
    Label14: TLabel;
    eUPZSisa: TJvCalcEdit;
    eHakAmilUPZ: TJvCalcEdit;
    eAmilBaznas: TJvCalcEdit;
    Label5: TLabel;
    Label6: TLabel;
    eUtang: TJvCalcEdit;
    ePiutang: TJvCalcEdit;
    eUPZ: TButtonedEdit;
    geAdd: TDBGridEh;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acCloseExecute(Sender: TObject);
    procedure Hapus1Click(Sender: TObject);
    procedure HapusSemua1Click(Sender: TObject);
    procedure Add1Click(Sender: TObject);
    procedure acNewExecute(Sender: TObject);
    procedure acSaveExecute(Sender: TObject);
    procedure eViaRightButtonClick(Sender: TObject);
    procedure vtAddAfterPost(DataSet: TDataSet);
    procedure qUPZAfterScroll(DataSet: TDataSet);
    procedure geAddColumns4EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure geDistColumns3EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure geAddColumns0EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure geDistColumns0EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure eUPZRightButtonClick(Sender: TObject);
    procedure eUPZTerbayarChange(Sender: TObject);
  private
    { Private declarations }
    function sqlSelectVia: String;
    function HitungSisa: Double;
  public
    { Public declarations }
    RekAmilUpz,
    BaseRek,
    KodeMuzakki : String;
    JenisDana,
    JenisZIS,
    JenisSalur: tperkiraan;
    UPZBolehMenyalurkan: Boolean;
  end;

var
  FTerimaUPZNonFitrah: TFTerimaUPZNonFitrah;

implementation

uses u_display_text, u_select_master_detail, umain, u_login_otf,
  u_select_kode_name, u_pilih_opsi, u_new_muzaki, u_get_jenis_distribusi_dana,
  u_new_mustahik;

{$R *.dfm}

procedure TFTerimaUPZNonFitrah.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFTerimaUPZNonFitrah.acNewExecute(Sender: TObject);
var
  jj: integer;
begin
  eUPZ.Clear;
  eVia.Clear;
  eAlamat.SetValues('', '');
  eUraian.Clear;
  EmptyDataset(vtAdd);
  BaseRek := '4';
  eUPZTerbayar.Value := 0;
  eUPZTerbayarChange(eUPZTerbayar);
  FocusTo(eTanggal);
end;

procedure TFTerimaUPZNonFitrah.acSaveExecute(Sender: TObject);
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
  Npm,
  UPZ,
  Uraian,
  RekVia,
  Kelurahan,
  InputCode: string;
  JenisMzkList: TStringList;
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
  if eUPZ.HiddenText = '' then
  begin
    Warn('UPZ/Perwakilan Muzakki masih kosong.');
    FocusTo(eUPZ);
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
  Kelurahan :=  eAlamat.HiddenText;
  tglJur := eTanggal.Date;
  UPZ    := eUPZ.HiddenText;
  Uraian := eUraian.Text;
  RekVia := eVia.HiddenText;
  Randomize;
  InputCode := 'IZS'+MD5(RandomPassword(32)+DateTimeToSQL(now)+IntToStr(Random(3883672)));
  // create transaction for multiple insertions:
  e := 0;
  StartTrans;
  if not QDet.Active then
    QDet.Open;
  vtAdd.DisableControls;
  try
    // Save data penerimaan:
    sjur := 'INSERT INTO acc_jurnal_u( '+
      'jenis_jurnal, branch_kode, '+
      'tahun, user_id, ref_table, ref_kode, '+
      'tanggal, no_bukti, uraian, '+
      'jenis_trans, npwz, nama, input_code ) VALUES ('+
      _q('JIZS')+', '+
      _q(CurrentUser.KodeCabang)+', '+
      _s(Tahun(tglJur))+', '+
      _s(CurrentUser.ID)+', '+
      _q('')+', '+
      _q('')+', '+
      _q(DateToSQL(tglJur))+', '+
      _q('JIZS/'+UPZ)+', '+
      _q('Penerimaan ZIS Kolektif dari UPZ: '+UPZ+'/'+
        eUPZ.Text+', Ket.: '+Uraian)+ ', '+
      _q(copy(JenisDana.kode,1,4))+', '+
      _q(UPZ)+', '+
      _q(eUPZ.Text)+ ', '+
      _q(InputCode)+
      ') returning kode';
    try
      kdjur := ExecSQLAndFetchOneValueAsString(sjur, '');
      if kdjur <> '' then
      begin
        // insert Kas/Bank penerima:
        if eDisetor.Value<>0 then
        begin
          QDet.Append;
          QDetref_jurnal.AsString := kdjur;
          QDetkode_rek.AsString := eVia.HiddenText;
          QDeturaian.AsString := copy(eVia.Text, 16, length(eVia.Text)-15);
          QDetdebet.AsFloat := eDisetor.Value;
          QDetkredit.AsFloat := 0;
          QDetnama.AsString := UPZ +' ('+ eUPZ.Text +')';
          try QDet.Post ; except inc(e) end;
        end;
        // insert rekening penerimaan zakat
        vtAdd.First;
        while not vtAdd.Eof do
        begin
          if e>0 then break;
          NPWZ:= vtAddNPWZ.AsString;
          if npwz = '' then
          begin
            inc(e);
            break;
          end;
          for i := 3 to geAdd.Columns.Count-2 do
          begin
            if e>0 then break;
            if geAdd.Columns[i].Field.AsFloat > 0 then
            begin
              QDet.Append;
              QDetref_jurnal.AsString := kdjur;
              QDetkode_rek.AsString := geAdd.Columns[i].FieldName;
              QDeturaian.AsString := 'Penerimaan '+geAdd.Columns[i].Title.Caption
                +' a.n. '+vtAddNama.AsString;
              QDetdebet.AsFloat  := 0;
              QDetkredit.AsFloat := geAdd.Columns[i].Field.AsFloat;
              QDetnama.AsString := vtAddNama.AsString;
              QDetref_kode.AsString := NPWZ;
              try QDet.Post ; except inc(e) end;
            end;
          end;
          vtAdd.Next;
        end;
        // Piutang UPZ
        {
        if ePiutang.Value<>0 then
        begin
          QDet.Append;
          QDetref_jurnal.AsString := kdjur;
          QDetkode_rek.AsString := FMain.rekPiutangAmilUPZ;
          QDeturaian.AsString := 'Piutang UPZ '+eUPZ.Text+' atas kekurangan setoran.';
          QDetdebet.AsFloat := ePiutang.Value;
          QDetkredit.AsFloat := 0;
          QDetnama.AsString := UPZ +' ('+ eUPZ.Text +')';
          try QDet.Post ; except inc(e) end;
        end;
        // Hutang kepada UPZ
        if eUtang.Value<>0 then
        begin
          QDet.Append;
          QDetref_jurnal.AsString := kdjur;
          QDetkode_rek.AsString := FMain.rekUtangAmilUPZ;
          QDeturaian.AsString := 'Hutang kekurangan Hak Amil UPZ '+eUPZ.Text+'.';
          QDetdebet.AsFloat := 0;
          QDetkredit.AsFloat := eUtang.Value;
          QDetnama.AsString := UPZ +' ('+ eUPZ.Text +')';
          try QDet.Post ; except inc(e) end;
        end;
        if eAmilBaznas.Value<>0 then
        begin
          // potong dana zakat
          QDet.Append;
          QDetref_jurnal.AsString := kdjur;
          QDetkode_rek.AsString := JenisDana.kode;
          QDeturaian.AsString := 'Potongan Bagian Hak Amil Baznas.';
          QDetdebet.AsFloat := eAmilBaznas.Value;
          QDetkredit.AsFloat := 0;
          QDetnama.AsString := 'Potongan Amil Baznas';
          try QDet.Post ; except inc(e) end;
          // tambahkan ke dana amil
          QDet.Append;
          QDetref_jurnal.AsString := kdjur;
          QDetkode_rek.AsString := FMain.rekDanaAmil;
          QDeturaian.AsString := 'Bagian Hak Amil Baznas.';
          QDetdebet.AsFloat := 0;
          QDetkredit.AsFloat := eAmilBaznas.Value;
          QDetnama.AsString := 'Amil Baznas '+copy(CurrentUser.NamaCabang, 1, 80);
          try QDet.Post ; except inc(e) end;
        end;
        if eHakAmilUPZ.Value<>0 then
        begin
          // sisa yg harus dibayarkan ke amil UPZ:
          QDet.Append;
          QDetref_jurnal.AsString := kdjur;
          QDetkode_rek.AsString := RekAmilUpz;
          QDeturaian.AsString := 'Pembayaran hak amil UPZ.';
          QDetdebet.AsFloat := eHakAmilUPZ.Value;
          QDetkredit.AsFloat := 0;
          QDetnama.AsString := 'Pembayaran Amil UPZ: '+eUPZ.Text;
          try QDet.Post ; except inc(e) end;
        end;
        }

      end
      else
        inc(e);
    except
      inc(e);
    end;
  finally
    vtAdd.EnableControls;
  end;
  // cek transaksi:
  if e>0 then
  begin
    RollBackTrans;
    Deny('Penerimaan Dana ZIS UPZ gagal.');
  end
  else
  begin
    CommitTrans;
    MsgBoxTimeout('Sukses', 'Penerimaan ZIS UPZ Selesai.', 3);
    acNew.Execute;
  end;
end;

procedure TFTerimaUPZNonFitrah.Add1Click(Sender: TObject);
var
  sl: TStringList;
begin
  sl := FMain.PilihMuzaki('ORG');
  if sl.Count>0 then
  begin
    if vtAdd.IsEmpty then
      vtadd.Append
    else
      vtAdd.Edit;
    vtAddNPWZ.AsString  := sl[0];
    vtAddNama.AsString := sl[1];
    vtAddKelurahan.AsString:= sl[2];
    vtAdd.Post;
  end;
  sl.Free;
end;

procedure TFTerimaUPZNonFitrah.eUPZRightButtonClick(Sender: TObject);
var
  sl: TStringList;
  b: TButtonedEdit;
begin
  b := TButtonedEdit(Sender);
  sl := FMain.PilihMuzaki('UPZ');
  if sl.Count>0 then
  begin
    b.SetValues(sl[1], sl[0]);
    eAlamat.SetValues(sl[2], sl[4]);
    {
    UPZBolehMenyalurkan := 'Y' = ExecSQLAndFetchOneValueAsString('select coalesce((select hak_salur from baz_muzakki where npwz = '+_q(sl[0])+'),''N'')');
    if UPZBolehMenyalurkan then
      geDist.Visible := true
    else
    begin
      geDist.Visible := false;
      EmptyDataset(vtDist);
    end;
    }
  end
  else
  begin
    b.Clear;
    eAlamat.Clear;
  end;
  sl.Free;
end;

procedure TFTerimaUPZNonFitrah.eUPZTerbayarChange(Sender: TObject);
begin
  HitungSisa;
end;

procedure TFTerimaUPZNonFitrah.eViaRightButtonClick(Sender: TObject);
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

procedure TFTerimaUPZNonFitrah.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TFTerimaUPZNonFitrah.FormCreate(Sender: TObject);
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
  (*

  Perhatikan!!!
  Bahwasannya penyaluran dana oleh UPZ dianggap selalu untuk 8 Asnaf atau Program Baznas
  Tidak diijinkan membukukan penyaluran UPZ langsung ke rekening operasional.

  *)
  if copy(JenisZIS.kode,1,2) = '41' then
  begin
    JenisSalur.kode := '51';
    jenisDana.kode  := '31010101';
    ePersenAmil.Value := FMain.PersenAmilDanaZakat;
    RekAmilUpz := FMain.rekAmilUPZZakat;
  end
  else
  if copy(JenisZIS.kode,1,2) = '42' then
  begin
    JenisSalur.kode := '52';
    jenisDana.kode  := '31020101';
    ePersenAmil.Value := FMain.PersenAmilDanaInfak;
    RekAmilUpz := FMain.rekAmilUPZInfak;
  end
  else
  if copy(JenisZIS.kode,1,2) = '43' then
  begin
    JenisSalur.kode := '53';
    jenisDana.kode  := '31030101';
    ePersenAmil.Value := FMain.PersenAmilDanaDSKL;
    RekAmilUpz := FMain.rekAmilUPZInfak;
  end
  else
  if copy(JenisZIS.kode,1,2) = '44' then
  begin
    JenisSalur.kode := '55';
    jenisDana.kode  := '31050101';
    ePersenAmil.Value := FMain.PersenAmilDanaCSR;
    RekAmilUpz := FMain.rekAmilUPZInfak;
  end
  else
  if copy(JenisZIS.kode,1,2) = '45' then
  begin
    JenisSalur.kode := '56';
    jenisDana.kode  := '31070101';
    ePersenAmil.Value := FMain.PersenAmilDanaHibah;
    RekAmilUpz := FMain.rekAmilUPZInfak;
  end
  else
  if copy(JenisZIS.kode,1,2) = '46' then
  begin
    JenisSalur.kode := '57';
    jenisDana.kode  := '31080101';
    ePersenAmil.Value := FMain.PersenAmilDanaAPBD;
    RekAmilUpz := FMain.rekAmilUPZInfak;
  end
  ;
  JenisSalur.vkode := FormatKodeRek(JenisSalur.kode);
  JenisSalur.Rekening := ExecSQLAndFetchOneValueAsString('select rekening from v_coa_2 where kode = '+_q(JenisSalur.kode));
  // Caption := JenisZIS.vkode+' - '+JenisZIS.Rekening;
  GroupBox1.Caption := 'Persentase Bagian Amil';
  Label8.Caption := 'Bagian Amil atas '+JenisZIS.Rekening+':';


  cap1.Caption := JenisZIS.vkode+' - '+JenisZIS.Rekening;

  eTanggal.Date := Date();
  if not QKel.Active then
    QKel.Open
  else
    QKel.Refresh;
  q := Query;
  // generate rekening penerimaan:
  if vtAdd.Active then
    vtAdd.close;
  q .sql.Text := 'select vkode, '+
    'replace(replace(rekening, ''Penerimaan '',''''), ''Zakat Mal - '',''ZM - '') '+
    'rekening from v_coa_2 where (kode like '+_q(JenisZIS.kode+'%')+') '+
    'and (tingkat=5) and (not (kode like '+_q(copy(FMain.rekZF,1,4)+'%')+'))  '+
    'order by full_kode asc';
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
    i:= vtAdd.Fields.Count-1;
    fn := StripDots(q.Fields[0].AsString);
    f := vtAdd.FieldDefs.AddFieldDef;
    f.Required := false;
    f.DataType := ftFloat;
    f.Name := fn;
    f.CreateField(vtAdd).FieldName := fn;
    // vtAdd.AddField(fn, ftFloat);

    ceh := geAdd.Columns.Add;
    ceh.FieldName := fn;
    ceh.Index := geAdd.Columns.Count-2;
    ceh.DisplayFormat := '#,#0.## ;(#,#0.##) ;  ';
    ceh.Title.Caption := 'Penerimaan Dana|'+q.Fields[1].AsString;
    ceh.Width := 120;
    ceh.ReadOnly := false;
    ceh.Footer.ValueType := fvtSum;
    ceh.Footer.DisplayFormat := ceh.DisplayFormat;
    q.Next;
  end;
  q.close;

  vtAdd.Open;

  eTanggal.Date := Date();
  acNew.Execute;
end;

procedure TFTerimaUPZNonFitrah.geAddColumns0EditButtonClick(
  Sender: TObject; var Handled: Boolean);
begin
  Handled := true;
  Add1.Click;
end;

procedure TFTerimaUPZNonFitrah.geAddColumns4EditButtonClick(
  Sender: TObject; var Handled: Boolean);
begin
  Handled := true;
  Hapus1.Click;
end;

procedure TFTerimaUPZNonFitrah.geDistColumns0EditButtonClick(
  Sender: TObject; var Handled: Boolean);
begin
  Handled := true;
  ambahMustahik1.Click;
end;

procedure TFTerimaUPZNonFitrah.geDistColumns3EditButtonClick(
  Sender: TObject; var Handled: Boolean);
begin
  Handled := true;
  Hapus2.Click;
end;

procedure TFTerimaUPZNonFitrah.Hapus1Click(Sender: TObject);
begin
  if not vtAdd.IsEmpty then
    vtAdd.Delete;
end;

procedure TFTerimaUPZNonFitrah.HapusSemua1Click(Sender: TObject);
begin
  EmptyDataset(vtAdd);
end;

function TFTerimaUPZNonFitrah.HitungSisa: Double;
var
  TotalTerima,
  TotalSalur,
  UPZTotal,
  UPZTerbayar,
  UPZSisa,
  SisaDana,
  SisaDanaDipotongSisaUPZ,
  PiutangKeUPZ,
  HutangKeUPZ,
  DanaDisetor,
  BagianAmilBAznas: Double;
  i: integer;
  perAU,
  perAB: Double;
begin
  TotalTerima             := 0;
  TotalSalur              := 0;
  UPZTotal                := 0;
  UPZTerbayar             := 0;
  UPZSisa                 := 0;
  SisaDana                := 0;
  SisaDanaDipotongSisaUPZ := 0;
  PiutangKeUPZ            := 0;
  HutangKeUPZ             := 0;
  DanaDisetor             := 0;
  BagianAmilBAznas        := 0;
  if ePersenAmil.Value = 0 then
  begin
    perAU := 0;
    perAB :=0;
  end
  else
  begin
    perAU :=   5/100;
    perAB := (ePersenAmil.Value-perAu)/100;
  end;
  for i := 3 to geAdd.Columns.Count-2 do
  begin
    TotalTerima := TotalTerima+ geAdd.Columns[i].Footer.SumValue;
  end;

  // AmilUPZ := Max(5/100*terima, 7.5/100*salur);
  UPZTotal  := perAU*TotalTerima;
  UPZTerbayar := eUPZTerbayar.Value;
  UPZSisa   := UPZTotal - UPZTerbayar;
  SisaDana  := TotalTerima - TotalSalur - UPZTerbayar;
  PiutangKeUPZ := _IIF(UPZSisa<0, -1*UPZSisa, 0);
  HutangKeUPZ  := _IIF(UPZSisa>0, UPZSisa, 0);
  BagianAmilBaznas
               := _IIF(SisaDana>(perab*TotalTerima), perab*TotalTerima, SisaDana);
  eTerima.Value     := TotalTerima;
  eHakAmilUPZ.Value := UPZTotal;
  eUPZTerbayar.Value:= UPZTerbayar;
  eUPZSisa.Value    := UPZSisa;
  eDisetor.Value    := SisaDana;
  eAmilBaznas.Value := BagianAmilBAznas;
  ePiutang.Value    := PiutangKeUPZ;
  eUtang.Value      := HutangKeUPZ;
  Result := SisaDana;
end;

procedure TFTerimaUPZNonFitrah.qUPZAfterScroll(DataSet: TDataSet);
begin
  //
end;

function TFTerimaUPZNonFitrah.sqlSelectVia: String;
begin
  Result :=
    'select pkode, kode, full_kode, vkode, rekening from v_coa_2 where '+
    ' ((kode like '+_q(Fmain.BaseKas+'%')+ ') or (kode like '+_q(Fmain.BaseBank+'%')+ ')) '+
    ' order by full_kode asc'
end;

procedure TFTerimaUPZNonFitrah.vtAddAfterPost(DataSet: TDataSet);
begin
  HitungSisa;
end;

end.
