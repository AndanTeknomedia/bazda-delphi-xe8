unit u_input_tanggal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TFInputTanggal = class(TForm)
    dp1: TDateTimePicker;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function InputTanggal(var Tanggal: TDate): Boolean;

implementation

{$R *.dfm}

function InputTanggal;
begin
  Result := False;
  with TFInputTanggal.Create(Application) do
  begin
    try
      dp1.Date := Tanggal;
      if ShowModal = mrOk then
      begin
        Tanggal:= dp1.Date;
        Result := True;
      end;
    finally
      Free;
    end;
  end;
end;

end.
