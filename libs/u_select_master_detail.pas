unit u_select_master_detail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  DynVarsEh, GridsEh, DBAxisGridsEh, DBGridEh, MemTableDataEh, Db, MemDS,
  DBAccess, Uni, MemTableEh, umain, u_utils, StdCtrls, Grids, DBGrids, EhLibVCL;

type
  TFSelectMasterDetail = class(TForm)
    Panel2: TPanel;
    Bevel2: TBevel;
    gep: TDBGridEh;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    UniQuery1: TUniQuery;
    Button2: TButton;
    Button3: TButton;
    MemTableEh1pkode: TStringField;
    MemTableEh1kode: TMemoField;
    MemTableEh1vkode: TStringField;
    MemTableEh1uraian: TStringField;
    MemTableEh1jumlah: TFloatField;
    MemTableEh1tipe: TIntegerField;
    DataSource2: TDataSource;
    procedure gepAdvDrawDataCell(Sender: TCustomDBGridEh; Cell,
      AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
      var Params: TColCellParamsEh; var Processed: Boolean);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure gepDblClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure gepKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    _allowSelectParent : boolean;
    _childLevel: Integer;
    _master, _detail: String;
  public
    { Public declarations }
  end;

function SelectMasterDetail(
  Connection: TUniConnection;
  const ASQL : String;
  const Fields: array of string;
  const MasterField, DetailField: String;
  const ChildLevel: Integer;
  const Captions      : array of string;
  const ColWidths: array of integer;
  const AllowSelectParent: Boolean = false;
  const W: Integer = 0;
  const H: integer = 0;
  const AFormCaption: String = ''
): TStringList; overload;

implementation


{$R *.dfm}

function SelectMasterDetail(
  Connection: TUniConnection;
  const ASQL : String;
  const Fields: array of string;
  const MasterField, DetailField: String;
  const ChildLevel: Integer;
  const Captions      : array of string;
  const ColWidths: array of integer;
  const AllowSelectParent: Boolean = false;
  const W: Integer = 0;
  const H: integer = 0;
  const AFormCaption: String = ''
): TStringList; overload;
var
  i, x: integer;
  umt: Boolean;
  function findInArray(arr: array of string; val: string): integer;
  var
    arid: integer;
  begin
    Result := -1;
    for arid := 0 to Length(arr) -1 do
    begin
      if _l(arr[arid]) = _l(val) then
      begin
        Result := arid;
        break;
      end;
    end;
  end;
