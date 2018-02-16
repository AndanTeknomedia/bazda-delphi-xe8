unit u_new_muzaki_ex;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,


  u_utils, Data.DB, MemDS, DBAccess, Uni;

type
  TFNewMuzakiEx = class(TForm)
    eNama: TEdit;
    eTipe: TDBLookupComboBox;
    eNik: TEdit;
    eNPWP: TEdit;
    eKelurahan: TDBLookupComboBox;
    eAlamat: TMemo;
    eNoKK: TEdit;
    eTelp: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
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

function InputMuzakiBaruEx(const Tipe: string = '*'): String {NPWZ};
function EditMuzakiEx(const NPWZ: String): Boolean;

implementation

{$R *.dfm}

uses umain;

function InputMuzakiBaruEx;
var
  Form: TFNewMuzakiEx;
  t: String;
begin
  result := '';
  if not CurrentUser.Accessible('Menambah Muzaki/UPZ') then
  begin
    Inform('Anda tidak memiliki Akses.'#13'Akses diperlukan:'#13'* Menginput Muzaki/UPZ');
    exit;
  end;
  t := _u(Tipe);
  form := TFNewMuzakiEx.Create(Application);
  with form do
  begin
    try
      _edit:= false;
      if not qKel2.Active then
        qKel2.Open;
      if qTipe.Active then
        qTipe.Close;
      if t = 'ORG' then
        qTipe.SQL.Text := 'select kode, uraian from baz_jenis_muzakki where kode=''01'' order by kode asc'
      else
      if t = 'UPZ' then
        qTipe.SQL.Text := 'select kode, uraian from baz_jenis_muzakki where not (kode in (''00'',''01'')) order by kode asc'
      else
        qTipe.SQL.Text := 'select kode, uraian from baz_jenis_muzakki where kode<>''00'' order by kode asc';
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
      eNPWP.Clear;
      eNoKK.Clear;
      eTelp.Clear;
      eAlamat.Clear;
      tag := mrNone;
      ShowModal;
      if tag = mrOK then
      begin
        t := 'insert into baz_muzakki(nama, tipe, kelurahan, nik, npwp,telp, alamat, kd_cabang) values ('+
          _q(eNama.Text)+', '+
          _q(eTipe.KeyValue)+', '+
          _q(eKelurahan.KeyValue)+', '+
          _q(eNik.Text)+', '+
          _q(eNPWP.Text)+', '+
          _q(eTelp.Text)+', '+
          _q(eAlamat.Text)+', '+
          _q(CurrentUser.KodeCabang)+' '+
          ') returning npwz';
        Result :=  ExecSQLAndFetchOneValueAsString(t);
        if Result = '' then
          Deny('Gagal menambah Muzaki/UPZ baru...');
      end;
    finally
      free;
    end;
  end;
end;

function EditMuzakiEx(const NPWZ: String): Boolean;
var
  Form: TFNewMuzakiEx;
  t: String;
  q: TUniQuery;
begin
  result := false;
  if not CurrentUser.Accessible('Mengedit Muzaki/UPZ') then
  begin
    Inform('Anda tidak memiliki Akses.'#13'Akses diperlukan:'#13'* Mengedit Muzaki/UPZ');
    exit;
  end;
  form := TFNewMuzakiEx.Create(Application);
  with form do
  begin
    try
      _edit:= true;
      Caption := 'Edit Muzaki/UPZ';
      if not qKel2.Active then
        qKel2.Open;
      if qTipe.Active then
        qTipe.Close;
      qTipe.SQL.Text := 'select kode, uraian from baz_jenis_muzakki where kode<>''00'' order by kode asc';
      qTipe.Open;
      q := ExecSQL('select * from baz_muzakki where npwz = '+_q(NPWZ));
      if not q.IsEmpty then
      begin
        eTipe.KeyValue := q.FieldByName('tipe').AsString;
        eTipe.Enabled := true;
        eNama.text := q.FieldByName('nama').AsString;
        eKelurahan.KeyValue := q.FieldByName('kelurahan').AsString;
        eNik.text := q.FieldByName('nik').AsString;
        eNPWP.text := q.FieldByName('npwp').AsString;
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
          q.FieldByName('npwp').AsString      :=  eNPWP.text;
          q.FieldByName('no_kk').AsString     :=  eNoKK.text;
          q.FieldByName('telp').AsString      :=  eTelp.text;
          q.FieldByName('alamat').AsString    :=  eAlamat.text;
          try q.post; result := true; except result := false; end;
          if not Result then
            Deny('Gagal mengupdate Muzaki/UPZ');
        end;
      end
      else
      begin
        inform('Data UPZ/Muzaki tidak ditemukan!');
      end;
      q.Free;
    finally
      free;
    end;
  end;

end;

procedure TFNewMuzakiEx.Button1Click(Sender: TObject);
begin
  Tag := mrCancel;
  close;
end;

procedure TFNewMuzakiEx.Button2Click(Sender: TObject);
begin
  if eNama.WarnForEmpty('Masih kosong.') then exit;
  if eTipe.KeyValue = '' then
  begin
    Warn('Jenis Muzaki masih kosong.');
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
