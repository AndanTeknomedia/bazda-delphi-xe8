unit u_daftar_jurnal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ToolWin, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  ExtCtrls, StdCtrls, DBGridEhGrouping, GridsEh, DBGridEh, DB, MemDS,
  DBAccess, Menus, ToolCtrlsEh,
  DBGridEhToolCtrls, DBAxisGridsEh, DynVarsEh, Uni, umain, u_utils,
  frxClass, frxDBSet, Grids, DBGrids, System.Actions, EhLibVCL,
  u_dbgrideh_dac_helper;

type
  TFDaftarJurnal = class(TForm)
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    acClose: TAction;
    acRefresh: TAction;
    acPrint: TAction;
    QKas: TUniQuery;
    DataSource1: TDataSource;
    Panel1: TPanel;
    cbBulan: TComboBox;
    Label10: TLabel;
    frxDBDSQJ: TfrxDBDataset;
    cbTahun: TComboBox;
    DBGridEh1: TDBGridEh;
    qj: TUniQuery;
    qd: TUniQuery;
    qk: TUniQuery;
    qjid: TLargeintField;
    qjkode: TStringField;
    qjjenis_jurnal: TStringField;
    qjbranch_kode: TStringField;
    qjtahun: TIntegerField;
    qjuser_id: TLargeintField;
    qjref_table: TStringField;
    qjref_kode: TStringField;
    qjtanggal: TDateTimeField;
    qjno_bukti: TStringField;
    qjuraian: TMemoField;
    qjchecked: TStringField;
    qjapproved: TStringField;
    qdkode: TStringField;
    qdref_jurnal: TStringField;
    qdskode: TIntegerField;
    qdkode_rek: TStringField;
    qddebet: TFloatField;
    qdkredit: TFloatField;
    qduraian: TMemoField;
    qdref_table: TStringField;
    qdref_kode: TStringField;
    qkkode: TStringField;
    qkref_jurnal: TStringField;
    qkskode: TIntegerField;
    qkkode_rek: TStringField;
    qkdebet: TFloatField;
    qkkredit: TFloatField;
    qkuraian: TMemoField;
    qkref_table: TStringField;
    qkref_kode: TStringField;
    frxDBDSQD: TfrxDBDataset;
    frxDBDSQK: TfrxDBDataset;
    qdrek: TStringField;
    qkrek: TStringField;
    DataSource2: TDataSource;
    qjtgl: TStringField;
    QKaskode: TStringField;
    QKasjenis_jurnal: TStringField;
    QKasbranch_kode: TStringField;
    QKasuser_id: TLargeintField;
    QKastanggal: TDateTimeField;
    QKasno_bukti: TStringField;
    QKasuraian: TMemoField;
    QKaschecked: TStringField;
    QKasapproved: TStringField;
    QKastotal_trx: TFloatField;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Memo1: TMemo;
    PopupMenu1: TPopupMenu;
    SelectAll1: TMenuItem;
    DeselectAll1: TMenuItem;
    reporter: TfrxReport;
    Button1: TButton;
    Detail1: TMenuItem;
    N1: TMenuItem;
    acDetJurnal: TAction;
    acCekApprove: TAction;
    Approve1: TMenuItem;
    acDel: TAction;
    HapusJurnal1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure acRefreshExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acCloseExecute(Sender: TObject);
    procedure gerekKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure gerekAdvDrawDataCell(Sender: TCustomDBGridEh; Cell,
      AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
      var Params: TColCellParamsEh; var Processed: Boolean);
    procedure cbBulanChange(Sender: TObject);
    procedure acPrintExecute(Sender: TObject);
    procedure qjCalcFields(DataSet: TDataSet);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
    procedure DeselectAll1Click(Sender: TObject);
    procedure reporterPreview(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure acDetJurnalExecute(Sender: TObject);
    procedure acCekApproveExecute(Sender: TObject);
    procedure acDelExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FDaftarJurnal: TFDaftarJurnal;

implementation

uses u_display_text, u_select_kode_name, u_frutils, u_select_master_detail,
  u_jurnal, u_pilih_opsi, u_login_otf;

{$R *.dfm}

procedure TFDaftarJurnal.acCekApproveExecute(Sender: TObject);
var
  sl: TStringList;
  c,
  a,
  AksesCheck,
  AksesApprove: Boolean;
  kd: String;
begin
  AksesCheck :=  AccessibleBy(CurrentUser, 'check_jurnal');
  AksesApprove :=  AccessibleBy(CurrentUser, 'approve_jurnal');
  if not (AksesCheck or AksesApprove) then
  begin
    Inform('Anda perlu salah satu hak akses berikut: '#13'* Check/Verifikasi Jurnal'#13'* Approve Jurnal');
    exit;
  end;
  if QKas.IsEmpty then
  begin
    Inform('Tidak ada data.');
    exit;
  end;

  if DBGridEh1.SelectedRows.Count <> 0 then
  begin
    Inform('Tidak perlu mencentang jurnal untuk dilihat detailnya:'#13'HAPUS CENTANG.');
    exit;
  end;
  c := QKaschecked.AsString = 'Y';
  a := QKasapproved.AsString = 'Y';
  sl := TStringList.Create;
  try
    if AksesApprove then
    begin
      sl.Add('Check='+boolToStr(c, true));
      sl.Add('Approve='+boolToStr(a, true));
    end
    else
    if AksesCheck then
    begin
      sl.Add('Check='+boolToStr(c, true));
    end
    ;
    if PilihDataAsNameBooleanPairs('Status Verifikasi Penjaminan', sl) then
    begin
      sl.Text := _u(sl.Text);
      kd := QKaskode.AsString;
      c := sl.IndexOf(_u('Check=True'))<>-1;
      a := sl.IndexOf(_u('Approve=True'))<>-1;
      sl.Text := 'update acc_jurnal_u set '+
        'checked = '+_q(_iif(c, 'Y', 'N'))+', '+
        'approved = '+_q(_iif(a, 'Y', 'N'))+
        ' where kode  = '+_q(kd);
      try
        ExecSQL(sl.Text).Free;
        acRefresh.Execute;
        QKas.Locate('kode', kd, []);
      except
        Warn('Gagal mengupdate jurnal...');
      end;
    end;
  finally
    sl.Free;
  end;
end;

procedure TFDaftarJurnal.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFDaftarJurnal.acDelExecute(Sender: TObject);
var
  AksesDel,
  AksesApprove: Boolean;
  bm: TBookmark;
  i,j : integer;
  kode: String;
begin
  AksesDel :=  AccessibleBy(CurrentUser, 'Menghapus Jurnal');
  if not AksesDel then
  begin
    Inform('Anda perlu hak akses berikut: '#13'* Menghapus Jurnal');
    exit;
  end;

  if QKas.IsEmpty then
  begin
    Inform('Tidak ada data.');
    exit;
  end;

  if DBGridEh1.SelectedRows.Count = 0 then
  begin
    Inform('CENTANG jurnal yang akan dihapus.');
    exit;
  end;
  AksesApprove := true;
  if QKasapproved.AsString = 'Y' then
  begin
    AksesApprove := LoginOTF('Jurnal telah diapprove.'#13'Anda perlu login admin:');
  end;
  if not AksesApprove then
  begin
    exit;
  end;
  if Ask('Anda akan menghapus jurnal yang dicentang.'#13'LANJUTKAN?') = mrYes then
  begin
    bm := QKas.GetBookmark;
    QKas.DisableControls;
    j := 0;
    try
      for i := 0 to DBGridEh1.SelectedRows.Count-1 do
      begin
        QKas.Bookmark := DBGridEh1.SelectedRows[i];
        kode := QKaskode.AsString;
        ExecSQL('delete from acc_jurnal_u where kode = '+_q(kode)).free;
      end;
    finally
      DBGridEh1.SelectedRows.Clear;
      QKas.EnableControls;
      acRefresh.Execute;
    end;
  end;
end;

procedure TFDaftarJurnal.acDetJurnalExecute(Sender: TObject);
var
  AksesCheck,
  AksesApprove: Boolean;
begin
  AksesCheck :=  AccessibleBy(CurrentUser, 'check_jurnal');
  AksesApprove :=  AccessibleBy(CurrentUser, 'approve_jurnal');
  if not (AksesCheck or AksesApprove) then
  begin
    Inform('Anda perlu salah satu hak akses berikut: '#13'* Check/Verifikasi Jurnal'#13'* Approve Jurnal');
    exit;
  end;
  if QKas.IsEmpty then
  begin
    Inform('Tidak ada data.');
    exit;
  end;

  if DBGridEh1.SelectedRows.Count <> 0 then
  begin
    Inform('Tidak perlu mencentang jurnal untuk dilihat detailnya:'#13'HAPUS CENTANG.');
    exit;
  end;
  SHowJurnal(QKaskode.AsString);
end;

procedure TFDaftarJurnal.acPrintExecute(Sender: TObject);
var
  rpt: String;
  bm: TBookmark;
  i, j: integer;
  wherecode: String;
  jmlD, jmlK: Double;
begin
  if QKas.IsEmpty then
  begin
    Inform('Tidak ada data untuk diprint.');
    exit;
  end;

  if DBGridEh1.SelectedRows.Count = 0 then
  begin
    if QKasjenis_jurnal.AsString.ToUpper = 'PYRL' then
    begin
      rpt := FMain.ReportsDir+'\pjss_gl_2.fr3';
      Inform('Masukkan kertas A4, kertas A5/Continuous Form tidak akan cukup.'#13+
        'Tekan OK jika kertas A4 telah siap...'
      );
    end
    else
      rpt := FMain.ReportsDir+'\pjss_gl_1.fr3';
    // Inform(rpt);
    if not FileExists(rpt) then
    begin
      Warn('File laporan "'+rpt+'" tidak ditemukan!');
      exit;
    end;
    if qj.Active then
      qj.Close;
    if qd.Active then
      qd.Close;
    if qk.Active then
      qk.Close;
    bm := QKas.GetBookmark;
    wherecode  :=  QKaskode.AsString;
    QKas.DisableControls;
    try
      qj.SQL.Text := 'select * from acc_jurnal_u where kode = '+_q(wherecode);
      qd.SQL.Text := 'select m.*, (d.rekening)::varchar(200) rek from acc_jurnal_u_detail m inner join v_coa_2 d on m.kode_rek = d.kode where m.ref_jurnal  = '+_q(wherecode)+' and (debet<>0) and (kredit=0) order by kode_rek asc';
      qk.SQL.Text := 'select m.*, (d.rekening)::varchar(200) rek from acc_jurnal_u_detail m inner join v_coa_2 d on m.kode_rek = d.kode where m.ref_jurnal  = '+_q(wherecode)+' and (debet=0) and (kredit<>0) order by kode_rek asc';
      qj.Open;
      qd.Open;
      qk.Open;
      if QKasjenis_jurnal.AsString.ToUpper = 'PYRL' then
      begin
        jmlD := ExecSQLAndFetchOneValueAsFloat(
          'select sum(coalesce(m.debet,0)) from acc_jurnal_u_detail m where m.ref_jurnal  = '+_q(wherecode)+' and (debet<>0) and (kredit=0)'
        );
        jmlK := ExecSQLAndFetchOneValueAsFloat(
          'select sum(coalesce(m.kredit,0)) from acc_jurnal_u_detail m where m.ref_jurnal  = '+_q(wherecode)+' and (debet=0) and (kredit<>0)'
        );
      end;
      reporter.Clear;
      reporter.LoadFromFile(rpt);
      if QKasjenis_jurnal.AsString.ToUpper = 'PYRL' then
      begin
        FRMemo(reporter, 'mjmlDebet') .Text := FloatToFinance(jmlD)+'   ';
        FRMemo(reporter, 'mjmlKredit').Text := FloatToFinance(jmlK)+'   ';
      end;
      //
      reporter.PrepareReport();
      reporter.ShowReport();
    finally
      if QKas.BookmarkValid(bm) then
        QKas.GotoBookmark(bm);
      QKas.EnableControls;
    end;
  end
  else
  begin
    if Ask('Anda memilih banyak data sekaligus (BATCH PRINT).'#13+
      'Jika terlalu banyak data, bisa mengganggu kinerja komputer.'#13#13+
      'JURNAL GAJI HARUS TIDAK AKAN DIPRINT SECARA BATCH, HARUS DIPRINT TERSENDIRI'#13#13+
      'Lanjutkan?'
    ) = mrYes then
    begin
      rpt := FMain.ReportsDir+'\pjss_gl_1.fr3';
      // Inform(rpt);
      if not FileExists(rpt) then
      begin
        Warn('File laporan "'+rpt+'" tidak ditemukan!');
        exit;
      end;
      qk.DisableControls;
      qj.DisableControls;
      qk.DisableControls;
      bm := QKas.GetBookmark;
      QKas.DisableControls;
      j := 0;
      try
        for i := 0 to DBGridEh1.SelectedRows.Count-1 do
        begin
          QKas.Bookmark := DBGridEh1.SelectedRows[i];
          if QKasjenis_jurnal.AsString.ToUpper <> 'PYRL' then
          begin
            inc(j);
            if qj.Active then
              qj.Close;
            if qd.Active then
              qd.Close;
            if qk.Active then
              qk.Close;
            wherecode  :=  QKaskode.AsString;
            try
              qj.SQL.Text := 'select * from acc_jurnal_u where kode = '+_q(wherecode);
              qd.SQL.Text := 'select m.*, (d.rekening)::varchar(200) rek from acc_jurnal_u_detail m inner join v_coa_2 d on m.kode_rek = d.kode where m.ref_jurnal  = '+_q(wherecode)+' and (debet<>0) and (kredit=0) order by kode_rek asc';
              qk.SQL.Text := 'select m.*, (d.rekening)::varchar(200) rek from acc_jurnal_u_detail m inner join v_coa_2 d on m.kode_rek = d.kode where m.ref_jurnal  = '+_q(wherecode)+' and (debet=0) and (kredit<>0) order by kode_rek asc';
              qj.Open;
              qd.Open;
              qk.Open;
              reporter.LoadFromFile(rpt);
              reporter.PrepareReport(i=0);
              // FMain.reporter.ShowReport();
              // FMain.reporter.Print;
            finally

            end;
          end;
        end;
      finally
        if j>0 then
          reporter.ShowPreparedReport;
        DBGridEh1.SelectedRows.Clear;
        qk.EnableControls;
        qj.EnableControls;
        qk.EnableControls;
        if QKas.BookmarkValid(bm) then
          QKas.GotoBookmark(bm);
        QKas.EnableControls;
      end;
    end;
  end;
end;

procedure TFDaftarJurnal.acRefreshExecute(Sender: TObject);
var
  tgl1, tgl2: TDateTime;
  sql: String;
begin
  QKas.DisableControls;
  if QKas.Active then
    QKas.Close;
  SetOption(CurrentUser.KodeCabang+'-'+Self.Name+'defbulan', _s(cbBulan.ItemIndex));
  SetOption(CurrentUser.KodeCabang+'-'+Self.Name+'deftahun', _s(cbTahun.ItemIndex));
  if cbBulan.Text = 'Semuanya' then
  begin
    tgl1 := AwalBulan(EncodeDate(_i(cbTahun.Items[cbTahun.ItemIndex]), 1, 1));
    tgl2 := AkhirTahun(tgl1);

  end
  else
  begin
    tgl1 := AwalBulan(EncodeDate(_i(cbTahun.Items[cbTahun.ItemIndex]), cbBulan.ItemIndex+1, 1));
    tgl2 := AkhirBulan(tgl1);
  end;

  sql := Memo1.Text;
  if CheckBox1.Checked then
    sql := StringReplace(sql,'(1=1)', '(j.checked=''Y'')', [rfIgnoreCase, rfReplaceAll]);
  if CheckBox2.Checked then
    sql := StringReplace(sql,'(2=2)', '(j.approved=''Y'')', [rfIgnoreCase, rfReplaceAll]);
  QKas.SQL.Text := sql;

  ScreenBussy;
  try
    QKas.ParamByName('cabang').AsString := CurrentUser.KodeCabang;
    QKas.ParamByName('tgl1').AsDateTime := tgl1;
    QKas.ParamByName('tgl2').AsDateTime:= tgl2;
    QKas.Open;        
  finally
    QKas.EnableControls;
    ScreenIdle;
  end;
end;

procedure TFDaftarJurnal.Button1Click(Sender: TObject);
begin
  FMain.JurnalUmum1.Click;
end;

procedure TFDaftarJurnal.cbBulanChange(Sender: TObject);
begin
  acRefresh.Execute;
end;

procedure TFDaftarJurnal.CheckBox1Click(Sender: TObject);
begin
  acRefresh.Execute;
end;

procedure TFDaftarJurnal.CheckBox2Click(Sender: TObject);
begin
  acRefresh.Execute;
end;

procedure TFDaftarJurnal.DeselectAll1Click(Sender: TObject);
begin
  DBGridEh1.SelectedRows.Clear;
end;

procedure TFDaftarJurnal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TFDaftarJurnal.FormCreate(Sender: TObject);
var
  i: integer;
begin
  cbBulan.Clear;
  for i := 1 to 12 do
    cbBulan.Items.Add(FormatSettings.LongMonthNames[i]);
  cbBulan.Items.Add('Semuanya');
  for i := 2000 to CurrentYear+5 do
    cbTahun.items.Add(IntToStr(i));
  cbBulan.ItemIndex := _i(GetOption(CurrentUser.KodeCabang+'-'+Self.Name+'defbulan'), Bulan(Date()) - 1);
  i := _i(GetOption(CurrentUser.KodeCabang+'-'+Self.Name+'deftahun'), cbTahun.Items.IndexOf(IntToStr(CurrentYear)));
  // Inform(_s(i));
  cbTahun.ItemIndex := i;
  acRefresh.Execute;
end;

procedure TFDaftarJurnal.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key <> VK_F3 then
    exit;
  key := 0;
  SendCtrlF;
end;

procedure TFDaftarJurnal.gerekAdvDrawDataCell(Sender: TCustomDBGridEh; Cell,
  AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
  var Params: TColCellParamsEh; var Processed: Boolean);
var
  Dataset: TDataset;
  c, a: string;
begin
  Dataset := sender.DataSource.DataSet;
  c := Dataset.FieldByName('checked').AsString+Dataset.FieldByName('approved').AsString;
  if c = 'YY' then
    Params.Background := $00E0FFC1
  else
  if c = 'YN' then
    Params.Background := $00B9FFFF
  else
  if c = 'NY' then
    Params.Background := $00D5D5FF;
end;

procedure TFDaftarJurnal.gerekKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if chr(key) in ['a'..'z','A'..'Z','0'..'9'] then
  begin
    SendCtrlF;
  end
  else
  if Key = VK_UP then
  begin
    if QKas.Bof then
      SendCtrlF;
  end
  else
  if Key = VK_Down then
  begin
    if QKas.Eof then
      SendCtrlF;
  end;
end;

procedure TFDaftarJurnal.qjCalcFields(DataSet: TDataSet);
begin
  Dataset.FieldByName('tgl').AsString := DateIndo(Dataset.FieldByName('tanggal').AsDateTime);
end;

procedure TFDaftarJurnal.reporterPreview(Sender: TObject);
begin
  AddMDIReport(TFrxReport(Sender), 'Report - GL');
end;

procedure TFDaftarJurnal.SelectAll1Click(Sender: TObject);
begin
  DBGridEh1.SelectedRows.SelectAll;
end;

end.
