unit u_select_kode_name;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, StdCtrls, ExtCtrls,
  DBGridEhGrouping, GridsEh, DBGridEh, Menus, ActnList,
  PlatformDefaultStyleActnCtrls, ActnMan,  u_utils, u_dbgrideh_dac_helper,
  Mask, DBCtrls, VirtualTable, ToolCtrlsEh, DBGridEhToolCtrls, DBAxisGridsEh,
  DynVarsEh, Uni, MemTableDataEh, MemTableEh, JvExControls, JvInspector,
  EhLibVCL;

type
  TAOS = array of string;
  TEditProc = TProc;
  TFSelectKodeName = class(TForm)
    MyQuery1: TUniQuery;
    gep: TDBGridEh;
    Panel3: TPanel;
    Button2: TButton;
    Button3: TButton;
    MyDataSource1: TDataSource;
    PopupMenu1: TPopupMenu;
    Find1: TMenuItem;
    Edit1: TMenuItem;
    Button1: TButton;
    mt: TMemTableEh;
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure gepDblClick(Sender: TObject);
    procedure gepKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Find1Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
  private
    { Private declarations }
    _EditProc: TEditProc;
  public
    { Public declarations }
  end;

var
  FSelectKodeName: TFSelectKodeName;


function SelectKodeName(
  Connection: TUniConnection;
  const ASQL : String;
  const DisplayFields: array of string;
  const Captions      : array of string;
  // const AFilterFields: array of string;
  const ReturnFields: array of string;
  const ColWidths: array of integer;
  var   results : TStringList;
  const W: Integer = 0;
  const H: integer = 0;
  const AFormCaption: String = '';
  const EditAction: TEditProc = nil;
  const EditCaption: String = 'Lanjutan...'
): Boolean; overload;

// Newest:
function SelectKodeName(
  Connection: TUniConnection;
  const ASQL : String;
  const Fields: array of string;
  const Captions      : array of string;
  const ColWidths: array of integer;
  const W: Integer = 0;
  const H: integer = 0;
  const AFormCaption: String = '';
  const EditAction: TEditProc = nil;
  const EditCaption: String = 'Lanjutan...'
): TStringList; overload;



implementation

uses u_display_text;

{$R *.dfm}

function StripUntilDot(const a:String): String;
var
  p: Integer;
begin
  Result := a;
  while pos('.',Result)>0 do
    delete(Result,1,1);
end;


function SelectKodeName(
  Connection: TUniConnection;
  const ASQL : String;
  const DisplayFields: array of string;
  const Captions      : array of string;
  // const AFilterFields: array of string;
  const ReturnFields: array of string;
  const ColWidths: array of integer;
  var   results : TStringList;
  const W: Integer = 0;
  const H: integer = 0;
  const AFormCaption: String = '';
  const EditAction: TEditProc = nil;
  const EditCaption: String = 'Lanjutan...'
): Boolean;
var
  i: integer;
  umt: Boolean;
begin
  Result := False;

  with TFSelectKodeName.Create(Application) do
  begin
    try
      _EditProc := EditAction;
      Button1.Caption := 'F2 - '+EditCaption;
      Button1.Enabled := Assigned(_EditProc);
      umt := False;
      Tag := mrNone;
      MyQuery1.Connection := Connection;
      if MyQuery1.Active then
        MyQuery1.Close;


      Width := _IIF(W = 0, 500, W);
      Height := _IIF(H = 0, 300, H);
      MyQuery1.SQL.Text := ASQL;
      //ShowText(ASQL);
      MyQuery1.Open;
      if gep.Columns.Count > 0 then
        gep.Columns.Clear;
      gep.ReadOnly := True;
      gep.Options := gep.Options - [dgMultiSelect];
      for i:= 0 to Length(DisplayFields) -1 do
      begin
        with gep.Columns do
        begin
          with Add do
          begin
            FieldName := DisplayFields[i];
            Title.Caption := Captions[i];
            umt := umt or (pos('|', Captions[i])>0);
            Title.TitleButton := True;

            Width := ColWidths[i];
            if Field.DataType in [ftFloat, ftCurrency] then
              DisplayFormat := FORMAT_FINANCE;
          end;
        end;
      end;
      gep.UseMultiTitle := umt;

      Caption := _IIF(AFormCaption<>'', AFormCaption, 'Pilih Data');

      ShowModal;
      {
      if length(FilterFields)>0 then
        SetLength(FilterFields, 0);
      }
      if Tag = mrOk then
      begin
        results.Clear;
        if not MyQuery1.IsEmpty then
        begin
          for I := 0 to Length(ReturnFields)-1 do
          begin
            //ShowMessage(returnFields[i]);
            if MyQuery1.FieldByName(returnFields[i]).DataType in [ftFloat, ftCurrency] then
              results.Add ( FloatToSql(MyQuery1.FieldByName(returnFields[i]).AsFloat))
            else
              results.Add ( MyQuery1.FieldByName(returnFields[i]).AsString ) ;
          end;
          Result := True;
        end;
      end;
    finally
      Free;
    end;
  end;
