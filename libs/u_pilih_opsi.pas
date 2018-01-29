unit u_pilih_opsi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, u_utils;

type
  TFPilihBulan = class(TForm)
    clBulan: TCheckListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure clBulanClickCheck(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    _MS: Boolean;
    function AllSelected: Boolean;
    function NoneSelected: Boolean;
  public
    { Public declarations }
  end;

var
  FPilihBulan: TFPilihBulan;

{
  Index starts from 1, not 0.
  You can decrement the returned indexes later
  for usage with zero-based index.
}
function PilihData(ACaption: String; var ListData: TStringList; const ReturnIndex: Boolean = False; const AMultiSelect: Boolean = False; DefaultIndex:  integer = -1): Boolean; overload;
//return -1 for invalid index:
function PilihData(ACaption: String; const ListData: array of string; DefaultIndex: Integer = -1): integer; overload;

// accept input as pair name=boolean i.e. Approved=True and return same format
function PilihDataAsNameBooleanPairs(ACaption: String; var ListData: TStringList): Boolean; overload;

implementation

{$R *.dfm}

function PilihData(ACaption: String; var ListData: TStringList; const ReturnIndex: Boolean = False; const AMultiSelect: Boolean = False; DefaultIndex: integer = -1): Boolean; overload;
var
  i: integer;
begin
  Result := False;
  with TFPilihBulan.Create(Application) do
  begin
    try
      Caption := ACaption;
      _MS := AMultiSelect;
      Button1.Visible := _MS;
      Button4.Visible := _MS;
      clBulan.Items.Clear;
      clBulan.Items.AddStrings(TStrings(listData));
      if (DefaultIndex > 0) and (DefaultIndex <= clBulan.Items.Count) then
        clBulan.Selected[DefaultIndex-1] := True;
      Result := ShowModal = mrOk;
      if Result then
      begin
        ListData.Clear;
        for i := 0 to clBulan.Items.Count-1 do
        begin
          if clBulan.Checked[i] then
            if ReturnIndex then
              ListData.Add(_s(i+1))
            else
              ListData.Add(clBulan.Items[i]);
        end;
      end;
    finally
      Free;
    end;
  end;
end;

function PilihDataAsNameBooleanPairs(ACaption: String; var ListData: TStringList): Boolean; overload;
var
  i: integer;
begin
  Result := False;
  with TFPilihBulan.Create(Application) do
  begin
    try
      Caption := ACaption;
      _MS := true;
      Button1.Visible := _MS;
      Button4.Visible := _MS;
      clBulan.Items.Clear;
      for i := 0 to listData.Count-1 do
      begin
        clBulan.Items.Add(ListData.Names[i]);
        clBulan.Checked[i] := StrToBoolDef(ListData.ValueFromIndex[i], false);
      end;
      Result := ShowModal = mrOk;
      if Result then
      begin
        ListData.Clear;
        for i := 0 to clBulan.Items.Count-1 do
        begin
          ListData.add(clBulan.Items[i]+'='+BoolToStr(clBulan.Checked[i], true));
        end;
      end;
    finally
      Free;
    end;
  end;
end;

function PilihData(ACaption: String; const ListData: array of string; DefaultIndex: Integer = -1): integer; overload;
var
  ss: TStringList;
  i: Integer;
begin
  Result := -1;
  ss := TStringList.Create;
  try
    if Length(ListData) > 0 then
    begin
      for i:= 0 to length(ListData)-1 do
      begin
        ss.Add(ListData[i]);
      end;
    end;
    if PilihData(ACaption, ss, True, False, DefaultIndex) then
      if ss.Count> 0 then
        Result := _i(ss[0]);
  finally
    ss.Free;
  end;
end;

function TFPilihBulan.AllSelected: Boolean;
var
  x,i: integer;
begin
  x := 0;
  for i:= 0 to clBulan.Items.Count -1 do
  begin
    if clBulan.Selected[i] then
      inc(x);
  end;
  Result := x = clBulan.Items.Count;
end;

procedure TFPilihBulan.Button1Click(Sender: TObject);
var
  i: integer;
begin
  if not _MS then
    exit;
  for i:= 0 to clBulan.Items.Count-1 do
    clBulan.Checked[i] := True;
end;

procedure TFPilihBulan.Button4Click(Sender: TObject);
var
  i: integer;
begin
  if not _MS then
    exit;
  for i:= 0 to clBulan.Items.Count-1 do
    clBulan.Checked[i] := False;
end;

procedure TFPilihBulan.clBulanClickCheck(Sender: TObject);
var
  i,x: integer;
begin
  if not _MS then
  begin
    x := clBulan.ItemIndex;
    for i:= 0 to clBulan.Items.Count-1 do
      clBulan.Checked[i] := False;
    clBulan.Checked[x]   := True;
  end;
  Button1.Enabled := (not AllSelected) and _MS;
  Button4.Enabled := (not NoneSelected) and _MS;
end;

function TFPilihBulan.NoneSelected;
var
  x,i: integer;
begin
  x := 0;
  for i:= 0 to clBulan.Items.Count -1 do
  begin
    if clBulan.Selected[i] then
      inc(x);
  end;
  Result := x = 0;
end;

end.
