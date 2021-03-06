unit u_terima_upz_fitrah;

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
  JvExtComponent, JvCaptionPanel, JvButton, JvTransparentButton;

type
  TFTerimaUPZFitrah = class(TForm)
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
    vtAddJumlahZakatFitrah: TFloatField;
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    geAdd: TDBGridEh;
    TabSheet2: TTabSheet;
    geDist: TDBGridEh;
    eSisa: TJvCalcEdit;
    Label2: TLabel;
    dsDist: TDataSource;
    QKel: TUniQuery;
    QKelkode: TStringField;
    QKelnama: TStringField;
    vtDist: TVirtualTable;
    vtDistNama: TStringField;
    vtDistKelurahan: TStringField;
    vtDistNPM: TStringField;
    pmDist: TPopupMenu;
    ambahMustahik1: TMenuItem;
    N2: TMenuItem;
    Hapus2: TMenuItem;
    HapusSemua2: TMenuItem;
    Label3: TLabel;
    dsKel: TDataSource;
    vtAddNPWZ: TStringField;
    eAlamat: TEdit;
    vtAddKelurahan: TStringField;
    eUPZ: TButtonedEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acCloseExecute(Sender: TObject);
    procedure Hapus1Click(Sender: TObject);
    procedure HapusSemua1Click(Sender: TObject);
    procedure Add1Click(Sender: TObject);
    procedure acNewExecute(Sender: TObject);
    procedure acSaveExecute(Sender: TObject);
    procedure eViaRightButtonClick(Sender: TObject);
    procedure ambahMustahik1Click(Sender: TObject);
    procedure Hapus2Click(Sender: TObject);
    procedure HapusSemua2Click(Sender: TObject);
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
  private
    { Private declarations }
    function sqlSelectVia: String;
    function HitungSisa: Double;
  public
    { Public declarations }
    BaseRek,
    KodeMuzakki : String;
  end;

var
  FTerimaUPZFitrah: TFTerimaUPZFitrah;

implementation

uses u_display_text, u_select_master_detail, umain, u_login_otf,
  u_select_kode_name, u_pilih_opsi, u_new_muzaki, u_new_mustahik;

{$R *.dfm}

procedure TFTerimaUPZFitrah.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFTerimaUPZFitrah.acNewExecute(Sender: TObject);
var
  jj: integer;
begin
  eUPZ.clear;
  eVia.Clear;
  eAlamat.SetValues('', '');
  eUraian.Clear;
  EmptyDataset(vtAdd);
  EmptyDataset(vtDist);
  PageControl1.ActivePageIndex := 0;
  BaseRek := '4';
  FocusTo(eTanggal);
end;

