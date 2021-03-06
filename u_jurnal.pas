unit u_jurnal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ToolWin, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  ExtCtrls, StdCtrls, DBGridEhGrouping, GridsEh, DBGridEh, DB, MemDS,
  DBAccess, Menus, ToolCtrlsEh,
  DBGridEhToolCtrls, DBAxisGridsEh, DynVarsEh, Uni, u_utils, u_dbgrideh_dac_helper,
  DBCtrls, MemTableDataEh, MemTableEh, frxClass, frxPreview, Mask, JvExMask,
  JvToolEdit, JvBaseEdits, ComCtrls, JvExControls, JvEnterTab, VirtualTable,
  Grids, DBGrids, frxDBSet, System.Actions, EhLibVCL;

type
  TFJurnal = class(TForm)
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    acClose: TAction;
    dsAdd: TDataSource;
    Panel7: TPanel;
    geRek: TDBGridEh;
    PopupMenu1: TPopupMenu;
    Add1: TMenuItem;
    Edit3: TMenuItem;
    N1: TMenuItem;
    Hapus1: TMenuItem;
    HapusSemua1: TMenuItem;
    acNew: TAction;
    acSave: TAction;
    Panel1: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label8: TLabel;
    eTanggal: TDateTimePicker;
    eBukti: TEdit;
    Panel2: TPanel;
    Bevel2: TBevel;
    Button3: TButton;
    Button4: TButton;
    vtAdd: TVirtualTable;
    vtAddkode: TStringField;
    vtAddfkode: TStringField;
    vtAdduraian: TStringField;
    vtAdddebet: TFloatField;
    vtAddkredit: TFloatField;
    eUraian: TMemo;
    QDet: TUniQuery;
    Panel3: TPanel;
    QDetkode: TStringField;
    QDetref_jurnal: TStringField;
    QDetskode: TIntegerField;
    QDetkode_rek: TStringField;
    QDetdebet: TFloatField;
    QDetkredit: TFloatField;
    QDeturaian: TMemoField;
    QDetref_table: TStringField;
    QDetref_kode: TStringField;
    QJ: TUniQuery;
    QD: TUniQuery;
    QJid: TLargeintField;
    QJkode: TStringField;
    QJjenis_jurnal: TStringField;
    QJbranch_kode: TStringField;
    QJtahun: TIntegerField;
    QJuser_id: TLargeintField;
    QJref_table: TStringField;
    QJref_kode: TStringField;
    QJtanggal: TDateTimeField;
    QJno_bukti: TStringField;
    QJuraian: TMemoField;
    QJchecked: TStringField;
    QJapproved: TStringField;
    QDkode: TStringField;
    QDref_jurnal: TStringField;
    QDskode: TIntegerField;
    QDkode_rek: TStringField;
    QDdebet: TFloatField;
    QDkredit: TFloatField;
    QDuraian: TMemoField;
    QDref_table: TStringField;
    QDref_kode: TStringField;
    vtAddid: TStringField;
    ckApprove: TCheckBox;
    ckCek: TCheckBox;
    ckAutoClose: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acCloseExecute(Sender: TObject);
    procedure Hapus1Click(Sender: TObject);
    procedure HapusSemua1Click(Sender: TObject);
    procedure Edit3Click(Sender: TObject);
    procedure Add1Click(Sender: TObject);
    procedure acNewExecute(Sender: TObject);
    procedure acSaveExecute(Sender: TObject);
    procedure vtAddAfterPost(DataSet: TDataSet);
    procedure geRekColumns1EditButtons0Click(Sender: TObject;
      var Handled: Boolean);
    procedure ckAutoCloseClick(Sender: TObject);
  private
    { Private declarations }
    EditMode: Boolean;
  public
    { Public declarations }
  end;

var
  FJurnal: TFJurnal;

// return true if edited:
function SHowJurnal(KodeJurnal: String): boolean;

implementation

uses u_display_text, u_select_master_detail, umain, u_login_otf;

{$R *.dfm}

function SHowJurnal(KodeJurnal: String): boolean;
var
  f: TFJurnal;
  s: string;
