unit u_muzaki;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ToolWin, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  ExtCtrls, StdCtrls, DBGridEhGrouping, GridsEh, DBGridEh, DB, MemDS,
  DBAccess, Menus, ToolCtrlsEh,
  DBGridEhToolCtrls, DBAxisGridsEh, DynVarsEh, Uni, umain, u_utils,
  frxClass, frxDBSet, Grids, DBGrids, System.Actions, EhLibVCL,
  Vcl.ComCtrls,
  u_dbgrideh_dac_helper, Vcl.DBCtrls, VirtualTable,
  superobject;

type
  TFMuzaki = class(TForm)
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    acClose: TAction;
    acRefresh: TAction;
    acPrintNPWZ: TAction;
    Panel1: TPanel;
    frxReport1: TfrxReport;
    acDetail: TAction;
    PopupMenu1: TPopupMenu;
    DetailJurnal1: TMenuItem;
    Label10: TLabel;
    dpStart: TDateTimePicker;
    Label3: TLabel;
    dpBs: TDateTimePicker;
    acPrintReport: TAction;
    lcKec: TDBLookupComboBox;
    lcKel: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    geAdd: TDBGridEh;
    vtMzk: TVirtualTable;
    vtMzkNama: TStringField;
    vtMzkKelurahan: TStringField;
    vtMzkNPWZ: TStringField;
    dsAdd: TDataSource;
    qFetch: TUniQuery;
    qFetchnpwz: TMemoField;
    qFetchtipe: TMemoField;
    qFetchnama: TMemoField;
    qFetchalamat_user: TMemoField;
    qFetchalamat_system: TMemoField;
    qFetchdata_penerimaan: TMemoField;
    qKec: TUniQuery;
    dsKec: TDataSource;
    qKeckode: TStringField;
    qKecnama: TStringField;
    dsKel: TDataSource;
    qKel: TUniQuery;
    qKelkode: TStringField;
    qKelkode_kec: TStringField;
    qKelnama: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acCloseExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbBulanChange(Sender: TObject);
    procedure acPrintNPWZExecute(Sender: TObject);
    procedure frxReport1Preview(Sender: TObject);
    procedure acDetailExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure geAddKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure qKelAfterScroll(DataSet: TDataSet);
    procedure acPrintReportExecute(Sender: TObject);
    procedure acRefreshExecute(Sender: TObject);
  private
    { Private declarations }
    procedure RefreshData;
  public
    { Public declarations }
  end;

var
  FMuzaki: TFMuzaki;


implementation

uses u_display_text, u_select_kode_name, u_frutils, u_select_master_detail,
  u_jurnal;

{$R *.dfm}


procedure TFMuzaki.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFMuzaki.acDetailExecute(Sender: TObject);
begin
  //
end;

procedure TFMuzaki.acPrintNPWZExecute(Sender: TObject);
var
  rpt: String;
  bm: TBookmark;
  codes: TStringList;
  i: integer;
  wherecode: String;
begin
  if vtMzk.IsEmpty then
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

  bm := vtMzk.GetBookmark;
  vtMzk.DisableControls;
  try
    frxReport1.LoadFromFile(rpt);

    frxReport1.ShowReport();
  finally
    if vtMzk.BookmarkValid(bm) then
      vtMzk.GotoBookmark(bm);
    vtMzk.EnableControls;
  end;
end;

procedure TFMuzaki.acPrintReportExecute(Sender: TObject);
begin
  //
end;

procedure TFMuzaki.acRefreshExecute(Sender: TObject);
begin
  BeginProgress('Memuat Data Muzaki...', RefreshData);
end;

procedure TFMuzaki.cbBulanChange(Sender: TObject);
begin
  acRefresh.Execute;
end;

procedure TFMuzaki.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TFMuzaki.FormCreate(Sender: TObject);
begin
  qKec.Open;
  qKel.Open;
  if not  qKec.IsEmpty then
  begin
    qKec.First;
    lcKec.KeyValue := qKeckode.AsString;
  end;
  if not qKel.IsEmpty then
  begin
    qKel.First;
    lcKel.KeyValue := qKelkode.AsString;
  end;
  dpStart.Date  := AwalBulan(date);
  dpBs.Date     := AkhirBulan(date);
end;

procedure TFMuzaki.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key <> VK_F3 then
    exit;
  key := 0;
  SendCtrlF;
end;

