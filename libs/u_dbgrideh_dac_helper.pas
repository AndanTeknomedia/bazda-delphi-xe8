unit u_dbgrideh_dac_helper;

{$DEFINE UNI_DAC}
//or
// {$DEFINE MY_DAC}
{$DEFINE MEM_TABLE_EH}

interface

uses
  windows, sysutils, classes, DB, DBAccess, MemDS, MemTableEh, menus, Dialogs
  {$IFDEF UNI_DAC}
  , uni
  {$ENDIF}
  {$IFDEF MY_DAC}
  , MyAccess
  {$ENDIF}
  //DBGrid Eh Reuired units:
  , GridsEh, DBGridEh, SearchPanelsEh, DBGridEhToolCtrls, ToolCtrlsEh, EhLibVCL, TypInfo,forms, controls, u_utils;


const
  ___GEH_TABLE_FILTERS = 'geh_table_filters';
  ___GEH_TABLE_SEARCHES = 'geh_table_searches';
  ___GEH_TABLE_BOOKMARKS = 'geh_table_bookmarks';

type
  TDBGridEhNavigatorPanel = class;
  TDBGridEh = class;
  TProcOnKeyDown = TProc<TDBGridEh,Word,TShiftState>;
  TDBGridEh = class(DBGridEh.TDBGridEh)
  private
    FUtilityQuery: {$IFDEF UNI_DAC} TUniQUery {$ELSE} TMyQuery {$ENDIF}  ;
    FPopupMenu: TPopupMenu;
    FAlreadyPainted: Boolean;
    function FShowSearcher: Boolean;
    procedure SetShowSearcher(const Value: Boolean);
  protected
    procedure ___MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ___SetFrozenCols(ATitle: TDBGridColumnEh; AFrozen: Boolean);
    procedure ___AttachTitleDefaultMenu;
    procedure ___DettachTitleDefaultMenu;
    procedure ___MenuClick(Sender: TObject);
  public
    KeyDownProc: TProcOnKeyDown;
    procedure Paint; override;
    procedure _OnSortMarkerChanged(Sender: TObject);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure DateColumnsFieldOnSetText(Sender: TField; const Text: string);
    function  ColumnByField(AFieldName: String): TColumnEh;
    procedure UpdateFieldsAndEditors;
    Constructor Create(AOwner: TComponent); override;
    Destructor  Destroy; override;

    procedure SaveLayout(const AFile: String = '');
    procedure LoadLayOut(const AFile: String = '');
    // for saving bookmarks, filters and searches:
    function SaveBookmarkAs(const AName: String): Boolean;
    function SaveFilterAs(const AName: String): Boolean;
    function SaveSearchAs(const AName: String): Boolean;
    function LoadNamedBookmark(const AName: String): Boolean;
    function LoadNamedFilter(const AName: String): Boolean;
    function LoadNamedSearch(const AName: String): Boolean;
    procedure ExportAsCSV(const FileName: String; const Titles: Boolean = True; const Overwrite: boolean = False);
    procedure ExportAsRTF(const FileName: String; const Titles: Boolean = True; const Overwrite: boolean = False);
    procedure ExportAsXLS(const FileName: String; const Titles: Boolean = True; const Overwrite: boolean = False);
  published
    property UtilityQuery: {$IFDEF UNI_DAC} TUniQUery {$ELSE} TMyQuery {$ENDIF} read FUtilityQuery write FUtilityQuery;
    property ShowSearcher: Boolean read FShowSearcher write SetShowSearcher;

  end;

  TDBGridEhNavigatorPanel = class(DBGridEhToolCtrls.TDBGridEhNavigatorPanel)
  public
    (*
    function GetSelectionInfoPanelText: String;
    *)
  end;

  procedure EnrichDBGridEh(Grid: TDBGridEh;
    Options: TDBGridOptions;
    OptionsEh: TDBGridEhOptions;
    IndicatorOptions: TDBGridEhIndicatorOptions);

implementation

type
  TCustomDBGridEhCrack = class(TCustomDBGridEh);

{ TDBGridEh }

{
EnrichDBGridEh(GeBeli,
    gebeli.Options + [dgMultiSelect] - [dgTitles],
    GeBeli.OptionsEh + [dghHotTrack],
    GeBeli.IndicatorOptions + [gioShowRowselCheckboxesEh]
    );
}


procedure EnrichDBGridEh;
begin
  Grid.Options := Options;
  Grid.OptionsEh := OptionsEh;
  Grid.IndicatorOptions := IndicatorOptions;
