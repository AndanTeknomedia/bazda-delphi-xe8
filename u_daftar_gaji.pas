unit u_daftar_gaji;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ToolWin, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  ExtCtrls, StdCtrls, DBGridEhGrouping, GridsEh, DBGridEh, DB, MemDS,
  DBAccess, Menus, ToolCtrlsEh,
  DBGridEhToolCtrls, DBAxisGridsEh, DynVarsEh, Uni, umain, u_utils,
  frxClass, frxDBSet, Grids, DBGrids, System.Actions, EhLibVCL, Vcl.DBCtrls,
  JvComponentBase, JvEnterTab, System.Win.ComObj, Vcl.OleServer, ExcelXP,
  u_dbgrideh_dac_helper;

type
  TFDaftarGaji = class(TForm)
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    acClose: TAction;
    acRefresh: TAction;
    frxReport1: TfrxReport;
    DataSource2: TDataSource;
    geh: TDBGridEh;
    DataSource3: TDataSource;
    JvEnterAsTab1: TJvEnterAsTab;
    qGaji: TUniQuery;
    PopupMenu2: TPopupMenu;
    N1: TMenuItem;
    MenuItem2: TMenuItem;
    Panel1: TPanel;
    Label10: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    cbBulan: TComboBox;
    cbTahun: TComboBox;
    acExcel: TAction;
    SaveDialog1: TSaveDialog;
    acPrintSlipGaji: TAction;
    PrintSlipGaji1: TMenuItem;
    qGajinama_lengkap: TStringField;
    qGajikode: TStringField;
    qGajinrp_pegawai: TStringField;
    qGajitahun: TIntegerField;
    qGajibulan: TIntegerField;
    qGajiuser_id: TLargeintField;
    qGajitanggal: TDateField;
    qGajijml_hadir: TIntegerField;
    qGajigaji_pokok: TFloatField;
    qGajitunj_jabatan: TFloatField;
    qGajitunj_makan_harian: TFloatField;
    qGajitunj_transportasi_harian: TFloatField;
    qGajitunj_lainnya: TFloatField;
    qGajilembur: TFloatField;
    qGajipot_pph21: TFloatField;
    qGajitotal_bpjs_kes: TFloatField;
    qGajitotal_bpjs_tk: TFloatField;
    qGajipot_bpjs_kes: TFloatField;
    qGajipot_bpjs_tk: TFloatField;
    qGajipot_zakat: TFloatField;
    qGajipot_lainnya: TFloatField;
    qGajitotal: TFloatField;
    qGajipembulatan: TFloatField;
    qGajibersih: TFloatField;
    qGajiuraian: TMemoField;
    qGajinpwp: TStringField;
    qGajiJumlahHariKerja: TIntegerField;
    qGajibpjs_dibayar_sendiri_kes: TFloatField;
    qGajibpjs_dibayar_sendiri_tk: TFloatField;
    qGajijabatan: TStringField;
    acJurnalGaji: TAction;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure acRefreshExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acCloseExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbBulanChange(Sender: TObject);
    procedure gehAdvDrawDataCell(Sender: TCustomDBGridEh; Cell,
      AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
      var Params: TColCellParamsEh; var Processed: Boolean);
    procedure gehKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure qGajiCalcFields(DataSet: TDataSet);
    procedure acExcelExecute(Sender: TObject);
    procedure acPrintSlipGajiExecute(Sender: TObject);
    procedure acJurnalGajiExecute(Sender: TObject);
  private
    { Private declarations }
    JmHrKerja: Integer;
    procedure ExportDaftarGaji;
    procedure ExportSlip;
  public
    { Public declarations }

  end;

var
  FDaftarGaji: TFDaftarGaji;
function ShowDaftarGaji(ATahun, ABulan: Integer): Boolean;

implementation

uses u_display_text, u_select_kode_name, u_frutils, u_select_master_detail,
  u_new_sb, u_hitung_thr, u_pembuat_dokumen, u_jurnal_gaji;

{$R *.dfm}

function ShowDaftarGaji(ATahun, ABulan: Integer): Boolean;
begin
  with TFDaftarGaji.Create(Application) do
  begin
    try
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TFDaftarGaji.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFDaftarGaji.acExcelExecute(Sender: TObject);
begin
  BeginProgress('Mengekspor Daftar Gaji...', exportDaftarGaji);
end;

procedure TFDaftarGaji.acJurnalGajiExecute(Sender: TObject);
begin
  InputJurnalGaji;
  // acRefresh.Execute;
end;

