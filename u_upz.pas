unit u_upz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ToolWin, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  ExtCtrls, StdCtrls, DBGridEhGrouping, GridsEh, DBGridEh, DB, MemDS,
  DBAccess, Menus, ToolCtrlsEh,
  DBGridEhToolCtrls, DBAxisGridsEh, DynVarsEh, Uni, umain, u_utils,
  frxClass, frxDBSet, Grids, DBGrids, System.Actions, EhLibVCL,
  Vcl.ComCtrls, System.Win.ComObj,
  u_dbgrideh_dac_helper, Vcl.DBCtrls, VirtualTable,
  superobject;

type
  TFUPZ = class(TForm)
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    acClose: TAction;
    acRefresh: TAction;
    acPrintNPM: TAction;
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
    Label5: TLabel;
    geAdd: TDBGridEh;
    vtMzk: TVirtualTable;
    vtMzkNama: TStringField;
    vtMzkKelurahan: TStringField;
    vtMzkNPWZ: TStringField;
    dsAdd: TDataSource;
    qFetch: TUniQuery;
    qKec: TUniQuery;
    dsKec: TDataSource;
    qKeckode: TStringField;
    qKecnama: TStringField;
    dsKel: TDataSource;
    qKel: TUniQuery;
    qKelkode: TStringField;
    qKelkode_kec: TStringField;
    qKelnama: TStringField;
    vtMzktipe: TStringField;
    Label6: TLabel;
    Label7: TLabel;
    lcTipe: TDBLookupComboBox;
    Bevel2: TBevel;
    qTipe: TUniQuery;
    dsTipe: TDataSource;
    qTipekode: TMemoField;
    qTipeuraian: TStringField;
    qFetchtipe: TMemoField;
    qFetchnama: TMemoField;
    qFetchalamat_user: TMemoField;
    qFetchalamat_system: TMemoField;
    qFetchdata: TMemoField;
    Panel2: TPanel;
    qFetchnpwz: TMemoField;
    acAdd: TAction;
    UPZBaru1: TMenuItem;
    lblChanged: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acCloseExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbBulanChange(Sender: TObject);
    procedure acPrintNPMExecute(Sender: TObject);
    procedure frxReport1Preview(Sender: TObject);
    procedure acDetailExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure geAddKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure qKelAfterScroll(DataSet: TDataSet);
    procedure acPrintReportExecute(Sender: TObject);
    procedure acRefreshExecute(Sender: TObject);
    procedure geAddCellClick(Column: TColumnEh);
    procedure geAddAdvDrawDataCell(Sender: TCustomDBGridEh; Cell,
      AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
      var Params: TColCellParamsEh; var Processed: Boolean);
    procedure acAddExecute(Sender: TObject);
  private
    { Private declarations }
    var
      LastKode: String;
    procedure RefreshData;
    procedure ExportKeExcel;
  public
    { Public declarations }
  end;

var
  FUPZ: TFUPZ;


implementation

uses u_display_text, u_select_kode_name, u_frutils, u_select_master_detail,
  u_jurnal, u_new_muzaki, u_new_muzaki_ex;

{$R *.dfm}


procedure TFUPZ.acAddExecute(Sender: TObject);
var
  mz: string;
begin
  mz := InputmuzakiBaruEx('UPZ');
  if mz<>'' then
    lblChanged.Show;
end;

procedure TFUPZ.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFUPZ.acDetailExecute(Sender: TObject);
begin
  //
end;

procedure TFUPZ.acPrintNPMExecute(Sender: TObject);
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

procedure TFUPZ.acPrintReportExecute(Sender: TObject);
begin
  BeginProgress('Mengekspor data ke Excel...', ExportKeExcel);
end;

procedure TFUPZ.acRefreshExecute(Sender: TObject);
begin
  BeginProgress('Memuat Data Muzaki...', RefreshData);
end;

procedure TFUPZ.cbBulanChange(Sender: TObject);
begin
  acRefresh.Execute;
end;

procedure TFUPZ.ExportKeExcel;
const
  TOTAL_Formula ='SUBTOTAL(9,%s%u:%s%u)';
  COUNT_Formula  ='SUBTOTAL(2,%s%u:%s%u)';
