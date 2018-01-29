unit uExpMod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ToolWin, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  ImgList, DB, SHFolder, StdCtrls, DBAccess, Uni,
  ExtCtrls;

type
  TCommandType    = (ctImport, ctExport, ctBackup, ctRestore, ctEmpty, ctVacuum, ctUnknown, ctCopyBetweenServer, ctUploadToDatacenter, ctDownloadAll);
  TDataType       = (dtData1, dtData21, dtData22, dtData3, dtDataMS, dtDataMd, dtDataLog, dtDataAll);
  TDataTypes      = set of TDataType;
  TOnCommandRead  = procedure(ALine: String) of object;
  TConProps       = record
                      Host,
                      User,
                      Password,
                      Database: String[100];
                      Port: Word;
                    end;

function TestConnection(const ConProp: TConProps): Boolean;
function BuildConnection(const ConProp: TConProps): TUniConnection;
procedure ExecuteSQL(const Connection: TConProps; const SQL:String; cbOnRead: TOnCommandRead; const UsePSQL: Boolean = True);
procedure ExecuteSQLFile(const ConProp: TConProps; const SrcFile:String; cobOnRead: TOnCommandRead{ALWAYS USE PSQL});

function  GetDosOutput(CommandLine, Params: string; cbOnDataRead: TOnCommandRead; Work: string = ''): DWORD;
procedure ProcessCommand(CommandLine, Params: string);
function  getConnectionProps(Connection: TUniConnection): TConProps;
//
//  CORE EXPORT - IMPORT ROUTINE
//
procedure DoBackup(AConnectionProp: TConProps; const ATargetFile:String);
procedure DoRestore(AConnectionProp: TConProps; const ASourceFile:String);
///
procedure BackupData;
procedure RestoreData;

var
  __GLOBAL_CONNECTION : TUniConnection;
  __GLOBAL_READPROC   : TOnCommandRead;

implementation

uses umain;

// {$R commands.RES}
// {$R 01.RES}

{ TExpMod }

const
  //POSTGRESQL'S DLL NAMES
  d01	= 'd01';  d01n = 'comerr32.dll'   ;
  d02	= 'd02';  d02n = 'cgssapi32.dll'  ;
  d03	= 'd03';  d03n = 'ciconv.dll'     ;
  d04	= 'd04';  d04n = 'ck5sprt32.dll'  ;
  d05	= 'd05';  d05n = 'ckrb5_32.dll'   ;
  d06	= 'd06';  d06n = 'clibeay32.dll'  ;
  d07	= 'd07';  d07n = 'clibiconv-2.dll';
  d08	= 'd08';  d08n = 'clibintl-8.dll' ;
  d09	= 'd09';  d09n = 'clibpq.dll'     ;
  d10	= 'd10';  d10n = 'clibxml2.dll'   ;
  d11	= 'd11';  d11n = 'clibxslt.dll'   ;
  d12	= 'd12';  d12n = 'cmsvcr71.dll'   ;
  d13	= 'd13';  d13n = 'cssleay32.dll'  ;
  d14	= 'd14';  d14n = 'czlib1.dll'     ;

var
  SysPath: String;
  PGDUMP_: String;
  PSQL___: String;
  PGREST_: String;
  RS     : TResourceStream;
  PGPASS_: String;
  CMD____: String;
  TMPPATH: String;

function TestConnection;
var
  ConTest: TUniConnection;
begin
  Result := False;
  ConTest := TUniConnection.Create(Application);
  try
    with ConTest do
    begin
      Server      := ConProp.Host;
      Port          := ConProp.Port;
      Username          := ConProp.User;
      Password      := ConProp.Password;
      Database      := ConProp.Database;
      ProviderName      := 'PostgreSQL';
      LoginPrompt   := False;
    end;
    try
      ConTest.Connect;
      Result := ConTest.Connected;
      if ConTest.Connected then
        ConTest.Disconnect;
    except on E: Exception do
    end;
  finally
    ConTest.Free;
  end;
end;

function BuildConnection;
begin
  Result:= TUniConnection.Create(Application);
  with Result do
  begin
    Server      := ConProp.Host;
    Port          := ConProp.Port;
    Username          := ConProp.User;
    Password      := ConProp.Password;
    Database      := ConProp.Database;
    LoginPrompt   := False;
    ProviderName      := 'PostgreSQL';
  end;
  try
    Result.Connect;
  except on E: Exception do
  end;
end;

function SysDir: String;
var
  p: PChar;
begin
  GetMem(p, 1024);
  GetSystemDirectory(p, 1023);
  Result := string(p);
  FreeMem(p, 1024);
  result := ExcludeTrailingPathDelimiter(Result);
end;

procedure SetPgPass(const ConProps: array of TConProps);
var
  i: Integer;
  s: String;
  ss: TStringList;
