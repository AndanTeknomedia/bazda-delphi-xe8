unit u_input_integer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFInputInteger = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Edit1: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FInputInteger: TFInputInteger;

function InputInt(const ACaption, APrompt: String; var AInteger: Integer; const max_length: integer = 7): Boolean;

implementation

{$R *.dfm}

function InputInt;
begin
  Result := False;
  with TFInputInteger.Create(Application) do
  begin
    try
      Edit1.Text := IntToStr(AInteger);
      Edit1.MaxLength := max_length;
      Caption := ACaption;
      Label1.Caption := APrompt;
      Edit1.SelectAll;
      Result := ShowModal = mrOk;
      if Result then
      begin
        AInteger := StrToIntDef(edit1.text,0);
      end;
    finally
      Free;
    end;
  end;
end;

end.