var
  kd: String;
  f: TfrxReport;
  sql: String;
  p: Pchar;
  //
  bukaExcel: Boolean;
  XL,
  WB,
  WS,
  cell,
  RNG: OleVariant;
  no, i, j, row: Integer;
  Head_Row,
  Start_Data_Row,
  Footer_Row,
  End_Data_Row: integer;
  col: TColumnEh;
  TargetFile,
  cap: String;
  arrData: variant;
begin
  TargetFile := TempFile('', '.xlsx');
  if TargetFile = '' then
  begin
    EndProgress;
    exit;
  end;
  if FileExists(TargetFile) then
    DeleteFile(TargetFile);

  bukaExcel := true;
  if not vtMzk.IsEmpty then
    kd := vtMzkNPWZ.AsString;
  vtMzk.DisableControls;
  ScreenBussy;
  Application.ProcessMessages;
  self.Enabled := False;
  try
    CopyFile(Pchar(Fmain.ReportsDir() + '\lap_upz.xlsx'),
      PChar(TargetFile), False);
    XL := createOleObject('Excel.Application');
    wb := XL.workbooks.open(TargetFile);
    ws := wb.WorkSheets[1];

    ws.cells[5, 3].value := ''''+DateIndo(dpStart.Date) +' - '+DateIndo(dpBs.Date);

    Head_Row := 7;
    Start_Data_Row := 10;
    Footer_Row := 65535;
    End_Data_Row := 65534;
    row := Start_Data_Row;
    no := 1;
    // creating columns:
    // 1. saldo awal:
    RNG := ExcelMergeAndCenter(ws, ExcelColumnByIndex(5)+_s(Head_Row)+':'+ExcelColumnByIndex(6)+_s(Head_Row));
    RNG.Borders.LineStyle := 1;
    RNG.Borders.Weight:= 2;
    RNG.Font.Bold := true;
    RNG.Font.Color := clBlack;
    RNG.Interior.Color := $00E4E4E4;
    RNG.borderAround(1,2,color:= clBlack);
    ws.cells[Head_Row, 5].value := 'Saldo Awal';
    Application.ProcessMessages;
    // penerimaan:
    RNG := ExcelMergeAndCenter(ws, ExcelColumnByIndex(7)+_s(Head_Row)+':'+ExcelColumnByIndex(23)+_s(Head_Row));
    RNG.Borders.LineStyle := 1;
    RNG.Borders.Weight:= 2;
    RNG.Font.Bold := true;
    RNG.Font.Color := clBlack;
    RNG.Interior.Color := $00E4E4E4;
    RNG.borderAround(1,2,color:= clBlack);
    ws.cells[Head_Row, 7].value := 'Penerimaan';
    Application.ProcessMessages;
    // Total penerimaan:
    RNG := ExcelMergeAndCenter(ws, ExcelColumnByIndex(24)+_s(Head_Row)+':'+ExcelColumnByIndex(24)+_s(Head_Row+1));
    RNG.Borders.LineStyle := 1;
    RNG.Borders.Weight:= 2;
    RNG.Font.Bold := true;
    RNG.Font.Color := clBlack;
    RNG.Interior.Color := $00E4E4E4;
    RNG.borderAround(1,2,color:= clBlack);
    ws.cells[Head_Row, 24].value := 'Total Penerimaan';
    Application.ProcessMessages;
    // Penyaluran Zakat:
    RNG := ExcelMergeAndCenter(ws, ExcelColumnByIndex(25)+_s(Head_Row)+':'+ExcelColumnByIndex(37)+_s(Head_Row));
    RNG.Borders.LineStyle := 1;
    RNG.Borders.Weight:= 2;
    RNG.Font.Bold := true;
    RNG.Font.Color := clBlack;
    RNG.Interior.Color := $00E4E4E4;
    RNG.borderAround(1,2,color:= clBlack);
    ws.cells[Head_Row, 25].value := 'Distribusi Zakat';
    Application.ProcessMessages;
    // Penyaluran Infak:
    RNG := ExcelMergeAndCenter(ws, ExcelColumnByIndex(38)+_s(Head_Row)+':'+ExcelColumnByIndex(50)+_s(Head_Row));
    RNG.Borders.LineStyle := 1;
    RNG.Borders.Weight:= 2;
    RNG.Font.Bold := true;
    RNG.Font.Color := clBlack;
    RNG.Interior.Color := $00E4E4E4;
    RNG.borderAround(1,2,color:= clBlack);
    ws.cells[Head_Row, 38].value := 'Distribusi Infak/Sedekah';
    Application.ProcessMessages;
    // Total penyaluran:
    RNG := ExcelMergeAndCenter(ws, ExcelColumnByIndex(51)+_s(Head_Row)+':'+ExcelColumnByIndex(51)+_s(Head_Row+1));
    RNG.Borders.LineStyle := 1;
    RNG.Borders.Weight:= 2;
    RNG.Font.Bold := true;
    RNG.Font.Color := clBlack;
    RNG.Interior.Color := $00E4E4E4;
    RNG.borderAround(1,2,color:= clBlack);
    ws.cells[Head_Row, 51].value := 'Total Penyaluran';
    Application.ProcessMessages;
    // Saldo Akhir:
    RNG := ExcelMergeAndCenter(ws, ExcelColumnByIndex(52)+_s(Head_Row)+':'+ExcelColumnByIndex(52)+_s(Head_Row+1));
    RNG.Borders.LineStyle := 1;
    RNG.Borders.Weight:= 2;
    RNG.Font.Bold := true;
    RNG.Font.Color := clBlack;
    RNG.Interior.Color := $00E4E4E4;
    RNG.borderAround(1,2,color:= clBlack);
    ws.cells[Head_Row, 52].value := 'Saldo Akhir';
    Application.ProcessMessages;
    //
    RNG := ws.range[ExcelColumnByIndex(5)+_s(Head_Row)+':'+ExcelColumnByIndex(52)+_s(Head_Row+1)];
    RNG.Borders.LineStyle := 1;
    RNG.Borders.Weight:= 2;
    RNG.Font.Bold := true;
    RNG.Font.Color := clBlack;
    RNG.Interior.Color := $00E4E4E4;
    RNG.borderAround(1,2,color:= clBlack);
    RNG := ws.range[ExcelColumnByIndex(5)+_s(Head_Row+2)+':'+ExcelColumnByIndex(52)+_s(Head_Row+2)];
    RNG.Borders.LineStyle := 1;
    RNG.Borders.Weight:= 2;
    RNG.Font.Bold := true;
    RNG.Font.Color := clBlack;
    RNG.Interior.Color := $00B4B4B4;
    RNG.borderAround(1,2,color:= clBlack);
    Application.ProcessMessages;
    // columns:
    arrData := VarArrayCreate([1,19], varVariant);
    for i := 3 to 21 do
    begin
      col := geAdd.Columns[i];
      cap :=  col.Title.Caption;
      while pos('|',cap)>0 do
        delete(cap,1,1);
      arrData[i-2] := cap;
    end;
    rng := ws.range[ExcelColumnByIndex(3+2)+_s(Head_Row+1)+':'+ExcelColumnByIndex(21+2)+_s(Head_Row+1)];
    rng.value := arrdata;
    rng.HorizontalAlignment := xlHAlignCenter;
    rng.VerticalAlignment := xlHAlignCenter;
    VarClear(arrData);
    Application.ProcessMessages;
    arrData := VarArrayCreate([21,46], varVariant);
    for i := 23 to 48 do
    begin
      col := geAdd.Columns[i];
      cap :=  col.Title.Caption;
      while pos('|',cap)>0 do
        delete(cap,1,1);
      arrData[i-2] := cap;
    end;
    rng := ws.range[ExcelColumnByIndex(23+2)+_s(Head_Row+1)+':'+ExcelColumnByIndex(48+2)+_s(Head_Row+1)];
    rng.value := arrdata;
    rng.HorizontalAlignment := xlHAlignCenter;
    rng.VerticalAlignment := xlHAlignCenter;
    VarClear(arrData);
    Application.ProcessMessages;
    arrData := VarArrayCreate([1,48], varVariant);
    for i := 3 to 50 do
    begin
      arrData[i-2] := _s(i+2);
    end;
    rng := ws.range[ExcelColumnByIndex(3+2)+_s(Head_Row+2)+':'+ExcelColumnByIndex(50+2)+_s(Head_Row+2)];
    rng.value := arrdata;
    rng.HorizontalAlignment := xlHAlignCenter;
    rng.VerticalAlignment := xlHAlignCenter;
    VarClear(arrData);
    Application.ProcessMessages;

    {
    // merge headers:
    RNG := ws.range[ExcelColumnByIndex(4+2)+_s(Head_Row)+':'+ExcelColumnByIndex((geAdd.Columns.Count-2)+2)+_s(Head_Row)];
    RNG.Borders.LineStyle := 1;
    RNG.Borders.Weight:= 2;
    RNG.Font.Bold := true;
    RNG.Font.Color := clBlack;
    RNG.Interior.Color := $00E4E4E4;
    RNG.borderAround(1,2,color:= clBlack);
    rng.merge;
    rng.HorizontalAlignment := xlHAlignCenter;
    rng.VerticalAlignment := xlVAlignCenter;
    ws.cells[Head_Row,4+2].value := 'Penerimaan Dana';
    // fill the data:
    arrData := VarArrayCreate([1,geAdd.Columns.Count+1], varVariant);
    row := Start_Data_Row;
    if not vtMzk.IsEmpty then
    begin
      vtMzk.First;
      while not vtMzk.Eof do
      begin
        arrData[1] := ''''+_s(row - Start_Data_Row + 1)+'.';
        for i := 2 to 4 do
          arrData[i] := geAdd.Columns[i-2].Field.AsString;
        for i := 5 to geAdd.Columns.Count+1 do
          arrData[i] := geAdd.Columns[i-2].Field.AsFloat;
        rng := ws.range[ExcelColumnByIndex(1)+_s(row)+':'+ExcelColumnByIndex(geAdd.Columns.Count+1)+_s(Row)];
        rng.numberFormat := '#,##0.00;[Red](#,##0.00);"-"';
        RNG.Borders.LineStyle := 1;
        RNG.Borders.Weight:= 2;
        RNG.borderAround(1,2,color:= clBlack);
        rng.value := arrdata;
        inc(row);
        vtMzk.Next;
      end;
    end;
    // footer:
    // arrData[1] := '='+format(COUNT_Formula, [ExcelColumnByIndex(1),start_data_row, ExcelColumnByIndex(1), row-1]);
    for i := 2 to 4 do
      arrData[i] := '';
    for i := 5 to geAdd.Columns.Count+1 do
      arrData[i] := '='+format(TOTAL_Formula, [ExcelColumnByIndex(i),start_data_row, ExcelColumnByIndex(i), row-1]);
    rng := ws.range[ExcelColumnByIndex(1)+_s(row)+':'+ExcelColumnByIndex(geAdd.Columns.Count+1)+_s(Row)];
    rng.numberFormat := '#,##0.00;[Red](#,##0.00);"-"';
    RNG.Borders.LineStyle := 1;
    RNG.Borders.Weight:= 2;
    RNG.borderAround(1,2,color:= clBlack);
    RNG.Font.Bold := true;
    RNG.Font.Color := clBlack;
    RNG.Interior.Color := $00B4B4E4;
    rng.value := arrdata;
    }
    wb.save;
    xl.visible := bukaExcel;
    rng := Unassigned;
    WS := Unassigned;
    WB := Unassigned;
    XL := Unassigned;
  finally
    vtMzk.Locate('npwz', kd, []);
    vtMzk.EnableControls;
    ScreenIdle;
    Application.ProcessMessages;
    self.Enabled := True;
    EndProgress;
  end;
