unit u_salur_zis;

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
  JvExtComponent, JvCaptionPanel, JvButton, JvTransparentButton, DBCtrlsEh,
  DBLookupEh;

type
  TFSalurZis = class(TForm)
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    acClose: TAction;
    dsAdd: TDataSource;
    Panel7: TPanel;
    PopupMenu1: TPopupMenu;
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
    Label12: TLabel;
    Label13: TLabel;
    Label8: TLabel;
    Label1: TLabel;
    eTanggal: TDateTimePicker;
    eUraian: TMemo;
    eVia: TButtonedEdit;
    QDetnama: TStringField;
    vtAddNPWZ: TStringField;
    vtAddNama: TStringField;
    PageControl1: TPageControl;
    geRek: TDBGridEh;
    vtAddAlamat: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acCloseExecute(Sender: TObject);
    procedure Hapus1Click(Sender: TObject);
    procedure HapusSemua1Click(Sender: TObject);
    procedure Add1Click(Sender: TObject);
    procedure acNewExecute(Sender: TObject);
    procedure acSaveExecute(Sender: TObject);
    procedure geRekColumns3EditButtons0Click(Sender: TObject;
      var Handled: Boolean);
    procedure eViaRightButtonClick(Sender: TObject);
    procedure geRekColumns0EditButtonClick(Sender: TObject;
      var Handled: Boolean);
  private
    { Private declarations }
    function sqlSelectVia: String;
  public
    { Public declarations }
    BaseBank,
    BaseKas,
    BaseRek: string;
    LastJenisDana : tperkiraan;
  end;

var
  FSalurZis: TFSalurZis;

implementation

uses u_display_text, u_select_master_detail, umain, u_login_otf,
  u_select_kode_name, u_pilih_opsi, u_get_jenis_distribusi_dana, u_new_mustahik;

{$R *.dfm}

procedure TFSalurZis.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFSalurZis.acNewExecute(Sender: TObject);
var
  jj: integer;
begin
  eTanggal.Date := date;
  eVia.Clear;
  eUraian.Clear;
  EmptyDataset(vtAdd);
  BaseKas:=GetOption(CurrentUser.KodeCabang+'defsetkas');
  BaseBank:=GetOption(CurrentUser.KodeCabang+'defsetbank');
  BaseRek := '4';
  FocusTo(eTanggal);
end;

procedure TFSalurZis.acSaveExecute(Sender: TObject);
var
  sjur: String;
  kdjur: String;
  i, e: integer;
  tglSvr,
  tglJur: TDate;
  approvedByAdmin: Boolean;
  jml: Double;
  tipeMustahik,
  NPWM,
  JenisDana,
  Uraian,
  RekVia,
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
    FocusTo(geRek);
    exit;
  end;
  // input as new UPZ:
  tipeMustahik := '';
  tglJur := eTanggal.Date;
  JenisDana    := LastJenisDana.kode;
  Uraian := eUraian.Text;
  RekVia := eVia.HiddenText;
  Randomize;
  InputCode := 'OZS'+MD5(RandomPassword(32)+DateTimeToSQL(now)+IntToStr(Random(3883672)));
  // create transaction for multiple insertions:
  e := 0;
  StartTrans;
  //start the input within loop:
  if not QDet.Active then
    QDet.Open;
  vtAdd.First;
  // Inform(vtAdd.FieldCount.ToString());
  // Inform(vtAdd.FieldDefs.Count.ToString());

  while not vtAdd.Eof do
  begin
    NPWM := vtAddNPWZ.AsString;
    sjur := 'INSERT INTO acc_jurnal_u( '+
      'jenis_jurnal, branch_kode, '+
      'tahun, user_id, ref_table, ref_kode, '+
      'tanggal, no_bukti, uraian, '+
      'jenis_trans, npwz, nama, input_code ) VALUES ('+
      _q('OZS')+', '+
      _q(CurrentUser.KodeCabang)+', '+
      _s(Tahun(tglJur))+', '+
      _s(CurrentUser.ID)+', '+
      _q('')+', '+
      _q('')+', '+
      _q(DateToSQL(tglJur))+', '+
      _q('OZS/'+NPWM)+', '+
      _q('Penyaluran Kepada '+
        NPWM +' ('+
        vtAddNama.AsString+'), Ket.: '+
        Uraian)+ ', '+
      _q(LastJenisDana.kode)+', '+
      _q(NPWM )+', '+
      _q(vtAddNama.AsString)+ ', '+
      _q(InputCode)+
      ') returning kode';
    try
      kdjur := ExecSQLAndFetchOneValueAsString(sjur, '');
      if kdjur <> '' then
      begin
        // insert the details:
        jml := 0;
        for i := 3 to geRek.Columns.Count-2 do
        begin
          jml := jml + geRek.Columns[i].Field.AsFloat;
        end;
        if jml>0 then
        begin
          for i := 3 to geRek.Columns.Count-2 do
          begin
            if e>0 then break;
            if geRek.Columns[i].Field.AsFloat > 0 then
            begin
              QDet.Append;
              QDetref_jurnal.AsString := kdjur;
              QDetkode_rek.AsString := geRek.Columns[i].FieldName;
              QDeturaian.AsString := 'Distribusi kepada '+geRek.Columns[i].Title.Caption
                +' ('+ NPWM +' - '+vtAddNama.AsString+')';
              QDetdebet.AsFloat := geRek.Columns[i].Field.AsFloat;
              QDetkredit.AsFloat := 0;
              QDetnama.AsString := vtAddNama.AsString;
              QDetref_kode.AsString := NPWM;
              try QDet.Post ; except inc(e) end;
            end;
          end;
          QDet.Append;
          QDetref_jurnal.AsString := kdjur;
          QDetkode_rek.AsString := eVia.HiddenText;
          QDeturaian.AsString := copy(eVia.Text, 16, length(eVia.Text)-15);
          QDetdebet.AsFloat := 0;
          QDetkredit.AsFloat := jml;
          QDetnama.AsString := NPWM +' ('+ vtAddNama.AsString +')';
          try QDet.Post ; except inc(e) end;
        end;
      end
      else
        inc(e);
    except
      inc(e);
    end;
    vtAdd.Next;
  end;
  if e>0 then
  begin
    RollBackTrans;
    Deny('Penerimaan Dana ZIS kolektif gagal.');
  end
  else
  begin
    CommitTrans;
    MsgBoxTimeout('Sukses', 'Penyaluran Dana Selesai.', 3);
    acNew.Execute;
  end;
