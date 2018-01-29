object FSelectKodeName: TFSelectKodeName
  Left = 0
  Top = 0
  ClientHeight = 238
  ClientWidth = 528
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object gep: TDBGridEh
    Left = 0
    Top = 0
    Width = 528
    Height = 196
    Align = alClient
    AllowedOperations = [alopUpdateEh, alopDeleteEh, alopAppendEh]
    AllowedSelections = [gstRecordBookmarks, gstAll]
    DataSource = MyDataSource1
    DrawMemoText = True
    DynProps = <>
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    FooterRowCount = 1
    FooterParams.Color = 15532021
    HorzScrollBar.ExtraPanel.Visible = True
    HorzScrollBar.ExtraPanel.VisibleItems = [gsbiRecordsInfoEh, gsbiSelAggregationInfoEh]
    IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    EmptyDataInfo.Active = True
    OddRowColor = 15987699
    Options = [dgTitles, dgIndicator, dgColumnResize, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
    ParentFont = False
    PopupMenu = PopupMenu1
    ReadOnly = True
    SearchPanel.Enabled = True
    SearchPanel.FilterOnTyping = True
    SumList.Active = True
    TabOrder = 0
    OnDblClick = gepDblClick
    OnKeyDown = gepKeyDown
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 196
    Width = 528
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      528
      42)
    object Button2: TButton
      Left = 9
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 90
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = Button3Click
    end
    object Button1: TButton
      Left = 372
      Top = 8
      Width = 149
      Height = 25
      Cursor = crHandPoint
      Hint = 'Edit Data...'
      Anchors = [akTop, akRight]
      Caption = 'F2 - Edit..'
      ImageIndex = 19
      Images = FMain.ilWin
      TabOrder = 2
      OnClick = Button1Click
    end
  end
  object MyQuery1: TUniQuery
    ReadOnly = True
    Left = 215
    Top = 110
  end
  object MyDataSource1: TDataSource
    AutoEdit = False
    DataSet = MyQuery1
    Left = 260
    Top = 120
  end
  object PopupMenu1: TPopupMenu
    Left = 165
    Top = 75
    object Find1: TMenuItem
      Caption = 'Find'
      ImageIndex = 15
      OnClick = Find1Click
    end
    object Edit1: TMenuItem
      Caption = 'Edit...'
      Hint = 'Edit Data...'
      ImageIndex = 19
      ShortCut = 113
      OnClick = Edit1Click
    end
  end
  object mt: TMemTableEh
    Params = <>
    Left = 320
    Top = 105
  end
end
