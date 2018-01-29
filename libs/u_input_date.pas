unit u_input_date;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TFInputDate = class(TForm)
    DateTimePicker1: TDateTimePicker;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FInputDate: TFInputDate;

function InputTanggal(var Tgl: TDate; const ACaption: String = 'Tanggal'): Boolean;

implementation

{$R *.dfm}

function InputTanggal;
begin
  Result := False;
  with TFInputDate.Create(Application) do
  begin
    try
      Caption := ACaption;
      DateTimePicker1.Date := Tgl;
      if ShowModal =  mrOk then
      begin
        tgl := DateTimePicker1.Date;
        Result := True;
      end;
    finally
      Free;
    end;
  end;
end;

end.