procedure TFTerimaUPZFitrah.acSaveExecute(Sender: TObject);
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
  if eSisa.Value<0 then
  begin
    Inform('Jumlah Penerimaan melebihi Penyaluran.'#13'Harap dikoreksi lagi.');
    PageControl1.ActivePageIndex := 1;
    if geDist.Visible then
      geDist.SetFocus;
    Exit;
  end;
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
  if vtDist.IsEmpty then
  begin
    Warn('Rincian Penyaluran masih kosong.');
    FocusTo(geDist);
    exit;
  end;
  Kelurahan := eAlamat.HiddenText;
  tglJur := eTanggal.Date;
  UPZ    := eUPZ.HiddenText;
  Uraian := eUraian.Text;
  RekVia := eVia.HiddenText;
  Randomize;
  InputCode := 'IZF'+MD5(RandomPassword(32)+DateTimeToSQL(now)+IntToStr(Random(3883672)));
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
    _q('JIZF')+', '+
    _q(CurrentUser.KodeCabang)+', '+
    _s(Tahun(tglJur))+', '+
    _s(CurrentUser.ID)+', '+
    _q('')+', '+
    _q('')+', '+
    _q(DateToSQL(tglJur))+', '+
    _q('JIZF/'+UPZ)+', '+
    _q('Penerimaan Zakat Fitrah Kolektif dari UPZ: '+UPZ+'/'+
      eUPZ.Text+', Ket.: '+Uraian)+ ', '+
    _q('UPZF')+', '+
    _q(UPZ)+', '+
    _q(eUPZ.Text)+ ', '+
    _q(InputCode)+
    ') returning kode';
  try
    kdjur := ExecSQLAndFetchOneValueAsString(sjur, '');
    if kdjur <> '' then
    begin
      // insert Kas/Bank penerima:
      // jml := geAdd.Columns[3].Footer.SumValue;
      jml := eSisa.Value;
      if jml<>0 then
      begin
        QDet.Append;
        QDetref_jurnal.AsString := kdjur;
        QDetkode_rek.AsString := eVia.HiddenText;
        QDeturaian.AsString := copy(eVia.Text, 16, length(eVia.Text)-15);
        QDetdebet.AsFloat := jml;
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
        QDet.Append;
        QDetref_jurnal.AsString := kdjur;
        QDetkode_rek.AsString := fmain.rekZF;
        QDeturaian.AsString := 'Penerimaan Zakat Fitrah dari '+vtAddNama.AsString;
        QDetdebet.AsFloat := 0;
        QDetkredit.AsFloat := vtAddJumlahZakatFitrah.AsFloat;
        QDetnama.AsString := NPWZ +' ('+ vtAddNama.AsString +')';
        QDetref_kode.AsString := NPWZ;
        try QDet.Post ; except inc(e) end;
        vtAdd.Next;
      end;
      // Save data penyaluran:
      vtDist.First;
      while not vtDist.Eof do
      begin
        if e>0 then break;

        Npm:= vtDistNPM.AsString;
        
        if Npm = '' then
        begin
          inc(e);
          break;
        end;
        for i := 3 to geDist.Columns.Count-2 do
        begin
          if e>0 then break;
          if geDist.Columns[i].Field.AsFloat > 0 then
          begin
            QDet.Append;
            QDetref_jurnal.AsString := kdjur;
            QDetkode_rek.AsString := geDist.Columns[i].FieldName;
            QDeturaian.AsString := 'Penyaluran kepada '+geDist.Columns[i].Title.Caption
              +' a.n. '+ Npm +' - '+vtDistNama.AsString;
            QDetdebet.AsFloat := geDist.Columns[i].Field.AsFloat;
            QDetkredit.AsFloat := 0;
            QDetnama.AsString := vtDistNama.AsString;
            QDetref_kode.AsString := npm;
            try QDet.Post ; except inc(e) end;
          end;
        end;
        vtDist.Next;
      end;
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
    Deny('Penerimaan Zakat Fitrah gagal.');
  end
  else
  begin
    CommitTrans;
    MsgBoxTimeout('Sukses', 'Penerimaan Zakat Fitrah UPZ Selesai.', 3);
    acNew.Execute;
  end;
end;

procedure TFTerimaUPZFitrah.Add1Click(Sender: TObject);
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
    vtAddJumlahZakatFitrah.AsFloat := 0;
    vtAdd.Post;
  end;
  sl.Free;
end;

procedure TFTerimaUPZFitrah.ambahMustahik1Click(Sender: TObject);
var
  sl: TStringList;
begin
  sl := FMain.PilihMustahik('ORG');
  if sl.Count>0 then
  begin
    if vtDist.IsEmpty then
      vtDist.Append
    else
      vtDist.Edit;
    vtDistNPM.AsString  := sl[0];
    vtDistNama.AsString := sl[1];
    vtDistKelurahan.AsString:= sl[2];
    vtDist.Post;
  end;
  sl.Free;
end;

procedure TFTerimaUPZFitrah.eUPZRightButtonClick(Sender: TObject);
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
  end
  else
  begin
    b.Clear;
    eAlamat.Clear;
  end;
  sl.Free;
end;

procedure TFTerimaUPZFitrah.eViaRightButtonClick(Sender: TObject);
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

procedure TFTerimaUPZFitrah.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TFTerimaUPZFitrah.FormCreate(Sender: TObject);
var
  q: TUniQuery;
  i: integer;
  ceh: TColumnEh;
  fn: string;
  f: TFieldDef;
begin
  eTanggal.Date := date;
  PageControl1.ActivePageIndex := 0;
  if not QKel.Active then
    QKel.Open
  else
    QKel.Refresh;

  if not vtAdd.Active then
    vtAdd.Open;
  if vtDist.Active then
    vtDist.Close;
  q := ExecSQL( 'select vkode, '+
      'replace(replace(replace(rekening, ''Distribusi Zakat Kepada '',''''), ''Program '',''''), ''Distribusi Infak/Sedekah Kepada '', '''') '+
      'rekening from v_coa_2 where kode like '+
      _q('51%')+' and (tingkat = 5) order by full_kode asc'
    );
    if q.IsEmpty then
    begin
      Deny('Akun-Akun Penyaluran ZIS belum ada.');
      q.Free;
      Close;
      exit;
    end;
  q.First;
  while not q.Eof do
  begin
    i:= vtDist.Fields.Count-1;
    fn := StripDots(q.Fields[0].AsString);
    f := vtDist.FieldDefs.AddFieldDef;
    f.Required := false;
    f.DataType := ftFloat;
    f.Name := fn;
    f.CreateField(vtDist).FieldName := fn;
    // vtAdd.AddField(fn, ftFloat);

    ceh := geDist.Columns.Add;
    ceh.FieldName := fn;
    ceh.Index := geDist.Columns.Count-2;
    ceh.DisplayFormat := '#,#0.## ;(#,#0.##) ;  ';
    ceh.Title.Caption := 'Distribusi Kepada|'+q.Fields[1].AsString;
    ceh.Width := 120;
    ceh.ReadOnly := false;
    ceh.Footer.ValueType := fvtSum;
    ceh.Footer.DisplayFormat := ceh.DisplayFormat;
    q.Next;
  end;
  vtDist.Open;
  q.Free;
  eTanggal.Date := Date();
  acNew.Execute;
end;

procedure TFTerimaUPZFitrah.geAddColumns0EditButtonClick(
  Sender: TObject; var Handled: Boolean);
begin
  Handled := true;
  Add1.Click;
end;

procedure TFTerimaUPZFitrah.geAddColumns4EditButtonClick(
  Sender: TObject; var Handled: Boolean);
begin
  Handled := true;
  Hapus1.Click;
end;

procedure TFTerimaUPZFitrah.geDistColumns0EditButtonClick(
  Sender: TObject; var Handled: Boolean);
begin
  Handled := true;
  ambahMustahik1.Click;
end;

procedure TFTerimaUPZFitrah.geDistColumns3EditButtonClick(
  Sender: TObject; var Handled: Boolean);
begin
  Handled := true;
  Hapus2.Click;
end;

procedure TFTerimaUPZFitrah.Hapus1Click(Sender: TObject);
begin
  if not vtAdd.IsEmpty then
    vtAdd.Delete;
end;

procedure TFTerimaUPZFitrah.Hapus2Click(Sender: TObject);
begin
  if not vtDist.IsEmpty then
    vtDist.Delete;
end;

procedure TFTerimaUPZFitrah.HapusSemua1Click(Sender: TObject);
begin
  EmptyDataset(vtAdd);
end;

procedure TFTerimaUPZFitrah.HapusSemua2Click(Sender: TObject);
begin
  EmptyDataset(vtDist);
end;

function TFTerimaUPZFitrah.HitungSisa: Double;
var
  terima,
  salur: Double;
  i: integer;
begin
  terima := geAdd.Columns[3].Footer.SumValue;
  salur := 0;
  for i := 3 to geDist.Columns.Count-2 do
    salur := salur + geDist.Columns[i].Footer.SumValue;
  Result := terima - salur;
  eSisa.Value := Result;
end;

procedure TFTerimaUPZFitrah.qUPZAfterScroll(DataSet: TDataSet);
begin
  //
end;

function TFTerimaUPZFitrah.sqlSelectVia: String;
begin
  Result :=
    'select pkode, kode, full_kode, vkode, rekening from v_coa_2 where '+
    ' ((kode like '+_q(Fmain.BaseKas+'%')+ ') or (kode like '+_q(Fmain.BaseBank+'%')+ ')) '+
    ' order by full_kode asc'
end;

procedure TFTerimaUPZFitrah.vtAddAfterPost(DataSet: TDataSet);
begin
  HitungSisa;
end;

end.
