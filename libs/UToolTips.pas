unit UToolTips;
{
by Reev Prajna



}

interface
uses
  windows, Messages, commctrl;

const
 TTS_BALLOON    = $40;
 TTM_SETTITLE = (WM_USER + 32);
 ICONTYPE_NONE = 0;
 ICONTYPE_INFORMATION   =1;
 ICONTYPE_WARNING =2;
 ICONTYPE_ERROR =3;

function ShowToolTip(const handle:HWND; const prevTooltipHandle:Cardinal; const text, title:String; const IconType:Integer ):Cardinal;

implementation

function CreateToolTips(hWnd: Cardinal; var ti:TToolInfo):Cardinal;
begin
 result:=CreateWindowEx(0, 'Tooltips_Class32', nil, TTS_ALWAYSTIP or TTS_BALLOON,
   Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT),Integer(CW_USEDEFAULT),
   Integer(CW_USEDEFAULT), hWnd, 0, hInstance, nil);
 if result <> 0 then
 begin
   SetWindowPos(result, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or
     SWP_NOSIZE or SWP_NOACTIVATE);
   ti.cbSize := SizeOf(TToolInfo);
   ti.uFlags := TTF_SUBCLASS;
   ti.hInst := hInstance;
 end;
end;

procedure AddToolTip(hwnd: dword; tipHandle:Cardinal; lpti: PToolInfo; IconType: Integer; Text, Title: PChar);
var
 Item: THandle;
 Rect: TRect;
 IType:Integer;
 buffer : array[0..255] of char;
 t1,t2:string;
begin
 t1:=text;
 t2:=title;
 if t1='' then t1:='No tip specified.';
 if t2='' then t2:='Untitled';
 Item := hWnd;
 Case icontype of
   MB_ICONINFORMATION : IType:=ICONTYPE_INFORMATION;
   MB_ICONHAND        : IType:=ICONTYPE_ERROR;
   MB_ICONWARNING     : IType:=ICONTYPE_WARNING;
   else                 IType:=ICONTYPE_NONE;
 end;
 if (Item <> 0) AND (GetClientRect(Item, Rect)) then
 begin
   lpti.hwnd := Item;
   lpti.Rect := Rect;
   lpti.lpszText := pchar(t1);
   SendMessage(tipHandle, TTM_ADDTOOL, 0, Integer(lpti));
   FillChar(buffer, sizeof(buffer), #0);
   lstrcpy(buffer, pchar(t2));
   SendMessage(tipHandle, TTM_SETTITLE, IType, Integer(@buffer));
 end;
end;

function ShowToolTip(const handle:HWND; const prevTooltipHandle:Cardinal; const text, title:String; const IconType:Integer ):Cardinal;
var
 hTooltip: Cardinal;
 ti: TToolInfo;
begin
 DestroyWindow(prevTooltipHandle);
 hToolTip:=CreateToolTips(Handle, ti);
 Result:=hToolTip;
 AddToolTip(Handle, hToolTip, @ti, IconType, pchar(text), pchar(Title));
end;


end.

