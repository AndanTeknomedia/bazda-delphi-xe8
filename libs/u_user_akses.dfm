object FUserAccessControl: TFUserAccessControl
  Left = 0
  Top = 0
  Caption = 'User Access Control'
  ClientHeight = 480
  ClientWidth = 777
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 289
    Top = 30
    Height = 402
    ExplicitLeft = 287
    ExplicitTop = 24
  end
  object Panel6: TPanel
    Left = 0
    Top = 432
    Width = 777
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object Bevel5: TBevel
      Left = 0
      Top = 0
      Width = 777
      Height = 6
      Align = alTop
      Shape = bsTopLine
      ExplicitWidth = 393
    end
    object Button3: TButton
      Left = 14
      Top = 12
      Width = 75
      Height = 25
      Caption = '&Save'
      Enabled = False
      TabOrder = 0
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 95
      Top = 12
      Width = 75
      Height = 25
      Caption = '&Cancel'
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 777
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      777
      30)
    object Label1: TLabel
      Left = 3
      Top = 8
      Width = 20
      Height = 13
      Caption = 'Tipe'
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 36
      Top = 6
      Width = 197
      Height = 21
      KeyField = 'tipe'
      ListField = 'uraian'
      ListSource = dsTipe
      TabOrder = 1
    end
    object Button1: TButton
      Left = 698
      Top = 4
      Width = 75
      Height = 25
      Action = acRefresh
      Anchors = [akTop, akRight]
      TabOrder = 0
    end
  end
  object PageControl1: TPageControl
    Left = 292
    Top = 30
    Width = 485
    Height = 402
    ActivePage = TabSheet1
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Hak Akses'
      object geAkses: TDBGridEh
        Left = 0
        Top = 0
        Width = 477
        Height = 371
        Align = alClient
        AllowedOperations = [alopUpdateEh]
        AllowedSelections = [gstRecordBookmarks, gstAll]
        DataSource = dsAccess
        DrawMemoText = True
        DynProps = <>
        EvenRowColor = clWhite
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        FooterParams.Color = 15532021
        GridLineParams.VertEmptySpaceStyle = dessNonEh
        IndicatorOptions = []
        IndicatorTitle.ShowDropDownSign = True
        IndicatorTitle.TitleButton = True
        EmptyDataInfo.Active = True
        OddRowColor = clWhite
        Options = [dgEditing, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize]
        ParentFont = False
        PopupMenu = PopupMenu2
        SearchPanel.Enabled = True
        SearchPanel.FilterOnTyping = True
        SumList.Active = True
        TabOrder = 0
        Columns = <
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'Uraian'
            Footers = <>
            ReadOnly = True
            Width = 400
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'Ijin'
            Footers = <>
            KeyList.Strings = (
              'Y'
              'N')
            NotInKeyListIndex = 1
            PickList.Strings = (
              'Boleh'
              'Larang')
            Width = 50
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  object PageControl2: TPageControl
    Left = 0
    Top = 30
    Width = 289
    Height = 402
    ActivePage = TabSheet3
    Align = alLeft
    Style = tsFlatButtons
    TabOrder = 1
    object TabSheet3: TTabSheet
      Caption = 'Daftar User'
      object geUsers: TDBGridEh
        Left = 0
        Top = 0
        Width = 281
        Height = 371
        Align = alClient
        AllowedOperations = []
        AllowedSelections = [gstRecordBookmarks, gstAll]
        DataSource = dsUsers
        DrawMemoText = True
        DynProps = <>
        EvenRowColor = clWhite
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        FooterParams.Color = 15532021
        GridLineParams.VertEmptySpaceStyle = dessNonEh
        IndicatorOptions = []
        IndicatorTitle.ShowDropDownSign = True
        IndicatorTitle.TitleButton = True
        EmptyDataInfo.Active = True
        OddRowColor = clWhite
        Options = [dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize]
        ParentFont = False
        PopupMenu = PopupMenu1
        SearchPanel.Enabled = True
        SearchPanel.FilterOnTyping = True
        SumList.Active = True
        TabOrder = 0
        Columns = <
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'kode'
            Footers = <>
            Width = 69
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'uraian'
            Footers = <>
            Width = 157
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  object vtAccess: TVirtualTable
    Options = [voPersistentData, voStored, voSkipUnSupportedFieldTypes]
    AfterPost = vtAccessAfterPost
    FieldDefs = <
      item
        Name = 'kode'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'Hak Akses'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Uraian'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Ijin'
        DataType = ftString
        Size = 1
      end>
    Left = 336
    Top = 160
    Data = {
      0300040004006B6F64650100050000000000090048616B20416B736573010064
      0000000000060055726169616E01006400000000000400496A696E0100010000
      000000000000000000}
    object vtAccesskode: TStringField
      FieldName = 'kode'
      Size = 5
    end
    object vtAccessHakAkses: TStringField
      FieldName = 'Hak Akses'
      Size = 100
    end
    object vtAccessUraian: TStringField
      FieldName = 'Uraian'
      Size = 100
    end
    object vtAccessIjin: TStringField
      FieldName = 'Ijin'
      Size = 1
    end
  end
  object dsAccess: TDataSource
    DataSet = vtAccess
    Left = 332
    Top = 208
  end
  object qTipe: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      'select'
      #9'group_kode::varchar(3) tipe,'
      #9'group_name:: varchar(30) uraian'
      'from usr_group'
      'where group_kode <> '#39'DEV'#39
      'order by pkode asc')
    Active = True
    AfterScroll = qTipeAfterScroll
    Left = 184
    Top = 96
    object qTipetipe: TStringField
      FieldName = 'tipe'
      ReadOnly = True
      Size = 3
    end
    object qTipeuraian: TStringField
      FieldName = 'uraian'
      ReadOnly = True
      Size = 30
    end
  end
  object dsTipe: TDataSource
    DataSet = qTipe
    Left = 228
    Top = 96
  end
  object dsUsers: TDataSource
    DataSet = qUsers
    Left = 236
    Top = 136
  end
  object qAkses: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      'select '
      '            ai.*,'
      '            count(al.*) jml'
      '        from '
      '            usr_user_access_items ai'
      
        '            left join usr_user_access_list al on al.access_kode ' +
        '= ai.kode and al.user_id = :uid'
      '        group by ai.kode, ai.access_item_name, ai.uraian')
    Left = 328
    Top = 260
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'uid'
        Value = nil
      end>
    object qAkseskode: TStringField
      FieldName = 'kode'
      Required = True
      Size = 5
    end
    object qAksesaccess_item_name: TStringField
      FieldName = 'access_item_name'
      Required = True
      Size = 100
    end
    object qAksesuraian: TStringField
      FieldName = 'uraian'
      Required = True
      Size = 100
    end
    object qAksesjml: TLargeintField
      FieldName = 'jml'
      ReadOnly = True
    end
  end
  object qUsers: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      'select'
      #9'id,'
      #9'group_kode,'
      #9'user_name kode,'
      #9'user_name uraian'
      #9'from usr_user where group_kode<>'#39'DEV'#39
      'order by user_name asc')
    MasterSource = dsTipe
    MasterFields = 'tipe'
    DetailFields = 'group_kode'
    Active = True
    AfterScroll = qUsersAfterScroll
    Left = 184
    Top = 148
    ParamData = <
      item
        DataType = ftString
        Name = 'tipe'
        ParamType = ptInput
        Value = 'ADM'
      end>
    object qUsersgroup_kode: TStringField
      FieldName = 'group_kode'
      Required = True
      FixedChar = True
      Size = 3
    end
    object qUserskode: TStringField
      FieldName = 'kode'
      Required = True
      Size = 50
    end
    object qUsersuraian: TStringField
      FieldName = 'uraian'
      Required = True
      Size = 50
    end
    object qUsersid: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
    end
  end
  object ActionManager1: TActionManager
    Left = 408
    Top = 89
    StyleName = 'Platform Default'
    object acRefresh: TAction
      Caption = '&Refresh'
      ShortCut = 116
      OnExecute = acRefreshExecute
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 104
    Top = 220
    object UserBaru1: TMenuItem
      Caption = 'User Baru...'
      ShortCut = 16462
      OnClick = UserBaru1Click
    end
    object EditUser1: TMenuItem
      Caption = 'Edit User...'
      ShortCut = 113
      OnClick = EditUser1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Hapus1: TMenuItem
      Caption = 'Hapus'
      Enabled = False
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 604
    Top = 276
    object IjinkanSemua1: TMenuItem
      Caption = 'Ijinkan Semua'
      ShortCut = 16449
      OnClick = IjinkanSemua1Click
    end
    object LarangSemua1: TMenuItem
      Caption = 'Larang Semua'
      ShortCut = 24641
      OnClick = LarangSemua1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Refresh1: TMenuItem
      Action = acRefresh
    end
  end
end
