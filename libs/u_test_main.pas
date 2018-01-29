unit u_test_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, u_utils, ComCtrls, Grids, ShellAPI, ShlObj,
  OleCtrls, SHDocVw;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    LbRek1: TLabel;
    LbRek2: TLabel;
    LbRek3: TLabel;
    LbRek4: TLabel;
    LbRek5: TLabel;
    LbRek6: TLabel;
    LbRek8: TLabel;
    LbRek7: TLabel;
    be1: TButtonedEdit;
    be2: TButtonedEdit;
    be3: TButtonedEdit;
    be4: TButtonedEdit;
    be5: TButtonedEdit;
    be6: TButtonedEdit;
    be8: TButtonedEdit;
    be7: TButtonedEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
