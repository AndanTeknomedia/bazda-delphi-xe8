unit u_get_jenis_distribusi_dana;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Data.DB,
  MemDS, DBAccess, Uni, u_utils;

type
  TFJenisDistribusiDana = class(TForm)
    dsJenisDana: TDataSource;
    qJenisDana: TUniQuery;
    qJenisDanakode: TMemoField;
    qJenisDanavkode: TStringField;
    qJenisDanarekening: TStringField;
    eJenisDana: TDBLookupComboBox;
    Label11: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetJenisDistribusiDana(PrefiksAkun: TStringArr): tperkiraan;

implementation

{$R *.dfm}

uses u_display_text;

function GetJenisDistribusiDana(PrefiksAkun: TStringArr): tperkiraan;
var
  s,
  sql: String;
  i: integer;
begin
  Result.kode := '';
  Result.vkode := '';
  Result.Rekening := '';
  s := '';
  sql := 'select kode, format_vkode(kode)::varchar(20) vkode, rekening  from v_coa_2 where (1=1) and (tingkat=2) order by kode asc';
  with TFJenisDistribusiDana.Create(Application) do
  begin
    try
      Tag := mrNone;
      for i := 0 to Length(PrefiksAkun)-1 do
        s := s+' or (kode like '+_q(PrefiksAkun[i]+'%')+')';
      delete(s,1,4);
      sql := _r(sql, '(1=1)','('+s+')',[]);

      qJenisDana.SQL.Text := SQL;
      qJenisDana.Open;
      if qJenisDana.IsEmpty then
      begin
        Warn('Akun-akun Jenis Dana Distribusi belum ada.');
        tag := mrCancel;
      end
      else
      begin
        qJenisDana.First;
        eJenisDana.KeyValue := qJenisDanakode.AsString;
        ShowModal;
        if tag = mrOk then
        begin
          Result.kode := eJenisDana.KeyValue;
          Result.vkode := qJenisDanavkode.AsString;
          Result.Rekening := qJenisDanarekening.AsString;
        end;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TFJenisDistribusiDana.Button1Click(Sender: TObject);
begin
  Tag := mrCancel;
  close;
end;

procedure TFJenisDistribusiDana.Button2Click(Sender: TObject);
begin
  Tag := mrOk;
  close;
end;

end.