procedure TFMuzaki.frxReport1Preview(Sender: TObject);
begin
  AddMDIReport(TFrxReport(Sender), 'Kartu Muzaki');
end;

procedure TFMuzaki.geAddKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if chr(key) in ['a'..'z','A'..'Z','0'..'9'] then
  begin
    SendCtrlF;
  end
  else
  if Key = VK_UP then
  begin
    if vtMzk.Bof then
      SendCtrlF;
  end
  else
  if Key = VK_Down then
  begin
    if vtMzk.Eof then
      SendCtrlF;
  end;
end;

procedure TFMuzaki.qKelAfterScroll(DataSet: TDataSet);
begin
  lcKel.KeyValue := qKelkode.AsString;
end;

procedure TFMuzaki.RefreshData;
var
  k: string;
  strJson: String;
  json, field: ISuperObject;
  i: integer;
  ceh: TColumnEh;
  f: TFieldDef;
begin
  k:= '';
  vtMzk.DisableControls;
  try
    if vtMzk.Active then
    begin
      k:= vtMzkNPWZ.AsString;
      vtMzk.Clear;
      vtMzk.Close;
    end;
    // clear data from vtMZK:
    if qFetch.Active then
      qFetch.Close;
    qFetch.ParamByName('cab').AsString := CurrentUser.KodeCabang;
    qFetch.ParamByName('t1').AsDateTime := dpStart.Date;
    qFetch.ParamByName('t1').AsDateTime := dpBs.Date;
    qFetch.ParamByName('kec').AsString := lcKec.KeyValue;
    qFetch.ParamByName('kel').AsString := lcKel.KeyValue;
    try
      qFetch.Open;
      if not qFetch.IsEmpty then
      begin
        qFetch.First;
        // fetch columns from qFtech to vtMZK:
        strJson := qFetchdata_penerimaan.AsString;
        try
          json := SO(strJson);
          for i := geAdd.Columns.Count-1 downto 3 do
            geAdd.Columns[i].Free;
          for i := vtMzk.Fields.Count-1 downto 3 do
            vtMzk.Fields[i].Free;
          for i := vtMzk.FieldDefs.Count-1 downto 3 do
            vtMzk.FieldDefs[i].Free;
          for field in json['data'] do
          begin
            f := vtMzk.FieldDefs.AddFieldDef;
            f.Required := false;
            f.DataType := ftFloat;
            f.Name := field.S['r'];
            f.CreateField(vtMzk).FieldName := f.Name;
            ceh := geAdd.Columns.Add;
            ceh.FieldName := f.name;
            ceh.Index := geAdd.Columns.Count-1;
            ceh.DisplayFormat := '#,#0.## ;(#,#0.##) ;  ';
            if field.s['k'][1]='4' then
              ceh.Title.Caption := 'Penerimaan Dana|'+f.Name
            else
              ceh.Title.Caption := f.Name;
            ceh.Width := 120;
            ceh.ReadOnly := false;
            ceh.Footer.ValueType := fvtSum;
            ceh.Footer.DisplayFormat := ceh.DisplayFormat;
          end;
          vtMzk.Open;
          {
          vtMzk.Append;
          vtMzkNPWZ.AsString := qFetchnpwz.AsString;
          vtMzkNama.AsString := qFetchnama.AsString;
          vtMzkKelurahan.AsString := qFetchalamat_system.AsString;
          i:=2;
          for field in json['data'] do
          begin
            inc(i);
            vtMzk.Fields[i].AsFloat := field.D['v'];
          end;
          vtMzk.Post;
          }
          while not qFetch.Eof do
          begin
            // fetch data into vtMZK:
            strJson := qFetchdata_penerimaan.AsString;
            json.Clear(true);
            json := SO(strJson);
            vtMzk.Append;
            vtMzkNPWZ.AsString := qFetchnpwz.AsString;
            vtMzkNama.AsString := qFetchnama.AsString;
            vtMzkKelurahan.AsString := qFetchalamat_system.AsString;
            i:=2;
            for field in json['data'] do
            begin
              inc(i);
              vtMzk.Fields[i].AsFloat := field.D['v'];
            end;
            vtMzk.Post;
            qFetch.Next;
          end;
          if k<>'' then
            vtMzk.Locate('npwz',k, []);
        except
          Deny('Gagal melakukan parsing JSON [Data Muzaki]');
        end;
      end;
    except
      Deny('Gagal memuat data [Data Muzaki]');
    end;
  finally
    vtMzk.EnableControls;
    EndProgress;
  end;
end;

end.