end;

function SelectKodeName(
  Connection: TUniConnection;
  const ASQL : String;
  const Fields: array of string;
  const Captions      : array of string;
  const ColWidths: array of integer;
  const W: Integer = 0;
  const H: integer = 0;
  const AFormCaption: String = '';
  const EditAction: TEditProc = nil;
  const EditCaption: String = 'Lanjutan...'
): TStringList; overload;
var
  i: integer;
  umt: Boolean;
begin
  Result := TStringList.Create;
  with TFSelectKodeName.Create(Application) do
  begin
    try
      _EditProc := EditAction;
      Button1.Caption := 'F2 - '+EditCaption;
      Button1.Enabled := Assigned(_EditProc);
      umt := False;
      Tag := mrNone;
      MyQuery1.Connection := Connection;
      if MyQuery1.Active then
        MyQuery1.Close;
      Width := _IIF(W = 0, 500, W);
      Height := _IIF(H = 0, 300, H);
      MyQuery1.SQL.Text := ASQL;
      MyQuery1.Open;
      if gep.Columns.Count > 0 then
        gep.Columns.Clear;
      gep.ReadOnly := True;
      gep.Options := gep.Options - [dgMultiSelect];
      for i:= 0 to Length(Fields) -1 do
      begin
        with gep.Columns do
        begin
          with Add do
          begin
            FieldName := Fields[i];
            Title.Caption := Captions[i];
            umt := umt or (pos('|', Captions[i])>0);
            Title.TitleButton := True;

            Width := ColWidths[i];
            if Field.DataType in [ftFloat, ftCurrency] then
            begin
              DisplayFormat := FORMAT_FINANCE;
              Alignment:= taRightJustify;
            end
            else
            if Field.DataType in [ftDate] then
              DisplayFormat := 'dd/MM/yyyy'
            else
            if Field.DataType in [ftDateTime] then
              DisplayFormat := 'dd/MM/yyyy hh:n:ss'
            else
            if Field.DataType in [ftInteger, ftLargeint, ftWord] then
              Alignment:= taRightJustify;
          end;
        end;
      end;
      gep.UseMultiTitle := umt;
      Caption := _IIF(AFormCaption<>'', AFormCaption, 'Pilih Data');
      ShowModal;
      if Tag = mrOk then
      begin
        result.Clear;
        if not MyQuery1.IsEmpty then
        begin
          for I := 0 to Length(Fields)-1 do
          begin
            // result.Add ( MyQuery1.FieldByName(Fields[i]).AsString ) ;
            if MyQuery1.FieldByName(Fields[i]).DataType in [ftFloat, ftCurrency] then
              result.Add ( FloatToSql(MyQuery1.FieldByName(Fields[i]).AsFloat))
            else
            if MyQuery1.FieldByName(Fields[i]).DataType in [ftDate] then
              result.Add ( DateToSQL (MyQuery1.FieldByName(Fields[i]).AsDateTime))
            else
            if MyQuery1.FieldByName(Fields[i]).DataType in [ftTime] then
              result.Add ( TimeToSQL(MyQuery1.FieldByName(Fields[i]).AsDateTime))
            else
            if MyQuery1.FieldByName(Fields[i]).DataType in [ftDateTime] then
              result.Add ( DateTimeToSQL(MyQuery1.FieldByName(Fields[i]).AsDateTime))
            else
              result.Add ( MyQuery1.FieldByName(Fields[i]).AsString ) ;
          end;
        end;
      end;
    finally
      Free;
    end;
  end;

end;



procedure TFSelectKodeName.Button1Click(Sender: TObject);
begin
  if Assigned(_EditProc) then
  begin
    _EditProc();
    MyQuery1.Refresh;
  end;
end;

procedure TFSelectKodeName.Button2Click(Sender: TObject);
begin
  Tag := mrOk;
  Close;
end;

procedure TFSelectKodeName.Button3Click(Sender: TObject);
begin
  Tag := mrCancel;
  Close;
end;

procedure TFSelectKodeName.Edit1Click(Sender: TObject);
begin
  Button1.Click;
end;

procedure TFSelectKodeName.Find1Click(Sender: TObject);
begin
  SendCtrlF;
end;

procedure TFSelectKodeName.FormActivate(Sender: TObject);
begin
  SendCtrlF;
end;

procedure TFSelectKodeName.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key <> VK_F3 then
    exit;
  key := 0;
  SendCtrlF;
end;

procedure TFSelectKodeName.gepDblClick(Sender: TObject);
begin
  Button2.Click;
end;

procedure TFSelectKodeName.gepKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
  begin
    Button2.Click;
    exit;
  end
  else
  if chr(key) in ['a'..'z','A'..'Z','0'..'9'] then
  begin
    SendCtrlF;
  end
  else
  if Key = VK_UP then
  begin
    if MyQuery1.Bof then
      SendCtrlF;
  end
  else
  if Key = VK_Down then
  begin
    if MyQuery1.Eof then
      SendCtrlF;
  end;
end;

end.