procedure TFDaftarGaji.acPrintSlipGajiExecute(Sender: TObject);
begin
  BeginProgress('Mengekspor Slip Gaji...', exportSlip);
end;

procedure TFDaftarGaji.acRefreshExecute(Sender: TObject);
var
  tgl1, tgl2: TDateTime;
  sql, prod, sprod, jhk: String;
begin
  jhk := GetOption(CurrentUser.KodeCabang+'jmlharikerja'+cbTahun.Text+_s(cbTahun.ItemIndex+1));
  if isNumbersOnly(jhk) then
    JmHrKerja := _i(jhk)
  else
    JmHrKerja := 22;
  qGaji.DisableControls;
  try
    if qGaji.Active then
      qGaji.Close;
    qGaji.ParamByName('thn').AsInteger := _i(cbTahun.Text);
    qGaji.ParamByName('bln').AsInteger := cbBulan.ItemIndex+1;
    qGaji.ParamByName('cab').AsString := CurrentUser.KodeCabang;
    qGaji.Open;
  finally
    qGaji.EnableControls;
  end;
end;

procedure TFDaftarGaji.cbBulanChange(Sender: TObject);

begin
  acRefresh.Execute;
end;

procedure TFDaftarGaji.ExportDaftarGaji;
var
  bm: TBookmark;
  f: TfrxReport;
  sql: String;
  //
  bukaExcel: Boolean;
  XL,
  WB,
  WS,
  RNG: OleVariant;
  no, i, row: Integer;
  Head_Row,
  Start_Data_Row,
  Footer_Row,
  End_Data_Row: integer;
  TTDs: TPembuatDokumenArray;
  NArr, VArr: TStringArr;