end;

procedure TFSalurZis.Add1Click(Sender: TObject);
var
  sl: TStringList;
begin
  sl := fmain.PilihMustahik('ORG');
  if sl.Count>0 then
  begin
    if vtAdd.IsEmpty then
      vtadd.Append
    else
      vtAdd.Edit;
    vtAddNPWZ.AsString  := sl[0];
    vtAddNama.AsString := sl[1];
    vtAddAlamat.AsString:= sl[2];
    vtAdd.Post;
  end;
  sl.Free;
end;

procedure TFSalurZis.eViaRightButtonClick(Sender: TObject);
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
    false,700, 400, 'Pilih Akun Penyaluran'
  );
  if sl.Count>0 then
  begin
    eVia.SetValues( sl[1]+' - '+sl[2], sl[0] );
  end;
  sl.Free;
end;

procedure TFSalurZis.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TFSalurZis.FormCreate(Sender: TObject);
var
  q: TUniQuery;
  i: integer;
  ceh: TColumnEh;
  kv,
  fn: string;
  f: TFieldDef;
begin
  LastJenisDana := GetJenisDistribusiDana(['51','52']);
  if LastJenisDana.kode <> '' then
  begin
    q := ExecSQL( 'select vkode, '+
      'replace(replace(replace(rekening, ''Distribusi Zakat Kepada '',''''), ''Program '',''''), ''Distribusi Infak/Sedekah Kepada '', '''') '+
      'rekening from v_coa_2 where kode like '+
      _q(LastJenisDana.kode+'%')+' and (tingkat = 5) order by full_kode asc'
    );
    if q.IsEmpty then
    begin
      Deny('Akun-Akun Penyaluran ZIS belum ada.');
      q.Free;
      Close;
      exit;
    end;
    Caption := LastJenisDana.vkode+' - '+LastJenisDana.Rekening;
    cap1.Caption := 'Jurnal Penyaluran: '+LastJenisDana.vkode+' - '+LastJenisDana.Rekening;
    Label8.Caption := 'Rincian '+Caption;
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

      ceh := geRek.Columns.Add;
      ceh.FieldName := fn;
      ceh.Index := geRek.Columns.Count-2;
      ceh.DisplayFormat := '#,#0.## ;(#,#0.##) ;  ';
      ceh.Title.Caption := q.Fields[1].AsString;
      ceh.Width := 120;
      ceh.ReadOnly := false;
      ceh.Footer.ValueType := fvtSum;
      ceh.Footer.DisplayFormat := ceh.DisplayFormat;
      q.Next;
    end;
    vtAdd.Open;
    q.Free;
    // --
    eTanggal.Date := Date();
    acNew.Execute;
  end
  else
    Close;
end;

procedure TFSalurZis.geRekColumns0EditButtonClick(Sender: TObject;
  var Handled: Boolean);
begin
  Handled := true;
  Add1.Click;
end;

procedure TFSalurZis.geRekColumns3EditButtons0Click(Sender: TObject;
  var Handled: Boolean);
begin
  handled := true;
  if not vtAdd.IsEmpty then
    vtAdd.Delete;
end;

procedure TFSalurZis.Hapus1Click(Sender: TObject);
begin
  if not vtAdd.IsEmpty then
    vtAdd.Delete;
end;

procedure TFSalurZis.HapusSemua1Click(Sender: TObject);
begin
  EmptyDataset(vtAdd);
end;


function TFSalurZis.sqlSelectVia: String;
begin
  Result :=
    'select pkode, kode, full_kode, vkode, rekening from v_coa_2 where '+
    ' ((kode like '+_q(BaseKas+'%')+ ') or (kode like '+_q(BaseBank+'%')+ ')) '+
    ' order by full_kode asc'
end;

end.
