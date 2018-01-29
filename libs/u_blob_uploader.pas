unit u_blob_uploader;

interface

uses
  WIndows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, ComCtrls, StdCtrls, ExtCtrls, ShellAPI, httpsend;

type
  TOnStartSendingFile = TProc<String,String>;
  TOnFinishSendingFile = TProc<String,Boolean, String>;

  TFormBinaryProgress = class(Tform)
  private
    _progressBar: TProgressBar;
    _Label: TLabel;
  public
    Constructor Create(Aowner: TCOmponent); override;
    Destructor Destroy; override;

  end;

function SendFile(const FileName: String;
  onStart: TOnStartSendingFile;
  onFinish: TOnFinishSendingFile): Boolean;

function DownloadFile(const RemoteFile, LocalFileName: String;
  onStart: TOnStartSendingFile;
  onFinish: TOnFinishSendingFile): Boolean; overload;

function DownloadFile(const RemoteFile: String; LocalBuffer: TStream;
  onStart: TOnStartSendingFile;
  onFinish: TOnFinishSendingFile): Boolean; overload;

function RemoteExists(const RemoteFile: String): Boolean;

function DownloadImageAsStream(const RemoteFile: String): TMemoryStream;
function DownloadImageAsTempFile(const RemoteFile: String): String;
function UploadFile(const FileName: String): String; overload;
function UploadFile(const FileData: TStream; const FileExt: String): String; overload;
function RemoteDelete(const RemoteFile: String): Boolean;
function RemotePreview(const RemoteFile: String): Boolean;
function RemoteRename(const RemoteOldName, RemoteNewName: String): Boolean;
// Upload and replace old file
function RemoteReplaceFile(const FileName, RemoteOldFile: String; const ReturnNewName: Boolean = False): String;

implementation

uses u_utils;

var
  ServerUploadURL,
  ServerDownloadURL,
  FileFieldName       : string;

function InitTransferVars: Boolean;
begin
  Result := False;
  ServerUploadURL   := GetOption( 'ServerUploadURL', true);
  ServerDownloadURL := GetOption( 'ServerDownloadURL', true);
  FileFieldName     := GetOption( 'FileFieldName', true);
  Result := (ServerUploadURL<>'')
            and
            (ServerDownloadURL<>'')
            and
            (FileFieldName<>'');
end;

function SendFile(const FileName: String;
  onStart: TOnStartSendingFile;
  onFinish: TOnFinishSendingFile): Boolean;
var
  ss: TFileStream;
  rs: TStrings;
  response: String;
begin
  Result := False;
  response := '';
  if Assigned(onStart) then
    onStart(FileName, 'Start sending file');
  if not InitTransferVars() then
  begin
    if Assigned(onFinish) then
      onFinish(FileName, False, 'Invalid Binary Transfer settings.');
    exit;
  end;
  try
    if FileExists(FileName) then
    begin
      rs := TStringList.Create;
      ss := TFileStream.Create(FileName, fmOpenRead);
      try
        ss.Position := 0;
        rs.Clear;
        Result := HttpPostFile( ServerUploadURL, FileFieldName, FileName, ss, rs);
        response := rs[0];
        Result :=  UpperCase(copy(response,1,2))='OK';
      finally
        rs.Free;
        ss.Free;
      end;
    end
    else
    begin
      if Assigned(onfinish) then
        onfinish(FileName, False, 'Start sending file');
    end
  finally
    if Assigned(onFinish) then
    begin
      if not Result then
        onFinish(FileName, Result, 'Error sending file')
      else
        onFinish(FileName, Result, copy(response,3, length(response)-2));
    end;
  end;
end;

function DownloadFile(const RemoteFile, LocalFileName: String;
  onStart: TOnStartSendingFile;
  onFinish: TOnFinishSendingFile): Boolean;
var
  ss: TMemoryStream;
  rs: TStrings;
  response: String;