begin
  Result := false;
  F := TFJurnal.Create(Application);
  F.ActiveControl := f.gerek;
  f.ckAutoClose.Visible := true;
  s := GetOption(CurrentUser.KodeCabang+'-ckAutoClose@TFJurnal-checked', true);
  f.ckAutoClose.Checked := StrToBoolDef(s, false);
  F.acNew.Enabled := false;
  F.EditMode := True;
  f.QJ.ParamByName('kd').AsString := KodeJurnal;
  f.QD.ParamByName('kd').AsString := KodeJurnal;
  f.QJ.Open;
  if f.QJ.IsEmpty then
  begin
    Warn('Jurnal tidak ditemukan!');
    F.Close;
    Exit;
  end;
  F.Caption := F.QJjenis_jurnal.AsString +' - '+f.QJno_bukti.AsString;
  f.eTanggal.Date := f.QJtanggal.AsDateTime;
  f.eBukti.Text := f.QJno_bukti.AsString;
  f.eUraian.Text := f.QJuraian.AsString;
  f.QD.Open;
  if not f.QD.IsEmpty then
  begin
    f.QD.First;
    while not f.QD.Eof do
    begin
      s := f.QDkode_rek.AsString;
      f.vtAdd.Append;
      f.vtAddkode.AsString := s;
      f.vtAddfkode.AsString := FormatKodeRek(s);
      f.vtAdduraian.AsString := f.QDuraian.AsString;
      f.vtAdddebet.AsFloat := f.QDdebet.AsFloat;
      f.vtAddkredit.AsFloat := f.QDkredit.AsFloat;
      f.vtAddid.AsString := f.QDkode.AsString;
      f.vtAdd.Post;
      f.QD.Next;
    end;
  end;
  FMain.AddChildForm(f);
end;

procedure TFJurnal.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFJurnal.acNewExecute(Sender: TObject);
begin
  EditMode := false;
  Caption := 'Jurnal Baru - Jurnal Umum';
  if QJ.Active then
    QJ.Close;
  if QD.Active then
    QD.Close;
  eBukti.Clear;
  eUraian.Clear;
  EmptyDataset(vtAdd);
  FocusTo(eTanggal);
end;

procedure TFJurnal.acSaveExecute(Sender: TObject);
var
  sjur: String;
  kdjur: String;
  e: integer;
  tglSvr,
  tglJur: TDate;
  lewatBulan,
  telahApprove,
  approvedByAdmin: Boolean;
  q: TUniQuery;
  er: string;
