unit u_change_pass;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage, JvExControls, JvXPCore, JvXPButtons;

type
  TFChangePass = class(TForm)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    Image2: TImage;
    JvXPButton1: TJvXPButton;
    JvXPButton2: TJvXPButton;
    Label1: TLabel;
    procedure JvXPButton1Click(Sender: TObject);
    procedure JvXPButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FChangePass: TFChangePass;

function ChangePassDlg(const Uid: String; var OldPass, NewPass1, NewPass2: String):Boolean; overload;
function ChangePassDlg(const Uid: String; var NewPass1, NewPass2: String):Boolean; overload;

implementation

{$R *.dfm}

function ChangePassDlg(const Uid: String; var OldPass, NewPass1, NewPass2: String):Boolean; overload;

begin
  Result := False;
  with TFChangePass.Create(Application ) do
  begin
    Label1.Caption := 'Ganti password untuk user ['+ Uid+']';
    LabeledEdit1.Clear;
    LabeledEdit2.Clear;
    LabeledEdit3.Clear;
    ShowModal;
    Result := Tag = mrOk;
    if Result then
    begin
      OldPass  := LabeledEdit1.Text;
      NewPass1 := LabeledEdit2.Text;
      NewPass2 := LabeledEdit3.Text;
    end;
    Free;
  end;
end;

function ChangePassDlg(const Uid: String; var NewPass1, NewPass2: String):Boolean; overload;
begin
  Result := False;
  with TFChangePass.Create(Application ) do
  begin
    Label1.Caption := 'Ganti password untuk user ['+ Uid+']';
    LabeledEdit1.Clear;
    LabeledEdit2.Clear;
    LabeledEdit3.Clear;
    LabeledEdit3.Top := LabeledEdit2.Top;
    LabeledEdit2.Top := LabeledEdit1.Top;
    LabeledEdit1.Hide;
    ShowModal;
    Result := Tag = mrOk;
    if Result then
    begin
      NewPass1 := LabeledEdit2.Text;
      NewPass2 := LabeledEdit3.Text;
    end;
    Free;
  end;
end;

procedure TFChangePass.JvXPButton1Click(Sender: TObject);
begin
  if LabeledEdit2.Text <> LabeledEdit3.Text then
  begin
    MessageBox(handle, 'Password baru tidak sama dengan konfirmasinya.', 'Error', MB_ICONHAND or MB_OK);
    LabeledEdit2.SetFocus;
    LabeledEdit2.SelectAll;
    exit;
  end;
  Self.Tag := mrOk;
  Close;
end;

procedure TFChangePass.JvXPButton2Click(Sender: TObject);
begin
  Self.Tag := mrCancel;
  Close;
end;

end.
