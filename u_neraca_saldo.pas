unit u_neraca_saldo;

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
  TFNeracaSaldo = class(TForm)
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
    mtCOA: TMemTableEh;
    Panel2: TPanel;
    acViewGL: TAction;
    BukuBesar1: TMenuItem;
    ActionList1: TActionList;
    Panel3: TPanel;
    Label2: TLabel;
    luFilter: TDBLookupComboBox;
    UniQuery1: TUniQuery;
    UniQuery1kode: TStringField;
    UniQuery1rekening: TStringField;
    DataSource1: TDataSource;
    qCOAtingkat: TIntegerField;
    qCOAp_kode: TMemoField;
    qCOAskode: TMemoField;
    qCOAkode_rek: TMemoField;
    qCOAvkode: TMemoField;
    qCOAnama_rek: TMemoField;
    qCOAsaldo_awal: TFloatField;
    qCOAbertambah: TFloatField;
    qCOAberkurang: TFloatField;
    qCOAsaldo_akhir: TFloatField;
    cbTipe: TComboBox;
    cbBulan: TComboBox;
    cbTahun: TComboBox;
    Panel4: TPanel;
    Memo1: TMemo;
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
  FNeracaSaldo: TFNeracaSaldo;

implementation

uses u_display_text, u_select_kode_name, u_frutils, u_select_master_detail,
  u_gl, u_input_integer, u_add_rek,
  u_login_otf;

{$R *.dfm}

procedure TFNeracaSaldo.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFNeracaSaldo.acRefreshExecute(Sender: TObject);
begin
  BeginProgress('Memuat Data...', RefreshData);
end;

procedure TFNeracaSaldo.acViewGLExecute(Sender: TObject);
var
  f: TForm;
  t1, t2: TDateTime;
begin
  if cbBulan.ItemIndex = 0 then
  begin
    t1 := EncodeDate(_i(cbTahun.Text), 01,01);
    t2 := AkhirTahun(t1);
  end
  else
  begin
    t1 := AwalBulan (EncodeDate(_i(cbTahun.Text), cbBulan.ItemIndex,01));
    t2 := AkhirBulan(t1);
  end;
  f := ShowGL(mtCOA.FieldByName('kode_rek').AsString, t1, t2);
  FMain.AddChildForm(f);
end;

procedure TFNeracaSaldo.cbBulanChange(Sender: TObject);
begin
  acRefresh.Execute;
end;

procedure TFNeracaSaldo.cbStatusChange(Sender: TObject);
begin
  acRefresh.Execute;
end;


procedure TFNeracaSaldo.gehAdvDrawDataCell(Sender: TCustomDBGridEh; Cell,
  AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
  var Params: TColCellParamsEh; var Processed: Boolean);
var
  Dataset: TDataset;
  vkode: string;
  lvl: integer;
begin
  Dataset := Sender.DataSource.DataSet;
  lvl := sender.DataSource.DataSet.FieldByName('tingkat').AsInteger;
  if lvl=1 then
  begin
    Params.Font.Style := [fsBold];
    Params.Background := $00C4D7FF;
  end
  else
  if lvl=2 then
  begin
    Params.Font.Style := [fsBold];
    Params.Background := $00ECF2FF;
  end
  else
  if lvl =3  then
  begin
    Params.Font.Style := [fsItalic];
    Params.Background := $00EAFCFF;
  end
  else
    Params.Font.Style := [];
  if Column.FieldName = 'vkode' then
  begin
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
  if Column.FieldName = 'nama_rek' then
  begin
    vkode := Column.Field.AsString;
    Params.Text := LPad('', (lvl-1)*4, ' ')+vkode;
  end
  ;

end;

procedure TFNeracaSaldo.luFilterCloseUp(Sender: TObject);
begin
  // acRefresh.Execute;
end;

procedure TFNeracaSaldo.RefreshData;
var
  bm: TBookmark;
  s,
  filterKey,
  k: string;
  arr: TStringArr;
  t1,
  t2: TDateTime;
begin

  filterKey := UniQuery1kode.AsString;
  if filterKey = '' then
    filterKey := '*';
  SetOption(CurrentUser.KodeCabang+'-default-nrc-saldo-filter', filterKey, true);
  SetOption(CurrentUser.KodeCabang+'-default-nrc-saldo-tipe', _s(cbTipe.ItemIndex), true);
  SetOption(CurrentUser.KodeCabang+'-default-nrc-saldo-tahun', _s(cbTahun.ItemIndex), true);
  SetOption(CurrentUser.KodeCabang+'-default-nrc-saldo-bulan', _s(cbBulan.ItemIndex), true);
  if cbBulan.ItemIndex = 0 then
  begin
    t1 := EncodeDate(_i(cbTahun.Text), 01,01);
    t2 := AkhirTahun(t1);
  end
  else
  begin
    t1 := AwalBulan (EncodeDate(_i(cbTahun.Text), cbBulan.ItemIndex,01));
    t2 := AkhirBulan(t1);
  end;
  k := mtCOA.FieldByName('kode_rek').AsString;
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
    mtCOA.Fields.Clear;
    qCOA.ParamByName('cab').AsString := CurrentUser.KodeCabang;
    qCOA.ParamByName('prefix').AsString := filterKey;
    qCOA.ParamByName('t1').AsDateTime := t1;
    qCOA.ParamByName('t2').AsDateTime := t2;
    qCOA.ParamByName('cur_only').AsString := _iif(cbTipe.ItemIndex = 0, 'N','Y');
    qCOA.Open;
    mtCOA.LoadFromDataSet(qCOA, -1, lmCopy, false);
    mtCOA.TreeList.KeyFieldName := 'kode_rek';
    mtCOA.TreeList.RefParentFieldName:= 'p_kode';
    mtCOA.TreeList.Active := true;
    mtCOA.Locate('kode_rek', k, []);
  finally
    mtCOA.EnableControls;
    ScreenIdle;
    Application.ProcessMessages;
  end;
  EndProgress;
end;

procedure TFNeracaSaldo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TFNeracaSaldo.FormCreate(Sender: TObject);
var
  i: integer;
  sl: TStringList;
  kode: string;
begin
  cbBulan.Clear;
  cbBulan.Items.Add('-- Semuanya --');
  for i := 1 to 12 do
    cbBulan.Items.Add(FormatSettings.LongMonthNames[i]);
  kode := GetOption(CurrentUser.KodeCabang+'-default-nrc-saldo-bulan', true);
  cbBulan.ItemIndex := Bulan(Now());
  UniQuery1.open;
  cbTahun.Clear;
  for i:= CurrentYear-10 to CurrentYear+10 do
    cbTahun.Items.Add(_s(i));
  kode := GetOption(CurrentUser.KodeCabang+'-default-nrc-saldo-tahun', true);
  cbTahun.ItemIndex :=  cbTahun.Items.IndexOf(_s(CurrentYear));
  cbTipe.Items.Clear;
  cbTipe.Items.Add('Saldo Akumulasi');
  cbTipe.Items.Add('Saldo Bulanan');
  kode := GetOption(CurrentUser.KodeCabang+'-default-nrc-saldo-tipe', true);
  cbTipe.ItemIndex := 0;
  kode := GetOption(CurrentUser.KodeCabang+'-default-nrc-saldo-filter', true);
  if kode = '' then
    kode := '*';
  UniQuery1.Locate('kode', kode, []);
  luFilter.KeyValue := kode;
  acRefresh.Execute;
end;

end.
