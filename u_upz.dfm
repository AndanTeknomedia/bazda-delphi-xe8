object FUPZ: TFUPZ
  Left = 0
  Top = 0
  Caption = 'Unit Pengumpul Zakat'
  ClientHeight = 483
  ClientWidth = 795
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
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
    Height = 44
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lKet: TLabel
      Left = 3
      Top = 29
      Width = 320
      Height = 13
      Caption = 
        'Yang tampil di GL hanya jurnal yang telah di-check dan di-approv' +
        'e.'
    end
    object Label10: TLabel
      Left = 15
      Top = 10
      Width = 23
      Height = 13
      Caption = 'Dari'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 147
      Top = 10
      Width = 42
      Height = 13
      Caption = 'Sampai'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dpStart: TDateTimePicker
      Left = 44
      Top = 6
      Width = 92
      Height = 21
      Date = 42578.606255474540000000
      Format = 'dd/MM/yyyy'
      Time = 42578.606255474540000000
      TabOrder = 0
    end
    object dpBs: TDateTimePicker
      Left = 195
      Top = 6
      Width = 92
      Height = 21
      Date = 42578.606255474540000000
      Format = 'dd/MM/yyyy'
      Time = 42578.606255474540000000
      TabOrder = 1
    end
  end
  object gerek: TDBGridEh
    AlignWithMargins = True
    Left = 3
    Top = 75
    Width = 789
    Height = 405
    Align = alClient
    AllowedOperations = []
    AllowedSelections = []
    DataSource = DataSource1
    DrawMemoText = True
    DynProps = <>
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    FooterRowCount = 3
    FooterParams.Color = 16773862
    GridLineParams.VertEmptySpaceStyle = dessNonEh
    IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    EmptyDataInfo.Active = True
    BackgroundData.ExcludeTitle = True
    BackgroundData.ExcludeFooter = True
    OddRowColor = 15987699
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghShowRecNo, dghColumnResize]
    ParentFont = False
    PopupMenu = PopupMenu1
    ReadOnly = True
    SearchPanel.Enabled = True
    SumList.Active = True
    TabOrder = 2
    TitleParams.MultiTitle = True
    OnKeyDown = gerekKeyDown
    Columns = <
      item
        CellButtons = <>
        DisplayFormat = 'dd/MM/yyyy'
        DynProps = <>
        EditButtons = <>
        FieldName = 'tanggal'
        Footers = <>
        Title.Caption = 'Tanggal'
        Width = 74
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'no_bukti'
        Footers = <>
        Title.Caption = 'No. Bukti'
        Width = 106
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'vkode'
        Footers = <>
        Title.Caption = 'Ref.'
        Width = 61
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'uraian'
        Footer.ValueType = fvtStaticText
        Footers = <
          item
            Value = 'Jumlah sebelumnya'
            ValueType = fvtStaticText
          end
          item
            Value = 'Jumlah saat ini'
            ValueType = fvtStaticText
          end
          item
            Value = 'Jumlah Seluruhnya'
            ValueType = fvtStaticText
          end>
        Title.Caption = 'Uraian'
        Width = 394
      end
      item
        CellButtons = <>
        DisplayFormat = '#,#0.## ;(#,#0.##); '
        DynProps = <>
        EditButtons = <>
        FieldName = 'debet'
        Footers = <
          item
            DisplayFormat = '#,#0.## ;(#,#0.##); '
            ValueType = fvtStaticText
          end
          item
            DisplayFormat = '#,#0.## ;(#,#0.##); '
            ValueType = fvtStaticText
          end
          item
            DisplayFormat = '#,#0.## ;(#,#0.##); '
            ValueType = fvtStaticText
          end>
        Title.Caption = 'Debet'
        Width = 140
      end
      item
        CellButtons = <>
        DisplayFormat = '#,#0.## ;(#,#0.##); '
        DynProps = <>
        EditButtons = <>
        FieldName = 'kredit'
        Footers = <
          item
            DisplayFormat = '#,#0.## ;(#,#0.##); '
            ValueType = fvtStaticText
          end
          item
            DisplayFormat = '#,#0.## ;(#,#0.##); '
            ValueType = fvtStaticText
          end
          item
            DisplayFormat = '#,#0.## ;(#,#0.##); '
            ValueType = fvtStaticText
          end>
        Title.Caption = 'Kredit'
        Width = 140
      end
      item
        CellButtons = <>
        DisplayFormat = '#,#0.## ;(#,#0.##); '
        DynProps = <>
        EditButtons = <>
        FieldName = 'saldo'
        Footers = <
          item
            DisplayFormat = '#,#0.## ;(#,#0.##); '
            ValueType = fvtStaticText
          end
          item
            DisplayFormat = '#,#0.## ;(#,#0.##); '
            ValueType = fvtStaticText
          end
          item
            DisplayFormat = '#,#0.## ;(#,#0.##); '
            ValueType = fvtStaticText
          end>
        Title.Caption = 'Saldo'
        Width = 140
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
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
            Action = acPrint
            Caption = '&Print'
            ImageIndex = 37
            ShortCut = 16464
          end
          item
            Action = acDetJurnal
            Caption = '&Detail Jurnal...'
            ImageIndex = 81
          end>
        ActionBar = ActionToolBar1
      end>
    Images = FMain.ilWin
    Left = 180
    Top = 140
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
    end
    object acPrint: TAction
      Caption = 'Print'
      ImageIndex = 37
      ShortCut = 16464
      OnExecute = acPrintExecute
    end
    object acDetJurnal: TAction
      Caption = 'Detail Jurnal...'
      ImageIndex = 81
      OnExecute = acDetJurnalExecute
    end
  end
  object QKas: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      
        'select * from gen_gl_2(:cabang, :tgl1, :tgl2, :akun) -- order by' +
        ' tanggal asc, kode asc')
    Left = 295
    Top = 220
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cabang'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'tgl1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'tgl2'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'akun'
        Value = nil
      end>
    object QKaskode: TMemoField
      FieldName = 'kode'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QKaskode_jenis_jurnal: TMemoField
      FieldName = 'kode_jenis_jurnal'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QKasbranch_kode: TMemoField
      FieldName = 'branch_kode'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QKastanggal: TDateField
      FieldName = 'tanggal'
      ReadOnly = True
    end
    object QKasno_bukti: TMemoField
      FieldName = 'no_bukti'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QKasuraian: TMemoField
      FieldName = 'uraian'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QKaskode_detail: TMemoField
      FieldName = 'kode_detail'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QKaskode_rek: TMemoField
      FieldName = 'kode_rek'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QKaskredit: TFloatField
      FieldName = 'kredit'
      ReadOnly = True
    end
    object QKasdebet: TFloatField
      FieldName = 'debet'
      ReadOnly = True
    end
    object QKassaldo: TFloatField
      FieldName = 'saldo'
      ReadOnly = True
    end
    object QKasuraian_detail: TMemoField
      FieldName = 'uraian_detail'
      ReadOnly = True
      BlobType = ftMemo
    end
  end
  object DataSource1: TDataSource
    DataSet = QKas
    Left = 300
    Top = 170
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
    ReportOptions.CreateDate = 41350.956592233800000000
    ReportOptions.LastChange = 42894.058339664350000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    OnPreview = frxReport1Preview
    Left = 330
    Top = 220
  end
  object frxGLList: TfrxDBDataset
    UserName = 'frxGLList'
    CloseDataSource = False
    FieldAliases.Strings = (
      'kode=kode'
      'kode_jenis_jurnal=kode_jenis_jurnal'
      'branch_kode=branch_kode'
      'tanggal=tanggal'
      'no_bukti=no_bukti'
      'uraian=uraian'
      'kode_detail=kode_detail'
      'kode_rek=kode_rek'
      'kredit=kredit'
      'debet=debet'
      'saldo=saldo'
      'uraian_detail=uraian_detail')
    DataSet = QKas
    BCDToCurrency = False
    Left = 310
    Top = 285
  end
  object PopupMenu1: TPopupMenu
    Left = 444
    Top = 284
    object DetailJurnal1: TMenuItem
      Action = acDetJurnal
    end
  end
end