begin
  if qGaji.IsEmpty then
  begin
    EndProgress;
    exit;
  end;
  sql := CurrentUser.KodeCabang+'gaji-ttd-param';
  SetLength(ttds, 2);
  VArr := GetMultipleOptions([
    sql+'0fungsi', sql+'0nama', sql+'0jabatan',
    sql+'1fungsi', sql+'1nama', sql+'1jabatan'
  ]);
  // ShowMessage(Varr[1]+#13+Varr[4]);
  with ttds[0] do
  begin
    Clear;
    Fungsi := 'Mengetahui';
    Nama := Varr[1];
    Jabatan := varr[2];
  end;
  with ttds[1] do
  begin
    Clear;
    Fungsi := 'Diproses';
    Nama := Varr[4];
    Jabatan := varr[5];
  end;
  if not InputPembuatDokumen(ttds) then
  begin
    EndProgress;
    exit;
  end;

  SetMultipleOptions([
    sql+'0fungsi', sql+'0nama', sql+'0jabatan',
    sql+'1fungsi', sql+'1nama', sql+'1jabatan'
  ], [
    ttds[0].Fungsi, ttds[0].Nama, ttds[0].Jabatan,
    ttds[1].Fungsi, ttds[1].Nama, ttds[1].Jabatan
  ]);
  if not SaveDialog1.Execute(handle) then
    exit;
  bukaExcel := true;

  bm := qgaji.GetBookmark;
  qGaji.DisableControls;
  ScreenBussy;
  Application.ProcessMessages;
  self.Enabled := False;
  try
    CopyFile(Pchar(Fmain.ReportsDir() + '\xlspeggaji-lamp1.xlsx'),
      PChar(SaveDialog1.FileName), False);
    XL := createOleObject('Excel.Application');
    wb := XL.workbooks.open(SaveDialog1.FileName);
    ws := wb.WorkSheets[1];

    ws.cells[4, 3].value := cbBulan.Text+' '+cbTahun.Text;

    qGaji.First;
    Head_Row := 7;
    Start_Data_Row := 8;
    Footer_Row := 65535;
    End_Data_Row := 65534;
    row := Start_Data_Row;
    no := 1;
    while not qGaji.Eof do
    begin
      ws.cells[row,  2].value := IntToStr(no);
      ws.cells[row,  3].value := qGajinama_lengkap.AsString;
      ws.cells[row,  4].value := qGajijabatan.AsString;
      ws.cells[row,  5].value := FloatToSQL(qGajigaji_pokok.AsFloat);
      ws.cells[row,  6].value := FloatToSQL(qGajitunj_jabatan.AsFloat);
      ws.cells[row,  7].value := FloatToSQL(qGajitunj_makan_harian.AsFloat);
      ws.cells[row,  8].value := FloatToSQL(qGajitunj_transportasi_harian.AsFloat);
      ws.cells[row,  9].value := FloatToSQL(qGajitunj_lainnya.AsFloat);
      ws.cells[row, 10].value := FloatToSQL(qGajilembur.AsFloat);
      ws.cells[row, 11].value := FloatToSQL(qGajipot_pph21.AsFloat);
      ws.cells[row, 12].value := FloatToSQL(qGajipot_bpjs_tk.AsFloat);
      ws.cells[row, 13].value := FloatToSQL(qGajipot_bpjs_kes.AsFloat);
      ws.cells[row, 14].value := FloatToSQL(qGajipot_zakat.AsFloat);
      ws.cells[row, 15].value := FloatToSQL(qGajipot_lainnya.AsFloat);
      ws.cells[row, 16].value := FloatToSQL(qGajitotal.AsFloat);
      ws.cells[row, 17].value := FloatToSQL(qGajipembulatan.AsFloat);
      ws.cells[row, 18].value := FloatToSQL(qGajibersih.AsFloat);
      if no<qgaji.RecordCount then
      begin
        ws.Rows[row+1].Insert;
        Inc(row);
        inc(no);
      end;
      qGaji.Next;
      Application.ProcessMessages;
    end;
    // decorate:
    End_Data_Row := row;
    Footer_Row := row+1;
    {for no  := Start_Data_Row to End_Data_Row do
    begin
      RNG := ws.range['B'+_s(no)+':R'+_s(no)];
      RNG.Borders.LineStyle := 1;
      RNG.Borders.Weight:= 2;
      Application.ProcessMessages;
    end;
    RNG := ws.range['B'+_s(Footer_Row)+':R'+_s(Footer_Row)];
    RNG.Borders.LineStyle := 1;
    RNG.Borders.Weight:= 2;
    RNG := ws.range['B'+_s(7)+':R'+_s(Footer_Row)];
    RNG.borderAround(1,2,color:= clBlack);
    // RNG.Borders.Weight := 3;
    }


    ws.cells[Footer_Row,  3].value := 'Total:';
    ws.cells[Footer_Row,  4].formula := '='+format(xlCount_Formula, ['D', Start_Data_Row, 'D', End_Data_Row]);
    ws.cells[Footer_Row,  5].formula := '='+format(xlTotal_Formula, ['E', Start_Data_Row, 'E', End_Data_Row]);
    ws.cells[Footer_Row,  6].formula := '='+format(xlTotal_Formula, ['F', Start_Data_Row, 'F', End_Data_Row]);
    ws.cells[Footer_Row,  7].formula := '='+format(xlTotal_Formula, ['G', Start_Data_Row, 'G', End_Data_Row]);
    ws.cells[Footer_Row,  8].formula := '='+format(xlTotal_Formula, ['H', Start_Data_Row, 'H', End_Data_Row]);
    ws.cells[Footer_Row,  9].formula := '='+format(xlTotal_Formula, ['I', Start_Data_Row, 'I', End_Data_Row]);
    ws.cells[Footer_Row, 10].formula := '='+format(xlTotal_Formula, ['J', Start_Data_Row, 'J', End_Data_Row]);
    ws.cells[Footer_Row, 11].formula := '='+format(xlTotal_Formula, ['K', Start_Data_Row, 'K', End_Data_Row]);
    ws.cells[Footer_Row, 12].formula := '='+format(xlTotal_Formula, ['L', Start_Data_Row, 'L', End_Data_Row]);
    ws.cells[Footer_Row, 13].formula := '='+format(xlTotal_Formula, ['M', Start_Data_Row, 'M', End_Data_Row]);
    ws.cells[Footer_Row, 14].formula := '='+format(xlTotal_Formula, ['N', Start_Data_Row, 'N', End_Data_Row]);
    ws.cells[Footer_Row, 15].formula := '='+format(xlTotal_Formula, ['O', Start_Data_Row, 'O', End_Data_Row]);
    ws.cells[Footer_Row, 16].formula := '='+format(xlTotal_Formula, ['P', Start_Data_Row, 'P', End_Data_Row]);
    ws.cells[Footer_Row, 17].formula := '='+format(xlTotal_Formula, ['Q', Start_Data_Row, 'Q', End_Data_Row]);
    ws.cells[Footer_Row, 18].formula := '='+format(xlTotal_Formula, ['R', Start_Data_Row, 'R', End_Data_Row]);

    ws.cells[Footer_Row+2,3].value := TTDs[0].Fungsi;
    ws.cells[Footer_Row+6,3].value := TTDs[0].Nama;
    ws.cells[Footer_Row+7,3].value := TTDs[0].Jabatan;

    ws.cells[Footer_Row+2,5].value := TTDs[1].Fungsi;
    ws.cells[Footer_Row+6,5].value := TTDs[1].Nama;
    ws.cells[Footer_Row+7,5].value := TTDs[1].Jabatan;

    wb.save;
    xl.visible := bukaExcel;
  finally
    if qGaji.BookmarkValid(bm) then
      qGaji.Bookmark := bm;
    qGaji.EnableControls;
    ScreenIdle;
    Application.ProcessMessages;
    self.Enabled := True;
  end;
  EndProgress;