begin
  ss := TStringList.Create;
  try
    if FileExists(PGPASS_) then
      ss.LoadFromFile(PGPASS_);
    for i := 0 to Length(ConProps)-1 do
    begin
      s:='';
      s := ConProps[i].Host+':'+Inttostr(ConProps[i].Port)+':*:'+ConProps[i].User+':'+ConProps[i].Password;
      ss.Insert(0, s);
    end;
    ss.SaveToFile(PGPASS_);
  finally
    ss.Free;
  end;
end;

procedure CleanPGPass;
begin
  DeleteFile(PGPASS_);
end;

procedure BackupData;
var
  cmd: String;
  TargetFile:String;
  ConProp: TConProps;
begin
  ConProp := getConnectionProps(__GLOBAL_CONNECTION);
  TargetFile := '';
  try
    DoBackup(ConProp, TargetFile);
  finally
  end;
end;

procedure DoBackup(AConnectionProp: TConProps;
  const ATargetFile: String);
var
  cmd: String;
begin
  Application.ProcessMessages;
  CleanPGPass;
  SetPgPass([AConnectionProp]);
  cmd := '-f "'+ATargetFile+'" --format=c --compress=9 -v -b -c -O -i -x --inserts --column-inserts --disable-dollar-quoting --host='+AConnectionProp.Host+' --port='+IntToStr(AConnectionProp.Port)+' --username='+AConnectionProp.User+' "'+ AConnectionProp.Database+'"';
  try
    GetDosOutput(PGDUMP_, cmd, __GLOBAL_READPROC);
  finally

  end;
end;

procedure DoRestore(AConnectionProp: TConProps;
  const ASourceFile: String);
var
  cmd: String;
begin
  Application.ProcessMessages;
  CleanPGPass;
  SetPgPass([AConnectionProp]);
  cmd := '-c -d "'+AConnectionProp.Database+'" -v --format=c -O -1 --host='+AConnectionProp.Host+' --port='+IntToStr(AConnectionProp.Port)+' --username='+AConnectionProp.User+' "'+ ASourceFile +'"';
  //InputQuery('s','d',cmd);
  try
    GetDosOutput(PGREST_, cmd, __GLOBAL_READPROC);
  finally
  end;
end;

procedure ExecuteSQL;
var
  param: String;
  conprop: TConProps;
  q: TUniQuery;
  con: TUniConnection;
begin
  conprop := Connection;
  if UsePSQL then
  begin
    CleanPGPass;
    SetPgPass([ConProp]);
    param := '--host='+ ConProp.Host+' --port='+ IntToStr(ConProp.Port)+' --username='+ConProp.User+
             ' -d "'+ConProp.Database+'" -c "'+SQL+'"';
    try
      GetDosOutput(PSQL___, param, cbOnRead);
    finally
    end;
  end
  else
  begin
    con := BuildConnection(conprop);
    try
      con.ExecSQL(SQL);
      con.Disconnect;
    finally
      con.Free;
    end;
  end;
end;

procedure ExecuteSQLFile(const ConProp: TConProps;
  const SrcFile: String; cobOnRead: TOnCommandRead);
var
  cmd: String;
  con: TUniConnection;
begin
  CleanPGPass;
  SetPgPass([ConProp]);
  //ShowMessage(ConProp.Host);
  cmd := '-d "'+ConProp.Database+'" -f "'+SrcFile+'" --host='+
    ConProp.Host+' --port='+IntToStr(ConProp.Port)+' --username='+ConProp.User;
  try
    GetDosOutput(PSQL___, cmd, cobOnRead);
  finally
  end;
end;

function getConnectionProps;
begin
  with Connection do
  begin
    Result.Host    := Server;
    Result.User    := Username;
    Result.Password:= Password;
    Result.Port    := Port;
    Result.Database:= Database;
  end;
end;

function GetDosOutput(CommandLine, Params: string;
  cbOnDataRead: TOnCommandRead; Work: string): DWORD;
var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  Buffer: array[0..255] of AnsiChar;
  BytesRead: Cardinal;
  WorkDir: string;
  Handle: Boolean;
  Parameter: PChar;
  DataRead, tmp: String;
  i:integer;
  iexit: Cardinal;
  procedure OutLine(const AText:String);
  begin
    if Assigned(cbOnDataRead) then
      cbOnDataRead(AText);
  end;
