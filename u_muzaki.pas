unit u_muzaki;

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
    Label6: TLabel;
    acAdd: TAction;
    MuzakiBaru1: TMenuItem;
    lblChanged: TLabel;
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
  FMuzaki: TFMuzaki;


implementation

uses u_display_text, u_select_kode_name, u_frutils, u_select_master_detail,
  u_jurnal, u_new_muzaki, u_new_muzaki_ex;

{$R *.dfm}


procedure TFMuzaki.acAddExecute(Sender: TObject);
var
  mz: string;
begin
  mz := InputmuzakiBaruEx('ORG');
  if mz<>'' then
    lblChanged.Show;
end;

procedure TFMuzaki.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFMuzaki.acDetailExecute(Sender: TObject);
var
  k: String;
begin
  if vtMzk.IsEmpty then
    exit;
  k := vtMzkNPWZ.AsString;
  if EditMuzakiEx(k) then
    lblChanged.Show;
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
  BeginProgress('Mengekspor data ke Excel...', ExportKeExcel);
end;

procedure TFMuzaki.acRefreshExecute(Sender: TObject);
begin
  BeginProgress('Memuat Data Muzaki...', RefreshData);
end;

procedure TFMuzaki.cbBulanChange(Sender: TObject);
begin
  acRefresh.Execute;
end;

procedure TFMuzaki.ExportKeExcel;
const
  TOTAL_Formula ='SUBTOTAL(9,%s%u:%s%u)';
  COUNT_Formula  ='SUBTOTAL(2,%s%u:%s%u)';
