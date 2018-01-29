program mitpgab;

uses
  Forms,
  umain in 'umain.pas' {FMain},
  uExpMod in 'uExpMod.pas' {ExpMod},
  ubackupSettings in 'ubackupSettings.pas' {FBackupSettings};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'MIT PostgreSQL Auto Backup';
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