end;

function TDBGridEh.ColumnByField(AFieldName: String): TColumnEh;
var
  i: integer;
begin
  Result := nil;
  for i:= 0 to self.Columns.Count-1 do
    if LowerCase(Self.Columns[i].FieldName) = LowerCase(AFieldName) then
      Result := Self.Columns[i];
end;

constructor TDBGridEh.Create(AOwner: TComponent);
var
  opEh: TDBGridEhOptions;
  op  : TDBGridOptions;
  optEh,
  i: integer;
  s: String;
begin
  inherited Create(AOwner);
  FAlreadyPainted := false;
  OnSortMarkingChanged := _OnSortMarkerChanged;

  self.HorzScrollBar.ExtraPanel.Visible := True;
  self.OnMouseDown := ___MouseDown;
  opEh := self.OptionsEh;
  Exclude(opEh, dghColumnMove);
  self.OptionsEh := opEh;
  // moved to Paint() : LoadLayOut();

   ___AttachTitleDefaultMenu;
   // Application.MessageBox('Restore',nil);
   // WARNING!!!! NTDLL.DLL HELL ERRRRRRORRRR raised when you use line below!!!
   // self.IndicatorOptions := [gioShowRowIndicatorEh,gioShowRecNoEh, gioShowRowselCheckboxesEh];
end;

procedure TDBGridEh.DateColumnsFieldOnSetText(Sender: TField;
  const Text: string);
begin
  if isNumbersOnly(copy(text, 7,4)) then
    Sender.AsDateTime := EncodeDate(
      _i(copy(text, 7,4)),
      _i(copy(text, 4,2)),
      _i(copy(text, 1,2))
    )
  else
    Sender.AsDateTime := EncodeDate(
      _i(copy(text, 1,4)),
      _i(copy(text, 6,2)),
      _i(copy(text, 9,2))
    )
end;

destructor TDBGridEh.Destroy;
begin
  SaveLayout();
  ___DettachTitleDefaultMenu;
  // Application.MessageBox('Save',nil);
  inherited Destroy;
end;

procedure TDBGridEh.ExportAsCSV(const FileName: String; const Titles,
  Overwrite: boolean);
begin

end;

procedure TDBGridEh.ExportAsRTF(const FileName: String; const Titles,
  Overwrite: boolean);
begin

end;

procedure TDBGridEh.ExportAsXLS(const FileName: String; const Titles,
  Overwrite: boolean);
begin

end;

function TDBGridEh.FShowSearcher: Boolean;
begin
  Result := self.SearchPanel.Enabled = True;
end;

procedure TDBGridEh.KeyDown(var Key: Word; Shift: TShiftState);
var
  dataset: TDataSet;
  bm: TBookmark;
begin
  dataset := DataSource.DataSet;
  if key = VK_TAB then
  begin
    if dgMultiSelect in Options then
    begin
      key := 0;
      {
      if not SelectedRows.CurrentRowSelected then
      begin
        with dataset do
        begin
          if (not eof) and (not bof) then
          begin
            BeginUpdate;
            SelectedRows.Clear;
            SelectedRows.AppendItem(Bookmark);
            Bookmark := nil;
            EndUpdate;
          end;
        end;
      end;
      }
      SelectedRows.CurrentRowSelected := not SelectedRows.CurrentRowSelected;
    end;
  end;
  if Assigned(KeyDownProc) then
    KeyDownProc(Self, Key, Shift) ;
  inherited KeyDown(Key, Shift);
end;

procedure TDBGridEh.LoadLayOut;
var
  fn: String;
begin
  exit;
  fn := ExtractFileDir(Application.ExeName)+'\settings.localstore';
  if FileExists(fn) then
  begin
    RestoreGridLayoutIni(
      fn, _iif(assigned(owner), owner.ClassName, 'NULL')+'\'+self.Name,
      [
        grpColIndexEh,
        grpColWidthsEh,
        grpSortMarkerEh,
        grpColVisibleEh,
        grpRowHeightEh,
        grpDropDownRowsEh,
        grpDropDownWidthEh,
        grpRowPanelColPlacementEh

      ]
    );
  end;
end;

function TDBGridEh.LoadNamedBookmark(const AName: String): Boolean;
begin
  Result := False;
  if not Assigned(FUtilityQuery) then exit;
end;

function TDBGridEh.LoadNamedFilter(const AName: String): Boolean;
begin
  Result := False;
  if not Assigned(FUtilityQuery) then exit;
