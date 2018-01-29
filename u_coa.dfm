object FCoa: TFCoa
  Left = 0
  Top = 0
  Caption = 'Chart Of Accounts'
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
    Height = 429
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
        FieldName = 'rekening'
        Footers = <>
        Title.Caption = 'Rekening'
        Width = 442
      end
      item
        Alignment = taCenter
        CellButtons = <>
        DisplayFormat = '#,0;-#,0; '
        DynProps = <>
        EditButtons = <>
        FieldName = 'jml'
        Footers = <>
        Title.Caption = 'Jml. Jurnal'
        Width = 62
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        Footers = <>
        Title.Caption = 'Keterangan'
        Width = 93
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
    DesignSize = (
      796
      33)
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
    object Label1: TLabel
      Left = 640
      Top = 8
      Width = 150
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Data Diubah. Silahkan Refresh.'
    end
    object Label2: TLabel
      Left = 12
      Top = 8
      Width = 24
      Height = 13
      Caption = 'Filter'
    end
    object CheckBox1: TCheckBox
      Left = 247
      Top = 8
      Width = 157
      Height = 17
      Caption = 'Tampilkan Jml. Jurnal (Slow)'
      TabOrder = 1
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
  end
  object Panel2: TPanel
    Left = 300
    Top = 212
    Width = 185
    Height = 41
    Caption = 'Panel2'
    Color = 3635455
    ParentBackground = False
    TabOrder = 4
    Visible = False
  end
  object Memo1: TMemo
    Left = 144
    Top = 304
    Width = 185
    Height = 89
    Lines.Strings = (
      'select'
      '        v_coa_2.tingkat,'
      '        v_coa_2.pkode,'
      '        v_coa_2.kode,'
      '        v_coa_2.rekening,'
      '        v_coa_2.vkode,'
      '        v_coa_2.sandi_ojk,'
      '        v_coa_2.hide,'
      '        (0)::bigint jml'
      ' from v_coa_2'
      
        ' -- --->left join acc_jurnal_u_detail u on u.kode_rek like (v_co' +
        'a_2.kode||'#39'%'#39')'
      'where (9=9)'
      ' group by'
      '        v_coa_2.tingkat,'
      '        v_coa_2.pkode,'
      '        v_coa_2.kode,'
      '        v_coa_2.rekening,'
      '        v_coa_2.full_kode,'
      '        v_coa_2.vkode,'
      '        v_coa_2.sandi_ojk,'
      '        v_coa_2.hide'
      'order by v_coa_2.full_kode asc;'
      '')
    ScrollBars = ssBoth
    TabOrder = 5
    Visible = False
    WantReturns = False
    WordWrap = False
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
    object acAdd: TAction
      Caption = 'Tambah Akun Selevel'
      ImageIndex = 74
      ShortCut = 45
      OnExecute = acAddExecute
    end
    object acAddChild: TAction
      Caption = 'Tambah Akun Anak'
      ImageIndex = 85
      ShortCut = 16429
      OnExecute = acAddChildExecute
    end
    object acEdit: TAction
      Caption = 'Edit Akun'
      ImageIndex = 86
      ShortCut = 113
      OnExecute = acEditExecute
    end
    object acHapus: TAction
      Caption = 'Hapus'
      ImageIndex = 75
      ShortCut = 16430
      OnExecute = acHapusExecute
    end
    object acSetKas: TAction
      Caption = 'Set Akun Kas'
      OnExecute = acSetKasExecute
    end
    object acSetBank: TAction
      Caption = 'Set Akun Bank'
      OnExecute = acSetBankExecute
    end
    object acSetAsetTetap: TAction
      Caption = 'Set Akun Aset Tetap'
      OnExecute = acSetAsetTetapExecute
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
      'select '
      #9#9#9'v_coa_2.tingkat,'
      #9#9#9'v_coa_2.pkode,'
      #9#9#9'v_coa_2.kode,'#9#9#9
      #9#9#9'v_coa_2.rekening,'
      #9#9#9'v_coa_2.vkode,'
      #9#9#9'v_coa_2.sandi_ojk,'
      #9#9#9'v_coa_2.hide,'
      #9#9#9'(0)::bigint jml'
      #9#9' from v_coa_2'
      
        #9#9' -- --->left join acc_jurnal_u_detail u on u.kode_rek like (v_' +
        'coa_2.kode||'#39'%'#39')'
      #9#9' group by '
      #9#9' '#9'v_coa_2.tingkat,'
      #9#9#9'v_coa_2.pkode,'
      #9#9#9'v_coa_2.kode,'
      #9#9#9'v_coa_2.rekening,'
      #9#9#9'v_coa_2.full_kode,'
      #9#9#9'v_coa_2.vkode,'
      #9#9#9'v_coa_2.sandi_ojk,'
      #9#9#9'v_coa_2.hide'
      #9#9'order by v_coa_2.full_kode asc;')
    ReadOnly = True
    Left = 119
    Top = 192
    object qCOAtingkat: TIntegerField
      FieldName = 'tingkat'
    end
    object qCOApkode: TStringField
      FieldName = 'pkode'
      Size = 8
    end
    object qCOAkode: TMemoField
      FieldName = 'kode'
      BlobType = ftMemo
    end
    object qCOArekening: TStringField
      FieldName = 'rekening'
      Size = 100
    end
    object qCOAvkode: TStringField
      FieldName = 'vkode'
      Size = 12
    end
    object qCOAjml: TLargeintField
      FieldName = 'jml'
      ReadOnly = True
    end
    object qCOAsandi_ojk: TStringField
      FieldName = 'sandi_ojk'
      Size = 4
    end
    object qCOAhide: TStringField
      FieldName = 'hide'
      FixedChar = True
      Size = 1
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 526
    Top = 253
    object BukuBesar1: TMenuItem
      Action = acViewGL
    end
    object acSaldo1: TMenuItem
      Caption = 'Saldo'
      ImageIndex = 84
      ShortCut = 16467
    end
    object MenuItem2: TMenuItem
      Action = acRefresh
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object SetAkunKas1: TMenuItem
      Action = acSetKas
    end
    object SetAkunBank1: TMenuItem
      Action = acSetBank
    end
    object SetAkunAsetTetap1: TMenuItem
      Action = acSetAsetTetap
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object ambahAkunSelevel1: TMenuItem
      Action = acAdd
    end
    object ambahAkunAnak1: TMenuItem
      Action = acAddChild
    end
    object EditAkun1: TMenuItem
      Action = acEdit
      SubMenuImages = FMain.ilWin
    end
    object Sembunyikan1: TMenuItem
      Caption = 'Sembunyikan'
      ImageIndex = 87
      ShortCut = 16456
    end
    object Hapus1: TMenuItem
      Action = acHapus
    end
  end
  object mtCOA: TMemTableEh
    Active = True
    Params = <>
    TreeList.DefaultNodeExpanded = True
    AfterScroll = mtCOAAfterScroll
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
        object pkode: TMTStringDataFieldEh
          FieldName = 'pkode'
          StringDataType = fdtStringEh
          DisplayLabel = 'pkode'
          DisplayWidth = 8
          Size = 8
          Transliterate = True
        end
        object kode: TMTBlobDataFieldEh
          FieldName = 'kode'
          DisplayLabel = 'kode'
          DisplayWidth = 10
          BlobType = ftMemo
          Transliterate = True
        end
        object rekening: TMTStringDataFieldEh
          FieldName = 'rekening'
          StringDataType = fdtStringEh
          DisplayLabel = 'rekening'
          DisplayWidth = 100
          Size = 100
          Transliterate = True
        end
        object vkode: TMTStringDataFieldEh
          FieldName = 'vkode'
          StringDataType = fdtStringEh
          DisplayLabel = 'vkode'
          DisplayWidth = 12
          Size = 12
          Transliterate = True
        end
        object jml: TMTNumericDataFieldEh
          FieldName = 'jml'
          NumericDataType = fdtLargeintEh
          AutoIncrement = False
          DisplayLabel = 'jml'
          DisplayWidth = 15
          currency = False
          Precision = 15
        end
        object sandi_ojk: TMTStringDataFieldEh
          FieldName = 'sandi_ojk'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object hide: TMTStringDataFieldEh
          FieldName = 'hide'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            1
            '*'
            '1'
            'Aset'
            '1.0.00.00.00'
            0
            nil
            nil)
          (
            2
            '1'
            '11'
            'Aset Lancar'
            '1.1.00.00.00'
            0
            nil
            nil)
          (
            3
            '11'
            '1101'
            'Kas dan Setara Kas'
            '1.1.01.00.00'
            0
            nil
            nil)
          (
            4
            '1101'
            '110101'
            'Kas'
            '1.1.01.01.00'
            0
            nil
            nil)
          (
            5
            '110101'
            '11010101'
            'Kas'
            '1.1.01.01.01'
            947
            nil
            nil)
          (
            5
            '110101'
            '11010102'
            'Kas Kecil'
            '1.1.01.01.02'
            43
            nil
            nil)
          (
            4
            '1101'
            '110102'
            'Bank'
            '1.1.01.02.00'
            0
            nil
            nil)
          (
            5
            '110102'
            '11010201'
            'Bank Sulselbar'
            '1.1.01.02.01'
            3
            nil
            nil)
          (
            5
            '110102'
            '11010202'
            'Bank Sulselbar Syariah Cab. Makassar'
            '1.1.01.02.02'
            70
            nil
            nil)
          (
            5
            '110102'
            '11010203'
            'PD. BPR Citra Mas'
            '1.1.01.02.03'
            2
            nil
            nil)
          (
            3
            '11'
            '1102'
            'Investasi Lancar'
            '1.1.02.00.00'
            0
            nil
            nil)
          (
            4
            '1102'
            '110201'
            'Deposito Bank BUMD'
            '1.1.02.01.00'
            0
            nil
            nil)
          (
            5
            '110201'
            '11020101'
            'Bank Sulselbar - Cabang Utama Makassar'
            '1.1.02.01.01'
            0
            nil
            nil)
          (
            5
            '110201'
            '11020102'
            'Bank Sulselbar Syariah Cab. Makassar'
            '1.1.02.01.02'
            7
            nil
            nil)
          (
            4
            '1102'
            '110202'
            'Deposito Bank BUMN'
            '1.1.02.02.00'
            0
            nil
            nil)
          (
            4
            '1102'
            '110203'
            'Deposito Bank BUSN'
            '1.1.02.03.00'
            0
            nil
            nil)
          (
            4
            '1102'
            '110204'
            'BPR'
            '1.1.02.04.00'
            0
            nil
            nil)
          (
            5
            '110204'
            '11020401'
            'PD BPR Citra Mas'
            '1.1.02.04.01'
            1
            nil
            nil)
          (
            3
            '11'
            '1103'
            'Piutang Imbal Jasa Penjaminan'
            '1.1.03.00.00'
            0
            nil
            nil)
          (
            4
            '1103'
            '110301'
            'Piutang Imbal Jasa Penjaminan'
            '1.1.03.01.00'
            0
            nil
            nil)
          (
            5
            '110301'
            '11030101'
            'Piutang Imbal Jasa Penjaminan'
            '1.1.03.01.01'
            0
            nil
            nil)
          (
            5
            '110301'
            '11030102'
            'Piutang Imbal Jasa Penjaminan Lainnya'
            '1.1.03.01.02'
            0
            nil
            nil)
          (
            4
            '1103'
            '110302'
            'Piutang Imbal Jasa Penjaminan Ulang'
            '1.1.03.02.00'
            0
            nil
            nil)
          (
            5
            '110302'
            '11030201'
            '  Piutang Imbal Jasa Penjaminan Ulang'
            '1.1.03.02.01'
            0
            nil
            nil)
          (
            5
            '110302'
            '11030202'
            '  Piutang Imbal Jasa Penjaminan Ulang Lainnya'
            '1.1.03.02.02'
            2
            nil
            nil)
          (
            3
            '11'
            '1104'
            'Piutang Co-Guarantee/Penjaminan Ulang'
            '1.1.04.00.00'
            0
            nil
            nil)
          (
            4
            '1104'
            '110401'
            'Piutang Co-Guarantee'
            '1.1.04.01.00'
            0
            nil
            nil)
          (
            4
            '1104'
            '110402'
            'Piutang Penjaminan Ulang'
            '1.1.04.02.00'
            0
            nil
            nil)
          (
            3
            '11'
            '1105'
            'Pendapatan Yang Masih Harus Diterima'
            '1.1.05.00.00'
            0
            nil
            nil)
          (
            4
            '1105'
            '110501'
            'Bunga Deposito Yang Akan Diterima '
            '1.1.05.01.00'
            0
            nil
            nil)
          (
            5
            '110501'
            '11050101'
            'Pendapatan Bunga YMHD Bank Sulselbar Syariah'
            '1.1.05.01.01'
            3
            nil
            nil)
          (
            5
            '110501'
            '11050102'
            'Pendapatan Bunga YMHD PD. BPR Citra Mas '
            '1.1.05.01.02'
            1
            nil
            nil)
          (
            4
            '1105'
            '110502'
            'Pendapatan Lainnya Yang Akan Diterima '
            '1.1.05.02.00'
            0
            nil
            nil)
          (
            3
            '11'
            '1106'
            'Beban Dibayar Di Muka'
            '1.1.06.00.00'
            0
            nil
            nil)
          (
            4
            '1106'
            '110601'
            'Beban Sewa Gedung Dibayar Di Muka'
            '1.1.06.01.00'
            0
            nil
            nil)
          (
            5
            '110601'
            '11060101'
            'Beban Sewa Gedung Dibayar Di muka'
            '1.1.06.01.01'
            0
            nil
            nil)
          (
            4
            '1106'
            '110602'
            'Beban Asuransi Kendaraan'
            '1.1.06.02.00'
            0
            nil
            nil)
          (
            5
            '110602'
            '11060201'
            'Beban Asuransi Kendaraan'
            '1.1.06.02.01'
            2
            nil
            nil)
          (
            4
            '1106'
            '110603'
            'Beban Pendirian'
            '1.1.06.03.00'
            0
            nil
            nil)
          (
            5
            '110603'
            '11060301'
            'Beban Pendirian'
            '1.1.06.03.01'
            0
            nil
            nil)
          (
            4
            '1106'
            '110604'
            'Beban Dibayar Di Muka Lainnya'
            '1.1.06.04.00'
            0
            nil
            nil)
          (
            5
            '110604'
            '11060401'
            'Beban Dibayar Di muka Lainnya'
            '1.1.06.04.01'
            0
            nil
            nil)
          (
            3
            '11'
            '1107'
            'Piutang Dalam Rangka Restrukturisasi Penjaminan'
            '1.1.07.00.00'
            0
            nil
            nil)
          (
            4
            '1107'
            '110701'
            'Piutang Dalam Rangka Restrukturisasi Penjaminan'
            '1.1.07.01.00'
            0
            nil
            nil)
          (
            5
            '110701'
            '11070101'
            'Piutang Dalam Rangka Restrukturisasi Penjaminan'
            '1.1.07.01.01'
            0
            nil
            nil)
          (
            3
            '11'
            '1108'
            'Aset Lancar Lainnya'
            '1.1.08.00.00'
            0
            nil
            nil)
          (
            4
            '1108'
            '110801'
            'Piutang Lain-Lain'
            '1.1.08.01.00'
            0
            nil
            nil)
          (
            5
            '110801'
            '11080101'
            'Piutang Karyawan'
            '1.1.08.01.01'
            0
            nil
            nil)
          (
            5
            '110801'
            '11080102'
            'Piutang Penjualan Aset'
            '1.1.08.01.02'
            0
            nil
            nil)
          (
            5
            '110801'
            '11080103'
            'Piutang Lain-Lain Lainnya'
            '1.1.08.01.03'
            0
            nil
            nil)
          (
            4
            '1108'
            '110802'
            'Rekening Antar Kantor'
            '1.1.08.02.00'
            0
            nil
            nil)
          (
            5
            '110802'
            '11080201'
            'Rekening Kantor Pusat'
            '1.1.08.02.01'
            0
            nil
            nil)
          (
            5
            '110802'
            '11080202'
            'Rekening Kantor Cabang Lain'
            '1.1.08.02.02'
            0
            nil
            nil)
          (
            4
            '1108'
            '110803'
            'Pajak Dibayar Di Muka'
            '1.1.08.03.00'
            0
            nil
            nil)
          (
            5
            '110803'
            '11080301'
            'PPN Masukan'
            '1.1.08.03.01'
            0
            nil
            nil)
          (
            4
            '1108'
            '110804'
            'PPh'
            '1.1.08.04.00'
            0
            nil
            nil)
          (
            5
            '110804'
            '11080401'
            'PPh Pasal 21'
            '1.1.08.04.01'
            0
            nil
            nil)
          (
            5
            '110804'
            '11080402'
            'PPh Pasal 22'
            '1.1.08.04.02'
            0
            nil
            nil)
          (
            5
            '110804'
            '11080403'
            'PPh Pasal 23'
            '1.1.08.04.03'
            0
            nil
            nil)
          (
            5
            '110804'
            '11080404'
            'PPh Pasal 25'
            '1.1.08.04.04'
            0
            nil
            nil)
          (
            4
            '1108'
            '110805'
            'Uang Muka'
            '1.1.08.05.00'
            0
            nil
            nil)
          (
            5
            '110805'
            '11080501'
            'Uang Muka Pembelian'
            '1.1.08.05.01'
            0
            nil
            nil)
          (
            5
            '110805'
            '11080502'
            'Uang Muka Lainnya'
            '1.1.08.05.02'
            0
            nil
            nil)
          (
            4
            '1108'
            '110806'
            'Uang Muka Biaya'
            '1.1.08.06.00'
            0
            nil
            nil)
          (
            4
            '1108'
            '110807'
            'Uang Muka Sewa'
            '1.1.08.07.00'
            0
            nil
            nil)
          (
            4
            '1108'
            '110808'
            'Investasi Jangka Panjang Lancar'
            '1.1.08.08.00'
            0
            nil
            nil)
          (
            5
            '110808'
            '11080801'
            'Deposito Bank Sulselbar'
            '1.1.08.08.01'
            0
            nil
            nil)
          (
            5
            '110808'
            '11080802'
            'Obligasi'
            '1.1.08.08.02'
            0
            nil
            nil)
          (
            5
            '110808'
            '11080803'
            'Investasi Jangka Panjang Lancar Lainnya'
            '1.1.08.08.03'
            0
            nil
            nil)
          (
            2
            '1'
            '12'
            'Aset Tidak Lancar'
            '1.2.00.00.00'
            0
            nil
            nil)
          (
            3
            '12'
            '1201'
            'Investasi Tidak Lancar'
            '1.2.01.00.00'
            0
            nil
            nil)
          (
            3
            '12'
            '1202'
            'Piutang Co-Guarantee/Penjaminan Ulang'
            '1.2.02.00.00'
            0
            nil
            nil)
          (
            4
            '1202'
            '120201'
            'Piutang Co-Guarantee Tidak Lancar'
            '1.2.02.01.00'
            0
            nil
            nil)
          (
            4
            '1202'
            '120202'
            'Piutang Penjaminan Ulang Tidak Lancar'
            '1.2.02.02.00'
            0
            nil
            nil)
          (
            3
            '12'
            '1203'
            'Beban Tidak Lancar Dibayar Di Muka'
            '1.2.03.00.00'
            0
            nil
            nil)
          (
            4
            '1203'
            '120301'
            'Beban Tidak Lancar Dibayar Di Muka'
            '1.2.03.01.00'
            0
            nil
            nil)
          (
            5
            '120301'
            '12030101'
            'Beban Sewa Gedung Tidak Lancar'
            '1.2.03.01.01'
            16
            nil
            nil)
          (
            5
            '120301'
            '12030102'
            'Beban Asuransi Kendaraan Tidak Lancar'
            '1.2.03.01.02'
            0
            nil
            nil)
          (
            5
            '120301'
            '12030103'
            'Beban Pendirian Tidak Lancar'
            '1.2.03.01.03'
            2272
            nil
            nil)
          (
            5
            '120301'
            '12030104'
            'Beban Tidak Lancar Dibayar Di Muka Lainnya'
            '1.2.03.01.04'
            177
            nil
            nil)
          (
            3
            '12'
            '1204'
            'Aset Tetap'
            '1.2.04.00.00'
            0
            nil
            nil)
          (
            4
            '1204'
            '120401'
            'Tanah'
            '1.2.04.01.00'
            0
            nil
            nil)
          (
            5
            '120401'
            '12040101'
            'Harga Perolehan Tanah'
            '1.2.04.01.01'
            0
            nil
            nil)
          (
            4
            '1204'
            '120402'
            'Bangunan Gedung Kantor'
            '1.2.04.02.00'
            0
            nil
            nil)
          (
            5
            '120402'
            '12040201'
            'Harga Perolehan Gedung Kantor'
            '1.2.04.02.01'
            0
            nil
            nil)
          (
            4
            '1204'
            '120403'
            'Inventaris Kantor'
            '1.2.04.03.00'
            0
            nil
            nil)
          (
            5
            '120403'
            '12040301'
            'Harga Perolehan Inventaris Kantor'
            '1.2.04.03.01'
            51
            nil
            nil)
          (
            4
            '1204'
            '120404'
            'Kendaraan'
            '1.2.04.04.00'
            0
            nil
            nil)
          (
            5
            '120404'
            '12040401'
            'Harga Perolehan Kendaraan'
            '1.2.04.04.01'
            7
            nil
            nil)
          (
            4
            '1204'
            '120405'
            'Inventaris Lainnya'
            '1.2.04.05.00'
            0
            nil
            nil)
          (
            5
            '120405'
            '12040501'
            'Harga Perolehan Inventaris Lainnya'
            '1.2.04.05.01'
            20
            nil
            nil)
          (
            3
            '12'
            '1205'
            'Akumulasi Penyusutan Aset Tetap (-)'
            '1.2.05.00.00'
            0
            nil
            nil)
          (
            4
            '1205'
            '120501'
            'Akumulasi Penyusutan Bangunan (-)'
            '1.2.05.01.00'
            0
            nil
            nil)
          (
            5
            '120501'
            '12050101'
            'Akumulasi Penyusutan Bangunan (-)'
            '1.2.05.01.01'
            0
            nil
            nil)
          (
            4
            '1205'
            '120502'
            'Akumulasi Penyusutan Inventaris Kantor (-)'
            '1.2.05.02.00'
            0
            nil
            nil)
          (
            5
            '120502'
            '12050201'
            'Akumulasi Penyusutan Inventaris Kantor (-)'
            '1.2.05.02.01'
            4
            nil
            nil)
          (
            4
            '1205'
            '120503'
            'Akumulasi Penyusutan Kendaraan (-)'
            '1.2.05.03.00'
            0
            nil
            nil)
          (
            5
            '120503'
            '12050301'
            'Akumulasi Penyusutan Kendaraan (-)'
            '1.2.05.03.01'
            14
            nil
            nil)
          (
            4
            '1205'
            '120504'
            'Akumulasi Penyusutan Inventaris Lainnya (-)'
            '1.2.05.04.00'
            0
            nil
            nil)
          (
            5
            '120504'
            '12050401'
            'Akumulasi Penyusutan Inventaris Lainnya (-)'
            '1.2.05.04.01'
            1
            nil
            nil)
          (
            3
            '12'
            '1206'
            'Aset Tidak Berwujud - Netto'
            '1.2.06.00.00'
            0
            nil
            nil)
          (
            4
            '1206'
            '120601'
            '  Aset Tidak Berwujud - Netto'
            '1.2.06.01.00'
            0
            nil
            nil)
          (
            3
            '12'
            '1207'
            'Piutang Dalam Rangka Restrukturisasi Penjaminan'
            '1.2.07.00.00'
            0
            nil
            nil)
          (
            4
            '1207'
            '120701'
            'Piutang Dalam Rangka Restrukturisasi Penjaminan'
            '1.2.07.01.00'
            0
            nil
            nil)
          (
            3
            '12'
            '1208'
            'Aset Pajak Tangguhan'
            '1.2.08.00.00'
            0
            nil
            nil)
          (
            4
            '1208'
            '120801'
            'Aset Pajak Tangguhan'
            '1.2.08.01.00'
            0
            nil
            nil)
          (
            3
            '12'
            '1209'
            'Aset Tidak Lancar Lainnya'
            '1.2.09.00.00'
            0
            nil
            nil)
          (
            4
            '1209'
            '120901'
            'Aset Tidak Lancar Lainnya'
            '1.2.09.01.00'
            0
            nil
            nil)
          (
            2
            '1'
            '19'
            'Aset Lain-Lain'
            '1.9.00.00.00'
            0
            nil
            nil)
          (
            1
            '*'
            '2'
            'Liabilitas'
            '2.0.00.00.00'
            0
            nil
            nil)
          (
            2
            '2'
            '21'
            'Liabilitas Lancar'
            '2.1.00.00.00'
            0
            nil
            nil)
          (
            3
            '21'
            '2101'
            'Hutang Klaim'
            '2.1.01.00.00'
            0
            nil
            nil)
          (
            4
            '2101'
            '210101'
            'Hutang Klaim Kredit Produktif (KPD)'
            '2.1.01.01.00'
            0
            nil
            nil)
          (
            4
            '2101'
            '210102'
            'Hutang Klaim Kredit Program (KP)'
            '2.1.01.02.00'
            0
            nil
            nil)
          (
            4
            '2101'
            '210103'
            'Hutang Klaim Kredit Produktif Non Bank (KNB)'
            '2.1.01.03.00'
            0
            nil
            nil)
          (
            4
            '2101'
            '210104'
            'Hutang Klaim Kredit Konsumtif'
            '2.1.01.04.00'
            0
            nil
            nil)
          (
            4
            '2101'
            '210105'
            'Hutang Klaim Surety Bond'
            '2.1.01.05.00'
            0
            nil
            nil)
          (
            4
            '2101'
            '210106'
            'Hutang Klaim Kontra Garansi Bank Garansi'
            '2.1.01.06.00'
            0
            nil
            nil)
          (
            4
            '2101'
            '210107'
            'Hutang Klaim Kontra Garansi L/C'
            '2.1.01.07.00'
            0
            nil
            nil)
          (
            4
            '2101'
            '210108'
            'Hutang Klaim Produk Lainnya'
            '2.1.01.08.00'
            0
            nil
            nil)
          (
            3
            '21'
            '2102'
            'IJP Yang Ditangguhkan'
            '2.1.02.00.00'
            0
            nil
            nil)
          (
            4
            '2102'
            '210201'
            'IJP Kredit Produktif (KPD)'
            '2.1.02.01.00'
            0
            nil
            nil)
          (
            5
            '210201'
            '21020101'
            'IJP Sektor Agribisnis KPd'
            '2.1.02.01.01'
            0
            nil
            nil)
          (
            5
            '210201'
            '21020102'
            'IJP Sektor Indt & Tambang KPd'
            '2.1.02.01.02'
            0
            nil
            nil)
          (
            5
            '210201'
            '21020103'
            'IJP Sektor Jasa & Dagang KPd'
            '2.1.02.01.03'
            0
            nil
            nil)
          (
            5
            '210201'
            '21020104'
            'IJP Sektor Lainnya KPd'
            '2.1.02.01.04'
            1
            nil
            nil)
          (
            4
            '2102'
            '210202'
            'IJP Kredit Program (KP)'
            '2.1.02.02.00'
            0
            nil
            nil)
          (
            4
            '2102'
            '210203'
            'IJP Kredit Non Bank (KNB)'
            '2.1.02.03.00'
            0
            nil
            nil)
          (
            4
            '2102'
            '210204'
            'IJP Kredit Konsumtif'
            '2.1.02.04.00'
            0
            nil
            nil)
          (
            3
            '21'
            '2103'
            'Hutang Pajak'
            '2.1.03.00.00'
            0
            nil
            nil)
          (
            4
            '2103'
            '210301'
            'Hutang PPh'
            '2.1.03.01.00'
            0
            nil
            nil)
          (
            5
            '210301'
            '21030101'
            'HUtang PPh 21'
            '2.1.03.01.01'
            0
            nil
            nil)
          (
            4
            '2103'
            '210302'
            'Hutang PPN'
            '2.1.03.02.00'
            0
            nil
            nil)
          (
            5
            '210302'
            '21030201'
            'Hutang PPn'
            '2.1.03.02.01'
            0
            nil
            nil)
          (
            3
            '21'
            '2104'
            'Hutang Premi Re-Garansi'
            '2.1.04.00.00'
            0
            nil
            nil)
          (
            4
            '2104'
            '210401'
            'Sertifikat Penjaminan'
            '2.1.04.01.00'
            0
            nil
            nil)
          (
            4
            '2104'
            '210402'
            'Surety Bond'
            '2.1.04.02.00'
            0
            nil
            nil)
          (
            4
            '2104'
            '210403'
            'Kontra Garansi Bank Garansi'
            '2.1.04.03.00'
            0
            nil
            nil)
          (
            4
            '2104'
            '210404'
            'Kontra Garansi L/C'
            '2.1.04.04.00'
            0
            nil
            nil)
          (
            4
            '2104'
            '210405'
            'Produk Lainnya'
            '2.1.04.05.00'
            0
            nil
            nil)
          (
            3
            '21'
            '2105'
            'Hutang Komisi'
            '2.1.05.00.00'
            0
            nil
            nil)
          (
            4
            '2105'
            '210501'
            'Sertifikat Penjaminan'
            '2.1.05.01.00'
            0
            nil
            nil)
          (
            4
            '2105'
            '210502'
            'Surety Bond'
            '2.1.05.02.00'
            0
            nil
            nil)
          (
            4
            '2105'
            '210503'
            'Kontra Garansi Bank Garansi'
            '2.1.05.03.00'
            0
            nil
            nil)
          (
            4
            '2105'
            '210504'
            'Kontra Haransi L/C'
            '2.1.05.04.00'
            0
            nil
            nil)
          (
            4
            '2105'
            '210505'
            'Produk Lainnya'
            '2.1.05.05.00'
            0
            nil
            nil)
          (
            3
            '21'
            '2106'
            'Hutang Co-Guarantee/Penjaminan Ulang'
            '2.1.06.00.00'
            0
            nil
            nil)
          (
            4
            '2106'
            '210601'
            'Sertifikat Penjaminan'
            '2.1.06.01.00'
            0
            nil
            nil)
          (
            4
            '2106'
            '210602'
            'Surety Bond'
            '2.1.06.02.00'
            0
            nil
            nil)
          (
            4
            '2106'
            '210603'
            'Kontra Garansi Bank Garansi'
            '2.1.06.03.00'
            0
            nil
            nil)
          (
            4
            '2106'
            '210604'
            'Kontra Garansi L/C'
            '2.1.06.04.00'
            0
            nil
            nil)
          (
            4
            '2106'
            '210605'
            'Produk Lainnya'
            '2.1.06.05.00'
            0
            nil
            nil)
          (
            3
            '21'
            '2107'
            'Beban Yang Masih Harus Dibayar'
            '2.1.07.00.00'
            0
            nil
            nil)
          (
            4
            '2107'
            '210701'
            'Beban Yang Masih Harus Dibayar'
            '2.1.07.01.00'
            0
            nil
            nil)
          (
            5
            '210701'
            '21070101'
            'Beban Yang Masih Harus Dibayar'
            '2.1.07.01.01'
            9
            nil
            nil)
          (
            5
            '210701'
            '21070102'
            'Utang Zakat'
            '2.1.07.01.02'
            0
            nil
            nil)
          (
            3
            '21'
            '2108'
            'Cadangan Klaim'
            '2.1.08.00.00'
            0
            nil
            nil)
          (
            4
            '2108'
            '210801'
            'Cadangan Klaim Sertifikat Penjaminan'
            '2.1.08.01.00'
            0
            nil
            nil)
          (
            4
            '2108'
            '210802'
            'Cadangan Klaim Surety Bond'
            '2.1.08.02.00'
            0
            nil
            nil)
          (
            4
            '2108'
            '210803'
            'Cadangan Klaim Kontra Garansi Bank Garansi'
            '2.1.08.03.00'
            0
            nil
            nil)
          (
            4
            '2108'
            '210804'
            'Cadangan Klaim Kontra Garansi L/C'
            '2.1.08.04.00'
            0
            nil
            nil)
          (
            4
            '2108'
            '210805'
            'Cadangan Klaim Produk Lainnya'
            '2.1.08.05.00'
            0
            nil
            nil)
          (
            3
            '21'
            '2109'
            'Liabilitas Pajak Tangguhan'
            '2.1.09.00.00'
            0
            nil
            nil)
          (
            4
            '2109'
            '210901'
            'Liabilitas Pajak Tangguhan'
            '2.1.09.01.00'
            0
            nil
            nil)
          (
            5
            '210901'
            '21090101'
            'Liabilitas Pajak Tangguhan'
            '2.1.09.01.01'
            0
            nil
            nil)
          (
            3
            '21'
            '2110'
            'Liabilitas Lancar Lainnya'
            '2.1.10.00.00'
            0
            nil
            nil)
          (
            4
            '2110'
            '211001'
            'Liabilitas Lancar Lainnya'
            '2.1.10.01.00'
            0
            nil
            nil)
          (
            2
            '2'
            '22'
            'Liabilitas Tidak Lancar'
            '2.2.00.00.00'
            0
            nil
            nil)
          (
            3
            '22'
            '2201'
            'IJP Yang Ditangguhkan Tidak Lancar'
            '2.2.01.00.00'
            0
            nil
            nil)
          (
            4
            '2201'
            '220101'
            'IJP Kredit Produktif (KPD)'
            '2.2.01.01.00'
            0
            nil
            nil)
          (
            4
            '2201'
            '220102'
            'IJP Kredit Program (KP)'
            '2.2.01.02.00'
            0
            nil
            nil)
          (
            4
            '2201'
            '220103'
            'IJP Kredit Non Bank (KNB)'
            '2.2.01.03.00'
            0
            nil
            nil)
          (
            4
            '2201'
            '220104'
            'IJP Kredit Konsumtif'
            '2.2.01.04.00'
            0
            nil
            nil)
          (
            4
            '2201'
            '220105'
            'IJP Surety Bond'
            '2.2.01.05.00'
            0
            nil
            nil)
          (
            4
            '2201'
            '220106'
            'IJP Kontra Garansi - Bank Garansi'
            '2.2.01.06.00'
            0
            nil
            nil)
          (
            4
            '2201'
            '220107'
            'IJP Kontra Garansi - L/C'
            '2.2.01.07.00'
            0
            nil
            nil)
          (
            4
            '2201'
            '220108'
            'IJP Produk Lainnya'
            '2.2.01.08.00'
            0
            nil
            nil)
          (
            3
            '22'
            '2202'
            'Cadangan Klaim Tidak Lancar'
            '2.2.02.00.00'
            0
            nil
            nil)
          (
            4
            '2202'
            '220201'
            'Sertifikat Penjaminan'
            '2.2.02.01.00'
            0
            nil
            nil)
          (
            4
            '2202'
            '220202'
            'Surety Bond'
            '2.2.02.02.00'
            0
            nil
            nil)
          (
            4
            '2202'
            '220203'
            'Kontra Garansi - Bank Garansi'
            '2.2.02.03.00'
            0
            nil
            nil)
          (
            4
            '2202'
            '220204'
            'Kontra Garansi - L/C'
            '2.2.02.04.00'
            0
            nil
            nil)
          (
            4
            '2202'
            '220205'
            'Produk Lainnya'
            '2.2.02.05.00'
            0
            nil
            nil)
          (
            3
            '22'
            '2203'
            'Hutang Imbalan Pasca Kerja'
            '2.2.03.00.00'
            0
            nil
            nil)
          (
            3
            '22'
            '2204'
            'Obligasi Wajib Konversi'
            '2.2.04.00.00'
            0
            nil
            nil)
          (
            3
            '22'
            '2205'
            'Liabilitas Tidak Lancar Lainnya'
            '2.2.05.00.00'
            0
            nil
            nil)
          (
            1
            '*'
            '3'
            'Ekuitas'
            '3.0.00.00.00'
            0
            nil
            nil)
          (
            2
            '3'
            '31'
            'Modal'
            '3.1.00.00.00'
            0
            nil
            nil)
          (
            3
            '31'
            '3101'
            'Modal Disetor'
            '3.1.01.00.00'
            0
            nil
            nil)
          (
            4
            '3101'
            '310101'
            'Modal Disetor'
            '3.1.01.01.00'
            0
            nil
            nil)
          (
            5
            '310101'
            '31010101'
            'Modal Pemerintah Provinsi Sulawesi Selatan'
            '3.1.01.01.01'
            1
            nil
            nil)
          (
            5
            '310101'
            '31010102'
            'Modal Koperasi Pegawai (KPRI) Toddopuli Prov. Sulsel'
            '3.1.01.01.02'
            1
            nil
            nil)
          (
            3
            '31'
            '3102'
            'Agio'
            '3.1.02.00.00'
            0
            nil
            nil)
          (
            3
            '31'
            '3103'
            'Disagio (-)'
            '3.1.03.00.00'
            0
            nil
            nil)
          (
            2
            '3'
            '32'
            'Cadangan'
            '3.2.00.00.00'
            0
            nil
            nil)
          (
            3
            '32'
            '3201'
            'Cadangan Umum'
            '3.2.01.00.00'
            0
            nil
            nil)
          (
            4
            '3201'
            '320101'
            'Cadangan Umum'
            '3.2.01.01.00'
            0
            nil
            nil)
          (
            5
            '320101'
            '32010101'
            'Cadangan Umum'
            '3.2.01.01.01'
            0
            nil
            nil)
          (
            3
            '32'
            '3202'
            'Cadangan Tujuan'
            '3.2.02.00.00'
            0
            nil
            nil)
          (
            4
            '3202'
            '320201'
            'Cadangan Tujuan'
            '3.2.02.01.00'
            0
            nil
            nil)
          (
            5
            '320201'
            '32020101'
            'Cadangan Tujuan'
            '3.2.02.01.01'
            0
            nil
            nil)
          (
            3
            '32'
            '3203'
            'Cadangan Lainnya'
            '3.2.03.00.00'
            0
            nil
            nil)
          (
            4
            '3203'
            '320301'
            'Cadangan Lainnya'
            '3.2.03.01.00'
            0
            nil
            nil)
          (
            5
            '320301'
            '32030101'
            'Cadangan Lainnya'
            '3.2.03.01.01'
            0
            nil
            nil)
          (
            2
            '3'
            '33'
            'Hibah'
            '3.3.00.00.00'
            0
            nil
            nil)
          (
            3
            '33'
            '3301'
            'Hibah'
            '3.3.01.00.00'
            0
            nil
            nil)
          (
            4
            '3301'
            '330101'
            'Hibah'
            '3.3.01.01.00'
            0
            nil
            nil)
          (
            5
            '330101'
            '33010101'
            'Hibah Pemprov. Sulawesi Selatan'
            '3.3.01.01.01'
            0
            nil
            nil)
          (
            2
            '3'
            '34'
            'Saldo Laba/Rugi'
            '3.4.00.00.00'
            0
            nil
            nil)
          (
            3
            '34'
            '3401'
            'Saldo Laba/Rugi Tahun Lalu'
            '3.4.01.00.00'
            0
            nil
            nil)
          (
            4
            '3401'
            '340101'
            'Saldo Laba/Rugi Tahun Lalu'
            '3.4.01.01.00'
            0
            nil
            nil)
          (
            5
            '340101'
            '34010101'
            'Saldo Laba/Rugi Tahun Lalu'
            '3.4.01.01.01'
            0
            nil
            nil)
          (
            2
            '3'
            '35'
            'Laba/Rugi Tahun Berjalan'
            '3.5.00.00.00'
            0
            nil
            nil)
          (
            3
            '35'
            '3501'
            'Laba/Rugi Tahun Berjalan'
            '3.5.01.00.00'
            0
            nil
            nil)
          (
            4
            '3501'
            '350101'
            'Laba/Rugi Tahun Berjalan'
            '3.5.01.01.00'
            0
            nil
            nil)
          (
            5
            '350101'
            '35010101'
            'Laba/Rugi Tahun Berjalan'
            '3.5.01.01.01'
            0
            nil
            nil)
          (
            2
            '3'
            '36'
            'Ekuitas Komprehensip'
            '3.6.00.00.00'
            0
            nil
            nil)
          (
            1
            '*'
            '4'
            'Pendapatan'
            '4.0.00.00.00'
            0
            nil
            nil)
          (
            2
            '4'
            '41'
            'Pendapatan Imbal Jasa Penjaminan'
            '4.1.00.00.00'
            0
            nil
            nil)
          (
            3
            '41'
            '4101'
            'Imbal Jasa Penjaminan Bruto'
            '4.1.01.00.00'
            0
            nil
            nil)
          (
            4
            '4101'
            '410101'
            'IJP Kredit Produktif (KPd)'
            '4.1.01.01.00'
            0
            nil
            nil)
          (
            5
            '410101'
            '41010101'
            'IJP Sektor Agribisnis KPd'
            '4.1.01.01.01'
            0
            nil
            nil)
          (
            5
            '410101'
            '41010102'
            'IJP Sektor Indt & Tambang  KPd'
            '4.1.01.01.02'
            0
            nil
            nil)
          (
            5
            '410101'
            '41010103'
            'IJP Sektor Jasa & Dagang  KPd'
            '4.1.01.01.03'
            0
            nil
            nil)
          (
            5
            '410101'
            '41010104'
            'IJP Sektor Lainnya'
            '4.1.01.01.04'
            1
            nil
            nil)
          (
            4
            '4101'
            '410102'
            'IJP Kredit Program (KP)'
            '4.1.01.02.00'
            0
            nil
            nil)
          (
            5
            '410102'
            '41010201'
            'IJP Sektor Agribisnis KP'
            '4.1.01.02.01'
            0
            nil
            nil)
          (
            5
            '410102'
            '41010202'
            'IJP Sektor Indt & Tambang  KP'
            '4.1.01.02.02'
            0
            nil
            nil)
          (
            5
            '410102'
            '41010203'
            'IJP Sektor Jasa & Dagang  KP'
            '4.1.01.02.03'
            0
            nil
            nil)
          (
            5
            '410102'
            '41010204'
            'IJP Sektor Lainnya'
            '4.1.01.02.04'
            0
            nil
            nil)
          (
            4
            '4101'
            '410103'
            'IJP Kredit Non Bank (KNB)'
            '4.1.01.03.00'
            0
            nil
            nil)
          (
            5
            '410103'
            '41010301'
            'IJP Sektor Agribisnis KNB'
            '4.1.01.03.01'
            0
            nil
            nil)
          (
            5
            '410103'
            '41010302'
            'IJP Sektor Indt & Tambang  KNB'
            '4.1.01.03.02'
            0
            nil
            nil)
          (
            5
            '410103'
            '41010303'
            'IJP Sektor Jasa & Dagang  KNB'
            '4.1.01.03.03'
            0
            nil
            nil)
          (
            5
            '410103'
            '41010304'
            'IJP Sektor Lainnya'
            '4.1.01.03.04'
            0
            nil
            nil)
          (
            4
            '4101'
            '410104'
            'IJP Kredit Konsumtif'
            '4.1.01.04.00'
            0
            nil
            nil)
          (
            5
            '410104'
            '41010401'
            'IJP Kredit Kendaraan'
            '4.1.01.04.01'
            0
            nil
            nil)
          (
            5
            '410104'
            '41010402'
            'IJP KPR'
            '4.1.01.04.02'
            0
            nil
            nil)
          (
            5
            '410104'
            '41010403'
            'IJP Kredit Konsumtip Lainnya'
            '4.1.01.04.03'
            0
            nil
            nil)
          (
            4
            '4101'
            '410105'
            'IJP Surety Bond'
            '4.1.01.05.00'
            0
            nil
            nil)
          (
            5
            '410105'
            '41010501'
            'IJP Kontraktor'
            '4.1.01.05.01'
            0
            nil
            nil)
          (
            5
            '410105'
            '41010502'
            'IJP Supplier'
            '4.1.01.05.02'
            0
            nil
            nil)
          (
            5
            '410105'
            '41010503'
            'IJP Klaim Pembeli'
            '4.1.01.05.03'
            0
            nil
            nil)
          (
            5
            '410105'
            '41010504'
            'IJP Lainnya'
            '4.1.01.05.04'
            0
            nil
            nil)
          (
            4
            '4101'
            '410106'
            'IJP Kontra Garansi - Bank Garansi'
            '4.1.01.06.00'
            0
            nil
            nil)
          (
            5
            '410106'
            '41010601'
            'IJP Kontraktor'
            '4.1.01.06.01'
            0
            nil
            nil)
          (
            5
            '410106'
            '41010602'
            'IJP Supplier'
            '4.1.01.06.02'
            0
            nil
            nil)
          (
            5
            '410106'
            '41010603'
            'IJP Klaim Pembeli'
            '4.1.01.06.03'
            0
            nil
            nil)
          (
            5
            '410106'
            '41010604'
            'IJP Lainnya'
            '4.1.01.06.04'
            0
            nil
            nil)
          (
            4
            '4101'
            '410107'
            'IJP Kontra Garansi - L/C'
            '4.1.01.07.00'
            0
            nil
            nil)
          (
            5
            '410107'
            '41010701'
            'IJP Kontraktor'
            '4.1.01.07.01'
            0
            nil
            nil)
          (
            5
            '410107'
            '41010702'
            'IJP Supplier'
            '4.1.01.07.02'
            0
            nil
            nil)
          (
            5
            '410107'
            '41010703'
            'IJP Klaim Pembeli'
            '4.1.01.07.03'
            0
            nil
            nil)
          (
            5
            '410107'
            '41010704'
            'IJP Lainnya'
            '4.1.01.07.04'
            0
            nil
            nil)
          (
            4
            '4101'
            '410108'
            'IJP Produk Lainnya'
            '4.1.01.08.00'
            0
            nil
            nil)
          (
            5
            '410108'
            '41010801'
            'IJP Produk Lainnya'
            '4.1.01.08.01'
            0
            nil
            nil)
          (
            3
            '41'
            '4102'
            'IJP Co-Guarantee/IJPU'
            '4.1.02.00.00'
            0
            nil
            nil)
          (
            4
            '4102'
            '410201'
            'IJP Kredit Produktif (KPd)'
            '4.1.02.01.00'
            0
            nil
            nil)
          (
            5
            '410201'
            '41020101'
            'CG/IJPU Sektor Agribisnis KPd'
            '4.1.02.01.01'
            0
            nil
            nil)
          (
            5
            '410201'
            '41020102'
            'CG/IJPU Sektor Indt & Tambang  KPd'
            '4.1.02.01.02'
            0
            nil
            nil)
          (
            5
            '410201'
            '41020103'
            'CG/IJPU Sektor Jasa & Dagang  KPd'
            '4.1.02.01.03'
            0
            nil
            nil)
          (
            5
            '410201'
            '41020104'
            'CG/IJPU Sektor Lainnya'
            '4.1.02.01.04'
            0
            nil
            nil)
          (
            4
            '4102'
            '410202'
            'IJP Kredit Program (KP)'
            '4.1.02.02.00'
            0
            nil
            nil)
          (
            5
            '410202'
            '41020201'
            'CG/IJPU Sektor Agribisnis KP'
            '4.1.02.02.01'
            0
            nil
            nil)
          (
            5
            '410202'
            '41020202'
            'CG/IJPU Sektor Indt & Tambang  KP'
            '4.1.02.02.02'
            0
            nil
            nil)
          (
            5
            '410202'
            '41020203'
            'CG/IJPU Sektor Jasa & Dagang  KP'
            '4.1.02.02.03'
            0
            nil
            nil)
          (
            5
            '410202'
            '41020204'
            'CG/IJPU Sektor Lainnya'
            '4.1.02.02.04'
            0
            nil
            nil)
          (
            4
            '4102'
            '410203'
            'IJP Kredit Non Bank (KNB)'
            '4.1.02.03.00'
            0
            nil
            nil)
          (
            5
            '410203'
            '41020301'
            'CG/IJPU Sektor Agribisnis KNB'
            '4.1.02.03.01'
            0
            nil
            nil)
          (
            5
            '410203'
            '41020302'
            'CG/IJPU Sektor Indt & Tambang  KNB'
            '4.1.02.03.02'
            0
            nil
            nil)
          (
            5
            '410203'
            '41020303'
            'CG/IJPU Sektor Jasa & Dagang  KNB'
            '4.1.02.03.03'
            0
            nil
            nil)
          (
            5
            '410203'
            '41020304'
            'CG/IJPU Sektor Lainnya'
            '4.1.02.03.04'
            0
            nil
            nil)
          (
            4
            '4102'
            '410204'
            'IJP Kredit Konsumtif'
            '4.1.02.04.00'
            0
            nil
            nil)
          (
            5
            '410204'
            '41020401'
            'CG/IJPU Kredit Kendaraan'
            '4.1.02.04.01'
            0
            nil
            nil)
          (
            5
            '410204'
            '41020402'
            'CG/IJPU KPR'
            '4.1.02.04.02'
            0
            nil
            nil)
          (
            5
            '410204'
            '41020403'
            'CG/IJPU Kredit Konsumtip Lainnya'
            '4.1.02.04.03'
            0
            nil
            nil)
          (
            4
            '4102'
            '410205'
            'IJP Surety Bond'
            '4.1.02.05.00'
            0
            nil
            nil)
          (
            5
            '410205'
            '41020501'
            'CG/IJPU Kontraktor'
            '4.1.02.05.01'
            0
            nil
            nil)
          (
            5
            '410205'
            '41020502'
            'CG/IJPU Supplier'
            '4.1.02.05.02'
            0
            nil
            nil)
          (
            5
            '410205'
            '41020503'
            'CG/IJPU Klaim Pembeli'
            '4.1.02.05.03'
            0
            nil
            nil)
          (
            5
            '410205'
            '41020504'
            'CG/IJPU Lainnya'
            '4.1.02.05.04'
            0
            nil
            nil)
          (
            4
            '4102'
            '410206'
            'IJP Kontra Garansi - Bank Garansi'
            '4.1.02.06.00'
            0
            nil
            nil)
          (
            5
            '410206'
            '41020601'
            'CG/IJPU Kontraktor'
            '4.1.02.06.01'
            0
            nil
            nil)
          (
            5
            '410206'
            '41020602'
            'CG/IJPU Supplier'
            '4.1.02.06.02'
            0
            nil
            nil)
          (
            5
            '410206'
            '41020603'
            'CG/IJPU Klaim Pembeli'
            '4.1.02.06.03'
            0
            nil
            nil)
          (
            5
            '410206'
            '41020604'
            'CG/IJPU Lainnya'
            '4.1.02.06.04'
            0
            nil
            nil)
          (
            4
            '4102'
            '410207'
            'IJP Kontra Garansi - L/C'
            '4.1.02.07.00'
            0
            nil
            nil)
          (
            5
            '410207'
            '41020701'
            'CG/IJPU Kontraktor'
            '4.1.02.07.01'
            0
            nil
            nil)
          (
            5
            '410207'
            '41020702'
            'CG/IJPU Supplier'
            '4.1.02.07.02'
            0
            nil
            nil)
          (
            5
            '410207'
            '41020703'
            'CG/IJPU Klaim Pembeli'
            '4.1.02.07.03'
            0
            nil
            nil)
          (
            5
            '410207'
            '41020704'
            'CG/IJPU Lainnya'
            '4.1.02.07.04'
            0
            nil
            nil)
          (
            4
            '4102'
            '410208'
            'IJP Produk Lainnya'
            '4.1.02.08.00'
            0
            nil
            nil)
          (
            5
            '410208'
            '41020801'
            'CG/IJPU Produk Lainnya'
            '4.1.02.08.01'
            0
            nil
            nil)
          (
            3
            '41'
            '4103'
            'Pendapatan Komisi Penjaminan'
            '4.1.03.00.00'
            0
            nil
            nil)
          (
            4
            '4103'
            '410301'
            'IJP Kredit Produktif (KPd)'
            '4.1.03.01.00'
            0
            nil
            nil)
          (
            5
            '410301'
            '41030101'
            'Komisi KPd Sektor Agribisnis'
            '4.1.03.01.01'
            0
            nil
            nil)
          (
            5
            '410301'
            '41030102'
            'Komisi KPd Sektor Indt & Tambang'
            '4.1.03.01.02'
            0
            nil
            nil)
          (
            5
            '410301'
            '41030103'
            'Komisi KPd Sektor Jasa & Dagang'
            '4.1.03.01.03'
            0
            nil
            nil)
          (
            5
            '410301'
            '41030104'
            'Komisi KPd Sektor Lainnya'
            '4.1.03.01.04'
            0
            nil
            nil)
          (
            4
            '4103'
            '410302'
            'IJP Kredit Program (KP)'
            '4.1.03.02.00'
            0
            nil
            nil)
          (
            5
            '410302'
            '41030201'
            'Komisi KP Sektor Agribisnis KP'
            '4.1.03.02.01'
            0
            nil
            nil)
          (
            5
            '410302'
            '41030202'
            'Komisi KP Sektor Indt & Tambang  KP'
            '4.1.03.02.02'
            0
            nil
            nil)
          (
            5
            '410302'
            '41030203'
            'Komisi KP Sektor Jasa & Dagang  KP'
            '4.1.03.02.03'
            0
            nil
            nil)
          (
            5
            '410302'
            '41030204'
            'Komisi KP Sektor Lainnya'
            '4.1.03.02.04'
            0
            nil
            nil)
          (
            4
            '4103'
            '410303'
            'IJP Kredit Non Bank (KNB)'
            '4.1.03.03.00'
            0
            nil
            nil)
          (
            5
            '410303'
            '41030301'
            'Komisi KNB Sektor Agribisnis KNB'
            '4.1.03.03.01'
            0
            nil
            nil)
          (
            5
            '410303'
            '41030302'
            'Komisi KNB Sektor Indt & Tambang  KNB'
            '4.1.03.03.02'
            0
            nil
            nil)
          (
            5
            '410303'
            '41030303'
            'Komisi KNB Sektor Jasa & Dagang  KNB'
            '4.1.03.03.03'
            0
            nil
            nil)
          (
            5
            '410303'
            '41030304'
            'Komisi KNB Sektor Lainnya'
            '4.1.03.03.04'
            0
            nil
            nil)
          (
            4
            '4103'
            '410304'
            'IJP Kredit Konsumtif'
            '4.1.03.04.00'
            0
            nil
            nil)
          (
            5
            '410304'
            '41030401'
            'Komisi Kr. Konsumtif Kredit Kendaraan'
            '4.1.03.04.01'
            0
            nil
            nil)
          (
            5
            '410304'
            '41030402'
            'Komisi Kr. Konsumtif KPR'
            '4.1.03.04.02'
            0
            nil
            nil)
          (
            5
            '410304'
            '41030403'
            'Komisi Kr. Konsumtif Kredit Konsumtip Lainnya'
            '4.1.03.04.03'
            0
            nil
            nil)
          (
            4
            '4103'
            '410305'
            'IJP Surety Bond'
            '4.1.03.05.00'
            0
            nil
            nil)
          (
            5
            '410305'
            '41030501'
            'Komisi SB Kontraktor'
            '4.1.03.05.01'
            0
            nil
            nil)
          (
            5
            '410305'
            '41030502'
            'Komisi SB Supplier'
            '4.1.03.05.02'
            0
            nil
            nil)
          (
            5
            '410305'
            '41030503'
            'Komisi SB Klaim Pembeli'
            '4.1.03.05.03'
            0
            nil
            nil)
          (
            5
            '410305'
            '41030504'
            'Komisi SB Lainnya'
            '4.1.03.05.04'
            0
            nil
            nil)
          (
            4
            '4103'
            '410306'
            'IJP Kontra Garansi - Bank Garansi'
            '4.1.03.06.00'
            0
            nil
            nil)
          (
            5
            '410306'
            '41030601'
            'Komisi CG-BG Kontraktor'
            '4.1.03.06.01'
            0
            nil
            nil)
          (
            5
            '410306'
            '41030602'
            'Komisi CG-BG Supplier'
            '4.1.03.06.02'
            0
            nil
            nil)
          (
            5
            '410306'
            '41030603'
            'Komisi CG-BG Klaim Pembeli'
            '4.1.03.06.03'
            0
            nil
            nil)
          (
            5
            '410306'
            '41030604'
            'Komisi CG-BG Lainnya'
            '4.1.03.06.04'
            0
            nil
            nil)
          (
            4
            '4103'
            '410307'
            'IJP Kontra Garansi - L/C'
            '4.1.03.07.00'
            0
            nil
            nil)
          (
            5
            '410307'
            '41030701'
            'Komisi CG-L/C Kontraktor'
            '4.1.03.07.01'
            0
            nil
            nil)
          (
            5
            '410307'
            '41030702'
            'Komisi CG-L/C Supplier'
            '4.1.03.07.02'
            0
            nil
            nil)
          (
            5
            '410307'
            '41030703'
            'Komisi CG-L/C Klaim Pembeli'
            '4.1.03.07.03'
            0
            nil
            nil)
          (
            5
            '410307'
            '41030704'
            'Komisi CG-L/C Lainnya'
            '4.1.03.07.04'
            0
            nil
            nil)
          (
            4
            '4103'
            '410308'
            'IJP Produk Lainnya'
            '4.1.03.08.00'
            0
            nil
            nil)
          (
            5
            '410308'
            '41030801'
            'Komisi Produk Lainnya'
            '4.1.03.08.01'
            0
            nil
            nil)
          (
            3
            '41'
            '4104'
            'Pendapatan Penjaminan Lainnya'
            '4.1.04.00.00'
            0
            nil
            nil)
          (
            4
            '4104'
            '410401'
            'Pendapatan Penjaminan Lainnya'
            '4.1.04.01.00'
            0
            nil
            nil)
          (
            5
            '410401'
            '41040101'
            'Pendapatan Penjaminan Lainnya'
            '4.1.04.01.01'
            0
            nil
            nil)
          (
            2
            '4'
            '42'
            'Pendapatan Operasional Lainnya'
            '4.2.00.00.00'
            0
            nil
            nil)
          (
            3
            '42'
            '4201'
            'Pendapatan Bunga'
            '4.2.01.00.00'
            0
            nil
            nil)
          (
            4
            '4201'
            '420101'
            'Pendapatan Bunga Jasa Giro/Tabungan'
            '4.2.01.01.00'
            0
            nil
            nil)
          (
            5
            '420101'
            '42010101'
            'Pendapatan Bunga Jasa Giro/Tab Bank Sulselbar'
            '4.2.01.01.01'
            0
            nil
            nil)
          (
            5
            '420101'
            '42010102'
            'Pendapatan Bunga Jasa Giro/Tab Bank BRI'
            '4.2.01.01.02'
            0
            nil
            nil)
          (
            5
            '420101'
            '42010103'
            'Pendapatan Bunga Jasa Giro/Tab Bank CIMB Niaga'
            '4.2.01.01.03'
            0
            nil
            nil)
          (
            5
            '420101'
            '42010104'
            'Pendapatan Bunga Jasa Giro/Tab Bank Panin'
            '4.2.01.01.04'
            0
            nil
            nil)
          (
            4
            '4201'
            '420102'
            'Pendapatan Bunga Deposito'
            '4.2.01.02.00'
            0
            nil
            nil)
          (
            5
            '420102'
            '42010201'
            'Pendapatan Bunga Deposito Bank Sulselbar'
            '4.2.01.02.01'
            0
            nil
            nil)
          (
            5
            '420102'
            '42010202'
            'Pendapatan Bunga Deposito Bank BRI'
            '4.2.01.02.02'
            0
            nil
            nil)
          (
            5
            '420102'
            '42010203'
            'Pendapatan Bunga Deposito Bank CIMB NIaga'
            '4.2.01.02.03'
            0
            nil
            nil)
          (
            5
            '420102'
            '42010204'
            'Pendapatan Bunga Deposito Bank Panin'
            '4.2.01.02.04'
            0
            nil
            nil)
          (
            5
            '420102'
            '42010205'
            'Pendapatan Bunga Deposito Bank Sulselbar Syariah'
            '4.2.01.02.05'
            6
            nil
            nil)
          (
            5
            '420102'
            '42010206'
            'Pendapatan Bunga Deposito PD. BPR Citra Mas'
            '4.2.01.02.06'
            1
            nil
            nil)
          (
            4
            '4201'
            '420103'
            'Pendapatan Bunga Obligasi'
            '4.2.01.03.00'
            0
            nil
            nil)
          (
            5
            '420103'
            '42010301'
            'Pendapatan Bunga Obligasi'
            '4.2.01.03.01'
            0
            nil
            nil)
          (
            4
            '4201'
            '420104'
            'Pendapatan Bunga Surat Utang Negara'
            '4.2.01.04.00'
            0
            nil
            nil)
          (
            5
            '420104'
            '42010401'
            'Pendapatan Bunga Surat Utang Negara'
            '4.2.01.04.01'
            0
            nil
            nil)
          (
            4
            '4201'
            '420105'
            'Pendapatan Bunga Surat Berharga Lainnya'
            '4.2.01.05.00'
            0
            nil
            nil)
          (
            5
            '420105'
            '42010501'
            'Pendapatan Bunga Surat Berharga Lainnya'
            '4.2.01.05.01'
            0
            nil
            nil)
          (
            3
            '42'
            '4202'
            'Pendapatan Investasi Selain Bunga'
            '4.2.02.00.00'
            0
            nil
            nil)
          (
            4
            '4202'
            '420201'
            'Pendapatan Investasi Selain Bunga'
            '4.2.02.01.00'
            0
            nil
            nil)
          (
            5
            '420201'
            '42020101'
            'Pendapatan Investasi Selain Bunga'
            '4.2.02.01.01'
            0
            nil
            nil)
          (
            3
            '42'
            '4203'
            'Pendapatan Peningkatan Nilai Wajar Aset Keuangan'
            '4.2.03.00.00'
            0
            nil
            nil)
          (
            4
            '4203'
            '420301'
            'Pendapatan Peningkatan Nilai Wajar Aset Keuangan'
            '4.2.03.01.00'
            0
            nil
            nil)
          (
            5
            '420301'
            '42030101'
            'Pendapatan Peningkatan Nilai Wajar Aset Keuangan'
            '4.2.03.01.01'
            0
            nil
            nil)
          (
            3
            '42'
            '4204'
            'Pendapatan Penurunan Nilai Wajar Liabilitas Keuangan'
            '4.2.04.00.00'
            0
            nil
            nil)
          (
            4
            '4204'
            '420401'
            'Pendapatan Penurunan Nilai Wajar Liabilitas Keuangan'
            '4.2.04.01.00'
            0
            nil
            nil)
          (
            5
            '420401'
            '42040101'
            'Pendapatan Penurunan Nilai Wajar Liabilitas Keuangan'
            '4.2.04.01.01'
            0
            nil
            nil)
          (
            3
            '42'
            '4205'
            'Keuntungan Penjualan Aset Keuangan'
            '4.2.05.00.00'
            0
            nil
            nil)
          (
            4
            '4205'
            '420501'
            'Keuntungan Penjualan Aset Keuangan'
            '4.2.05.01.00'
            0
            nil
            nil)
          (
            5
            '420501'
            '42050101'
            'Keuntungan Penjualan Aset Keuangan'
            '4.2.05.01.01'
            0
            nil
            nil)
          (
            3
            '42'
            '4206'
            'Pendapatan Operasional Lain-Lain'
            '4.2.06.00.00'
            0
            nil
            nil)
          (
            4
            '4206'
            '420601'
            'Pendapatan Operasional Lain-Lain'
            '4.2.06.01.00'
            0
            nil
            nil)
          (
            5
            '420601'
            '42060101'
            'Pendapatan Operasional Lain-Lain'
            '4.2.06.01.01'
            1
            nil
            nil)
          (
            2
            '4'
            '43'
            'Pendapatan Non Operasional'
            '4.3.00.00.00'
            0
            nil
            nil)
          (
            3
            '43'
            '4301'
            'Keuntungan Penjualan Aset Tetap'
            '4.3.01.00.00'
            0
            nil
            nil)
          (
            4
            '4301'
            '430101'
            'Keuntungan Penjualan Aset Tetap'
            '4.3.01.01.00'
            0
            nil
            nil)
          (
            5
            '430101'
            '43010101'
            'Keuntungan Penjualan Aset Tetap'
            '4.3.01.01.01'
            0
            nil
            nil)
          (
            3
            '43'
            '4302'
            'Pendapatan Non Operasional'
            '4.3.02.00.00'
            0
            nil
            nil)
          (
            4
            '4302'
            '430201'
            'Pendapatan Non Operasional'
            '4.3.02.01.00'
            0
            nil
            nil)
          (
            5
            '430201'
            '43020101'
            'Pendapatan Non Operasional'
            '4.3.02.01.01'
            28
            nil
            nil)
          (
            2
            '4'
            '44'
            'Pendapatan Komprehensip Lainnya'
            '4.4.00.00.00'
            0
            nil
            nil)
          (
            3
            '44'
            '4401'
            'Pendapatan Komprehensip Lainnya'
            '4.4.01.00.00'
            0
            nil
            nil)
          (
            4
            '4401'
            '440101'
            'Pendapatan Komprehensip Lainnya'
            '4.4.01.01.00'
            0
            nil
            nil)
          (
            5
            '440101'
            '44010101'
            'Pendapatan Komprehensip Lainnya'
            '4.4.01.01.01'
            0
            nil
            nil)
          (
            1
            '*'
            '5'
            'Beban'
            '5.0.00.00.00'
            0
            nil
            nil)
          (
            2
            '5'
            '51'
            'Beban Klaim'
            '5.1.00.00.00'
            0
            nil
            nil)
          (
            3
            '51'
            '5101'
            'Beban Klaim Bruto'
            '5.1.01.00.00'
            0
            nil
            nil)
          (
            4
            '5101'
            '510101'
            'SP Kredit Produktif (KPD)'
            '5.1.01.01.00'
            0
            nil
            nil)
          (
            5
            '510101'
            '51010101'
            'SP Kredit Produktif (KPD)'
            '5.1.01.01.01'
            0
            nil
            nil)
          (
            4
            '5101'
            '510102'
            'SP Kredit Program (KP)'
            '5.1.01.02.00'
            0
            nil
            nil)
          (
            5
            '510102'
            '51010201'
            'SP Kredit Program (KP)'
            '5.1.01.02.01'
            0
            nil
            nil)
          (
            4
            '5101'
            '510103'
            'SP Kredit Non Bank (KNB)'
            '5.1.01.03.00'
            0
            nil
            nil)
          (
            5
            '510103'
            '51010301'
            'SP Kredit Non Bank (KNB)'
            '5.1.01.03.01'
            0
            nil
            nil)
          (
            4
            '5101'
            '510104'
            'SP Kredit Konsumtif'
            '5.1.01.04.00'
            0
            nil
            nil)
          (
            5
            '510104'
            '51010401'
            'SP Kredit Konsumtif'
            '5.1.01.04.01'
            0
            nil
            nil)
          (
            4
            '5101'
            '510105'
            'Klaim Surety Bonk'
            '5.1.01.05.00'
            0
            nil
            nil)
          (
            5
            '510105'
            '51010501'
            'Klaim Surety Bonk'
            '5.1.01.05.01'
            0
            nil
            nil)
          (
            4
            '5101'
            '510106'
            'Klaim Kontra Garansi - Bank Garansi'
            '5.1.01.06.00'
            0
            nil
            nil)
          (
            5
            '510106'
            '51010601'
            'Klaim Kontra Garansi - Bank Garansi'
            '5.1.01.06.01'
            0
            nil
            nil)
          (
            4
            '5101'
            '510107'
            'Klaim Kontra Garansi - L/C'
            '5.1.01.07.00'
            0
            nil
            nil)
          (
            5
            '510107'
            '51010701'
            'Klaim Kontra Garansi - L/C'
            '5.1.01.07.01'
            0
            nil
            nil)
          (
            4
            '5101'
            '510108'
            'Klaim SP Produk Lainnya'
            '5.1.01.08.00'
            0
            nil
            nil)
          (
            5
            '510108'
            '51010801'
            'Klaim SP Produk Lainnya'
            '5.1.01.08.01'
            0
            nil
            nil)
          (
            3
            '51'
            '5102'
            'Beban Klaim Co-Guarantee/Penjaminan Ulang'
            '5.1.02.00.00'
            0
            nil
            nil)
          (
            4
            '5102'
            '510201'
            'SP Kredit Produktif (KPD)'
            '5.1.02.01.00'
            0
            nil
            nil)
          (
            5
            '510201'
            '51020101'
            'SP Kredit Produktif (KPD)'
            '5.1.02.01.01'
            0
            nil
            nil)
          (
            4
            '5102'
            '510202'
            'SP Kredit Program (KP)'
            '5.1.02.02.00'
            0
            nil
            nil)
          (
            5
            '510202'
            '51020201'
            'SP Kredit Program (KP)'
            '5.1.02.02.01'
            0
            nil
            nil)
          (
            4
            '5102'
            '510203'
            'SP Kredit Non Bank (KNB)'
            '5.1.02.03.00'
            0
            nil
            nil)
          (
            5
            '510203'
            '51020301'
            'SP Kredit Non Bank (KNB)'
            '5.1.02.03.01'
            0
            nil
            nil)
          (
            4
            '5102'
            '510204'
            'SP Kredit Konsumtif'
            '5.1.02.04.00'
            0
            nil
            nil)
          (
            5
            '510204'
            '51020401'
            'SP Kredit Konsumtif'
            '5.1.02.04.01'
            0
            nil
            nil)
          (
            4
            '5102'
            '510205'
            'Klaim Surety Bond'
            '5.1.02.05.00'
            0
            nil
            nil)
          (
            5
            '510205'
            '51020501'
            'Klaim Surety Bond'
            '5.1.02.05.01'
            0
            nil
            nil)
          (
            4
            '5102'
            '510206'
            'Klaim Kontra Garansi - Bank Garansi'
            '5.1.02.06.00'
            0
            nil
            nil)
          (
            5
            '510206'
            '51020601'
            'Klaim Kontra Garansi - Bank Garansi'
            '5.1.02.06.01'
            0
            nil
            nil)
          (
            4
            '5102'
            '510207'
            'Klaim Kontra Garansi - L/C'
            '5.1.02.07.00'
            0
            nil
            nil)
          (
            5
            '510207'
            '51020701'
            'Klaim Kontra Garansi - L/C'
            '5.1.02.07.01'
            0
            nil
            nil)
          (
            4
            '5102'
            '510208'
            'Klaim SP Produk Lainnya'
            '5.1.02.08.00'
            0
            nil
            nil)
          (
            5
            '510208'
            '51020801'
            'Klaim SP Produk Lainnya'
            '5.1.02.08.01'
            0
            nil
            nil)
          (
            3
            '51'
            '5103'
            'Penurunan/Kenaikan Cadangan Klaim'
            '5.1.03.00.00'
            0
            nil
            nil)
          (
            4
            '5103'
            '510301'
            'SP Kredit Produktif (KPD)'
            '5.1.03.01.00'
            0
            nil
            nil)
          (
            5
            '510301'
            '51030101'
            'SP Kredit Produktif (KPD)'
            '5.1.03.01.01'
            0
            nil
            nil)
          (
            4
            '5103'
            '510302'
            'SP Kredit Program (KP)'
            '5.1.03.02.00'
            0
            nil
            nil)
          (
            5
            '510302'
            '51030201'
            'SP Kredit Program (KP)'
            '5.1.03.02.01'
            0
            nil
            nil)
          (
            4
            '5103'
            '510303'
            'SP Kredit Non Bank (KNB)'
            '5.1.03.03.00'
            0
            nil
            nil)
          (
            5
            '510303'
            '51030301'
            'SP Kredit Non Bank (KNB)'
            '5.1.03.03.01'
            0
            nil
            nil)
          (
            4
            '5103'
            '510304'
            'SP Kredit Konsumtif'
            '5.1.03.04.00'
            0
            nil
            nil)
          (
            5
            '510304'
            '51030401'
            'SP Kredit Konsumtif'
            '5.1.03.04.01'
            0
            nil
            nil)
          (
            4
            '5103'
            '510305'
            'Surety Bond'
            '5.1.03.05.00'
            0
            nil
            nil)
          (
            5
            '510305'
            '51030501'
            'Surety Bond'
            '5.1.03.05.01'
            0
            nil
            nil)
          (
            4
            '5103'
            '510306'
            'Kontra Garansi - Bank Garansi'
            '5.1.03.06.00'
            0
            nil
            nil)
          (
            5
            '510306'
            '51030601'
            'Kontra Garansi - Bank Garansi'
            '5.1.03.06.01'
            0
            nil
            nil)
          (
            4
            '5103'
            '510307'
            'Kontra Garansi - L/C'
            '5.1.03.07.00'
            0
            nil
            nil)
          (
            5
            '510307'
            '51030701'
            'Kontra Garansi - L/C'
            '5.1.03.07.01'
            0
            nil
            nil)
          (
            4
            '5103'
            '510308'
            'SP Produk Lainnya'
            '5.1.03.08.00'
            0
            nil
            nil)
          (
            5
            '510308'
            '51030801'
            'SP Produk Lainnya'
            '5.1.03.08.01'
            0
            nil
            nil)
          (
            3
            '51'
            '5104'
            'Beban Klaim Lainnya'
            '5.1.04.00.00'
            0
            nil
            nil)
          (
            4
            '5104'
            '510401'
            'Beban Klaim Lainnya'
            '5.1.04.01.00'
            0
            nil
            nil)
          (
            5
            '510401'
            '51040101'
            'Beban Klaim Lainnya'
            '5.1.04.01.01'
            0
            nil
            nil)
          (
            2
            '5'
            '52'
            'Beban Operasional Lainnya'
            '5.2.00.00.00'
            0
            nil
            nil)
          (
            3
            '52'
            '5201'
            'Beban Gaji dan Pegawai'
            '5.2.01.00.00'
            0
            nil
            nil)
          (
            4
            '5201'
            '520101'
            'Beban Direksi'
            '5.2.01.01.00'
            0
            nil
            nil)
          (
            5
            '520101'
            '52010101'
            'Gaji Direksi'
            '5.2.01.01.01'
            2
            nil
            nil)
          (
            5
            '520101'
            '52010102'
            'Tunjangan Kesehatan Direksi'
            '5.2.01.01.02'
            0
            nil
            nil)
          (
            5
            '520101'
            '52010103'
            'Tunjangan Pakaian Kerja Direksi'
            '5.2.01.01.03'
            1
            nil
            nil)
          (
            5
            '520101'
            '52010104'
            'Tunjangan Kesejahteraan Direksi'
            '5.2.01.01.04'
            0
            nil
            nil)
          (
            5
            '520101'
            '52010105'
            'Tunjangan Perumahan Direksi'
            '5.2.01.01.05'
            0
            nil
            nil)
          (
            5
            '520101'
            '52010106'
            'Tunjangan Transfort Direksi'
            '5.2.01.01.06'
            0
            nil
            nil)
          (
            5
            '520101'
            '52010107'
            'Tunjangan hari Raya Direksi'
            '5.2.01.01.07'
            0
            nil
            nil)
          (
            5
            '520101'
            '52010108'
            'Beban Konsumsi Direksi'
            '5.2.01.01.08'
            0
            nil
            nil)
          (
            5
            '520101'
            '52010109'
            'Beban Cuti Direksi'
            '5.2.01.01.09'
            0
            nil
            nil)
          (
            5
            '520101'
            '52010110'
            'Beban Premi Pensiun Direksi'
            '5.2.01.01.10'
            0
            nil
            nil)
          (
            5
            '520101'
            '52010111'
            'Beban BPJS Direksi'
            '5.2.01.01.11'
            0
            nil
            nil)
          (
            5
            '520101'
            '52010112'
            'Beban PPh Pasal 21'
            '5.2.01.01.12'
            0
            nil
            nil)
          (
            5
            '520101'
            '52010113'
            'Beban Insentif Direksi'
            '5.2.01.01.13'
            0
            nil
            nil)
          (
            5
            '520101'
            '52010114'
            'Beban Asuransi Kesehatan Direksi'
            '5.2.01.01.14'
            0
            nil
            nil)
          (
            5
            '520101'
            '52010115'
            'Jasa Produksi Direksi'
            '5.2.01.01.15'
            0
            nil
            nil)
          (
            5
            '520101'
            '52010116'
            'Tunjangan Lainnya'
            '5.2.01.01.16'
            0
            nil
            nil)
          (
            4
            '5201'
            '520102'
            'Beban Dewan Komisaris'
            '5.2.01.02.00'
            0
            nil
            nil)
          (
            5
            '520102'
            '52010201'
            'Gaji Dewan Komisaris'
            '5.2.01.02.01'
            1
            nil
            nil)
          (
            5
            '520102'
            '52010202'
            'Tunjangan Kesehatan Dewan Komisaris'
            '5.2.01.02.02'
            0
            nil
            nil)
          (
            5
            '520102'
            '52010203'
            'Tunjangan Pakaian Kerja Dewan Komisaris'
            '5.2.01.02.03'
            0
            nil
            nil)
          (
            5
            '520102'
            '52010204'
            'Tunjangan Kesejahteraan Dewan Komisaris'
            '5.2.01.02.04'
            0
            nil
            nil)
          (
            5
            '520102'
            '52010205'
            'Tunjangan Perumahan Dewan Komisaris'
            '5.2.01.02.05'
            0
            nil
            nil)
          (
            5
            '520102'
            '52010206'
            'Tunjangan Transfort Dewan Komisaris'
            '5.2.01.02.06'
            0
            nil
            nil)
          (
            5
            '520102'
            '52010207'
            'Tunjangan hari Raya Dewan Komisaris'
            '5.2.01.02.07'
            0
            nil
            nil)
          (
            5
            '520102'
            '52010208'
            'Beban Konsumsi Dewan Komisaris'
            '5.2.01.02.08'
            0
            nil
            nil)
          (
            5
            '520102'
            '52010209'
            'Beban Cuti Dewan Komisaris'
            '5.2.01.02.09'
            0
            nil
            nil)
          (
            5
            '520102'
            '52010210'
            'Beban Premi Pensiun Dewan Komisaris'
            '5.2.01.02.10'
            0
            nil
            nil)
          (
            5
            '520102'
            '52010211'
            'Beban BPJS Dewan Komisaris'
            '5.2.01.02.11'
            0
            nil
            nil)
          (
            5
            '520102'
            '52010212'
            'Beban PPh Pasal 21'
            '5.2.01.02.12'
            0
            nil
            nil)
          (
            5
            '520102'
            '52010213'
            'Beban Insentif Dewan Komisaris'
            '5.2.01.02.13'
            0
            nil
            nil)
          (
            5
            '520102'
            '52010214'
            'Beban Asuransi Kesehatan Dewan Komisaris'
            '5.2.01.02.14'
            0
            nil
            nil)
          (
            5
            '520102'
            '52010215'
            'Jasa Produksi Dewan Komisaris'
            '5.2.01.02.15'
            0
            nil
            nil)
          (
            5
            '520102'
            '52010216'
            'Tunjangan Lainnya'
            '5.2.01.02.16'
            0
            nil
            nil)
          (
            4
            '5201'
            '520103'
            'Beban Karyawan'
            '5.2.01.03.00'
            0
            nil
            nil)
          (
            5
            '520103'
            '52010301'
            'Gaji Karyawan'
            '5.2.01.03.01'
            1
            nil
            nil)
          (
            5
            '520103'
            '52010302'
            'Tunjangan Kesehatan'
            '5.2.01.03.02'
            0
            nil
            nil)
          (
            5
            '520103'
            '52010303'
            'Tunjangan Pakaian Kerja'
            '5.2.01.03.03'
            0
            nil
            nil)
          (
            5
            '520103'
            '52010304'
            'Tunjangan Kesejahteraan'
            '5.2.01.03.04'
            0
            nil
            nil)
          (
            5
            '520103'
            '52010305'
            'Tunjangan Perumahan'
            '5.2.01.03.05'
            0
            nil
            nil)
          (
            5
            '520103'
            '52010306'
            'Tunjangan Transfort'
            '5.2.01.03.06'
            1
            nil
            nil)
          (
            5
            '520103'
            '52010307'
            'Tunjangan Hari Raya'
            '5.2.01.03.07'
            0
            nil
            nil)
          (
            5
            '520103'
            '52010308'
            'Beban Konsumsi'
            '5.2.01.03.08'
            1
            nil
            nil)
          (
            5
            '520103'
            '52010309'
            'Beban Cuti Karyawan'
            '5.2.01.03.09'
            0
            nil
            nil)
          (
            5
            '520103'
            '52010310'
            'Beban Premi Pensiun'
            '5.2.01.03.10'
            0
            nil
            nil)
          (
            5
            '520103'
            '52010311'
            'Beban PPh Pasal 21'
            '5.2.01.03.11'
            0
            nil
            nil)
          (
            5
            '520103'
            '52010312'
            'Beban Insentif Karyawan'
            '5.2.01.03.12'
            0
            nil
            nil)
          (
            5
            '520103'
            '52010313'
            'Beban Jasa Produksi (Tantiem)'
            '5.2.01.03.13'
            0
            nil
            nil)
          (
            5
            '520103'
            '52010314'
            'Beban Lembur'
            '5.2.01.03.14'
            1
            nil
            nil)
          (
            5
            '520103'
            '52010315'
            'Beban Pendidikan dan Pelatihan'
            '5.2.01.03.15'
            0
            nil
            nil)
          (
            5
            '520103'
            '52010316'
            'Tunjangan Jabatan'
            '5.2.01.03.16'
            1
            nil
            nil)
          (
            5
            '520103'
            '52010317'
            'Tunjangan Lainnya'
            '5.2.01.03.17'
            0
            nil
            nil)
          (
            4
            '5201'
            '520104'
            'Pembulatan Gaji'
            '5.2.01.04.00'
            0
            nil
            nil)
          (
            5
            '520104'
            '52010401'
            'Pembulatan Gaji'
            '5.2.01.04.01'
            0
            nil
            nil)
          (
            3
            '52'
            '5202'
            'Beban Depresesiasi dan Amortisasi'
            '5.2.02.00.00'
            0
            nil
            nil)
          (
            4
            '5202'
            '520201'
            'Beban Penyusutan'
            '5.2.02.01.00'
            0
            nil
            nil)
          (
            5
            '520201'
            '52020101'
            'Beban Penyusutan Gedung Kantor'
            '5.2.02.01.01'
            0
            nil
            nil)
          (
            5
            '520201'
            '52020102'
            'Beban Penyusutan Inventaris Kantor'
            '5.2.02.01.02'
            3
            nil
            nil)
          (
            5
            '520201'
            '52020103'
            'Beban Penyusutan Kendaraan'
            '5.2.02.01.03'
            14
            nil
            nil)
          (
            5
            '520201'
            '52020104'
            'Beban Penyusutan Inventaris Lainnya'
            '5.2.02.01.04'
            2
            nil
            nil)
          (
            4
            '5202'
            '520202'
            'Beban Amortisasi'
            '5.2.02.02.00'
            0
            nil
            nil)
          (
            5
            '520202'
            '52020201'
            'Biaya Sewa Gedung'
            '5.2.02.02.01'
            10
            nil
            nil)
          (
            5
            '520202'
            '52020202'
            'Biaya Asuransi Kendaraan'
            '5.2.02.02.02'
            1
            nil
            nil)
          (
            5
            '520202'
            '52020203'
            'Biaya Pendirian'
            '5.2.02.02.03'
            1573
            nil
            nil)
          (
            5
            '520202'
            '52020204'
            'Biaya Program Komputerisasi dan SIM'
            '5.2.02.02.04'
            13
            nil
            nil)
          (
            5
            '520202'
            '52020205'
            'Beban Dibayar Di Muka Lainnya'
            '5.2.02.02.05'
            109
            nil
            nil)
          (
            3
            '52'
            '5203'
            'Beban Umum dan Administrasi Lainnya'
            '5.2.03.00.00'
            0
            nil
            nil)
          (
            4
            '5203'
            '520301'
            'Beban Administrasi'
            '5.2.03.01.00'
            0
            nil
            nil)
          (
            5
            '520301'
            '52030101'
            'Beban ATK'
            '5.2.03.01.01'
            2
            nil
            nil)
          (
            5
            '520301'
            '52030102'
            'Beban Bank'
            '5.2.03.01.02'
            0
            nil
            nil)
          (
            5
            '520301'
            '52030103'
            'Beban Konsultasi'
            '5.2.03.01.03'
            0
            nil
            nil)
          (
            5
            '520301'
            '52030104'
            'Beban Perijinan'
            '5.2.03.01.04'
            0
            nil
            nil)
          (
            5
            '520301'
            '52030105'
            'Beban PBB'
            '5.2.03.01.05'
            0
            nil
            nil)
          (
            5
            '520301'
            '52030106'
            'PPN Masukan'
            '5.2.03.01.06'
            0
            nil
            nil)
          (
            5
            '520301'
            '52030107'
            'Beban Pungutan / Iuran OJK'
            '5.2.03.01.07'
            2
            nil
            nil)
          (
            5
            '520301'
            '52030108'
            'Beban Pajak Atas Bunga'
            '5.2.03.01.08'
            0
            nil
            nil)
          (
            4
            '5203'
            '520302'
            'Beban Sewa'
            '5.2.03.02.00'
            0
            nil
            nil)
          (
            5
            '520302'
            '52030201'
            'Beban Sewa Gedung Kantor'
            '5.2.03.02.01'
            0
            nil
            nil)
          (
            5
            '520302'
            '52030202'
            'Beban Sewa Rumah Dinas'
            '5.2.03.02.02'
            0
            nil
            nil)
          (
            5
            '520302'
            '52030203'
            'Beban Sewa Peralatan Kantor'
            '5.2.03.02.03'
            0
            nil
            nil)
          (
            5
            '520302'
            '52030204'
            'Beban Sewa Kendaraan'
            '5.2.03.02.04'
            1
            nil
            nil)
          (
            5
            '520302'
            '52030205'
            'Beban Sewa Lain-Lain'
            '5.2.03.02.05'
            0
            nil
            nil)
          (
            4
            '5203'
            '520303'
            'Beban Komunikasi dan Energi'
            '5.2.03.03.00'
            0
            nil
            nil)
          (
            5
            '520303'
            '52030301'
            'Beban Listrik'
            '5.2.03.03.01'
            2
            nil
            nil)
          (
            5
            '520303'
            '52030302'
            'Beban Telepon'
            '5.2.03.03.02'
            2
            nil
            nil)
          (
            5
            '520303'
            '52030303'
            'Beban PDAM'
            '5.2.03.03.03'
            0
            nil
            nil)
          (
            5
            '520303'
            '52030304'
            'Beban Komunikasi dan Energi Lainnya'
            '5.2.03.03.04'
            1
            nil
            nil)
          (
            4
            '5203'
            '520304'
            'Beban Pemeliharaan Aktiva Tetap'
            '5.2.03.04.00'
            0
            nil
            nil)
          (
            5
            '520304'
            '52030401'
            'Beban Pemeliharaan Inventaris'
            '5.2.03.04.01'
            0
            nil
            nil)
          (
            5
            '520304'
            '52030402'
            'Beban Pemeliharaan Aktiva Tetap'
            '5.2.03.04.02'
            0
            nil
            nil)
          (
            4
            '5203'
            '520305'
            'Beban Umum Lainnya'
            '5.2.03.05.00'
            0
            nil
            nil)
          (
            5
            '520305'
            '52030501'
            'Beban Representasi'
            '5.2.03.05.01'
            0
            nil
            nil)
          (
            5
            '520305'
            '52030502'
            'Beban Rapat Kerja'
            '5.2.03.05.02'
            0
            nil
            nil)
          (
            5
            '520305'
            '52030503'
            'Beban Pemeriksaan (KAP)'
            '5.2.03.05.03'
            0
            nil
            nil)
          (
            5
            '520305'
            '52030504'
            'Beban Pindah Kantor'
            '5.2.03.05.04'
            0
            nil
            nil)
          (
            5
            '520305'
            '52030505'
            'Beban Pemasaran'
            '5.2.03.05.05'
            0
            nil
            nil)
          (
            5
            '520305'
            '52030506'
            'Beban Penyisihan Piutang Lain'
            '5.2.03.05.06'
            0
            nil
            nil)
          (
            5
            '520305'
            '52030507'
            'Beban Amortisasi Biaya Yang Ditangguhkan'
            '5.2.03.05.07'
            0
            nil
            nil)
          (
            5
            '520305'
            '52030508'
            'Beban Perjalanan Dinas'
            '5.2.03.05.08'
            1
            nil
            nil)
          (
            5
            '520305'
            '52030509'
            'Beban Maintanance Komputerisasi & SIM'
            '5.2.03.05.09'
            0
            nil
            nil)
          (
            5
            '520305'
            '52030510'
            'Beban Promosi dan Publikasi'
            '5.2.03.05.10'
            0
            nil
            nil)
          (
            5
            '520305'
            '52030511'
            'Beban Makan Minum Kantor, Tamu dan Mitra'
            '5.2.03.05.11'
            6
            nil
            nil)
          (
            5
            '520305'
            '52030512'
            'Beban Bahan Bakar Minyak (BBM)'
            '5.2.03.05.12'
            1
            nil
            nil)
          (
            5
            '520305'
            '52030513'
            'Beban Lain-Lain'
            '5.2.03.05.13'
            2
            nil
            nil)
          (
            3
            '52'
            '5204'
            'Penurunan Nilai Wajar Aset Keuangan'
            '5.2.04.00.00'
            0
            nil
            nil)
          (
            4
            '5204'
            '520401'
            'Penurunan Nilai Wajar Aset Keuangan'
            '5.2.04.01.00'
            0
            nil
            nil)
          (
            5
            '520401'
            '52040101'
            'Penurunan Nilai Wajar Aset Keuangan'
            '5.2.04.01.01'
            0
            nil
            nil)
          (
            3
            '52'
            '5205'
            'Kenaikan Nilai Wajar Liabilitas Keuangan'
            '5.2.05.00.00'
            0
            nil
            nil)
          (
            4
            '5205'
            '520501'
            'Kenaikan Nilai Wajar Liabilitas Keuangan'
            '5.2.05.01.00'
            0
            nil
            nil)
          (
            5
            '520501'
            '52050101'
            'Kenaikan Nilai Wajar Liabilitas Keuangan'
            '5.2.05.01.01'
            0
            nil
            nil)
          (
            3
            '52'
            '5206'
            'Kerugian Penjualan Aset Keuangan'
            '5.2.06.00.00'
            0
            nil
            nil)
          (
            4
            '5206'
            '520601'
            'Kerugian Penjualan Aset Keuangan'
            '5.2.06.01.00'
            0
            nil
            nil)
          (
            5
            '520601'
            '52060101'
            'Kerugian Penjualan Aset Keuangan'
            '5.2.06.01.01'
            0
            nil
            nil)
          (
            3
            '52'
            '5207'
            'Beban Penurunan Nilai Aset Keuangan'
            '5.2.07.00.00'
            0
            nil
            nil)
          (
            4
            '5207'
            '520701'
            'Beban Penurunan Nilai Aset Keuangan'
            '5.2.07.01.00'
            0
            nil
            nil)
          (
            5
            '520701'
            '52070101'
            'Beban Penurunan Nilai Aset Keuangan'
            '5.2.07.01.01'
            0
            nil
            nil)
          (
            3
            '52'
            '5208'
            'Beban Operasional Lain-Lain'
            '5.2.08.00.00'
            0
            nil
            nil)
          (
            4
            '5208'
            '520801'
            'Beban Operasional Lain-Lain'
            '5.2.08.01.00'
            0
            nil
            nil)
          (
            5
            '520801'
            '52080101'
            'Beban Operasional Lain-Lain'
            '5.2.08.01.01'
            0
            nil
            nil)
          (
            2
            '5'
            '53'
            'Beban Non Operasional'
            '5.3.00.00.00'
            0
            nil
            nil)
          (
            3
            '53'
            '5301'
            'Beban Non Operasional'
            '5.3.01.00.00'
            0
            nil
            nil)
          (
            4
            '5301'
            '530101'
            'Kerugian Penjualan Aset Tetap'
            '5.3.01.01.00'
            0
            nil
            nil)
          (
            5
            '530101'
            '53010101'
            'Kerugian Penjualan Aset Tetap'
            '5.3.01.01.01'
            0
            nil
            nil)
          (
            4
            '5301'
            '530102'
            'Beban Non Operasional Lain-Lain'
            '5.3.01.02.00'
            0
            nil
            nil)
          (
            5
            '530102'
            '53010201'
            'Beban Non Operasional Lain-Lain'
            '5.3.01.02.01'
            0
            nil
            nil)
          (
            2
            '5'
            '54'
            'Pajak Penghasilan'
            '5.4.00.00.00'
            0
            nil
            nil)
          (
            3
            '54'
            '5401'
            'Taksiran Pajak Penghasilan'
            '5.4.01.00.00'
            0
            nil
            nil)
          (
            4
            '5401'
            '540101'
            'Taksiran Pajak Penghasilan'
            '5.4.01.01.00'
            0
            nil
            nil)
          (
            5
            '540101'
            '54010101'
            'Taksiran Pajak Penghasilan'
            '5.4.01.01.01'
            2
            nil
            nil)
          (
            3
            '54'
            '5402'
            'Pajak Tangguhan'
            '5.4.02.00.00'
            0
            nil
            nil)
          (
            4
            '5402'
            '540201'
            'Beban Pajak Tangguhan'
            '5.4.02.01.00'
            0
            nil
            nil)
          (
            5
            '540201'
            '54020101'
            'Beban Pajak Tangguhan'
            '5.4.02.01.01'
            0
            nil
            nil)
          (
            2
            '5'
            '55'
            'Beban Komprehensip Lainnya'
            '5.5.00.00.00'
            0
            nil
            nil)
          (
            3
            '55'
            '5501'
            'Beban Komprehensip Lainnya'
            '5.5.01.00.00'
            0
            nil
            nil)
          (
            4
            '5501'
            '550101'
            'Beban Komprehensip Lainnya'
            '5.5.01.01.00'
            0
            nil
            nil)
          (
            5
            '550101'
            '55010101'
            'Beban Komprehensip Lainnya'
            '5.5.01.01.01'
            0
            nil
            nil))
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
    Left = 400
    Top = 256
  end
end
