object FNeracaSaldo: TFNeracaSaldo
  Left = 0
  Top = 0
  Caption = 'Neraca Saldo'
  ClientHeight = 490
  ClientWidth = 796
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ActionToolBar1: TActionToolBar
    Left = 0
    Top = 0
    Width = 796
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
  object geh: TDBGridEh
    Left = 0
    Top = 61
    Width = 796
    Height = 363
    Align = alClient
    AllowedOperations = []
    AllowedSelections = []
    DataSource = dsCOA
    DrawMemoText = True
    DynProps = <>
    EvenRowColor = clWhite
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    FooterParams.Color = 16773862
    FrozenCols = 1
    GridLineParams.VertEmptySpaceStyle = dessNonEh
    IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    EmptyDataInfo.Active = True
    BackgroundData.ExcludeTitle = True
    BackgroundData.ExcludeFooter = True
    OddRowColor = clWhite
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghShowRecNo, dghColumnResize]
    ParentFont = False
    PopupMenu = PopupMenu2
    ReadOnly = True
    SearchPanel.Enabled = True
    SumList.Active = True
    TabOrder = 2
    TitleParams.MultiTitle = True
    OnAdvDrawDataCell = gehAdvDrawDataCell
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'vkode'
        Footers = <>
        Title.Caption = 'Kode'
        Width = 168
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'nama_rek'
        Footers = <>
        Title.Caption = 'Rekening'
        Width = 345
      end
      item
        CellButtons = <>
        DisplayFormat = '#,#0.## ;(#,#0.##); '
        DynProps = <>
        EditButtons = <>
        FieldName = 'saldo_awal'
        Footers = <>
        Title.Caption = 'Saldo|Awal'
        Width = 120
      end
      item
        CellButtons = <>
        DisplayFormat = '#,#0.## ;(#,#0.##); '
        DynProps = <>
        EditButtons = <>
        FieldName = 'bertambah'
        Footers = <>
        Title.Caption = 'Saldo|Bertambah'
        Width = 120
      end
      item
        CellButtons = <>
        DisplayFormat = '#,#0.## ;(#,#0.##); '
        DynProps = <>
        EditButtons = <>
        FieldName = 'berkurang'
        Footers = <>
        Title.Caption = 'Saldo|Berkurang'
        Width = 120
      end
      item
        CellButtons = <>
        DisplayFormat = '#,#0.## ;(#,#0.##); '
        DynProps = <>
        EditButtons = <>
        FieldName = 'saldo_akhir'
        Footers = <>
        Title.Caption = 'Saldo|Akhir'
        Width = 120
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 28
    Width = 796
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label4: TLabel
      Left = 448
      Top = 53
      Width = 3
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 12
      Top = 8
      Width = 24
      Height = 13
      Caption = 'Filter'
    end
    object luFilter: TDBLookupComboBox
      Left = 42
      Top = 5
      Width = 199
      Height = 21
      KeyField = 'kode'
      ListField = 'kode;rekening'
      ListFieldIndex = 1
      ListSource = DataSource1
      TabOrder = 0
      OnCloseUp = luFilterCloseUp
    end
    object cbTipe: TComboBox
      Left = 467
      Top = 6
      Width = 214
      Height = 21
      Style = csDropDownList
      TabOrder = 3
    end
    object cbBulan: TComboBox
      Left = 247
      Top = 5
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 1
    end
    object cbTahun: TComboBox
      Left = 398
      Top = 6
      Width = 63
      Height = 21
      Style = csDropDownList
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 300
    Top = 212
    Width = 185
    Height = 41
    Caption = 'Panel2'
    Color = 15400191
    ParentBackground = False
    TabOrder = 4
    Visible = False
  end
  object Panel3: TPanel
    Left = 336
    Top = 172
    Width = 185
    Height = 41
    Caption = 'Panel3'
    TabOrder = 3
    Visible = False
  end
  object Panel4: TPanel
    Left = 0
    Top = 424
    Width = 796
    Height = 66
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel4'
    ShowCaption = False
    TabOrder = 5
    object Memo1: TMemo
      Left = 0
      Top = 0
      Width = 796
      Height = 66
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      Lines.Strings = (
        'Saldo Periode: Saldo Keseluruhan'
        'Saldo Posisi : Saldo Bulanan'
        
          '* Saldo Periode menghitung saldo Aset, Kewajiban dan Saldo Dana ' +
          'sejak awal transaksi,'
        
          '  sedangkan Saldo Penerimaan dan Pendistribusian sejak awal tahu' +
          'n.')
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
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
            Action = acViewGL
            Caption = '&Buku Besar...'
            ImageIndex = 39
            ShortCut = 16450
          end
          item
            Caption = '-'
          end
          item
            Action = acRefresh
            Caption = '&Refresh'
            ImageIndex = 40
            ShortCut = 116
          end>
        ActionBar = ActionToolBar1
      end>
    Images = FMain.ilWin
    Left = 372
    Top = 224
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
    object acViewGL: TAction
      Caption = 'Buku Besar...'
      ImageIndex = 39
      SecondaryShortCuts.Strings = (
        'F6')
      ShortCut = 16450
      OnExecute = acViewGLExecute
    end
  end
  object dsCOA: TDataSource
    AutoEdit = False
    DataSet = mtCOA
    Left = 152
    Top = 236
  end
  object JvEnterAsTab1: TJvEnterAsTab
    Left = 500
    Top = 200
  end
  object qCOA: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      
        'select * from gen_neraca_saldo(:cab, :prefix, :t1, :t2, :cur_onl' +
        'y);')
    ReadOnly = True
    Left = 119
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cab'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'prefix'
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
        Name = 'cur_only'
        Value = nil
      end>
    object qCOAtingkat: TIntegerField
      FieldName = 'tingkat'
      ReadOnly = True
    end
    object qCOAp_kode: TMemoField
      FieldName = 'p_kode'
      ReadOnly = True
      BlobType = ftMemo
    end
    object qCOAskode: TMemoField
      FieldName = 'skode'
      ReadOnly = True
      BlobType = ftMemo
    end
    object qCOAkode_rek: TMemoField
      FieldName = 'kode_rek'
      ReadOnly = True
      BlobType = ftMemo
    end
    object qCOAvkode: TMemoField
      FieldName = 'vkode'
      ReadOnly = True
      BlobType = ftMemo
    end
    object qCOAnama_rek: TMemoField
      FieldName = 'nama_rek'
      ReadOnly = True
      BlobType = ftMemo
    end
    object qCOAsaldo_awal: TFloatField
      FieldName = 'saldo_awal'
      ReadOnly = True
    end
    object qCOAbertambah: TFloatField
      FieldName = 'bertambah'
      ReadOnly = True
    end
    object qCOAberkurang: TFloatField
      FieldName = 'berkurang'
      ReadOnly = True
    end
    object qCOAsaldo_akhir: TFloatField
      FieldName = 'saldo_akhir'
      ReadOnly = True
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 526
    Top = 253
    object BukuBesar1: TMenuItem
      Action = acViewGL
    end
    object MenuItem2: TMenuItem
      Action = acRefresh
    end
  end
  object mtCOA: TMemTableEh
    Active = True
    FieldDefs = <
      item
        Name = 'tingkat'
        DataType = ftInteger
        Precision = 15
      end
      item
        Name = 'p_kode'
        DataType = ftMemo
      end
      item
        Name = 'skode'
        DataType = ftMemo
      end
      item
        Name = 'kode_rek'
        DataType = ftMemo
      end
      item
        Name = 'vkode'
        DataType = ftMemo
      end
      item
        Name = 'nama_rek'
        DataType = ftMemo
      end
      item
        Name = 'saldo_awal'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'bertambah'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'berkurang'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'saldo_akhir'
        DataType = ftFloat
        Precision = 15
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    TreeList.KeyFieldName = 'kode_rek'
    TreeList.RefParentFieldName = 'p_kode'
    TreeList.DefaultNodeExpanded = True
    Left = 152
    Top = 192
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object tingkat: TMTNumericDataFieldEh
          FieldName = 'tingkat'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'tingkat'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object p_kode: TMTBlobDataFieldEh
          FieldName = 'p_kode'
          DisplayLabel = 'p_kode'
          DisplayWidth = 10
          BlobType = ftMemo
          Transliterate = True
        end
        object skode: TMTBlobDataFieldEh
          FieldName = 'skode'
          DisplayLabel = 'skode'
          DisplayWidth = 10
          BlobType = ftMemo
          Transliterate = True
        end
        object kode_rek: TMTBlobDataFieldEh
          FieldName = 'kode_rek'
          DisplayLabel = 'kode_rek'
          DisplayWidth = 10
          BlobType = ftMemo
          Transliterate = True
        end
        object vkode: TMTBlobDataFieldEh
          FieldName = 'vkode'
          DisplayLabel = 'vkode'
          DisplayWidth = 10
          BlobType = ftMemo
          Transliterate = True
        end
        object nama_rek: TMTBlobDataFieldEh
          FieldName = 'nama_rek'
          DisplayLabel = 'nama_rek'
          DisplayWidth = 10
          BlobType = ftMemo
          Transliterate = True
        end
        object saldo_awal: TMTNumericDataFieldEh
          FieldName = 'saldo_awal'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'saldo_awal'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object bertambah: TMTNumericDataFieldEh
          FieldName = 'bertambah'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'bertambah'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object berkurang: TMTNumericDataFieldEh
          FieldName = 'berkurang'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'berkurang'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object saldo_akhir: TMTNumericDataFieldEh
          FieldName = 'saldo_akhir'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'saldo_akhir'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            1
            ''
            '1'
            '1'
            '1.0.00.00.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            2
            ''
            '1'
            '11'
            '1.1.00.00.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            3
            ''
            '01'
            '1101'
            '1.1.01.00.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '01'
            '110101'
            '1.1.01.01.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '11010101'
            '1.1.01.01.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '02'
            '11010102'
            '1.1.01.01.02'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '02'
            '110102'
            '1.1.01.02.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '11010201'
            '1.1.01.02.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '02'
            '11010202'
            '1.1.01.02.02'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '03'
            '11010203'
            '1.1.01.02.03'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '04'
            '11010204'
            '1.1.01.02.04'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '05'
            '11010205'
            '1.1.01.02.05'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            3
            ''
            '02'
            '1102'
            '1.1.02.00.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            3
            ''
            '03'
            '1103'
            '1.1.03.00.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '01'
            '110301'
            '1.1.03.01.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '11030101'
            '1.1.03.01.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '02'
            '110302'
            '1.1.03.02.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '11030201'
            '1.1.03.02.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '03'
            '110303'
            '1.1.03.03.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '11030301'
            '1.1.03.03.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '04'
            '110304'
            '1.1.03.04.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '11030401'
            '1.1.03.04.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '05'
            '110305'
            '1.1.03.05.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '11030501'
            '1.1.03.05.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '09'
            '110309'
            '1.1.03.09.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '11030901'
            '1.1.03.09.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            3
            ''
            '04'
            '1104'
            '1.1.04.00.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '01'
            '110401'
            '1.1.04.01.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '11040101'
            '1.1.04.01.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '02'
            '110402'
            '1.1.04.02.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '11040201'
            '1.1.04.02.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '03'
            '110403'
            '1.1.04.03.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '11040301'
            '1.1.04.03.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            3
            ''
            '05'
            '1105'
            '1.1.05.00.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '01'
            '110501'
            '1.1.05.01.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '11050101'
            '1.1.05.01.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '02'
            '110502'
            '1.1.05.02.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '11050201'
            '1.1.05.02.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '03'
            '110503'
            '1.1.05.03.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '11050301'
            '1.1.05.03.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            3
            ''
            '06'
            '1106'
            '1.1.06.00.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '01'
            '110601'
            '1.1.06.01.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '11060101'
            '1.1.06.01.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '02'
            '110602'
            '1.1.06.02.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '11060201'
            '1.1.06.02.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            3
            ''
            '07'
            '1107'
            '1.1.07.00.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            2
            ''
            '2'
            '12'
            '1.2.00.00.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            3
            ''
            '01'
            '1201'
            '1.2.01.00.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '01'
            '120101'
            '1.2.01.01.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '12010101'
            '1.2.01.01.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '02'
            '120102'
            '1.2.01.02.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '12010201'
            '1.2.01.02.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '03'
            '120103'
            '1.2.01.03.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '12010301'
            '1.2.01.03.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '04'
            '120104'
            '1.2.01.04.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '12010401'
            '1.2.01.04.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '05'
            '120105'
            '1.2.01.05.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '12010501'
            '1.2.01.05.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            3
            ''
            '02'
            '1202'
            '1.2.02.00.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '01'
            '120201'
            '1.2.02.01.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '12020101'
            '1.2.02.01.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '02'
            '120202'
            '1.2.02.02.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '12020201'
            '1.2.02.02.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '03'
            '120203'
            '1.2.02.03.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '12020301'
            '1.2.02.03.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '04'
            '120204'
            '1.2.02.04.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '12020401'
            '1.2.02.04.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            2
            ''
            '3'
            '13'
            '1.3.00.00.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            3
            ''
            '01'
            '1301'
            '1.3.01.00.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '01'
            '130101'
            '1.3.01.01.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            3
            ''
            '02'
            '1302'
            '1.3.02.00.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '01'
            '130201'
            '1.3.02.01.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            3
            ''
            '03'
            '1303'
            '1.3.03.00.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            4
            ''
            '01'
            '130301'
            '1.3.03.01.00'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '01'
            '13030101'
            '1.3.03.01.01'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000)
          (
            5
            ''
            '02'
            '13030102'
            '1.3.03.01.02'
            ''
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000
            0.000000000000000000))
      end
    end
  end
  object ActionList1: TActionList
    Left = 388
    Top = 244
  end
  object UniQuery1: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      'with x as ('
      
        #9'select '#39'*'#39'::char(1) kode,'#39'-- Semuanya --'#39'::varchar(100) rekenin' +
        'g'
      #9'union'
      #9'select kode, rekening from sys_coa_1'
      ') select kode, rekening from x order by kode asc;')
    Left = 468
    Top = 128
    object UniQuery1kode: TStringField
      FieldName = 'kode'
      Required = True
      FixedChar = True
      Size = 1
    end
    object UniQuery1rekening: TStringField
      FieldName = 'rekening'
      Required = True
      Size = 100
    end
  end
  object DataSource1: TDataSource
    DataSet = UniQuery1
    Left = 432
    Top = 280
  end
end
