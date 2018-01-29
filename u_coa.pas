unit u_coa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ToolWin, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  ExtCtrls, StdCtrls, DBGridEhGrouping, GridsEh, DBGridEh, DB, MemDS,
  DBAccess, Menus, ToolCtrlsEh,
  DBGridEhToolCtrls, DBAxisGridsEh, DynVarsEh, Uni, umain, u_utils,
  frxClass, frxDBSet, Grids, DBGrids, System.Actions, EhLibVCL, Vcl.DBCtrls,
  JvComponentBase, JvEnterTab, System.Win.ComObj,

  u_dbgrideh_dac_helper, MemTableDataEh, MemTableEh;

type
  TFCoa = class(TForm)
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    acClose: TAction;
    acRefresh: TAction;
    dsCOA: TDataSource;
    geh: TDBGridEh;
    JvEnterAsTab1: TJvEnterAsTab;
    qCOA: TUniQuery;
    PopupMenu2: TPopupMenu;
    MenuItem2: TMenuItem;
    Panel1: TPanel;
    Label4: TLabel;
    qCOAtingkat: TIntegerField;
    qCOApkode: TStringField;
    qCOAkode: TMemoField;
    qCOArekening: TStringField;
    qCOAvkode: TStringField;
    qCOAjml: TLargeintField;
    mtCOA: TMemTableEh;
    Panel2: TPanel;
    qCOAsandi_ojk: TStringField;
    acViewGL: TAction;
    BukuBesar1: TMenuItem;
    acSaldo1: TMenuItem;
    Label1: TLabel;
    acAdd: TAction;
    acAddChild: TAction;
    acEdit: TAction;
    N1: TMenuItem;
    ambahAkunSelevel1: TMenuItem;
    ambahAkunAnak1: TMenuItem;
    EditAkun1: TMenuItem;
    Sembunyikan1: TMenuItem;
    Memo1: TMemo;
    CheckBox1: TCheckBox;
    qCOAhide: TStringField;
    acHapus: TAction;
    Hapus1: TMenuItem;
    ActionList1: TActionList;
    acSetKas: TAction;
    acSetBank: TAction;
    acSetAsetTetap: TAction;
    N2: TMenuItem;
    SetAkunKas1: TMenuItem;
    SetAkunBank1: TMenuItem;
    SetAkunAsetTetap1: TMenuItem;
    Panel3: TPanel;
    Label2: TLabel;
    luFilter: TDBLookupComboBox;
    UniQuery1: TUniQuery;
    UniQuery1kode: TStringField;
    UniQuery1rekening: TStringField;
    DataSource1: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure acRefreshExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acCloseExecute(Sender: TObject);
    procedure cbBulanChange(Sender: TObject);
    procedure cbStatusChange(Sender: TObject);
    procedure gehAdvDrawDataCell(Sender: TCustomDBGridEh; Cell,
      AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
      var Params: TColCellParamsEh; var Processed: Boolean);
    procedure acViewGLExecute(Sender: TObject);
    procedure mtCOAAfterScroll(DataSet: TDataSet);
    procedure acAddExecute(Sender: TObject);
    procedure acAddChildExecute(Sender: TObject);
    procedure acEditExecute(Sender: TObject);
    procedure acHapusExecute(Sender: TObject);
    procedure acSetKasExecute(Sender: TObject);
    procedure acSetBankExecute(Sender: TObject);
    procedure acSetAsetTetapExecute(Sender: TObject);
    procedure luFilterCloseUp(Sender: TObject);
  private
    { Private declarations }
    DefKas,
    DefBank,
    DefLR,
    DefLRLalu,
    DefAset,
    DefBYMHD: String;
    procedure RefreshData;
  public
    { Public declarations }

  end;

var
  FCoa: TFCoa;

implementation

uses u_display_text, u_select_kode_name, u_frutils, u_select_master_detail,
  u_gl, u_input_integer, u_add_rek,
  u_login_otf;

{$R *.dfm}

procedure TFCoa.acAddChildExecute(Sender: TObject);
var
  k, n: String;
  AksesDel: Boolean;
