program test;

uses
  Forms,
  u_test_main in 'u_test_main.pas' {Form1},
  u_utils in 'u_utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