begin
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
  if geRek.Columns[2].Footer.SumValue<>geRek.Columns[3].Footer.SumValue then
  begin
    Warn('Jumlah Debet/Kredit belum balance!');
    FocusTo(geRek);
    exit;
  end;
  if not EditMode then
  begin
    tglSvr := ServerDate();
    tglJur := eTanggal.Date;
    approvedByAdmin := true;
    if tglJur < awalBulan(tglSvr) then
    begin
      approvedByAdmin := LoginOTF('Transaksi di bulan-bulan yang lalu perlu approval Admin.'#13'Persilahkan Admin login:');
    end;
    if not approvedByAdmin then
      exit;
    if not QDet.Active then
      QDet.Open;
    sjur := 'INSERT INTO acc_jurnal_u( '+
      'jenis_jurnal, branch_kode, tahun, user_id, ref_table,ref_kode, tanggal, no_bukti, uraian, jenis_trans'+
      ') VALUES ('+
      '''JU00'', '+
      _q(CurrentUser.KodeCabang)+', '+
      _s(Tahun(tglJur))+', '+
      _s(CurrentUser.ID)+', '+
      _q('')+', '+
      _q('')+', '+
      _q(DateToSQL(tglJur))+', '+
      _q(eBukti.Text)+', '+
      _q(eUraian.Text)+ ', ''UMUM'') returning kode';
    e := 0;
    StartTrans;
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
          if e>0 then break;
          QDet.Append;
          QDetref_jurnal.AsString := kdjur;
          QDetkode_rek.AsString := vtAddkode.AsString;
          QDeturaian.AsString := vtAdduraian.AsString;
          QDetdebet.AsFloat := vtAdddebet.AsFloat;
          QDetkredit.AsFloat := vtAddkredit.AsFloat;
          try QDet.Post ; except inc(e) end;
          vtAdd.Next;
        end;
      finally
        vtAdd.EnableControls;
      end;
    finally
      if e > 0 then
      begin
        RollBackTrans;
        ShowDefaultError;
      end
      else
      begin
        CommitTrans;
        MsgBoxTimeout('Sukses', 'Jurnal tersimpan...', 3);
        acNew.Execute;
      end;
    end;
  end
  else
  // save on edit mode:
  begin
    tglSvr := ServerDate();
    tglJur := eTanggal.Date;
    er := '';
    lewatBulan := tglJur < awalBulan(tglSvr);
    telahApprove := QJapproved.AsString = 'Y';
    approvedByAdmin := true;
    if lewatBulan then
      er := er+'Transaksi di bulan-bulan lalu.'#13;
    if telahApprove then
      er := er+'Transaksi telah diapprove.'#13;
    if er <> '' then
    begin
      er := er +'Anda perlu login Admin:';
      approvedByAdmin := LoginOTF(er);
    end;
    if not approvedByAdmin then
      exit;
    sjur := 'update acc_jurnal_u set'+
      '  tahun = '+_s(Tahun(tglJur))+
      ', tanggal = '+_q(DateToSQL(tglJur))+
      ', no_bukti = '+ _q(eBukti.Text)+
      ', uraian = '+_q(eUraian.Text)+
      '  where kode = '+_q(QJkode.AsString)+' returning kode';
    e := 0;
    StartTrans;
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
      q:= Query;
      try
        vtAdd.First;
        ExecSQL('delete from acc_jurnal_u_detail where ref_jurnal = '+_q(QJkode.AsString)).Free;
        while not vtAdd.Eof do
        begin
          if q.Active then
            q.Close;
          if e>0 then break;
          sjur := 'INSERT INTO acc_jurnal_u_detail( '+
            'ref_jurnal, kode_rek, debet, kredit, uraian) values('+
            _q(QJkode.AsString)+','+
            _q(vtAddkode.AsString)+', '+
            FloatToSQL(vtAdddebet.AsFloat)+', '+
            FloatToSQL(vtAddkredit.AsFloat)+', '+
            _q(vtAdduraian.AsString)+')';
          q.SQL.Text := sjur;
          try q.ExecSQL; q.close; except inc(e) end;
          vtAdd.Next;
        end;
      finally
        q.Free;
        vtAdd.EnableControls;
      end;
    finally
      if e > 0 then
      begin
        RollBackTrans;
        ShowDefaultError;
      end
      else
      begin
        CommitTrans;
        if not ckAutoClose.Checked then
          MsgBoxTimeout('Sukses', 'Jurnal telah diedit.', 3)
        else
          Close;
        {
        if Ask('Jurnal tersimpan.'#13'Tutup form?') = mrNo then
          acNew.Execute
        else
          close;
        }
      end;
    end;
  end;
end;

procedure TFJurnal.Add1Click(Sender: TObject);
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
    vtAdddebet.AsFloat  := 0;
    vtAddkredit.AsFloat := 0;
    vtAdd.Post;
  end;
  sl.Free;
end;

procedure TFJurnal.ckAutoCloseClick(Sender: TObject);
begin
  SetOption(CurrentUser.KodeCabang+'-ckAutoClose@TFJurnal-checked', BoolToStr(ckAutoClose.Checked, true), true);
end;

procedure TFJurnal.Edit3Click(Sender: TObject);
var
  c: Double;
begin
  if vtAdd.IsEmpty then
    exit;
  vtAdd.Edit;
  c := vtAdddebet.AsFloat;
  vtAdddebet.AsFloat := vtAddkredit.AsFloat;
  vtAddkredit.AsFloat := c;
  vtAdd.Post;
end;

procedure TFJurnal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TFJurnal.FormCreate(Sender: TObject);
begin
  if not vtAdd.Active then
    vtAdd.Open;
  eTanggal.Date := Date();
  acNew.Execute;
end;

procedure TFJurnal.geRekColumns1EditButtons0Click(Sender: TObject;
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
    // vtAdddebet.AsFloat  := 0;
    // vtAddkredit.AsFloat := 0;
    vtAdd.Post;
  end;
  sl.Free;
end;

procedure TFJurnal.Hapus1Click(Sender: TObject);
begin
  if not vtAdd.IsEmpty then
    vtAdd.Delete;
end;

procedure TFJurnal.HapusSemua1Click(Sender: TObject);
begin
  EmptyDataset(vtAdd);
end;

procedure TFJurnal.vtAddAfterPost(DataSet: TDataSet);
begin
  with geRek do
  begin
    Panel3.Visible := Columns[2].Footer.SumValue<>Columns[3].Footer.SumValue;
    acSave.Enabled := not Panel3.Visible;
  end;
end;

end.