end;

function TDBGridEh.LoadNamedSearch(const AName: String): Boolean;
begin
  Result := False;
  if not Assigned(FUtilityQuery) then exit;
end;

procedure TDBGridEh.Paint;
begin
  inherited Paint;
  if FAlreadyPainted then
    exit;
  LoadLayOut();
  FAlreadyPainted := true;
end;

function TDBGridEh.SaveBookmarkAs(const AName: String): Boolean;

begin
  Result := False;
  if not Assigned(FUtilityQuery) then exit;
  if FUtilityQuery.Active then
    FUtilityQuery.Close;
  //FUtilityQuery.SQL.Text := 'create table if not exists
end;

function TDBGridEh.SaveFilterAs(const AName: String): Boolean;
begin
  Result := False;
  if not Assigned(FUtilityQuery) then exit;
end;

procedure TDBGridEh.SaveLayout;
begin
  exit;
  SaveGridLayoutIni(ExtractFileDir(Application.ExeName)+'\settings.localstore', _iif(assigned(owner), owner.ClassName, 'NULL')+'\'+self.Name, False);
end;

function TDBGridEh.SaveSearchAs(const AName: String): Boolean;
begin
  Result := False;
  if not Assigned(FUtilityQuery) then exit;
end;

procedure TDBGridEh.SetShowSearcher(const Value: Boolean);
begin
  if Value = Self.SearchPanel.Enabled then
    exit;
  if Value then
  begin
    with Self.SearchPanel do
    begin
      Enabled := true;
      FilterEnabled := True;
      FilterOnTyping := True;
      Location := SearchPanelsEh.splGridTopEh;
      PersistentShowing := True;
    end;
  end
  else
    self.SearchPanel.Enabled := False;
end;


procedure TDBGridEh.UpdateFieldsAndEditors;
var
  i: integer;
  ds: TDataset;
  c: TColumnEh;
begin
  if not Assigned(self.DataSource) then
    exit;
  if not Assigned(self.DataSource.DataSet) then
    exit;
  ds := self.DataSource.DataSet;
  for i:= 0 to ds.Fields.Count-1 do
  begin
    if ds.Fields[i] is TDateField then
      ds.Fields[i].OnSetText:=DateColumnsFieldOnSetText;
  end;
  for i := 0 to self.Columns.Count-1 do
  begin
    c := self.Columns[i];
    if (c.Field is TFloatField)
    or (c.Field.DataType in [ftFloat, ftCurrency])then
    begin
      if c.DisplayFormat = '' then
        c.DisplayFormat := FORMAT_FINANCE;
    end
    else
    if c.Field is TDateField then
    begin
      c.DisplayFormat := FORMAT_DATE_DISPLAY;
      // c.EditMask := FORMAT_DATE_MASK;
    end;
  end;
end;

procedure TDBGridEh._OnSortMarkerChanged(Sender: TObject);
var
  i : integer;
  s : String;
  ds: TDataset;
  col: TColumnEh;
begin

  //Prevent both definitions enabled together:
  {$IFDEF UNI_DAC}
    {$IFDEF MY_DAC}
       {$DEFINE WRONG_DAC}
    {$ENDIF}
  {$ENDIF}

  {$IFDEF WRONG_DAC}
  raise Exception.Create('You are defining both UniDAC and MyDac which is denied.');
  {$ELSE}
  ds := TDBGridEh(sender).DataSource.DataSet;
  if not ((ds is {$IFDEF UNI_DAC}TUniTable{$ELSE}TMyTable{$ENDIF})
  or (ds is {$IFDEF UNI_DAC}TUniQuery{$ELSE}TMyQuery{$ENDIF})
  {$IFDEF MEM_TABLE_EH} or (ds is TMemTableEh){$ENDIF}) then
    exit;
  s := '';
  for i :=0 to TDBGridEh(sender).SortMarkedColumns.Count-1 do
  //for i := 0 to TDBGridEh(sender).Columns.Count-1 do
  begin
    //col := TDBGridEh(sender).Columns[i];
    col := TDBGridEh(sender).SortMarkedColumns[i];
    with col.Title do
    begin
      case SortMarker of
      smUpEh  : s := s + col.FieldName+' asc;';
      smDownEh: s := s + col.FieldName+' desc;';
      else
        s := s + '';
      end;
    end;
  end;
  s := trim(s);
  if s = '' then
  begin
    if ds is {$IFDEF UNI_DAC}TUniTable{$ELSE}TMyTable{$ENDIF} then
      {$IFDEF UNI_DAC}TUniTable{$ELSE}TMyTable{$ENDIF}(ds).IndexFieldNames := ''
    else
    if ds is {$IFDEF UNI_DAC}TUniQuery{$ELSE}TMyQuery{$ENDIF} then
      {$IFDEF UNI_DAC}TUniQuery{$ELSE}TMyQuery{$ENDIF}(ds).IndexFieldNames := ''
    {$IFDEF MEM_TABLE_EH}
    else
      TMemTableEh(ds).SortOrder := ''
    {$ENDIF};
  end
  else
  begin
    //remove tailing semicolon:
    Delete(s,length(s),1);
    if ds is {$IFDEF UNI_DAC}TUniTable{$ELSE}TMyTable{$ENDIF} then
      {$IFDEF UNI_DAC}TUniTable{$ELSE}TMyTable{$ENDIF}(ds).IndexFieldNames := s
    else
    if ds is {$IFDEF UNI_DAC}TUniQuery{$ELSE}TMyQuery{$ENDIF} then
      {$IFDEF UNI_DAC}TUniQuery{$ELSE}TMyQuery{$ENDIF}(ds).IndexFieldNames := s
    {$IFDEF MEM_TABLE_EH}
    else
      TMemTableEh(ds).SortOrder := StringReplace(s, ';',',',[rfReplaceAll])
    {$ENDIF};
  end;
  {$ENDIF}
  //Debug view of s:
  //ShowMessage(s);
end;


procedure TDBGridEh.___AttachTitleDefaultMenu;
var
  mi: TMenuItem;
  i: integer;
begin
  if not Assigned(FPopupMenu) then
    FPopupMenu := TPopupMenu.Create(Self);
  // freeze/unfreeze

  {
  mi := TMenuItem.Create(FPopupMenu);
  mi.AutoCheck := True;
  mi.AutoHotkeys := maAutomatic;
  mi.Caption :=  'Freeze';
  mi.Tag := 01;
  mi.OnClick := ___MenuClick;
  FPopupMenu.Items.Add(mi);
  }
  // hide column:
  mi := TMenuItem.Create(FPopupMenu);
  mi.AutoHotkeys := maAutomatic;
  mi.Caption :=  'Hide';
  mi.Tag := 02;
  mi.OnClick := ___MenuClick;
  FPopupMenu.Items.Add(mi);
  self.TitleParams.PopupMenu := FPopupMenu;

end;

procedure TDBGridEh.___DettachTitleDefaultMenu;
var
  i: Integer;
begin
  FPopupMenu.Items.Clear;
  FPopupMenu.Free;
end;

procedure TDBGridEh.___MenuClick(Sender: TObject);
var
  p: TPoint;
  c: TGridCoord;
  col: TDBGridColumnEh;
begin

  p := Self.ScreenToClient(Mouse.CursorPos);
  c := Self.MouseCoord(p.x, p.y);
  // Inform(_s(c.X) +':'+_s(c.Y));
  // col := TDBGridColumnEh(self.Columns[c.X]);

  {
  if Assigned(col) then
    self.FrozenCols := col.Index + 1;
  }

  col := TDBGridColumnEh(self.Columns[c.X-1]);
  if Assigned(col) then
    if TMenuItem(Sender).Tag = 2 then
      col.Visible := False;
end;

procedure TDBGridEh.___MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  s: string;
begin
  if dgMultiSelect in Self.Options then
  begin
    self.AllowedSelections := [gstRecordBookmarks, gstRectangle, gstAll];
    Self.HorzScrollBar.ExtraPanel.NavigatorButtons := [nbFirstEh,nbPriorEh,nbNextEh,nbLastEh,nbRefreshEh];
    self.HorzScrollBar.ExtraPanel.VisibleItems := [gsbiRecordsInfoEh,gsbiNavigator,gsbiSelAggregationInfoEh];
  end;
  if gsbiRecordsInfoEh in self.HorzScrollBar.ExtraPanel.VisibleItems then
    s := 'gsbiRecordsInfoEh';
  if gsbiNavigator in self.HorzScrollBar.ExtraPanel.VisibleItems then
    s := s +#13'gsbiNavigator';
  if gsbiSelAggregationInfoEh in self.HorzScrollBar.ExtraPanel.VisibleItems then
    s := s +#13'gsbiSelAggregationInfoEh';
  //Inform(s);
end;

procedure TDBGridEh.___SetFrozenCols(ATitle: TDBGridColumnEh; AFrozen: Boolean);
begin

end;

{ TDBGridEhNavigatorPanel }

(*

function TDBGridEhNavigatorPanel.GetSelectionInfoPanelText: String;
var
  ResultArr: TAggrResultArr;
  Grid: TCustomDBGridEhCrack;
  FromBM, ToTB: TUniBookmarkEh;
  FieldName: String;
  PaintControl: TNavButtonEh;

  procedure SetSelectionInfoPanelData(var Item: TSelectionInfoPanelDataItemEh; Text1, Text2: String);
  begin
    Result := Result + Text1;
    Item.Text := Text2;
    Item.Start := PaintControl.Canvas.TextWidth(Result);
    Result := Result + Text2;
    Item.Finish := PaintControl.Canvas.TextWidth(Result);
  end;

begin
  SetLength(SelectionInfoPanelDataEh, 0);
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  Result := '';
  if (Grid.Selection.SelectionType in [gstRectangle, gstColumns]) and
      (Grid.FIntMemTable <> nil) then
  begin
    if Grid.Selection.SelectionType = gstRectangle then
    begin
      FromBM := Grid.Selection.Rect.TopRow;
      ToTB := Grid.Selection.Rect.BottomRow;
      FieldName := Grid.Columns[Grid.Selection.Rect.LeftCol].FieldName;
    end else
    begin
      FromBM := NilBookmarkEh;
      ToTB := NilBookmarkEh;
      FieldName := Grid.Selection.Columns[0].FieldName;
    end;
    if FieldName = '' then Exit;
    Grid.FIntMemTable.GetAggregatedValuesForRange(
      FromBM, ToTB, FieldName, ResultArr, [agfSumEh, agfCountEh, agfAvg, agfMin, agfMax]);
    PaintControl := RecordsInfoPanel;
    PaintControl.Canvas.Font := Grid.Font;
    PaintControl.Canvas.Font.Size := PaintControl.Canvas.Font.Size;
    if not VarIsNull(ResultArr[agfSumEh]) then
    begin
      SetLength(SelectionInfoPanelDataEh, Length(SelectionInfoPanelDataEh)+1);
      SetSelectionInfoPanelData(SelectionInfoPanelDataEh[Length(SelectionInfoPanelDataEh)-1],
         ' '+SGridSelectionInfo_Sum+': ', VarToStr(ResultArr[agfSumEh]));
    end;
    if not VarIsNull(ResultArr[agfCountEh]) then
    begin
      if Result <> '' then Result := Result + '   ';
      SetLength(SelectionInfoPanelDataEh, Length(SelectionInfoPanelDataEh)+1);
      SetSelectionInfoPanelData(SelectionInfoPanelDataEh[Length(SelectionInfoPanelDataEh)-1],
         ' '+SGridSelectionInfo_Cnt+': ', VarToStr(ResultArr[agfCountEh]));
    end;
    if not VarIsNull(ResultArr[agfAvg]) then
    begin
      if Result <> '' then Result := Result + '   ';
      SetLength(SelectionInfoPanelDataEh, Length(SelectionInfoPanelDataEh)+1);
      SetSelectionInfoPanelData(SelectionInfoPanelDataEh[Length(SelectionInfoPanelDataEh)-1],
         ' '+SGridSelectionInfo_Evg+': ', VarToStr(ResultArr[agfAvg]));
    end;
    if not VarIsNull(ResultArr[agfMin]) then
    begin
      if Result <> '' then Result := Result + '   ';
      SetLength(SelectionInfoPanelDataEh, Length(SelectionInfoPanelDataEh)+1);
      SetSelectionInfoPanelData(SelectionInfoPanelDataEh[Length(SelectionInfoPanelDataEh)-1],
         ' '+SGridSelectionInfo_Min+': ', VarToStr(ResultArr[agfMin]));
    end;
    if not VarIsNull(ResultArr[agfMax]) then
    begin
      if Result <> '' then Result := Result + '   ';
      SetLength(SelectionInfoPanelDataEh, Length(SelectionInfoPanelDataEh)+1);
      SetSelectionInfoPanelData(SelectionInfoPanelDataEh[Length(SelectionInfoPanelDataEh)-1],
         ' '+SGridSelectionInfo_Max+': ', VarToStr(ResultArr[agfMax]));
    end;
    if Result <> '' then Result := Result + ' ';
  end;

end;
*)

end.
