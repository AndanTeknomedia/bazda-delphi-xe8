unit u_input_text;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFInputTeks = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FInputTeks: TFInputTeks;

function InputTeks(const ACaption, APrompt: String; var ATeks: String): Boolean;
function GetTeks(const ACaption, APrompt, Default: String): String;

implementation

{$R *.dfm}

function InputTeks;
begin
  Result := False;
  with TFInputTeks.Create(Application) do
  begin
    try
      Memo1.Text := ATeks;
      Caption := ACaption;
      Label1.Caption := APrompt;
      Memo1.SelectAll;
      Result := ShowModal = mrOk;
      if Result then
      begin
        ATeks := Memo1.Lines.{Delimited}Text;
      end;
    finally
      Free;
    end;
  end;
end;

function GetTeks;
begin
  Result := '';
  with TFInputTeks.Create(Application) do
  begin
    try
      Memo1.Text := Default;
      Caption := ACaption;
      Label1.Caption := APrompt;
      Memo1.SelectAll;
      if ShowModal = mrOk then
        Result := Memo1.Lines.{Delimited}Text;
    finally
      Free;
    end;
  end;
end;

end.
