unit u_input_email_settings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, JvExControls, JvEnterTab, DateUtils,
  Mask, JvExMask, JvSpin, JvComponentBase, u_utils, Vcl.Samples.Spin;

type
  TEmailAttachment = record
    Name: String[100];
    FileName: string[200];
    FileSize: Int64;
  end;

  TSendEmailSettings = record
    From,
    Email: String[100];
    SMTPServer,
    SMTPUserName,
    SMTPPassword: String[100];
    SMTPPort: Word;
    SMTPAutoTLS,
    SMTPFullSSL: Boolean;
    Attachment: TEmailAttachment;
    procedure Clear;
  end;

  TFInputEmailSettings = class(TForm)
    eSMTPUsername: TEdit;
    eSMTPServer: TEdit;
    eSMTPPassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Panel2: TPanel;
    Bevel2: TBevel;
    Button1: TButton;
    Button2: TButton;
    JvEnterAsTab1: TJvEnterAsTab;
    Label10: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    eMail: TEdit;
    Label8: TLabel;
    eAttachment: TButtonedEdit;
    Label5: TLabel;
    eSMTPPort: TSpinEdit;
    procedure JvEnterAsTab1HandleEnter(Sender: TObject; AControl: TWinControl;
      var Handled: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function InputSendMailSettings(var EmailSettings: TSendEmailSettings): Boolean;

implementation

uses umain;

{$R *.dfm}

function InputSendMailSettings;
var
  s: string;
  d: TDate;
  i: integer;
begin
  Result := False;
  with TFInputEmailSettings.Create(Application) do
  begin
    try
      eMail.Text := EmailSettings.Email;
      eAttachment.Text := EmailSettings.Attachment.FileName;
      eAttachment.HiddenText := '';
      eAttachment.HiddenInt := 0;
      eSMTPServer.Text   := EmailSettings.SMTPServer;
      eSMTPUsername.Text := EmailSettings.SMTPUserName;
      eSMTPPassword.Text := EmailSettings.SMTPPassword;
      if EmailSettings.SMTPPort = 0 then
        eSMTPPort.Value := 25
      else
        eSMTPPort.Value := EmailSettings.SMTPPort;
      Tag := mrNone;
      ShowModal;
      Result := Tag = mrOk;
      if Result then
      begin
        EmailSettings.SMTPServer    := eSMTPServer.Text;
        EmailSettings.SMTPUserName  := eSMTPUsername.Text;
        EmailSettings.SMTPPassword  := eSMTPPassword.Text;
        EmailSettings.SMTPPort      := eSMTPPort.Value;
        EmailSettings.Email         := eMail.Text;
        if FileExists(eAttachment.Text) then
        begin
          with EmailSettings.Attachment do
          begin
            Name      := ExtractFileName(eAttachment.Text);
            FileName  := eAttachment.Text;
            // FileSize  := u_utils.FileSize(eAttachment.Text);
          end;
        end;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TFInputEmailSettings.Button1Click(Sender: TObject);
begin
  if eMail.WarnForEmpty() then exit;
  if eSMTPServer.WarnForEmpty() then exit;
  if eSMTPUsername.WarnForEmpty() then exit;
  if eSMTPPassword.WarnForEmpty() then exit;
  Tag := mrOk;
  Close;
end;

procedure TFInputEmailSettings.Button2Click(Sender: TObject);
begin
  Tag := mrCancel;
  Close;
end;

procedure TFInputEmailSettings.JvEnterAsTab1HandleEnter(Sender: TObject;
  AControl: TWinControl; var Handled: Boolean);
begin
  Handled := AControl = Button1;
end;

{ TSendEmailSettings }

procedure TSendEmailSettings.Clear;
begin
  From                := '';
  Email               := '';
  SMTPServer          := '';
  SMTPUserName        := '';
  SMTPPassword        := '';
  SMTPPort            := 0;
  SMTPAutoTLS         := true;
  SMTPFullSSL         := false;
  Attachment.Name     := '';
  Attachment.FileName := '';
  Attachment.FileSize := 0;
end;

end.