var
  kd: String;
  f: TfrxReport;
  sql: String;
  //
  bukaExcel: Boolean;
  XL,
  WB,
  WS,
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
  // TargetFile := FMain.GetSaveFileName('Excel Files (*.xls;*.xlsx)|*.xls;*.xlsx', true);
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
    CopyFile(Pchar(Fmain.ReportsDir() + '\lap_mzk.xlsx'),
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
    for i := 3 to geAdd.Columns.Count-1 do
    begin
      col := geAdd.Columns[i];
      cap := _r(col.Title.Caption, 'Penerimaan Dana|','',[rfIgnoreCase]);
      // inform(col.Title.Caption);
      if i = 3 then
      begin
        RNG := ws.range[ExcelColumnByIndex(i+2)+_s(Head_Row)+':'+ExcelColumnByIndex(i+2)+_s(Head_Row+1)];
        RNG.Borders.LineStyle := 1;
        RNG.Borders.Weight:= 2;
        RNG.Font.Bold := true;
        RNG.Font.Color := clBlack;
        RNG.Interior.Color := $00E4E4E4;
        RNG.borderAround(1,2,color:= clBlack);
        rng.merge;
        rng.HorizontalAlignment := xlHAlignCenter;
        rng.VerticalAlignment := xlVAlignCenter;
        ws.cells[Head_Row, i+2].value := cap;
      end
      else
      if i = (geAdd.Columns.Count-1) then
      begin
        RNG := ws.range[ExcelColumnByIndex(i+2)+_s(Head_Row)+':'+ExcelColumnByIndex(i+2)+_s(Head_Row+1)];
        RNG.Borders.LineStyle := 1;
        RNG.Borders.Weight:= 2;
        RNG.Font.Bold := true;
        RNG.Font.Color := clBlack;
        RNG.Interior.Color := $00E4E4E4;
        RNG.borderAround(1,2,color:= clBlack);
        rng.merge;
        rng.HorizontalAlignment := xlHAlignCenter;
        rng.VerticalAlignment := xlVAlignCenter;
        ws.cells[Head_Row, i+2].value := cap;
      end
      else
      begin
        RNG := ws.range[ExcelColumnByIndex(i+2)+_s(Head_Row+1)+':'+ExcelColumnByIndex(i+2)+_s(Head_Row+1)];
        RNG.Borders.LineStyle := 1;
        RNG.Borders.Weight:= 2;
        RNG.Font.Bold := true;
        RNG.Font.Color := clBlack;
        RNG.Interior.Color := $00E4E4E4;
        RNG.borderAround(1,2,color:= clBlack);
        rng.HorizontalAlignment := xlHAlignCenter;
        rng.VerticalAlignment := xlVAlignCenter;
        ws.cells[Head_Row+1, i+2].value := cap;
      end;
      rng := ws.range[ExcelColumnByIndex(i+2)+_s(Head_Row+2)];
      RNG.Borders.LineStyle := 1;
      RNG.Borders.Weight:= 2;
      RNG.Font.Color := clBlack;
      RNG.Interior.Color := $00B4B4B4;
      RNG.borderAround(1,2,color:= clBlack);
      ws.cells[Head_Row+2, i+2].value := i+2;
      rng.HorizontalAlignment := xlHAlignCenter;
      rng.VerticalAlignment := xlVAlignCenter;
    end;
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

    {
    for i:= 0 to geh.SelectedRows.Count-1 do
    begin
      qAset.Bookmark := geh.SelectedRows[i];
      row := Start_Data_Row+i;
      tipe := qAsettipe.AsString;
      if tipe = '1' then
      begin
        ws.cells[row, 2].value := qAsetno_urut.AsString;
        ws.cells[row, 3].value := qAsetnama.AsString;
      end
      else
      if tipe = '2' then
      begin
        ws.cells[row, 2].value := qAsetno_urut.AsString;
        ws.cells[row, 3].value := qAsetnama.AsString;
        ws.cells[row, 4].value := qAsettgl_p.AsString;
        ws.cells[row, 5].value := qAsetbln_p.AsString;
        ws.cells[row, 6].value := qAsetthn_p.AsString;
        ws.cells[row, 7].value := ''''+qAsetno_bukti.AsString;
        ws.cells[row, 8].value := qAsetmerek.AsString;
        ws.cells[row, 9].value := ''''+qAsetno_pabrikasi.AsString;
        ws.cells[row, 10].value := FloatToSQL(qAsetvolume.AsFloat);
        ws.cells[row, 11].value := qAsetsatuan.AsString;
        ws.cells[row, 12].value := FloatToSQL(qAsetnilai_satuan.AsFloat);
        ws.cells[row, 13].value := FloatToSQL(qAsetnilai_perolehan.AsFloat);
        ws.cells[row, 14].value := FloatToSQL(qAsetnilai_sisa.AsFloat);
        ws.cells[row, 15].value := FloatToSQL(qAsetumur_ekonomis.AsInteger);
        ws.cells[row, 16].value := FloatToSQL(qAsetsusut_per_bln.AsFloat);
        ws.cells[row, 17].value := FloatToSQL(qAsetpenyusutan_ke.AsInteger);
        ws.cells[row, 18].value := FloatToSQL(qAsetakum_penyusutan.AsFloat);
        ws.cells[row, 19].value := FloatToSQL(qAsetnilai_buku.AsFloat);
      end
      else
      if tipe = '3' then
      begin
        ws.cells[row, 3].value := qAsetnama.AsString;
        ws.cells[row, 13].value := FloatToSQL(qAsetnilai_perolehan.AsFloat);
        ws.cells[row, 14].value := FloatToSQL(qAsetnilai_sisa.AsFloat);
        ws.cells[row, 18].value := FloatToSQL(qAsetakum_penyusutan.AsFloat);
        ws.cells[row, 19].value := FloatToSQL(qAsetnilai_buku.AsFloat);
      end
      else
      if tipe = '3a' then
      begin

      end
      else
      if tipe = '4' then
      begin
        ws.cells[row, 3].value := qAsetnama.AsString;
        ws.cells[row, 13].value := FloatToSQL(qAsetnilai_perolehan.AsFloat);
        ws.cells[row, 14].value := FloatToSQL(qAsetnilai_sisa.AsFloat);
        ws.cells[row, 18].value := FloatToSQL(qAsetakum_penyusutan.AsFloat);
        ws.cells[row, 19].value := FloatToSQL(qAsetnilai_buku.AsFloat);
      end;
      RNG := ws.range['B'+_s(row)+':S'+_s(row)];
      RNG.Borders.LineStyle := 1;
      RNG.Borders.Weight:= 2;
      Application.ProcessMessages;
    end;
    End_Data_Row := row;
    Footer_Row := End_Data_Row;
    RNG := ws.range['B'+_s(Footer_Row)+':S'+_s(Footer_Row)];
    RNG.Borders.LineStyle := 1;
    RNG.Borders.Weight:= 2;
    RNG := ws.range['B'+_s(Head_Row)+':S'+_s(Footer_Row)];
    RNG.borderAround(1,2,color:= clBlack);
    // dibuat oleh
    RNG := ws.range['E'+_s(Footer_Row+2)+':F'+_s(Footer_Row+2)];
    RNG.merge;
    Rng.HorizontalAlignment := xlHAlignCenter;
    RNG.borderAround(1,2,color:= clBlack);
    ws.cells[Footer_Row+2,5].value := 'Dibuat Oleh';

    RNG := ws.range['E'+_s(Footer_Row+7)+':F'+_s(Footer_Row+7)];
    RNG.merge;
    Rng.HorizontalAlignment := xlHAlignCenter;
    ws.cells[Footer_Row+7,5].value := eBuat.Text;

    RNG := ws.range['E'+_s(Footer_Row+8)+':F'+_s(Footer_Row+8)];
    RNG.merge;
    Rng.HorizontalAlignment := xlHAlignCenter;
    ws.cells[Footer_Row+8,5].value := eBuat.HiddenText;

    RNG := ws.range['E'+_s(Footer_Row+7)+':F'+_s(Footer_Row+8)];
    RNG.borderAround(1,2,color:= clBlack);
    RNG := ws.range['E'+_s(Footer_Row+2)+':F'+_s(Footer_Row+8)];
    RNG.borderAround(1,2,color:= clBlack);
    // mengetahui
    RNG := ws.range['G'+_s(Footer_Row+2)+':I'+_s(Footer_Row+2)];
    RNG.merge;
    Rng.HorizontalAlignment := xlHAlignCenter;
    RNG.borderAround(1,2,color:= clBlack);
    ws.cells[Footer_Row+2,7].value := 'Mengetahui';

    RNG := ws.range['G'+_s(Footer_Row+7)+':I'+_s(Footer_Row+7)];
    RNG.merge;
    Rng.HorizontalAlignment := xlHAlignCenter;
    ws.cells[Footer_Row+7,7].value := eMengetahui.Text;
    Rng.HorizontalAlignment := xlHAlignCenter;

    RNG := ws.range['G'+_s(Footer_Row+8)+':I'+_s(Footer_Row+8)];
    RNG.merge;
    Rng.HorizontalAlignment := xlHAlignCenter;
    ws.cells[Footer_Row+8,7].value := eMengetahui.HiddenText;

    RNG := ws.range['G'+_s(Footer_Row+7)+':I'+_s(Footer_Row+8)];
    RNG.borderAround(1,2,color:= clBlack);
    RNG := ws.range['G'+_s(Footer_Row+2)+':I'+_s(Footer_Row+8)];
    RNG.borderAround(1,2,color:= clBlack);
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
  acRefresh.Execute;
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
  // AddMDIReport(TFrxReport(Sender), 'Kartu Muzaki');
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
            if field.s['k'][1] in ['4', 'T'] then
              ceh.Title.Caption := 'Penerimaan Dana|'+f.Name
            else
              ceh.Title.Caption := f.Name;
            if field.s['k'][1] <> '4' then
              ceh.Color := $00EAFCFF;
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
