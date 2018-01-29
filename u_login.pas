unit u_login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, u_utils;

type
  TFLogin = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Bevel2: TBevel;
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLogin: TFLogin;

implementation

{$R *.dfm}

procedure TFLogin.Button1Click(Sender: TObject);
begin
  Tag := mrcancel;

  Close;
end;

procedure TFLogin.Button2Click(Sender: TObject);
begin
  with ExecSQL('SELECT u.*, g.group_name FROM usr_user u '+
    'inner join usr_group g on g.group_kode = u.group_kode '+
    'where u.user_name = '+QuotedStr(Edit1.Text)+
    ' and u.user_password = md5('+QuotedStr(Edit2.Text)+')') do
  begin
    CurrentUser.Clear;
    if CheckBox1.Checked then
    begin
      SetOption('login-username',Edit1.Text, true);
      SetOption('login-password',Edit2.Text, true);
      SetOption('login-remember',BoolToStr(CheckBox1.Checked, true), true);
    end;
    if IsEmpty then
    begin
      Warn('Username atau Password tidak cocok.');
      Tag := mrCancel;
    end
    else
    begin
      first;
      if FieldByName('allow_login').AsString<>'Y' then
      begin
        Warn('Anda tidak dijinkan login.');
        Tag := mrCancel;
      end
      else
      begin
        CurrentUser.ID := FieldByName('id').AsInteger;
        CurrentUser.GrupName:= FieldByName('group_name').AsString;
        CurrentUser.UserName:= FieldByName('user_name').AsString;
        CurrentUser.Password := FieldByName('user_password').AsString;
        CurrentUser.FullName := FieldByName('full_name').AsString;
        CurrentUser.Grup := FieldByName('group_kode').AsString;
        tag  := mrOk;
      end;
    end;
    Free;
  end;
  Close;
end;

procedure TFLogin.FormCreate(Sender: TObject);
var
  _: String;
begin
  Edit1.Text := GetOption('login-username', true);
  Edit2.Text := getOption('login-password', true);
  _ := getOption('login-remember', true);
  if _.IsEmpty then
    _ := 'False';
  CheckBox1.Checked := StrToBool(_);
end;

end.
