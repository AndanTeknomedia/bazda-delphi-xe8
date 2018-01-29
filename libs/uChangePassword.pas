unit uChangePassword;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, u_utils, JvExControls, JvEnterTab;

type
  TPasswordDlg = class(TForm)
    Label1: TLabel;
    eOldP: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    Label2: TLabel;
    eNewP: TEdit;
    Label3: TLabel;
    eNewPC: TEdit;
    JvEnterAsTab1: TJvEnterAsTab;
    procedure CancelBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure JvEnterAsTab1HandleEnter(Sender: TObject; AControl: TWinControl;
      var Handled: Boolean);
  private
    { Private declarations }
    _OP: String;
  public
    { Public declarations }
  end;

function PromptChangePassword(const PassLama: String; var PasswordBaru: String): Boolean;

implementation

{$R *.dfm}

function PromptChangePassword;
begin
  Result := False;
  PasswordBaru := '';
  with TPasswordDlg.Create(Application) do
  begin
    try
      _OP := PassLama;
      eOldP.Clear;
      eNewP.Clear;
      eNewPC.Clear;
      Tag := mrNone;
      ShowModal;
      if Tag = mrOk then
      begin
        PasswordBaru := eNewP.Text;
        Result := True;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TPasswordDlg.CancelBtnClick(Sender: TObject);
begin
  Tag := mrCancel;
  Close;
end;

procedure TPasswordDlg.JvEnterAsTab1HandleEnter(Sender: TObject;
  AControl: TWinControl; var Handled: Boolean);
begin
  Handled := AControl is TButton;
end;

procedure TPasswordDlg.OKBtnClick(Sender: TObject);
begin
  if eOldP.Text<>_OP then
  begin
    Warn('Password lama tidak cocok.', handle);
    exit;
  end;
  if eNewP.Text <> eNewPC.Text then
  begin
    Warn('Password baru tidak sama dengan konfirmasinya.', handle);
    FocusTo(eNewP);
    exit;
  end;
  if eNewP.WarnForEmpty('Password baru tidak boleh kosong.') then
    exit;
  Tag := mrOk;
  Close;
end;

end.
 
