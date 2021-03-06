unit u_salur_non_zis;

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
  TFSalurNonZis = class(TForm)
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    acClose: TAction;
    dsAdd: TDataSource;
    Panel7: TPanel;
    geRek: TDBGridEh;
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
    vtAddkode: TStringField;
    vtAddfkode: TStringField;
    vtAdduraian: TStringField;
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
    vtAddjumlah: TFloatField;
    cap1: TJvCaptionPanel;
    Label12: TLabel;
    Label13: TLabel;
    Label8: TLabel;
    Label1: TLabel;
    eTanggal: TDateTimePicker;
    eUraian: TMemo;
    eVia: TButtonedEdit;
    QDetnama: TStringField;
    Label2: TLabel;
    eBukti: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acCloseExecute(Sender: TObject);
    procedure Hapus1Click(Sender: TObject);
    procedure HapusSemua1Click(Sender: TObject);
    procedure Add1Click(Sender: TObject);
    procedure acNewExecute(Sender: TObject);
    procedure acSaveExecute(Sender: TObject);
    procedure geRekColumns1EditButtons0Click(Sender: TObject;
      var Handled: Boolean);
    procedure geRekColumns3EditButtons0Click(Sender: TObject;
      var Handled: Boolean);
    procedure eViaRightButtonClick(Sender: TObject);
  private
    { Private declarations }
    function sqlSelectRek: String;
    function sqlSelectVia: String;
  public
    { Public declarations }
    BaseBank,
    BaseKas,
    BaseRek: string;
    LastJenisDana : tperkiraan;
  end;

var
  FSalurNonZis: TFSalurNonZis;

implementation

uses u_display_text, u_select_master_detail, umain, u_login_otf,
  u_select_kode_name, u_get_jenis_distribusi_dana;

{$R *.dfm}

procedure TFSalurNonZis.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFSalurNonZis.acNewExecute(Sender: TObject);
var
  jj: integer;
begin
  eBukti.Clear;
  eVia.Clear;
  eUraian.Clear;
  EmptyDataset(vtAdd);
  BaseKas:=GetOption(CurrentUser.KodeCabang+'defsetkas');
  BaseBank:=GetOption(CurrentUser.KodeCabang+'defsetbank');
  FocusTo(eTanggal);
end;

procedure TFSalurNonZis.acSaveExecute(Sender: TObject);
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
  if eBukti.WarnForEmpty('Nomor Bukti masih kosong.') then
    exit;
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
  if not QDet.Active then
    QDet.Open;
  // Inform(eNPWZ.HiddenText);
  sjur := 'INSERT INTO acc_jurnal_u( '+
    'jenis_jurnal, branch_kode, '+
    'tahun, user_id, ref_table, ref_kode, '+
    'tanggal, no_bukti, uraian, '+
    'jenis_trans, npwz, nama ) VALUES ('+
    _q('ONZ')+', '+
    _q(CurrentUser.KodeCabang)+', '+
    _s(Tahun(tglJur))+', '+
    _s(CurrentUser.ID)+', '+
    _q('')+', '+
    _q('')+', '+
    _q(DateToSQL(tglJur))+', '+
    _q(eBukti.Text)+', '+
    _q(eUraian.Text)+ ', '+
    _q(LastJenisDana.kode)+', '+
    _q('')+', '+
    _q('')+
    ') returning kode';
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
    vtAdd.DisableControls;
    try
      vtAdd.First;
      while not vtAdd.Eof do
      begin
        jml := jml + vtAddjumlah.AsFloat;
        vtAdd.Next;
      end;
      QDet.Append;
      QDetref_jurnal.AsString := kdjur;
      QDetkode_rek.AsString := eVia.HiddenText;
      QDeturaian.AsString := copy(eVia.Text, 16, length(eVia.Text)-15);
      QDetdebet.AsFloat := 0;
      QDetkredit.AsFloat := jml;
      QDetnama.AsString := '';
      try QDet.Post ; except inc(e) end;
      vtAdd.First;
      while not vtAdd.Eof do
      begin
        if e>0 then break;
        QDet.Append;
        QDetref_jurnal.AsString := kdjur;
        QDetkode_rek.AsString := vtAddkode.AsString;
        QDeturaian.AsString := vtAdduraian.AsString;
        QDetdebet.AsFloat := vtAddjumlah.AsFloat;
        QDetkredit.AsFloat := 0;
        QDetnama.AsString := '';
        try QDet.Post ; except inc(e) end;
        vtAdd.Next;
      end;
    finally
      vtAdd.EnableControls;
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
      MsgBoxTimeout('Sukses', 'Penyaluran Dana Selesai.', 3);
      acNew.Execute;
    end;
  end;