end;

procedure TFUPZ.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TFUPZ.FormCreate(Sender: TObject);
begin
  qTipe.Open;
  if not qTipe.IsEmpty then
  begin
    qTipe.First;
    lcTipe.KeyValue := qTipekode.AsString;
  end;
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
  acRefresh.Execute;
end;

procedure TFUPZ.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key <> VK_F3 then
    exit;
  key := 0;
  SendCtrlF;
end;

procedure TFUPZ.frxReport1Preview(Sender: TObject);
begin
  // AddMDIReport(TFrxReport(Sender), 'Kartu Muzaki');
end;

procedure TFUPZ.geAddAdvDrawDataCell(Sender: TCustomDBGridEh; Cell,
  AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
  var Params: TColCellParamsEh; var Processed: Boolean);
var
  ds: TDataset;
  col,
  tipe: String;
begin
  ds := Sender.DataSource.DataSet;
  tipe := _l(ds.fieldbyname('tipe').asstring);
  col := _l(Column.FieldName);
  if tipe = 'head' then
  begin
    Params.Font.Style := [fsBold];
    Params.Background := $00E8E8E8;
    params.Font.Color := $002B1D15;
    if col <> 'npwz' then
    begin
      Params.Text := '';
    end;
  end
  else
  begin
    if col = 'npwz' then
    begin
      Params.Text := '    '+Params.Text;
    end;
  end;
