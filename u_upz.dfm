object FUPZ: TFUPZ
  Left = 0
  Top = 0
  Caption = 'Data Unit Pengumpul Zakat'
  ClientHeight = 483
  ClientWidth = 795
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object ActionToolBar1: TActionToolBar
    Left = 0
    Top = 0
    Width = 795
    Height = 28
    ActionManager = ActionManager1
    ColorMap.HighlightColor = 14410210
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = 14410210
    EdgeBorders = [ebBottom]
    EdgeOuter = esLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Spacing = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 28
    Width = 795
    Height = 93
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label10: TLabel
      Left = 319
      Top = 26
      Width = 19
      Height = 13
      Caption = 'Dari'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 319
      Top = 48
      Width = 34
      Height = 13
      Caption = 'Sampai'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 19
      Top = 49
      Width = 53
      Height = 13
      Caption = 'Kecamatan'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 19
      Top = 71
      Width = 48
      Height = 13
      Caption = 'Kelurahan'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 306
      Top = 5
      Width = 94
      Height = 13
      Caption = 'Data Penyaluran'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 12
      Top = 5
      Width = 110
      Height = 13
      Caption = 'Jenis && Alamat UPZ'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 19
      Top = 26
      Width = 46
      Height = 13
      Caption = 'Jenis UPZ'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 291
      Top = -8
      Width = 10
      Height = 101
      Shape = bsLeftLine
    end
    object lblChanged: TLabel
      Left = 472
      Top = 26
      Width = 253
      Height = 13
      Caption = 'Refresh untuk menampilkan perubahan data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dpStart: TDateTimePicker
      Left = 363
      Top = 22
      Width = 92
      Height = 21
      Date = 42578.606255474540000000
      Format = 'dd/MM/yyyy'
      Time = 42578.606255474540000000
      TabOrder = 1
    end
    object dpBs: TDateTimePicker
      Left = 363
      Top = 45
      Width = 92
      Height = 21
      Date = 42578.606255474540000000
      Format = 'dd/MM/yyyy'
      Time = 42578.606255474540000000
      TabOrder = 3
    end
    object lcKec: TDBLookupComboBox
      Left = 87
      Top = 45
      Width = 198
      Height = 21
      KeyField = 'kode'
      ListField = 'nama'
      ListSource = dsKec
      TabOrder = 2
    end
    object lcKel: TDBLookupComboBox
      Left = 87
      Top = 68
      Width = 198
      Height = 21
      KeyField = 'kode'
      ListField = 'nama'
      ListSource = dsKel
      TabOrder = 4
    end
    object lcTipe: TDBLookupComboBox
      Left = 87
      Top = 22
      Width = 198
      Height = 21
      KeyField = 'kode'
      ListField = 'uraian'
      ListSource = dsTipe
      TabOrder = 0
    end
  end
  object geAdd: TDBGridEh
    Left = 0
    Top = 121
    Width = 795
    Height = 362
    Align = alClient
    AllowedOperations = [alopUpdateEh, alopDeleteEh, alopAppendEh]
    AllowedSelections = [gstRecordBookmarks, gstAll]
    DataSource = dsAdd
    DrawMemoText = True
    DynProps = <>
    EvenRowColor = clWhite
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    FooterRowCount = 1
    FooterParams.Color = 15532021
    FrozenCols = 2
    GridLineParams.VertEmptySpaceStyle = dessNonEh
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    EmptyDataInfo.Active = True
    OddRowColor = clWhite
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize]
    ParentFont = False
    PopupMenu = PopupMenu1
    SearchPanel.Enabled = True
    SearchPanel.FilterOnTyping = True
    SumList.Active = True
    TabOrder = 2
    TitleParams.MultiTitle = True
    OnAdvDrawDataCell = geAddAdvDrawDataCell
    OnCellClick = geAddCellClick
    OnKeyDown = geAddKeyDown
    Columns = <
      item
        CellButtons = <>
        Color = clWhite
        DynProps = <>
        EditButton.Enabled = False
        EditButton.Style = ebsPlusEh
        EditButton.Visible = True
        EditButtons = <>
        FieldName = 'NPWZ'
        Footer.Value = 'Ket.: '
        Footer.ValueType = fvtStaticText
        Footers = <>
        ReadOnly = True
        Title.Caption = 'NPM'
        Width = 150
      end
      item
        AlwaysShowEditButton = True
        CellButtons = <>
        Color = clWhite
        DynProps = <>
        EditButtons = <>
        FieldName = 'Nama'
        Footers = <>
        ReadOnly = True
        Width = 150
      end
      item
        CellButtons = <>
        Color = clWhite
        DynProps = <>
        EditButtons = <>
        FieldName = 'Kelurahan'
        Footers = <>
        ReadOnly = True
        Title.Caption = 'Alamat (Kel./Kec.)'
        Width = 249
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Panel2: TPanel
    Left = 348
    Top = 324
    Width = 185
    Height = 41
    Caption = 'Panel2'
    Color = 15263976
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2825493
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
    Visible = False
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = acClose
            Caption = '&Close'
            ImageIndex = 4
            ShortCut = 16499
          end
          item
            Caption = '-'
          end
          item
            Action = acRefresh
            Caption = '&Refresh'
            ImageIndex = 40
            ShortCut = 116
          end
          item
            Action = acAdd
            Caption = '&UPZ Baru...'
            ImageIndex = 74
            ShortCut = 45
          end
          item
            Caption = '-'
          end
          item
            Action = acDetail
            Caption = '&Edit...'
            ImageIndex = 86
            ShortCut = 113
          end
          item
            Action = acPrintNPM
            ImageIndex = 88
            ShortCut = 16464
          end
          item
            Action = acPrintReport
            Caption = 'Pr&int Laporan '#187' Excel'
            ImageIndex = 89
            ShortCut = 24656
          end>
        ActionBar = ActionToolBar1
      end>
    Images = FMain.ilWin
    Left = 228
    Top = 292
    StyleName = 'Platform Default'
    object acClose: TAction
      Caption = 'Close'
      ImageIndex = 4
      ShortCut = 16499
      OnExecute = acCloseExecute
    end
    object acRefresh: TAction
      Caption = 'Refresh'
      ImageIndex = 40
      ShortCut = 116
      OnExecute = acRefreshExecute
    end
    object acPrintNPM: TAction
      Caption = 'Print Kwitansi'
      ImageIndex = 88
      ShortCut = 16464
      OnExecute = acPrintNPMExecute
    end
    object acPrintReport: TAction
      Caption = 'Print Laporan '#187' Excel'
      ImageIndex = 89
      ShortCut = 24656
      OnExecute = acPrintReportExecute
    end
    object acDetail: TAction
      Caption = 'Edit...'
      ImageIndex = 86
      ShortCut = 113
      OnExecute = acDetailExecute
    end
    object acAdd: TAction
      Caption = 'UPZ Baru...'
      ImageIndex = 74
      ShortCut = 45
      OnExecute = acAddExecute
    end
  end
  object frxReport1: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.MDIChild = True
    PreviewOptions.Modal = False
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43174.628680856500000000
    ReportOptions.LastChange = 43174.679181469900000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    OnPreview = frxReport1Preview
    Left = 330
    Top = 220
  end
  object PopupMenu1: TPopupMenu
    Left = 444
    Top = 284
    object DetailJurnal1: TMenuItem
      Action = acDetail
    end
    object UPZBaru1: TMenuItem
      Action = acAdd
    end
    object PrintKartuMustahik1: TMenuItem
      Action = acPrintNPM
    end
  end
  object vtMzk: TVirtualTable
    Options = [voPersistentData, voStored, voSkipUnSupportedFieldTypes]
    Left = 201
    Top = 219
    Data = {03000000000000000000}
    object vtMzkNPWZ: TStringField
      FieldName = 'NPWZ'
      Size = 18
    end
    object vtMzkNama: TStringField
      FieldName = 'Nama'
      Size = 100
    end
    object vtMzkKelurahan: TStringField
      FieldName = 'Kelurahan'
      KeyFields = 'kode_kel'
      Size = 100
    end
    object vtMzktipe: TStringField
      DisplayLabel = 'Tipe'
      FieldName = 'tipe'
      Size = 100
    end
  end
  object dsAdd: TDataSource
    DataSet = vtMzk
    Left = 171
    Top = 215
  end
  object qFetch: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      'select * from '
      #9'get_data_upz(:cab, :t1, :t2, :tp, :kec, :kel)')
    Left = 448
    Top = 212
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cab'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 't1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 't2'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'tp'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'kec'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'kel'
        Value = nil
      end>
    object qFetchtipe: TMemoField
      FieldName = 'tipe'
      ReadOnly = True
      BlobType = ftMemo
    end
    object qFetchnama: TMemoField
      FieldName = 'nama'
      ReadOnly = True
      BlobType = ftMemo
    end
    object qFetchalamat_user: TMemoField
      FieldName = 'alamat_user'
      ReadOnly = True
      BlobType = ftMemo
    end
    object qFetchalamat_system: TMemoField
      FieldName = 'alamat_system'
      ReadOnly = True
      BlobType = ftMemo
    end
    object qFetchdata: TMemoField
      FieldName = 'data'
      ReadOnly = True
      BlobType = ftMemo
    end
    object qFetchnpwz: TMemoField
      FieldName = 'npwz'
      ReadOnly = True
      BlobType = ftMemo
    end
  end
  object qKec: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      '-- select kode, nama from sys_kec order by nama asc'
      'with x as ('
      #9'select kode, nama from sys_kec '
      #9'union'
      #9'select '#39'*'#39'::varchar(6),'#39'-- Semuanya --'#39'::varchar(100)'
      ') select * from x order by nama asc')
    Left = 199
    Top = 142
    object qKeckode: TStringField
      FieldName = 'kode'
      Required = True
      Size = 6
    end
    object qKecnama: TStringField
      FieldName = 'nama'
      Size = 100
    end
  end
  object dsKec: TDataSource
    DataSet = qKec
    Left = 224
    Top = 144
  end
  object dsKel: TDataSource
    DataSet = qKel
    Left = 284
    Top = 148
  end
  object qKel: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      '-- select kode, kode_kec, nama from sys_kel order by nama asc'
      'with x as ('
      #9'select kode, kode_kec, nama from sys_kel '
      #9'union'
      
        #9'select '#39'**'#39'::varchar(10), kode::varchar(6), '#39'-- Semuanya --'#39'::v' +
        'archar(100) from sys_kec'
      #9'union'#9
      
        #9'select '#39'**'#39'::varchar(10), '#39'*'#39'::varchar(6), '#39'-- Semuanya --'#39'::va' +
        'rchar(100)'
      ') select * from x order by nama asc')
    MasterSource = dsKec
    MasterFields = 'kode'
    DetailFields = 'kode_kec'
    AfterScroll = qKelAfterScroll
    Left = 259
    Top = 146
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'kode'
        Value = nil
      end>
    object qKelkode: TStringField
      FieldName = 'kode'
      Required = True
      Size = 10
    end
    object qKelkode_kec: TStringField
      FieldName = 'kode_kec'
      Required = True
      Size = 6
    end
    object qKelnama: TStringField
      FieldName = 'nama'
      Size = 100
    end
  end
  object qTipe: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      '-- select kode, nama from sys_kec order by nama asc'
      'with x as ('
      
        #9'select kode, uraian from baz_jenis_muzakki where not (kode in (' +
        #39'00'#39','#39'01'#39'))'
      #9'union'
      #9'select '#39'*'#39'::varchar(2),'#39'-- Semuanya --'#39'::varchar(100)'
      ') select * from x order by uraian asc')
    Left = 131
    Top = 142
    object qTipekode: TMemoField
      FieldName = 'kode'
      ReadOnly = True
      BlobType = ftMemo
    end
    object qTipeuraian: TStringField
      FieldName = 'uraian'
      ReadOnly = True
      Size = 100
    end
  end
  object dsTipe: TDataSource
    DataSet = qTipe
    Left = 156
    Top = 144
  end
end
