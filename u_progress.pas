unit u_progress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvExControls, JvAnimatedImage,
  JvGIFCtrl, Vcl.ExtCtrls, u_utils;

type
  TFProgress = class(TForm)
    pProgress: TPanel;
    JvGIFAnimator1: TJvGIFAnimator;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ProcedureToRun: TOnProgressProc;
  end;

var
  FProgress: TFProgress;

implementation

{$R *.dfm}

procedure TFProgress.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ProcedureToRun := nil;
  // Action := caHide;
end;

procedure TFProgress.FormShow(Sender: TObject);
begin
  ProcedureToRun;
end;

end.