end;

procedure TFUPZ.geAddCellClick(Column: TColumnEh);
begin
  // ShowMessage(Column.Index.ToString());
end;

procedure TFUPZ.geAddKeyDown(Sender: TObject; var Key: Word;
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

procedure TFUPZ.qKelAfterScroll(DataSet: TDataSet);
begin
  lcKel.KeyValue := qKelkode.AsString;
end;

procedure TFUPZ.RefreshData;
var
  k: string;
  strJson: String;
  json, field: ISuperObject;
  i: integer;
  ceh: TColumnEh;
  f: TFieldDef;
begin
  k:= '';
  ScreenBussy;
  Application.ProcessMessages;
  self.Enabled := False;
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
    qFetch.ParamByName('t2').AsDateTime := dpBs.Date;
    qFetch.ParamByName('tp').AsString := lcTipe.KeyValue;
    qFetch.ParamByName('kec').AsString := lcKec.KeyValue;
    qFetch.ParamByName('kel').AsString := lcKel.KeyValue;
    try
      qFetch.Open;
      if not qFetch.IsEmpty then
      begin
        qFetch.First;
        // fetch columns from qFtech to vtMZK:
        strJson := qFetchdata.AsString;
        try
          json := SO(strJson);
          for i := geAdd.Columns.Count-1 downto 3 do
            geAdd.Columns[i].Free;
          for i := vtMzk.Fields.Count-1 downto 4 do
            vtMzk.Fields[i].Free;
          for i := vtMzk.FieldDefs.Count-1 downto 4 do
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
            if field.D['c'] = 0 then
              ceh.Color := clWhite
            else
            if field.D['c'] = 10 then
              ceh.Color := $00DEFEE9
            else
            if field.D['c'] = 20 then
              ceh.Color := $00DEECFE
            else
            if field.D['c'] = 30 then
              ceh.Color := $00FFF0E1;
            ;
            ceh.Width := 120;
            ceh.ReadOnly := false;
            ceh.Footer.ValueType := fvtSum;
            ceh.Footer.DisplayFormat := ceh.DisplayFormat;
          end;
          vtMzk.Open;
          if not qFetch.Eof then
            qFetch.Next;
          while not qFetch.Eof do
          begin
            // fetch data into vtMZK:
            strJson := qFetchdata.AsString;
            json.Clear(true);
            json := SO(strJson);
            vtMzk.Append;
            // ShowText(json.S['tipe']);
            vtMzktipe.AsString := json.S['tipe'];
            if _l(json.S['tipe']) = 'head' then
              vtMzkNPWZ.AsString := qFetchnama.AsString
            else
              vtMzkNPWZ.AsString := qFetchnpwz.AsString;
            vtMzkNama.AsString := qFetchnama.AsString;
            vtMzkKelurahan.AsString := qFetchalamat_system.AsString;
            i:=3;
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
          Deny('Gagal melakukan parsing JSON [Data UPZ]');
        end;
      end;
    except
      Deny('Gagal memuat data [Data UPZ]');
    end;
  finally
    lblChanged.hide;
    vtMzk.EnableControls;
    EndProgress;
    ScreenIdle;
    Application.ProcessMessages;
    self.Enabled := true;
    if qFetch.Active then
      qFetch.Close;
  end;
end;

end.
