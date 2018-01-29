unit u_login_otf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, u_utils;

type
  TFLoginOTF = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Bevel2: TBevel;
    Button1: TButton;
    Button2: TButton;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function LoginOTF(const ACaption: String = 'Perlu approval Administrator.'): Boolean;

implementation

{$R *.dfm}

function LoginOTF;
begin
  Result := true;
  exit;
  // sementara, sampe dibutuhkan!
  Result := False;
  // current user is admin or dev:
  if (CurrentUser.ID<> 0)
  and (
    (CurrentUser.Grup  = 'ADM')
    or
    (CurrentUser.Grup  = 'DEV')
  ) then
  begin
    Result := true;
    exit;
  end;
  // if already has approval:
  if (CurrentUser.SuperVisorID <> 0)
  and (
    (CurrentUser.SuperVisorGrup  = 'ADM')
    or
    (CurrentUser.SuperVisorGrup  = 'DEV')
  ) then
  begin
    Result := true;
    exit;
  end;
  with TFLoginOTF.Create(Application) do
  begin
    try
      Label3.Caption := ACaption;
      ShowModal;
      Result := Tag = mrOk;
      // ShowMessage(BoolToStr(Result, true));
    finally
      Free;
    end;
  end;
end;

procedure TFLoginOTF.Button1Click(Sender: TObject);
begin
  Tag := mrcancel;     
  Close;
end;

procedure TFLoginOTF.Button2Click(Sender: TObject);
begin
  with ExecSQL('SELECT u.*, g.group_name FROM usr_user u '+
    'inner join usr_group g on g.group_kode = u.group_kode '+
    'where u.group_kode in (''ADM'',''DEV'') and '+
    ' u.user_name = '+QuotedStr(Edit1.Text)+
    ' and u.user_password = md5('+QuotedStr(Edit2.Text)+')') do
  begin    
    if IsEmpty then
    begin
      Warn('Username atau Password tidak cocok.');
      self.Tag := mrCancel;
    end
    else
    begin
      first;
      if FieldByName('allow_login').AsString<>'Y' then
      begin
        Warn(FieldByName('full_name').AsString+' tidak dijinkan login.');
        self.Tag := mrCancel;
      end
      else
      begin
        if CheckBox1.Checked then
        begin
          CurrentUser.SuperVisorID := FieldByName('id').AsInteger;
          CurrentUser.SuperVisorUserName := FieldByName('user_name').AsString;
          CurrentUser.SuperVisorGrupName := FieldByName('group_name').AsString;
          CurrentUser.SuperVisorPassword := FieldByName('user_password').AsString;
          CurrentUser.SuperVisorFullName := FieldByName('full_name').AsString;
          CurrentUser.SuperVisorGrup := FieldByName('group_kode').AsString;
        end;
        self.tag  := mrOk;
      end;
    end;
    Free;
  end;
  Close;
end;

end.