end;

procedure TFSalurNonZis.Add1Click(Sender: TObject);
var
  sl: TStringList;
begin
  sl := SelectMasterDetail(
    GetGlobalConnection,
    sqlSelectRek(),
    ['full_kode', 'vkode', 'rekening'],
    'pkode','kode',
    4,
    ['','Kode','Uraian'],
    [0,80,280],
    false,700, 400, 'Pilih Akun Distribusi'
  );
  if sl.Count>0 then
  begin
    vtadd.Append;
    vtAddkode.AsString  := sl[0];
    vtAddfkode.AsString := sl[1];
    vtAdduraian.AsString:= sl[2];
    vtAddjumlah.AsFloat  := 0;
    vtAdd.Post;
  end;
  sl.Free;
end;

procedure TFSalurNonZis.eViaRightButtonClick(Sender: TObject);
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

procedure TFSalurNonZis.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TFSalurNonZis.FormCreate(Sender: TObject);
var
  q: TUniQuery;
  i: integer;
  ceh: TColumnEh;
  kv,
  fn: string;
  f: TFieldDef;
begin
  eTanggal.Date := date;
  if not vtAdd.Active then
    vtAdd.Open;
  LastJenisDana := GetJenisDistribusiDana(['53','54','55','56','57','58']);
  if LastJenisDana.kode <> '' then
  begin
    Caption := LastJenisDana.vkode+' - '+LastJenisDana.Rekening;
    cap1.Caption := 'Jurnal Penyaluran: '+LastJenisDana.vkode+' - '+LastJenisDana.Rekening;
    Label8.Caption := 'Rincian '+Caption;
    acNew.Execute;
  end
  else
    Close;
end;

procedure TFSalurNonZis.geRekColumns1EditButtons0Click(Sender: TObject;
  var Handled: Boolean);
var
  sl: TStringList;
begin
  sl := SelectMasterDetail(
    GetGlobalConnection,
    sqlSelectRek(),
    ['full_kode', 'vkode', 'rekening'],
    'pkode','kode',
    5,
    ['','Kode','Uraian'],
    [0,80,280],
    false,700, 400, 'Pilih Akun Perolehan'
  );
  if sl.Count>0 then
  begin
    if vtAdd.IsEmpty then
      vtadd.Append
    else
      vtAdd.Edit;
    vtAddkode.AsString  := sl[0];
    vtAddfkode.AsString := sl[1];
    vtAdduraian.AsString:= sl[2];
    vtAdd.Post;
  end;
  sl.Free;
end;

procedure TFSalurNonZis.geRekColumns3EditButtons0Click(Sender: TObject;
  var Handled: Boolean);
begin
  handled := true;
  if not vtAdd.IsEmpty then
    vtAdd.Delete;
end;

procedure TFSalurNonZis.Hapus1Click(Sender: TObject);
begin
  if not vtAdd.IsEmpty then
    vtAdd.Delete;
end;

procedure TFSalurNonZis.HapusSemua1Click(Sender: TObject);
begin
  EmptyDataset(vtAdd);
end;


function TFSalurNonZis.sqlSelectRek: String;
begin
  Result :=
    'select pkode, kode, full_kode, vkode, rekening from v_coa_2 where '+
    '(kode like ''5%'') and '+
    '(kode like '+_q(LastJenisDana.kode+'%')+')'+
    ' order by full_kode asc'
end;

function TFSalurNonZis.sqlSelectVia: String;
begin
  Result :=
    'select pkode, kode, full_kode, vkode, rekening from v_coa_2 where '+
    ' ((kode like '+_q(BaseKas+'%')+ ') or (kode like '+_q(BaseBank+'%')+ ')) '+
    ' order by full_kode asc'
end;

end.
