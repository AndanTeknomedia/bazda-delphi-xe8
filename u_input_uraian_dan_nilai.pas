unit u_input_uraian_dan_nilai;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, JvExMask, JvToolEdit, JvBaseEdits, StdCtrls;

type
  TFInputUraianDanNilai = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    tsPendapatanBeNilai: TJvCalcEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FInputUraianDanNilai: TFInputUraianDanNilai;

implementation

{$R *.dfm}

end.
