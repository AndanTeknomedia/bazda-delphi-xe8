object FPembuatDokumen: TFPembuatDokumen
  Left = 0
  Top = 0
  ActiveControl = Button2
  Caption = 'Pembuat Dokumen'
  ClientHeight = 288
  ClientWidth = 614
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 608
    Height = 241
    Align = alClient
    AllowedOperations = [alopUpdateEh]
    AllowedSelections = []
    DataSource = DataSource2
    DrawMemoText = True
    DynProps = <>
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    FooterParams.Color = 16773862
    GridLineParams.VertEmptySpaceStyle = dessNonEh
    IndicatorOptions = [gioShowRecNoEh]
    IndicatorParams.HorzLines = True
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    EmptyDataInfo.Active = True
    BackgroundData.ExcludeTitle = True
    BackgroundData.ExcludeFooter = True
    OddRowColor = 15987699
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove]
    ParentFont = False
    SumList.Active = True
    TabOrder = 0
    TitleParams.MultiTitle = True
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Fungsi'
        Footers = <>
        Width = 187
      end
      item
        AlwaysShowEditButton = True
        ButtonStyle = cbsEllipsis
        CellButtons = <>
        Checkboxes = False
        DynProps = <>
        EditButton.Style = ebsEllipsisEh
        EditButton.Visible = True
        EditButton.OnClick = DBGridEh1Columns1EditButtonClick
        EditButtons = <>
        FieldName = 'Nama'
        Footers = <>
        Width = 181
        OnEditButtonClick = DBGridEh1Columns1EditButtonClick
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'Jabatan'
        Footers = <>
        Width = 182
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 247
    Width = 614
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Button1: TButton
      Left = 407
      Top = 7
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Batal'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 488
      Top = 7
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object DataSource2: TDataSource
    DataSet = VirtualTable1
    Left = 420
    Top = 116
  end
  object VirtualTable1: TVirtualTable
    Options = [voStored, voSkipUnSupportedFieldTypes]
    FieldDefs = <
      item
        Name = 'Fungsi'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Nama'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'Jabatan'
        DataType = ftString
        Size = 100
      end>
    Left = 328
    Top = 120
    Data = {
      03000300060046756E677369010064000000000004004E616D610100C8000000
      000007004A61626174616E0100640000000000000000000000}
    object VirtualTable1Fungsi: TStringField
      FieldName = 'Fungsi'
      Size = 100
    end
    object VirtualTable1Nama: TStringField
      FieldName = 'Nama'
      Size = 200
    end
    object VirtualTable1Jabatan: TStringField
      FieldName = 'Jabatan'
      Size = 100
    end
  end
end
