unit u_jurnal_kas;

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
  TFJurnalKas = class(TForm)
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
    JvCaptionPanel1: TJvCaptionPanel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label8: TLabel;
    eTanggal: TDateTimePicker;
    eBukti: TEdit;
    eUraian: TMemo;
    Label1: TLabel;
    eRekKas: TComboBox;
    vtAddjumlah: TFloatField;
    ckApprove: TCheckBox;
    ckCek: TCheckBox;
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
  private
    { Private declarations }
    KasMasuk: Boolean;
  public
    { Public declarations }
  end;

var
  FJurnalKas: TFJurnalKas;

implementation

uses u_display_text, u_select_master_detail, umain, u_login_otf;

{$R *.dfm}

procedure TFJurnalKas.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFJurnalKas.acNewExecute(Sender: TObject);
var
  jj: integer;
  baseKas: String;
begin
  jj := Ask3Options('Jenis Transaksi:', 0, 'Kas Masuk', 'Kas Keluar','Batal');
  if jj = mrCancel then
    close;
  KasMasuk := jj = mrYes;
  if KasMasuk then
  begin
    Caption := 'Jurnal Kas Masuk';
    JvCaptionPanel1.CaptionColor := $005BB700;
    Label8.Caption := 'Rincian Penerimaan';
  end
  else
  begin
    Caption := 'Jurnal Kas Keluar';
    JvCaptionPanel1.CaptionColor := $004080FF;
    Label8.Caption := 'Rincian Pengeluaran';
  end;
  JvCaptionPanel1.Caption := Caption;
  eRekKas.Clear;
  Basekas:=GetOption(CurrentUser.KodeCabang+'defsetkas');
  with ExecSQL('select full_kode, vkode, rekening from v_coa_2 where (kode like ('+_q(basekas+'%')+')) and (tingkat=5) order by kode asc') do
  begin
    if IsEmpty then
    begin
      Free;
      Inform('Anda belum mengatur Rekening Kas di Chart Of Account.');
      Close;
    end
    else
    begin
      First;
      while not Eof do
      begin
        eRekKas.Items.Add(fields[1].AsString + ' - '+ Fields[2].AsString);
        Next;
      end;
    end;
  end;
  eRekKas.ItemIndex := 0;
  eBukti.Clear;
  eUraian.Clear;
  EmptyDataset(vtAdd);
  FocusTo(eTanggal);
end;

procedure TFJurnalKas.acSaveExecute(Sender: TObject);
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
  if vtAdd.IsEmpty then
  begin
    Warn('Rekening Rincian Transaksi masih kosong.');
    FocusTo(geRek);
    exit;
  end;
  if not QDet.Active then
    QDet.Open;

  sjur := 'INSERT INTO acc_jurnal_u( '+
    'jenis_jurnal, branch_kode, tahun, user_id, ref_table,ref_kode, tanggal, no_bukti, uraian'+
    ', jenis_trans) VALUES ('+
    _iif(KasMasuk, '''JKM0''', '''JKK0''')+', '+
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
    vtAdd.DisableControls;
    try
      vtAdd.First;
      while not vtAdd.Eof do
      begin
        jml := jml + vtAddjumlah.AsFloat;
        vtAdd.Next;
      end;
      if KasMasuk then
      begin
        QDet.Append;
        QDetref_jurnal.AsString := kdjur;
        QDetkode_rek.AsString := StripDots(copy(eRekKas.Text, 1, 12));
        QDeturaian.AsString := copy(eRekKas.Text, 16, length(eRekKas.Text)-15);
        QDetdebet.AsFloat := jml;
        QDetkredit.AsFloat := 0;
        try QDet.Post ; except inc(e) end;
      end;
      vtAdd.First;
      while not vtAdd.Eof do
      begin
        if e>0 then break;
        QDet.Append;
        QDetref_jurnal.AsString := kdjur;
        QDetkode_rek.AsString := vtAddkode.AsString;
        QDeturaian.AsString := vtAdduraian.AsString;
        if KasMasuk then
        begin
          QDetdebet.AsFloat := 0;
          QDetkredit.AsFloat := vtAddjumlah.AsFloat;
        end
        else
        begin
          QDetdebet.AsFloat := vtAddjumlah.AsFloat;
          QDetkredit.AsFloat := 0;
        end;
        try QDet.Post ; except inc(e) end;
        vtAdd.Next;
      end;
      if not KasMasuk then
      begin
        QDet.Append;
        QDetref_jurnal.AsString := kdjur;
        QDetkode_rek.AsString := StripDots(copy(eRekKas.Text, 1, 12));
        QDeturaian.AsString := copy(eRekKas.Text, 16, length(eRekKas.Text)-15);
        QDetdebet.AsFloat := 0;
        QDetkredit.AsFloat := jml;
        try QDet.Post ; except inc(e) end;
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
      MsgBoxTimeout('Sukses', 'Jurnal tersimpan...', 3);
      acNew.Execute;
    end;
  end;
end;

procedure TFJurnalKas.Add1Click(Sender: TObject);
var
  sl: TStringList;
begin
  sl := SelectMasterDetail(
    GetGlobalConnection,
    'select pkode, kode, full_kode, vkode, rekening from v_coa_2 order by full_kode asc',
    ['full_kode', 'vkode', 'rekening'],
    'pkode','kode',
    5,
    ['','Kode','Uraian'],
    [0,80,280],
    false,700, 400, 'Pilih Akun Perolehan'
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

procedure TFJurnalKas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TFJurnalKas.FormCreate(Sender: TObject);
begin
  if not vtAdd.Active then
    vtAdd.Open;
  eTanggal.Date := Date();
  acNew.Execute;
end;

procedure TFJurnalKas.geRekColumns1EditButtons0Click(Sender: TObject;
  var Handled: Boolean);
var
  sl: TStringList;
begin
  sl := SelectMasterDetail(
    GetGlobalConnection,
    'select pkode, kode, full_kode, vkode, rekening from v_coa_2 order by full_kode asc',
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

procedure TFJurnalKas.Hapus1Click(Sender: TObject);
begin
  if not vtAdd.IsEmpty then
    vtAdd.Delete;
end;

procedure TFJurnalKas.HapusSemua1Click(Sender: TObject);
begin
  EmptyDataset(vtAdd);
end;

end.
