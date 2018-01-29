unit u_koneksi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  u_utils, Data.DB, DBAccess, Uni, UniProvider, PostgreSQLUniProvider;

type
  TFKoneksi = class(TForm)
    Label1: TLabel;
    eHost: TEdit;
    ePort: TSpinEdit;
    eUser: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    ePassword: TEdit;
    Label4: TLabel;
    eDatabase: TEdit;
    Label5: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    UniConnection1: TUniConnection;
    PostgreSQLUniProvider1: TPostgreSQLUniProvider;
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FKoneksi: TFKoneksi;

implementation

{$R *.dfm}

procedure TFKoneksi.Button1Click(Sender: TObject);
begin
  if UniConnection1.Connected then
    UniConnection1.Disconnect;
  UniConnection1.Server := eHost.Text;
  UniConnection1.Port := ePort.Value;
  UniConnection1.Database := eDatabase.Text;
  UniConnection1.Username := eUser.Text;
  UniConnection1.Password := ePassword.Text;
  try
    UniConnection1.Connect;
    if UniConnection1.Connected then
      Inform('Koneksi sukses! Klik OK untuk menyimpan setting koneksi.')
    else
      Deny('Koneksi gagal! Silahkan periksa setting koneksi.')
    ;
    UniConnection1.Disconnect;
  except
    Deny('Koneksi gagal! Silahkan periksa setting koneksi.')
  end;
end;

procedure TFKoneksi.Button2Click(Sender: TObject);
begin
  if eHost.WarnForEmpty() then exit;
  if ePort.Value<=0 then
  begin
    Warn('Nomor port tidak valid!');
    FocusTo(ePort);
    exit;
  end;
  if eUser.WarnForEmpty() then exit;
  if ePassword.WarnForEmpty() then exit;
  if eDatabase.WarnForEmpty() then exit;
  tag := mrOK;
  Close;
end;

procedure TFKoneksi.Button3Click(Sender: TObject);
begin
  tag := mrCancel;
  Close;
end;

end.
