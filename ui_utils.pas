unit ui_utils;

interface

uses
  Windows, sysutils, classes, graphics, extCtrls, Forms, menus, ActnList;

type
  TFadeDirection = (fdIn, fdOut);

function  LoadAsBitmap(const FileName:String): TBitmap;
procedure FadeBitmap(const BMP:TImage; Pause:integer; Direction: TFadeDirection) ;

implementation

function LoadAsBitmap;
var
  p: TPicture;
begin
  Result := TBitmap.Create;
  if FileExists(FileName) then
  begin
    p := TPicture.Create;
    try
      p.LoadFromFile(FileName);
      Result.Assign(p.Graphic);
      Result.PixelFormat := pf24bit;
    finally
      p.Free;
    end;
  end;
end;

procedure FadeBitmap;
var
BytesPorScan : integer;
w,h : integer;
p : pByteArray;
counter : integer;

begin
  {This only works with 24 or 32 bits bitmaps}
  If Not (BMP.Picture.Bitmap.PixelFormat
          in [pf24Bit, pf32Bit])
   then raise exception.create
      ('Error, bitmap format not supported.') ;

  try
   BytesPorScan:=
    Abs(Integer(BMP.Picture.Bitmap.ScanLine[1])-
        Integer(BMP.Picture.Bitmap.ScanLine[0])) ;
  except
    raise exception.create('Error') ;
  end;

  {Decrease the RGB for each single pixel}
  if Direction = fdOut then
  begin
    for counter:=1 to 256 do
    begin
      for h:=0 to BMP.Picture.Bitmap.Height-1 do
      begin
        P:=BMP.Picture.Bitmap.ScanLine[h];
        for w:=0 to BytesPorScan-1 do
          if P^[w] >0 then P^[w]:=P^[w]-1;
        Application.processMessages;
      end;
      Sleep(Pause) ;
      BMP.Refresh;
    end;
  end
  else
  begin

  end;
end; {procedure FadeOut}

end.