end;

procedure TFDaftarGaji.ExportSlip;
var
  bm: TBookmark;
  f: TfrxReport;
  sql: String;
  //
  bukaExcel: Boolean;
  XL,
  WB,
  WS,
  RNGSrc, RngTo: OleVariant;
  no, i, row: Integer;
  Head_Row,
  Start_Data_Row,
  Footer_Row,
  pageStart,
  End_Data_Row: integer;
  TTDs: TPembuatDokumenArray;
  NArr, VArr: TStringArr;
  RowHeights: array of single;
  Pembulatan: Boolean;
begin
  if qGaji.IsEmpty then
  begin
    EndProgress;
    exit;
  end;
  sql := CurrentUser.KodeCabang+'gaji-slip-ttd-param';
  SetLength(ttds, 1);
  VArr := GetMultipleOptions([
    sql+'0fungsi', sql+'0nama', sql+'0jabatan'
  ]);
  with ttds[0] do
  begin
    Clear;
    Fungsi := 'Manager';
    Nama := Varr[1];
    Jabatan := varr[2];
  end;
  if not InputPembuatDokumen(ttds) then
  begin
    EndProgress;
    exit;
  end;
  Pembulatan := Ask('Hitung dengan pembulatan gaji?',0,'Ya','Jangan') = mrNone;
  SetMultipleOptions([
    sql+'0fungsi', sql+'0nama', sql+'0jabatan'
  ], [
    ttds[0].Fungsi, ttds[0].Nama, ttds[0].Jabatan
  ]);
  if not SaveDialog1.Execute(handle) then
  begin
    EndProgress;
    exit;
  end;
  bukaExcel := true;

  Inform('Harap tunggu sampai selesai...');

  bm := qgaji.GetBookmark;
  qGaji.DisableControls;
  ScreenBussy;
  Application.ProcessMessages;
  self.Enabled := False;
  try
    CopyFile(Pchar(Fmain.ReportsDir() + '\xlspeggaji-slip.xlsx'),
      PChar(SaveDialog1.FileName), False);
    XL := createOleObject('Excel.Application');
    wb := XL.workbooks.open(SaveDialog1.FileName);
    ws := wb.WorkSheets[1];
    SetLength(RowHeights, 33);
    for i := 1 to 33 do
      RowHeights[i-1] := ws.Rows[i].RowHeight;
    qGaji.First;
    pageStart := 1;
    no := 1;
    while not qGaji.Eof do
    begin
      // page break setiap 2 record:
      if no > 1 then
      begin
        // RNGSrc := ws.range['B'+_s(pageStart)+':I'+_s(pageStart+32)];
        ws.range['A'+_s(pageStart)+':I'+_s(pageStart+32)].copy(
          ws.range['A'+_s(pageStart+33)+':I'+_s(pageStart+32+33)]
        );

        inc(pageStart, 33);
        // RngTo  := ws.range['B'+_s(pageStart)+':I'+_s(pageStart+32)];
        // ws.range('B'+_s(pageStart)+':I'+_s(pageStart+32)).select;
        // xl.selection.PasteSpecial(xlPasteAll);
        // xl.Application.CutCopyMode := False;
        // copy and paste the template:
        // RNGSrc.copy(RngTo);

        for i := pageStart to pageStart+33 do
          WS.rows[i].rowHeight := RowHeights[i-pageStart];


        {
        ws.range['B'+_s(pageStart)+':I'+_s(pageStart+68)].copy(
          ws.range['B'+_s(pageStart-68-68)+':I'+_s(pageStart-68)]
        );
        }
      end;
      ws.cells[pageStart+6,  4].value := DateIndo(Date);
      ws.cells[pageStart+7,  4].value := qGajinama_lengkap.AsString;
      ws.cells[pageStart+8,  4].value := qGajijabatan.AsString;
      ws.cells[pageStart+9,  4].value := cbBulan.Text+' '+cbTahun.Text;
      ws.cells[pageStart+11,  6].value := FloatToSQL(qGajigaji_pokok.AsFloat);
      ws.cells[pageStart+12,  6].value := FloatToSQL(qGajitunj_jabatan.AsFloat);
      ws.cells[pageStart+13,  6].value := FloatToSQL(qGajitunj_transportasi_harian.AsFloat);
      ws.cells[pageStart+14,  6].value := FloatToSQL(qGajitunj_makan_harian.AsFloat);
      ws.cells[pageStart+15,  6].value := FloatToSQL(qGajitunj_lainnya.AsFloat);
      ws.cells[pageStart+16,  6].value := FloatToSQL(qGajilembur.AsFloat);

      ws.cells[pageStart+17,  6].value := FloatToSQL(-1*qGajipot_pph21.AsFloat);
      ws.cells[pageStart+18,  6].value := FloatToSQL(-1*qGajipot_bpjs_tk.AsFloat);
      ws.cells[pageStart+19,  6].value := FloatToSQL(-1*qGajipot_bpjs_kes.AsFloat);
      ws.cells[pageStart+20,  6].value := FloatToSQL(-1*qGajipot_zakat.AsFloat);
      ws.cells[pageStart+21,  6].value := FloatToSQL(-1*qGajipot_lainnya.AsFloat);

      ws.cells[pageStart+22,  6].value := FloatToSQL(qGajitotal.AsFloat);
      if Pembulatan then
      begin
        ws.cells[pageStart+23,  6].value := FloatToSQL(qGajipembulatan.AsFloat);
        ws.cells[pageStart+24,  6].value := FloatToSQL(qGajibersih.AsFloat);
      end
      else
      begin
        ws.cells[pageStart+23,  6].value := FloatToSQL(0);
        ws.cells[pageStart+24,  6].value := FloatToSQL(qGajitotal.AsFloat);
      end;

      ws.cells[pageStart+27,  2].value := TTDs[0].Fungsi;
      ws.cells[pageStart+30,  2].value := TTDs[0].Nama;
      ws.cells[pageStart+31,  2].value := TTDs[0].Jabatan;
      ws.cells[pageStart+30,  7].value := qGajinama_lengkap.AsString;

      inc(no);
      qGaji.Next;
      Application.ProcessMessages;
    end;
    wb.save;
    // RNGSrc := Unassigned;
    // RngTo := Unassigned;
    {
    WS := Unassigned;
    WB := Unassigned;
    }
    FMain.EndStatus;
    xl.visible := bukaExcel;
    Inform('Selesai...');
    ScreenIdle;
    // XL := Unassigned;
  finally
    if qGaji.BookmarkValid(bm) then
      qGaji.Bookmark := bm;
    qGaji.EnableControls;
    self.Enabled := True;
    Application.ProcessMessages;
  end;
  EndProgress;