begin
  DataRead := '';
  if not FileExists(CommandLine) then
  begin
    DataRead := 'File '+ CommandLine+ ' tidak ditemukan!';
    OutLine(DataRead);
    Application.ProcessMessages;
    Result := 0;
    exit;
  end;
  OutLine('Starting '+ CommandLine+'...'#13#10);
  with SA do begin
    nLength := SizeOf(SA);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SA, 0);
  try
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // don't redirect stdin
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;
    if not DirectoryExists(Work) then
      WorkDir := ExtractFileDir(CommandLine)
    else
      WorkDir := Work;
    //OnRead(CommandLine+#13#10);
    //OnRead(WorkDir+#13#10);
    //OnRead(Params+#13#10);
    Parameter := PChar('"'+CommandLine + '" '+Params);
    try
      Handle := CreateProcess(nil{PChar( CommandLine )}, Parameter,
                              nil, nil, True, 0, nil,
                              PChar(WorkDir), SI, PI);
      CloseHandle(StdOutPipeWrite);
      if Handle then
        try
          repeat
            FillChar(Buffer, sizeof(Buffer), 0);
            WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);
            if BytesRead > 0 then
            begin
              Buffer[BytesRead] := #0;
              DataRead := {DataRead + }Buffer;
            end;
            OutLine(DataRead);
            DataRead := '';
            Application.ProcessMessages;
            GetExitCodeProcess(pi.hProcess,iExit);
          until (not WasOK )or (BytesRead = 0);// or (iexit <> STILL_ACTIVE);
          WaitForSingleObject(pi.hProcess, INFINITE);
          if DataRead<>'' then
            OutLine(DataRead);
        finally
          CloseHandle(PI.hThread);
          CloseHandle(PI.hProcess);
        end
      else
      begin
        OutLine('Failed.');
      end;
    Except on e: exception do
      OutLine(e.Message+#13#10);
    end;
  finally
    CloseHandle(StdOutPipeRead);
  end;
end;

procedure ProcessCommand(CommandLine, Params: string);
begin
  GetDosOutput(CommandLine,Params, __GLOBAL_READPROC);
end;



procedure RestoreData;
var
  cmd: String;
  SrcFile:String;
  ConProp: TConProps;
  DataOnly: String;
begin
  ConProp := getConnectionProps(__GLOBAL_CONNECTION);
  SrcFile := '';
  try
    DoRestore(ConProp, SrcFile);
  finally
  end;
end;

function GetPGPassFile : string;
const
  SHGFP_TYPE_CURRENT = 0;
var
  path: array [0..MAX_PATH] of char;
  dirg: string;
begin
  if SUCCEEDED(SHGetFolderPath(0,CSIDL_APPDATA,0,SHGFP_TYPE_CURRENT,@path[0])) then
    Result := path +'\postgresql\pgpass.conf'
  else
    Result := '';
  dirg := ExtractFileDir(Result);
  if not DirectoryExists(dirg) then
    try ForceDirectories(dirg) except end;
end;

procedure ExtractRes(const ResName:String; const TargetFile: String);
begin
  if not FileExists(TargetFile) then
  begin
    RS := TResourceStream.Create(HInstance, PChar(ResName), RT_RCDATA);
    try
      RS.SaveToFile(TargetFile);
    finally
      RS.Free;
    end;
  end;
end;

initialization

SysPath := SysDir ();

PGDUMP_ := ExtractFileDir(ParamStr(0)) +'\dmp.exe';
PSQL___ := ExtractFileDir(ParamStr(0)) +'\sql.exe';
PGREST_ := ExtractFileDir(ParamStr(0)) +'\rst.exe';
PGPASS_ := GetPGPassFile;
CMD____ := SysPath+'\cmd.exe';

TMPPATH := ExtractFilePath(ParamStr(0))+'tmp';
if not DirectoryExists(TMPPATH) then
  ForceDirectories(TMPPATH);
{
if not FileExists(PGDUMP_) then
begin
  RS := TResourceStream.Create(HInstance, 'PGDUMP', RT_RCDATA);
  try
    RS.SaveToFile(PGDUMP_);
  finally
    RS.Free;
  end;
end;

if not FileExists(PSQL___) then
begin
  RS := TResourceStream.Create(HInstance, 'PSQL', RT_RCDATA);
  try
    RS.SaveToFile(PSQL___);
  finally
    RS.Free;
  end;
end;

if not FileExists(PGREST_) then
begin
  RS := TResourceStream.Create(HInstance, 'PGRES', RT_RCDATA);
  try
    RS.SaveToFile(PGREST_);
  finally
    RS.Free;
  end;
end;

}

{

ExtractRes(d01, SysPath+'\'+ d01n);
ExtractRes(d02, SysPath+'\'+ d02n);
ExtractRes(d03, SysPath+'\'+ d03n);
ExtractRes(d04, SysPath+'\'+ d04n);
ExtractRes(d05, SysPath+'\'+ d05n);
ExtractRes(d06, SysPath+'\'+ d06n);
ExtractRes(d07, SysPath+'\'+ d07n);
ExtractRes(d08, SysPath+'\'+ d08n);
ExtractRes(d09, SysPath+'\'+ d09n);
ExtractRes(d10, SysPath+'\'+ d10n);
ExtractRes(d11, SysPath+'\'+ d11n);
ExtractRes(d12, SysPath+'\'+ d12n);
ExtractRes(d13, SysPath+'\'+ d13n);
ExtractRes(d14, SysPath+'\'+ d14n);
}

end.