begin

  Result := TStringList.Create;
  with TFSelectMasterDetail.Create(Application) do
  begin
    try
      _allowSelectParent := AllowSelectParent;
      _childLevel := ChildLevel;
      _master := MasterField;
      _detail := DetailField;
      umt := False;
      Tag := mrNone;
      UniQuery1.Connection := Connection;
      if UniQuery1.Active then
        UniQuery1.Close;
      gep.ReadOnly := True;
      gep.Options := gep.Options - [DBGridEh.TDBGridOption.dgMultiSelect];
      if gep.Columns.Count > 0 then
        gep.Columns.Clear;
      if MemTableEh1.Active then
        MemTableEh1.Close;
      MemTableEh1.Fields.Clear;

      Width := _IIF(W = 0, 500, W);
      Height := _IIF(H = 0, 300, H);
      UniQuery1.SQL.Text := ASQL;
      // ShowText(ASQL);
      UniQuery1.Open;
      {
      for i:= gep.Columns.Count- 1 downto 0 do
      begin
        x := findInArray(Fields, gep.Columns[i].FieldName);
        if x = -1 then
        begin
          showmessage(gep.Columns[i].FieldName+' deleted');
          gep.Columns[i].width := 0;
        end
        else
        begin
          with gep.Columns[i] do
          begin
            showmessage(gep.Columns[i].FieldName+' added');
            Title.Caption := Captions[x];
            Width := ColWidths[x];
            if Field.DataType in [ftFloat, ftCurrency] then
                DisplayFormat := FORMAT_FINANCE;
          end;
          umt := umt or (pos('|', Captions[x])>0);
        end;
      end;
      }
      gep.Columns.Clear;
      with gep.Columns.Add do
      begin
        FieldName := MasterField; Title.Caption := ' [+] '; Width := 100;
        MaxWidth := 100;
        MinWidth := 50;
      end;
      for i := 0 to Length(Fields)-1 do
      begin
        with gep.Columns.Add do
        begin
          Title.Caption := Captions[i];
          Width := ColWidths[i];
          Field:= UniQuery1.FieldByName( Fields[i] );
          if Field.DataType in [ftFloat, ftCurrency] then
            DisplayFormat := FORMAT_FINANCE;
        end;

        umt := umt or (pos('|', Captions[i])>0);
      end;
      MemTableEh1.LoadFromDataSet(UniQuery1, -1, lmCopy, false);
      MemTableEh1.TreeList.RefParentFieldName := MasterField;
      MemTableEh1.TreeList.KeyFieldName := DetailField;
      MemTableEh1.TreeList.Active := true;
      gep.UseMultiTitle := umt;
      Caption := _IIF(AFormCaption<>'', AFormCaption, 'Pilih Data');
      // ShowMessage(gep.DataSource.DataSet.Name);
      ShowModal;
      if Tag = mrOk then
      begin
        result.Clear;
        if not MemTableEh1.IsEmpty then
        begin
          for I := 0 to Length(Fields)-1 do
          begin
            // result.Add ( MyQuery1.FieldByName(Fields[i]).AsString ) ;
            if MemTableEh1.FieldByName(Fields[i]).DataType in [ftFloat, ftCurrency] then
              result.Add ( FloatToSql(MemTableEh1.FieldByName(Fields[i]).AsFloat))
            else
              result.Add ( MemTableEh1.FieldByName(Fields[i]).AsString ) ;
          end;
        end;
      end;
    finally
      Free;
    end;
  end;

end;

procedure TFSelectMasterDetail.Button2Click(Sender: TObject);
begin
  if not _allowSelectParent then
  begin
    // MemTableEh1.FieldByName()
    if MemTableEh1.TreeNodeLevel<>_childLevel then
    begin
      Warn('Pilih data/rekening anak (Level '+_s(_childLevel)+') saja.'#13'* Diberi warna hijau.');
      exit;
    end;
  end;
  Tag := mrOk;
  Close;
end;

procedure TFSelectMasterDetail.Button3Click(Sender: TObject);
begin
  Tag := mrCancel;
  Close;
end;

procedure TFSelectMasterDetail.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key <> VK_F3 then
    exit;
  key := 0;
  SendCtrlF;
end;

procedure TFSelectMasterDetail.gepAdvDrawDataCell(Sender: TCustomDBGridEh; Cell,
  AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
  var Params: TColCellParamsEh; var Processed: Boolean);
var
  mt: TMemTableEh;
begin
  mt := TMemTableEh(sender.DataSource.DataSet);
  if (_l(Column.FieldName) = _l(_master)) or (_l(Column.FieldName) = _l(_detail)) then
  begin
    // Params.BlankCell := true;
    Params.Text := '........';
  end
  ;
  if Column.Index = (Sender.Columns.Count-1) then
  begin
    // Params.BlankCell := true;
    Params.Text := LPad('', (mt.TreeNodeLevel-1)*4, ' ')+Params.Text;
  end;
  if mt.TreeNodeLevel = _childLevel then
    Params.Font.Color := clGreen;

end;

procedure TFSelectMasterDetail.gepDblClick(Sender: TObject);
begin
  Button2.Click;
end;

procedure TFSelectMasterDetail.gepKeyDown(Sender: TObject; var Key: Word;
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
    if MemTableEh1.Bof then
      SendCtrlF;
  end
  else
  if Key = VK_Down then
  begin
    if MemTableEh1.Eof then
      SendCtrlF;
  end;
end;

end.