begin
  Result := False;
  response := '';
  if Assigned(onStart) then
    onStart(RemoteFile, 'Start downloading file');
  if not InitTransferVars() then
  begin
    if Assigned(onFinish) then
      onFinish(RemoteFile, False, 'Invalid Binary Transfer settings.');
    exit;
  end;
  try
    ss := TMemoryStream.Create;
    try
      Result := HttpGetBinary(ServerDownloadURL+'?action=download&file='+RemoteFile, ss);
      Result := Result and (ss.Size<>0);
      if Result then
      begin
        try
          ss.SaveToFile(LocalFileName);
        except
          onFinish(RemoteFile, Result, 'Cannot save file. Maybe local file is in use');
        end;
      end;
    finally
      ss.Free;
    end;
  finally
    if Assigned(onFinish) then
    begin
      if not Result then
        onFinish(RemoteFile, Result, 'Error downloading file')
      else
        onFinish(RemoteFile, Result, LocalFileName);
    end;
  end;
end;

function DownloadFile(const RemoteFile: String; LocalBuffer: TStream;
  onStart: TOnStartSendingFile;
  onFinish: TOnFinishSendingFile): Boolean;
var
  ss: TMemoryStream;
  rs: TStrings;
  response: String;
begin
  Result := False;
  response := '';
  LocalBuffer.Position := 0;
  if Assigned(onStart) then
    onStart(RemoteFile, 'Start downloading file');
  if not InitTransferVars() then
  begin
    if Assigned(onFinish) then
      onFinish(RemoteFile, False, 'Invalid Binary Transfer settings.');
    exit;
  end;
  try
    try
      Result := HttpGetBinary(ServerDownloadURL+'?action=download&file='+RemoteFile, LocalBuffer);
      Result := Result and (LocalBuffer.Size<>0);
    except
      if Assigned(onFinish) then
        onFinish(RemoteFile, False, 'Binary Transfer failed.');
    end;
  finally
    if Assigned(onFinish) then
    begin
      if not Result then
        onFinish(RemoteFile, Result, 'Error downloading file')
      else
        onFinish(RemoteFile, Result, 'Binary Transfer finished.');
    end;
  end;

end;

function RemoteExists(const RemoteFile: String): Boolean;
var
  rs: TStrings;
begin
  Result := False;
  if not InitTransferVars() then
    exit;
  rs := TStringList.Create;
  ScreenBussy;
  try
    Result := HttpGetText( ServerDownloadURL+'?action=exists&file='+RemoteFile,rs);
    // InputBox('','',ServerDownloadURL+'?action=exists&file='+RemoteFile);
    if rs.Count>0 then
      Result := Result and (uppercase(trim(rs[0]))='EXISTS');
  finally
    ScreenIdle;
    rs.Free;
  end;
end;

function DownloadImageAsStream(const RemoteFile: String): TMemoryStream;
begin
  Result := nil;
  if not RemoteExists(RemoteFile) then
    exit;
  ScreenBussy;
  Result := TMemoryStream.Create;
  try
    if not DownloadFile(RemoteFile, Result,
    procedure(a: String; b: String)
    begin
      ScreenBussy;
    end,
    procedure(a: String; b: boolean; c: String)
    begin
      ScreenIdle;
    end) then
      FreeAndNil(Result);
  finally
    ScreenIdle;
  end;
end;

function DownloadImageAsTempFile(const RemoteFile: String): String;
var
  ss: TMemoryStream;
  rs: TStrings;
  response: String;
  b: boolean;

begin
  Result := '';
  response := '';
  if not InitTransferVars() then
    raise Exception.Create('Inisialisasi variabel Binary Transfer gagal.');
  if not RemoteExists(RemoteFile) then
    exit;
  Result := TempFile(AppPath(false)+'temp', ExtractFileExt(RemoteFile));
  if Result = '' then
    exit;
  ss := TMemoryStream.Create;
  ScreenBussy;
  try
    b := HttpGetBinary(ServerDownloadURL+'?action=download&file='+RemoteFile, ss);
    b := b and (ss.Size>0);
    if b then
    begin
      ss.SaveToFile(Result);
    end;
  finally
    ScreenIdle;
    ss.Free;
  end;
end;

function UploadFile(const FileName: String): String;
var
  ss: TFileStream;
  rs: TStrings;
  response: String;