end;

procedure TFDaftarGaji.gehAdvDrawDataCell(Sender: TCustomDBGridEh; Cell,
  AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
  var Params: TColCellParamsEh; var Processed: Boolean);
var
  Dataset: TDataset;
  kode: string;
  kol: String;
  tipe: integer;
begin

end;

procedure TFDaftarGaji.gehKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if chr(key) in ['a'..'z','A'..'Z','0'..'9'] then
  begin
    SendCtrlF;
  end
  else
  ;
end;

procedure TFDaftarGaji.qGajiCalcFields(DataSet: TDataSet);

begin
  with DataSet do
  begin
    FieldByName('JumlahHariKerja').AsInteger := JmHrKerja;
    FieldByName('bpjs_dibayar_sendiri_kes').AsFloat := FieldByName('total_bpjs_kes').AsFloat - FieldByName('pot_bpjs_kes').AsFloat;
    FieldByName('bpjs_dibayar_sendiri_tk').AsFloat := FieldByName('total_bpjs_tk').AsFloat - FieldByName('pot_bpjs_tk').AsFloat;
  end;


end;

procedure TFDaftarGaji.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TFDaftarGaji.FormCreate(Sender: TObject);
var
  i: integer;
  sl: TStringList;
begin
  JmHrKerja := 0;
  cbTahun.Clear;
  for i := 2000 to CurrentYear+5 do
    cbTahun.items.Add(IntToStr(i));
  cbTahun.ItemIndex := cbTahun.Items.IndexOf(IntToStr(CurrentYear));

  cbBulan.Clear;
  for i := 1 to 12 do
    cbBulan.Items.Add(FormatSettings.LongMonthNames[i]);
  cbBulan.ItemIndex := Bulan(Date())-1;
  acRefresh.Execute;
end;

procedure TFDaftarGaji.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key <> VK_F3 then
    exit;
  key := 0;
  SendCtrlF;
end;

end.
