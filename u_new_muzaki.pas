unit u_new_muzaki;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,


  u_utils, Data.DB, MemDS, DBAccess, Uni;

type
  TFNewMuzaki = class(TForm)
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
  public
    { Public declarations }
  end;

function InputMuzakiBaru(const Tipe: string = '*'): String {NPWZ};

implementation

{$R *.dfm}

uses umain;

function InputMuzakiBaru;
var
  Form: TFNewMuzaki;
  t: String;
begin
  result := '';
  if not CurrentUser.Accessible('Menambah Muzaki/UPZ') then
  begin
    Inform('Anda tidak memiliki Akses.'#13'Akses diperlukan:'#13'* Menginput Muzaki/UPZ');
    exit;
  end;
  t := _u(Tipe);
  form := TFNewMuzaki.Create(Application);
  with form do
  begin
    try
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

procedure TFNewMuzaki.Button1Click(Sender: TObject);
begin
  Tag := mrCancel;
  close;
end;

procedure TFNewMuzaki.Button2Click(Sender: TObject);
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
