unit u_new_mustahik_ex;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,


  u_utils, Data.DB, MemDS, DBAccess, Uni;

type
  TFNewMustahikEx = class(TForm)
    eNama: TEdit;
    eTipe: TDBLookupComboBox;
    eNik: TEdit;
    eKelurahan: TDBLookupComboBox;
    eAlamat: TMemo;
    eNoKK: TEdit;
    eTelp: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    qKel2: TUniQuery;
    dsKel2: TDataSource;
    qTipe: TUniQuery;
    dsTipe: TDataSource;
    qTipekode: TStringField;
    qTipeuraian: TStringField;
    qKel2kode: TStringField;
    qKel2nama: TStringField;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    _edit: Boolean;
  public
    { Public declarations }
  end;

function InputMustahikBaruEx(const Tipe: string = '*'): String {NPM};
function EditMustahikEx(const NPWM: String): Boolean;

implementation

{$R *.dfm}

uses umain;

function InputMustahikBaruEx;
var
  Form: TFNewMustahikEx;
  t: String;
begin
  result := '';
  if not CurrentUser.Accessible('Menambah Mustahik') then
  begin
    Inform('Anda tidak memiliki Akses.'#13'Akses diperlukan:'#13'* Menginput Mustahik');
    exit;
  end;
  t := _u(Tipe);
  form := TFNewMustahikEx.Create(Application);
  with form do
  begin
    try
      if not qKel2.Active then
        qKel2.Open;
      if qTipe.Active then
        qTipe.Close;
      if t = 'ORG' then
        qTipe.SQL.Text := 'select kode, uraian from baz_jenis_mustahik where kode=''01'' order by kode asc'
      else
      if t = 'UPZ' then
        qTipe.SQL.Text := 'select kode, uraian from baz_jenis_mustahik where not (kode in (''00'',''01'')) order by kode asc'
      else
        qTipe.SQL.Text := 'select kode, uraian from baz_jenis_mustahik where kode<>''00'' order by kode asc';
      qTipe.Open;
      if t = 'ORG' then
      begin
        eTipe.KeyValue := '01';
        eTipe.Enabled := false;
      end
      else
      begin
        qTipe.First;
        eTipe.KeyValue := qTipekode.AsString;
        eTipe.Enabled := true;
      end;
      eNama.Clear;
      qKel2.First;
      eKelurahan.KeyValue := qKel2kode.AsString;
      eNik.Clear;
      eNoKK.Clear;
      eTelp.Clear;
      eAlamat.Clear;
      tag := mrNone;
      ShowModal;
      if tag = mrOK then
      begin
        t := 'insert into baz_mustahik(nama, tipe, kelurahan, nik, telp, alamat, kd_cabang) values ('+
          _q(eNama.Text)+', '+
          _q(eTipe.KeyValue)+', '+
          _q(eKelurahan.KeyValue)+', '+
          _q(eNik.Text)+', '+
          _q(eTelp.Text)+', '+
          _q(eAlamat.Text)+', '+
          _q(CurrentUser.KodeCabang)+' '+
          ') returning npwm';
        Result :=  ExecSQLAndFetchOneValueAsString(t);
        if Result = '' then
          Deny('Gagal menambah Mustahik baru...');
      end;
    finally
      free;
    end;
  end;
end;

function EditMustahikEx(const NPWM: String): Boolean;
var
  Form: TFNewMustahikEx;
  t: String;
  q: TUniQuery;
begin
  result := false;
  if not CurrentUser.Accessible('Mengedit Mustahik') then
  begin
    Inform('Anda tidak memiliki Akses.'#13'Akses diperlukan:'#13'* Mengedit Mustahik');
    exit;
  end;
  form := TFNewMustahikEx.Create(Application);
  with form do
  begin
    try
      _edit:= true;
      Caption := 'Edit Mustahik';
      if not qKel2.Active then
        qKel2.Open;
      if qTipe.Active then
        qTipe.Close;
      qTipe.SQL.Text := 'select kode, uraian from baz_jenis_mustahik where kode<>''00'' order by kode asc';
      qTipe.Open;
      q := ExecSQL('select * from baz_mustahik where npwm = '+_q(NPWM));
      if not q.IsEmpty then
      begin
        eTipe.KeyValue := q.FieldByName('tipe').AsString;
        eTipe.Enabled := true;
        eNama.text := q.FieldByName('nama').AsString;
        eKelurahan.KeyValue := q.FieldByName('kelurahan').AsString;
        eNik.text := q.FieldByName('nik').AsString;
        eNoKK.text := q.FieldByName('no_kk').AsString;
        eTelp.text := q.FieldByName('telp').AsString;
        eAlamat.text := q.FieldByName('alamat').AsString;
        tag := mrNone;
        ShowModal;
        if tag = mrOK then
        begin
          q.Edit;
          q.FieldByName('tipe').AsString      :=  eTipe.KeyValue;
          q.FieldByName('nama').AsString      :=  eNama.text;
          q.FieldByName('kelurahan').AsString :=  eKelurahan.KeyValue;
          q.FieldByName('nik').AsString       :=  eNik.text;
          q.FieldByName('no_kk').AsString     :=  eNoKK.text;
          q.FieldByName('telp').AsString      :=  eTelp.text;
          q.FieldByName('alamat').AsString    :=  eAlamat.text;
          try q.post; result := true; except result := false; end;
          if not Result then
            Deny('Gagal mengupdate Mustahik');
        end;
      end
      else
      begin
        inform('Data Mustahik tidak ditemukan!');
      end;
      q.Free;
    finally
      free;
    end;
  end;
end;

procedure TFNewMustahikEx.Button1Click(Sender: TObject);
begin
  Tag := mrCancel;
  close;
end;

procedure TFNewMustahikEx.Button2Click(Sender: TObject);
begin
  if eNama.WarnForEmpty('Masih kosong.') then exit;
  if eTipe.KeyValue = '' then
  begin
    Warn('Jenis Mustahik masih kosong.');
    FocusTo(eTipe);
    exit;
  end;
  if eKelurahan.KeyValue = '' then
  begin
    Warn('Kelurahan/Kecamatan masih kosong.');
    FocusTo(eKelurahan);
    exit;
  end;
  Tag := mrOk;
  close;
end;

end.
