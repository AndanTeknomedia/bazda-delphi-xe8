unit u_frutils;

interface

uses  Windows, SysUtils, frxClass, Classes;

//This function was created by JokoRB (http://jokorb.wordpress.com) as
//an helper for obtaining object from inside a fastreport object:
function FRObject(FastReport: TfrxReport; const ObjectName:String): TObject;
function FRMemo( FastReport: TfrxReport; const ObjectName:String): TfrxMemoView;
function FRPicture( FastReport: TfrxReport; const ObjectName:String): TfrxPictureView;
procedure FrReplace(FastReport: TfrxReport; aFindReplace: TStringList);


implementation

function FRMemo;
begin
  Result := TfrxMemoView( FRObject(FastReport, ObjectName) );
end;

function FRPicture;
begin
  Result := TfrxPictureView( FRObject(FastReport, ObjectName) );
end;

procedure FrReplace;
var
  i, j: Integer;
  t: String;
  f: TfrxMemoView;
begin
  for I := 0 to FastReport.ComponentCount - 1 do
  begin
    if FastReport.Components[i] is TfrxMemoView then
    begin
      f := TfrxMemoView(FastReport.Components[i]);
      t := f.Text;
      for j := 0 to aFindReplace.count-1 do
      begin
        t := stringreplace(t, aFindReplace.Names[j], aFindReplace.ValueFromIndex[j], [rfReplaceAll, rfIgnoreCase]);
      end;
      f.Text := t;
    end;
  end;
end;

function FRObject;
var
  i: Integer;
  AFound: Boolean;
begin
  AFound:=False;
  for I := 0 to FastReport.ComponentCount - 1 do
  begin
    if LowerCase(FastReport.Components[i].Name) = LowerCase(ObjectName) then
    begin
      Result:=TObject(FastReport.Components[i]);
      AFound:=True;
      Break;
    end;
  end;
  if not AFound then
  begin
    Result:=nil;
  end;
end;

end.
