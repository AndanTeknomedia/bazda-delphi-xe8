unit u_display_text;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFDisplayText = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FDisplayText: TFDisplayText;

function ShowText(const AText: String): String;

implementation

{$R *.dfm}

function ShowText;
begin
  Result := '';
  with TFDisplayText.Create(Application) do
  begin
    try
      Memo1.Text := AText;
      tag := mrNone;
      ShowModal;
      if tag = mrOK then
        result := Memo1.Text;
    finally
      Free;
    end;
  end;
end;

procedure TFDisplayText.Button1Click(Sender: TObject);
begin
  tag := mrOK;
  close;
end;

procedure TFDisplayText.Button2Click(Sender: TObject);
begin
  tag := mrCancel;
  CLose;
end;

end.