begin
  Result := '';
  response := '';
  if not InitTransferVars() then
    raise Exception.Create('Inisialisasi variabel Binary Transfer gagal.');
  if FileExists(FileName) then
  begin
    rs := TStringList.Create;
    ss := TFileStream.Create(FileName, fmOpenRead);
    ScreenBussy;
    try
      ss.Position := 0;
      rs.Clear;
      if HttpPostFile( ServerUploadURL, FileFieldName, FileName, ss, rs) then
      begin
        // response := rs.Text;
        response := rs[0];
        if UpperCase(copy(response,1,2))='OK' then
        begin
          Result := copy(response,3,MaxInt);
          while result[length(Result)] in [#13, #10] do
            Result := Copy(Result,1,length(Result)-1);
        end;
      end;
    finally
      ScreenIdle;
      rs.Free;
      ss.Free;
    end;
  end
  else
    raise Exception.Create(FileName +' tidak ditemukan.');
end;

function UploadFile(const FileData: TStream; const FileExt: String): String;
var
  tmp: String;
  fs: TFileStream;
begin
  Result := '';
  tmp := TempFile(AppPath(false)+'temp', FileExt);
  if tmp = '' then
    exit;
  try
    FileData.Position := 0;
    fs := TFileStream.Create(tmp, fmCreate);
    fs.CopyFrom(FileData, FileData.Size);
    fs.free;
    Result := UploadFile(tmp);
    if FileExists(tmp) then
      DeleteFile(tmp);
  except
    raise;
  end;
end;

function RemoteDelete(const RemoteFile: String): Boolean;
var
  rs: TStrings;

begin
  Result := False;
  if not InitTransferVars() then
    exit;
  rs := TStringList.Create;
  ScreenBussy;
  try
    Result := HttpGetText( ServerDownloadURL+'?action=delete&file='+RemoteFile,rs);
    Result := Result and (uppercase(trim(rs[0]))='REMOVED');
  finally
    ScreenIdle;
    rs.free;
  end;
end;

{ TFormBinaryProgress }

constructor TFormBinaryProgress.Create(Aowner: TCOmponent);
begin
  inherited Create(Aowner);
  FormStyle := fsStayOnTop;
  BorderStyle := bsToolWindow;
  Width := 300;
  Height:= 64;
  Position := poDesktopCenter;
  _progressBar := TProgressBar.Create(self);
  with _progressBar do
  begin
    Parent := self;
    Align := alTop;
    Min := 0;
    Max := 100;
    AlignWithMargins := true;
    Visible := true;
    Style:= pbstMarquee;
  end;
  _Label := TLabel.Create(self);
  with _progressBar do
  begin
    Parent := self;
    Align := alBottom;
    AlignWithMargins := true;
    Height := 20;
    Caption := 'Transfering Data...';
    Visible := true;
  end;

end;

destructor TFormBinaryProgress.Destroy;
begin
  _progressBar.Free;
  _Label.Free;
  inherited Destroy;
end;

function RemotePreview(const RemoteFile: String): Boolean;
var
  s: String;
begin
  Result := False;
  s := DownloadImageAsTempFile(RemoteFile);
  if not FileExists(s) then
    Warn('File tidak ditemukan!'#13'Pastikan server sedang berjalan.')
  else
  begin
    Result := 32 < ShellExecute(Application.Handle, 'open', PChar(s), '', PChar(ExtractFileDir(s)), SW_SHOWNORMAL);
  end;
end;

function RemoteRename(const RemoteOldName, RemoteNewName: String): Boolean;
var
  rs: TStrings;
begin
  Result := False;
  if not InitTransferVars() then
    exit;
  rs := TStringList.Create;
  ScreenBussy;
  try
    Result := HttpGetText( ServerDownloadURL+'?action=rename&file1='+RemoteOldName+'&file2='+RemoteNewName,rs);
    Result := Result and (uppercase(trim(rs[0]))='RENAMED');
  finally
    ScreenIdle;
    rs.free;
  end;

end;

function RemoteReplaceFile(const FileName, RemoteOldFile: String; const ReturnNewName: Boolean = False): String;
var
  t: String;
begin
  Result := '';
  if RemoteDelete(RemoteOldFile) then
  begin
    t := UploadFile(FileName);
    if ReturnNewName then
      Result := t
    else
    begin
      if RemoteRename(t, RemoteOldFile) then
        Result := RemoteOldFile;
    end;
  end;
end;


end.