begin
  AksesDel :=  AccessibleBy(CurrentUser, 'Menambah Akun');
  if not AksesDel then
  begin
    Inform('Anda perlu hak akses berikut: '#13'* Menambah Akun');
    exit;
  end;
  {
  AksesDel := true;
  AksesDel := LoginOTF('Anda perlu login admin:');
  if not AksesDel then
  begin
    exit;
  end;
  }
  if mtCOA.IsEmpty then
    exit;
  k := '';
  n := '';
  if AddRek(mtCOA.FieldByName('kode').AsString, k, n) then
    Label1.Show;
end;

procedure TFCoa.acAddExecute(Sender: TObject);
var
  k, n: String;
  AksesDel: Boolean;
begin
  AksesDel :=  AccessibleBy(CurrentUser, 'Menambah Akun');
  if not AksesDel then
  begin
    Inform('Anda perlu hak akses berikut: '#13'* Menambah Akun');
    exit;
  end;
  {
  AksesDel := true;
  AksesDel := LoginOTF('Anda perlu login admin:');
  if not AksesDel then
  begin
    exit;
  end;
  }
  if mtCOA.IsEmpty then
    exit;
  k := '';
  n := '';
  if AddRek(mtCOA.FieldByName('pkode').AsString, k, n) then
    Label1.Show;
end;

procedure TFCoa.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFCoa.acEditExecute(Sender: TObject);
var
  n: String;
  AksesDel: Boolean;
begin
  AksesDel :=  AccessibleBy(CurrentUser, 'Mengedit Akun');
  if not AksesDel then
  begin
    Inform('Anda perlu hak akses berikut: '#13'* Mengedit Akun');
    exit;
  end;
  {
  AksesDel := true;
  AksesDel := LoginOTF('Anda perlu login admin:');
  if not AksesDel then
  begin
    exit;
  end;
  }
  if mtCOA.IsEmpty then
    exit;
  n := '';
  if EditRek(mtCOA.FieldByName('kode').AsString, n) then
    Label1.Show;
end;

procedure TFCoa.acHapusExecute(Sender: TObject);
var
  k,
  n: String;
  t: integer;
  AksesDel: Boolean;
begin
  AksesDel :=  AccessibleBy(CurrentUser, 'Menghapus Akun');
  if not AksesDel then
  begin
    Inform('Anda perlu hak akses berikut: '#13'* Menghapus Akun');
    exit;
  end;
  {
  AksesDel := true;
  AksesDel := LoginOTF('Anda perlu login admin:');
  if not AksesDel then
  begin
    exit;
  end;
  }
  if mtCOA.IsEmpty then
    exit;
  n := mtCOA.FieldByName('vkode').AsString +' '+mtCOA.FieldByName('rekening').AsString;
  k := mtCOA.FieldByName('kode').AsString;
  t := ExecSQLAndFetchOneValueAsInteger('select count(*) from acc_jurnal_u_detail where kode_rek like '+_q(k+'%'));
  if t>0 then
  begin
    Inform(n+' telah dijurnal dan tidak dapat dihapus.');
    exit;
  end;
  t := mtCOA.FieldByName('tingkat').AsInteger;
  if Ask('Hapus akun:'#13+n+#13'Lanjutkan?') <>mryes then
    exit;
  try
    // ShowText('delete from sys_coa_'+_s(t)+' where kode = '+_q(k));
    ExecSQL('delete from sys_coa_'+_s(t)+' where kode = '+_q(k)).Free;
    Label1.Show;
  except
    Warn('Gagal menghapus akun');
  end;
end;

procedure TFCoa.acRefreshExecute(Sender: TObject);
begin
  BeginProgress('Memuat Data...', RefreshData);
end;

procedure TFCoa.acSetAsetTetapExecute(Sender: TObject);
begin
  if mtCOA.IsEmpty then
    exit;
  if 'Y' = SetOption(CurrentUser.KodeCabang+'defkodeasetlevel3', mtCOA.FieldByName('kode').AsString) then
    Label1.Show;
end;

procedure TFCoa.acSetBankExecute(Sender: TObject);
begin
  if mtCOA.IsEmpty then
    exit;
  if 'Y' = SetOption(CurrentUser.KodeCabang+'defsetbank', mtCOA.FieldByName('kode').AsString) then
    Label1.Show;
end;

procedure TFCoa.acSetKasExecute(Sender: TObject);
begin
  if mtCOA.IsEmpty then
    exit;
  if 'Y' = SetOption(CurrentUser.KodeCabang+'defsetkas', mtCOA.FieldByName('kode').AsString) then
    Label1.Show;
end;

procedure TFCoa.acViewGLExecute(Sender: TObject);
var
  f: TForm;
begin
  f := ShowGL(mtCOA.FieldByName('kode').AsString, AwalBulan(date), date);
  FMain.AddChildForm(f);
end;

procedure TFCoa.cbBulanChange(Sender: TObject);
begin
  acRefresh.Execute;
end;

procedure TFCoa.cbStatusChange(Sender: TObject);
begin
  acRefresh.Execute;
end;


procedure TFCoa.gehAdvDrawDataCell(Sender: TCustomDBGridEh; Cell,
  AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
  var Params: TColCellParamsEh; var Processed: Boolean);
var
  Dataset: TDataset;
  vkode: string;
  lvl: integer;
begin
  Dataset := Sender.DataSource.DataSet;
  if Dataset.FieldByName('hide').AsString = 'Y' then
  begin
    Params.Background := $00F3F3F3;
    if Column.Index = 4 then
      Params.Text := 'Tersembunyi';
  end;
  if Column.FieldName = 'vkode' then
  begin
    lvl := sender.DataSource.DataSet.FieldByName('tingkat').AsInteger;
    vkode := Column.Field.AsString;
    case lvl of
      1: Params.Text := vkode[1];
      2: Params.Text := copy(vkode, 1,3);
      3: Params.Text := copy(vkode, 1,6);
      4: Params.Text := copy(vkode, 1,9);
      else
         Params.Text := vkode;
    end;
  end
  else
  if Column.FieldName = 'rekening' then
  begin
    lvl := sender.DataSource.DataSet.FieldByName('tingkat').AsInteger;
    vkode := Column.Field.AsString;
    Params.Text := LPad('', (lvl-1)*4, ' ')+vkode;
  end
  else
  if Column.FieldName = 'jml' then
  begin
    lvl := Column.Field.AsInteger;
    if lvl<>0 then
      Params.Background := $00C4D7FF;
  end
  else
  if column.FieldName = 'sandi_ojk' then
  begin
    lvl := sender.DataSource.DataSet.FieldByName('tingkat').AsInteger;
    if (Column.Field.AsString = '') and (lvl=5) then
      Params.Background := $003778FF;
  end;

  vKode:= Dataset.FieldByName('kode').AsString;
  // ShowMessage(vkode+':'+DefKas);
  if vkode = DefKas then
  begin
    Params.Background := $00ffebeb;
    Params.Font.Style := [fsBold];
  end
  else
  if vkode = DefBank then
  begin
    Params.Background := $00ebffeb;
    Params.Font.Style := [fsBold];
  end
  else
  if vkode = DefLR then
  begin
    Params.Background := $00eb9090;
    Params.Font.Style := [fsBold];
  end
  else
  if vkode = DefLRLalu then
  begin
    Params.Background := $00ebabab;
    Params.Font.Style := [fsBold];
  end
  else
  if vkode = DefAset then
  begin
    Params.Background := $00abebeb;
    Params.Font.Style := [fsBold];
  end
  else
  if vkode = DefBYMHD then
  begin
    Params.Background := $00ababee;
    Params.Font.Style := [fsBold];
  end;
end;

procedure TFCoa.luFilterCloseUp(Sender: TObject);
begin
  acRefresh.Execute;
end;

procedure TFCoa.mtCOAAfterScroll(DataSet: TDataSet);
var
  t : Integer;
begin
  Label1.Hide;
  t := mtCOA.FieldByName('tingkat').AsInteger;
  acAdd.Enabled := t in [2..5];
  acAddChild.Enabled := t in [1..4];
  acEdit.Enabled := t in [2..5];
  if t in [2..5] then
  begin
    //
  end;
end;

procedure TFCoa.RefreshData;
var
  bm: TBookmark;
  s,
  filterKey,
  k: string;
  arr: TStringArr;
begin
  filterKey := UniQuery1kode.AsString;
  if filterKey = '' then
    filterKey := '*';
  SetOption(CurrentUser.KodeCabang+'-default-coa-filter', filterKey, true);
  k := mtCOA.FieldByName('kode').AsString;
  ScreenBussy;
  SetLength(arr, 6);
  arr := [
    currentuser.KodeCabang+'defsetkas',
    currentuser.KodeCabang+'defsetbank',
    currentuser.KodeCabang+'defsetlr',
    currentuser.KodeCabang+'defsetlrn1',
    currentuser.KodeCabang+'defkodeasetlevel3',
    currentuser.KodeCabang+'defsetbymhd'
  ];
  arr := GetMultipleOptions(arr);
  DefKas := arr[0];
  DefBank := arr[1];
  DefLR := arr[2];
  DefLRLalu := arr[3];
  DefAset := arr[4];
  DefBYMHD := arr[5];

  Application.ProcessMessages;
  mtCOA.DisableControls;
  try
    if qCOA.Active then
      qCOA.Close;
    s := Memo1.Text;
    if CheckBox1.Checked then
    begin
      s := _r(s, '(0)', 'count(u.*)', []);
      s := _r(s, '-- --->', '', []);
    end;
    if filterKey<>'*' then
      s := _r(s, '(9=9)', ' (v_coa_2.kode like '+_q(filterKey+'%')+ ') ', []);
    qCOA.SQL.Text := s;
    {
    if mtCOA.Active then
      mtCOA.Close;
    }
    mtCOA.Fields.Clear;
    qCOA.Open;
    mtCOA.LoadFromDataSet(qCOA, -1, lmCopy, false);
    mtCOA.TreeList.KeyFieldName := 'kode';
    mtCOA.TreeList.RefParentFieldName:= 'pkode';
    mtCOA.TreeList.Active := true;
    mtCOA.Locate('kode', k, []);
  finally
    {
    if mtCOA.BookmarkValid(bm) then
      mtCOA.Bookmark := bm;
    }
    mtCOA.EnableControls;
    ScreenIdle;
    Application.ProcessMessages;
  end;
  EndProgress;
end;

procedure TFCoa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TFCoa.FormCreate(Sender: TObject);
var
  i: integer;
  sl: TStringList;
  kode: string;
begin
  UniQuery1.open;
  kode := GetOption(CurrentUser.KodeCabang+'-default-coa-filter', true);
  if kode = '' then
    kode := '*';
  UniQuery1.Locate('kode', kode, []);
  luFilter.KeyValue := kode;
  acRefresh.Execute;
end;

end.
