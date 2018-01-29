object FRekTransaksiKas: TFRekTransaksiKas
  Left = 0
  Top = 0
  Caption = 'Rekening Transaksi Kas'
  ClientHeight = 366
  ClientWidth = 646
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object gep: TDBGridEh
    Left = 0
    Top = 0
    Width = 646
    Height = 324
    Align = alClient
    AllowedOperations = []
    AllowedSelections = [gstRecordBookmarks]
    Color = clWhite
    DataSource = MyDataSource1
    DrawMemoText = True
    DynProps = <>
    EvenRowColor = clWhite
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    FooterParams.Color = 13631430
    HorzScrollBar.ExtraPanel.Visible = True
    HorzScrollBar.ExtraPanel.VisibleItems = [gsbiRecordsInfoEh, gsbiSelAggregationInfoEh]
    IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    EmptyDataInfo.Active = True
    OddRowColor = clWhite
    Options = [dgTitles, dgIndicator, dgColumnResize, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
    ParentFont = False
    PopupMenu = PopupMenu1
    ReadOnly = True
    SearchPanel.Enabled = True
    SearchPanel.FilterOnTyping = True
    SumList.Active = True
    TabOrder = 0
    OnAdvDrawDataCell = gepAdvDrawDataCell
    OnDblClick = gepDblClick
    OnKeyDown = gepKeyDown
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'vkode'
        Footers = <>
        Title.Caption = 'Kode'
        Width = 142
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'uraian'
        Footers = <>
        Title.Caption = 'Uraian'
        Width = 344
      end
      item
        DisplayFormat = '#,#0.## ;(#,#0.##) ; '
        DynProps = <>
        EditButtons = <>
        FieldName = 'jumlah'
        Footers = <>
        Title.Caption = 'Jumlah'
        Width = 103
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 324
    Width = 646
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
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
  end
  object MyQuery1: TUniQuery
    SQL.Strings = (
      
        'select *, (case lvl when 1 then f1 when 2 then f2 when 3 then f3' +
        ' when 4 then f4 when 5 then f5 end) vkode from vw_tpl_lra')
    ReadOnly = True
    Left = 215
    Top = 110
    object MyQuery1lvl: TIntegerField
      FieldName = 'lvl'
      ReadOnly = True
    end
    object MyQuery1pkode: TStringField
      FieldName = 'pkode'
      ReadOnly = True
      Size = 26
    end
    object MyQuery1kode: TMemoField
      FieldName = 'kode'
      ReadOnly = True
      BlobType = ftMemo
    end
    object MyQuery1f1: TStringField
      FieldName = 'f1'
      ReadOnly = True
      Size = 1
    end
    object MyQuery1f2: TStringField
      FieldName = 'f2'
      ReadOnly = True
      Size = 2
    end
    object MyQuery1f3: TStringField
      FieldName = 'f3'
      ReadOnly = True
      Size = 2
    end
    object MyQuery1f4: TStringField
      FieldName = 'f4'
      ReadOnly = True
      Size = 2
    end
    object MyQuery1f5: TStringField
      FieldName = 'f5'
      ReadOnly = True
      Size = 3
    end
    object MyQuery1fkode: TStringField
      FieldName = 'fkode'
      ReadOnly = True
    end
    object MyQuery1uraian: TStringField
      FieldName = 'uraian'
      ReadOnly = True
      Size = 255
    end
    object MyQuery1jumlah: TFloatField
      FieldName = 'jumlah'
      ReadOnly = True
    end
    object MyQuery1vkode: TMemoField
      FieldName = 'vkode'
      ReadOnly = True
      BlobType = ftMemo
    end
  end
  object MyDataSource1: TDataSource
    AutoEdit = False
    DataSet = mt
    Left = 260
    Top = 120
  end
  object PopupMenu1: TPopupMenu
    Left = 165
    Top = 75
    object Find1: TMenuItem
      Caption = 'Find'
      ImageIndex = 15
    end
    object Edit1: TMenuItem
      Caption = 'Edit...'
      Hint = 'Edit Data...'
      ImageIndex = 19
      ShortCut = 113
    end
  end
  object mt: TMemTableEh
    Active = True
    FieldDefs = <
      item
        Name = 'lvl'
        DataType = ftInteger
        Precision = 15
      end
      item
        Name = 'pkode'
        DataType = ftString
        Size = 26
      end
      item
        Name = 'kode'
        DataType = ftMemo
      end
      item
        Name = 'f1'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'f2'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'f3'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'f4'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'f5'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'fkode'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'uraian'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'jumlah'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'vkode'
        DataType = ftMemo
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    TreeList.Active = True
    TreeList.KeyFieldName = 'kode'
    TreeList.RefParentFieldName = 'pkode'
    TreeList.DefaultNodeExpanded = True
    Left = 315
    Top = 130
    object mtlvl: TIntegerField
      DisplayWidth = 10
      FieldName = 'lvl'
    end
    object mtpkode: TStringField
      DisplayWidth = 26
      FieldName = 'pkode'
      Size = 26
    end
    object mtkode: TMemoField
      DisplayWidth = 10
      FieldName = 'kode'
      BlobType = ftMemo
    end
    object mtf1: TStringField
      DisplayWidth = 1
      FieldName = 'f1'
      Size = 1
    end
    object mtf2: TStringField
      DisplayWidth = 2
      FieldName = 'f2'
      Size = 2
    end
    object mtf3: TStringField
      DisplayWidth = 2
      FieldName = 'f3'
      Size = 2
    end
    object mtf4: TStringField
      DisplayWidth = 2
      FieldName = 'f4'
      Size = 2
    end
    object mtf5: TStringField
      DisplayWidth = 3
      FieldName = 'f5'
      Size = 3
    end
    object mtfkode: TStringField
      DisplayWidth = 20
      FieldName = 'fkode'
    end
    object mturaian: TStringField
      DisplayWidth = 255
      FieldName = 'uraian'
      Size = 255
    end
    object mtjumlah: TFloatField
      DisplayWidth = 10
      FieldName = 'jumlah'
    end
    object mtvkode: TMemoField
      FieldName = 'vkode'
      BlobType = ftMemo
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object lvl: TMTNumericDataFieldEh
          FieldName = 'lvl'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'lvl'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object pkode: TMTStringDataFieldEh
          FieldName = 'pkode'
          StringDataType = fdtStringEh
          DisplayLabel = 'pkode'
          DisplayWidth = 26
          Size = 26
          Transliterate = True
        end
        object kode: TMTBlobDataFieldEh
          FieldName = 'kode'
          DisplayLabel = 'kode'
          DisplayWidth = 10
          BlobType = ftMemo
          GraphicHeader = True
          Transliterate = True
        end
        object f1: TMTStringDataFieldEh
          FieldName = 'f1'
          StringDataType = fdtStringEh
          DisplayLabel = 'f1'
          DisplayWidth = 1
          Size = 1
          Transliterate = True
        end
        object f2: TMTStringDataFieldEh
          FieldName = 'f2'
          StringDataType = fdtStringEh
          DisplayLabel = 'f2'
          DisplayWidth = 2
          Size = 2
          Transliterate = True
        end
        object f3: TMTStringDataFieldEh
          FieldName = 'f3'
          StringDataType = fdtStringEh
          DisplayLabel = 'f3'
          DisplayWidth = 2
          Size = 2
          Transliterate = True
        end
        object f4: TMTStringDataFieldEh
          FieldName = 'f4'
          StringDataType = fdtStringEh
          DisplayLabel = 'f4'
          DisplayWidth = 2
          Size = 2
          Transliterate = True
        end
        object f5: TMTStringDataFieldEh
          FieldName = 'f5'
          StringDataType = fdtStringEh
          DisplayLabel = 'f5'
          DisplayWidth = 3
          Size = 3
          Transliterate = True
        end
        object fkode: TMTStringDataFieldEh
          FieldName = 'fkode'
          StringDataType = fdtStringEh
          DisplayLabel = 'fkode'
          DisplayWidth = 20
          Transliterate = True
        end
        object uraian: TMTStringDataFieldEh
          FieldName = 'uraian'
          StringDataType = fdtStringEh
          DisplayLabel = 'uraian'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object jumlah: TMTNumericDataFieldEh
          FieldName = 'jumlah'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'jumlah'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object vkode: TMTBlobDataFieldEh
          FieldName = 'vkode'
          DisplayLabel = 'vkode'
          DisplayWidth = 10
          BlobType = ftMemo
          GraphicHeader = True
          Transliterate = True
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            1
            '0'
            '73010220030000001'
            '1'
            ''
            ''
            ''
            ''
            '1'
            'PENDAPATAN'
            0.000000000000000000
            nil)
          (
            2
            '73010220030000001'
            '7301022003000000101'
            '1'
            '1'
            ''
            ''
            ''
            '1.1'
            'Pendapatan Asli Desa'
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000101'
            '730102200300000010101'
            '1'
            '1'
            '1'
            ''
            ''
            '1.1.1'
            'Hasil Usaha'
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000101'
            '730102200300000010102'
            '1'
            '1'
            '2'
            ''
            ''
            '1.1.2'
            'Swadaya,  Partisipasi dan Gotong  Royong'
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000101'
            '730102200300000010103'
            '1'
            '1'
            '3'
            ''
            ''
            '1.1.3'
            'Lain-lain Pendapatan Asli Desa yang sah'
            0.000000000000000000
            nil)
          (
            2
            '73010220030000001'
            '7301022003000000102'
            '1'
            '2'
            ''
            ''
            ''
            '1.2'
            'Pendapatan Transfer'
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000102'
            '730102200300000010201'
            '1'
            '2'
            '1'
            ''
            ''
            '1.2.1'
            'Dana Desa'
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000102'
            '730102200300000010202'
            '1'
            '2'
            '2'
            ''
            ''
            '1.2.2'
            'Bagian dari hasil pajak &retribusi daerah kabupaten/ kota'
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000102'
            '730102200300000010203'
            '1'
            '2'
            '3'
            ''
            ''
            '1.2.3'
            'Alokasi Dana Desa'
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000102'
            '730102200300000010204'
            '1'
            '2'
            '4'
            ''
            ''
            '1.2.4'
            'Bantuan Keuangan'
            0.000000000000000000
            nil)
          (
            4
            '730102200300000010204'
            '73010220030000001020401'
            '1'
            '2'
            '4'
            '1'
            ''
            '1.2.4.1'
            'Bantuan Provinsi'
            0.000000000000000000
            nil)
          (
            4
            '730102200300000010204'
            '73010220030000001020402'
            '1'
            '2'
            '4'
            '2'
            ''
            '1.2.4.2'
            'Bantuan Kabupaten / Kota'
            0.000000000000000000
            nil)
          (
            2
            '73010220030000001'
            '7301022003000000103'
            '1'
            '3'
            ''
            ''
            ''
            '1.3'
            'Pendapatan Lain lain'
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000103'
            '730102200300000010301'
            '1'
            '3'
            '1'
            ''
            ''
            '1.3.1'
            'Hibah dan Sumbangan dari pihak ke-3 yang tidak mengikat'
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000103'
            '730102200300000010302'
            '1'
            '3'
            '2'
            ''
            ''
            '1.3.2'
            'Lain-lain Pendapatan Desa yang sah'
            0.000000000000000000
            nil)
          (
            1
            '0'
            '73010220030000002'
            '2'
            ''
            ''
            ''
            ''
            '2'
            'BELANJA'
            0.000000000000000000
            nil)
          (
            2
            '73010220030000002'
            '7301022003000000201'
            '2'
            '1'
            ''
            ''
            ''
            '2.1'
            'Bidang Penyelenggaraan Pemerintahan Desa'
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000201'
            '730102200300000020101'
            '2'
            '1'
            '1'
            ''
            ''
            '2.1.1'
            'Penghasilan Tetap dan Tunjangan'
            0.000000000000000000
            nil)
          (
            4
            '730102200300000020101'
            '73010220030000002010101'
            '2'
            '1'
            '1'
            '1'
            ''
            '2.1.1.1'
            'Belanja Pegawai:'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010101'
            '73010220030000002010101001'
            '2'
            '1'
            '1'
            '1'
            '1'
            '2.1.1.1.1'
            '- Penghasilan Tetap Kepala Desa  dan Perangkat'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010101'
            '73010220030000002010101002'
            '2'
            '1'
            '1'
            '1'
            '2'
            '2.1.1.1.2'
            '- Tunjangan BPD '
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010101'
            '73010220030000002010101003'
            '2'
            '1'
            '1'
            '1'
            '3'
            '2.1.1.1.3'
            '- Tunjangan Hari Tukang'
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000201'
            '730102200300000020102'
            '2'
            '1'
            '2'
            ''
            ''
            '2.1.2'
            'Operasional Perkantoran'
            0.000000000000000000
            nil)
          (
            4
            '730102200300000020102'
            '73010220030000002010202'
            '2'
            '1'
            '2'
            '2'
            ''
            '2.1.2.2'
            'Belanja Barang dan Jasa'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010202'
            '73010220030000002010202001'
            '2'
            '1'
            '2'
            '2'
            '1'
            '2.1.2.2.1'
            '- Alat Tulis Kantor'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010202'
            '73010220030000002010202002'
            '2'
            '1'
            '2'
            '2'
            '2'
            '2.1.2.2.2'
            '- Benda POS'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010202'
            '73010220030000002010202003'
            '2'
            '1'
            '2'
            '2'
            '3'
            '2.1.2.2.3'
            '- Pakaian Dinas dfan Atribut'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010202'
            '73010220030000002010202004'
            '2'
            '1'
            '2'
            '2'
            '4'
            '2.1.2.2.4'
            '- Pakaian Dinas'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010202'
            '73010220030000002010202005'
            '2'
            '1'
            '2'
            '2'
            '5'
            '2.1.2.2.5'
            '- Alat dan Bahan Kebersihan'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010202'
            '73010220030000002010202006'
            '2'
            '1'
            '2'
            '2'
            '6'
            '2.1.2.2.6'
            '- Perjalanan Dinas'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010202'
            '73010220030000002010202007'
            '2'
            '1'
            '2'
            '2'
            '7'
            '2.1.2.2.7'
            '- Pemeliharaan'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010202'
            '73010220030000002010202008'
            '2'
            '1'
            '2'
            '2'
            '8'
            '2.1.2.2.8'
            '- Air, Listrik,dasn Telepon'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010202'
            '73010220030000002010202009'
            '2'
            '1'
            '2'
            '2'
            '9'
            '2.1.2.2.9'
            '- Honor'
            0.000000000000000000
            nil)
          (
            4
            '730102200300000020102'
            '73010220030000002010203'
            '2'
            '1'
            '2'
            '3'
            ''
            '2.1.2.3'
            'Belanja Modal'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010203'
            '73010220030000002010203001'
            '2'
            '1'
            '2'
            '3'
            '1'
            '2.1.2.3.1'
            '- Komputer'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010203'
            '73010220030000002010203002'
            '2'
            '1'
            '2'
            '3'
            '2'
            '2.1.2.3.2'
            '- Meja dan Kursi'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010203'
            '73010220030000002010203003'
            '2'
            '1'
            '2'
            '3'
            '3'
            '2.1.2.3.3'
            '- Mesin TIK'
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000201'
            '730102200300000020103'
            '2'
            '1'
            '3'
            ''
            ''
            '2.1.3'
            'Operasional BPD'
            0.000000000000000000
            nil)
          (
            4
            '730102200300000020103'
            '73010220030000002010302'
            '2'
            '1'
            '3'
            '2'
            ''
            '2.1.3.2'
            'Belanja Barang dan Jasa'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010302'
            '73010220030000002010302001'
            '2'
            '1'
            '3'
            '2'
            '1'
            '2.1.3.2.1'
            '- ATK'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010302'
            '73010220030000002010302002'
            '2'
            '1'
            '3'
            '2'
            '2'
            '2.1.3.2.2'
            '- Penggandaan'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010302'
            '73010220030000002010302003'
            '2'
            '1'
            '3'
            '2'
            '3'
            '2.1.3.2.3'
            '- Konsumsi Rapat'
            0.000000000000000000
            nil)
          (
            4
            '730102200300000020103'
            '73010220030000002010303'
            '2'
            '1'
            '3'
            '3'
            ''
            '2.1.3.3'
            'Belaja Operasional Nagntuk'
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000201'
            '730102200300000020104'
            '2'
            '1'
            '4'
            ''
            ''
            '2.1.4'
            'Operasional RT/ RW'
            0.000000000000000000
            nil)
          (
            4
            '730102200300000020104'
            '73010220030000002010402'
            '2'
            '1'
            '4'
            '2'
            ''
            '2.1.4.2'
            'Belanja Barang dan Jasa'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010402'
            '73010220030000002010402001'
            '2'
            '1'
            '4'
            '2'
            '1'
            '2.1.4.2.1'
            '- ATK'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010402'
            '73010220030000002010402002'
            '2'
            '1'
            '4'
            '2'
            '2'
            '2.1.4.2.2'
            '- Penggandaan'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002010402'
            '73010220030000002010402003'
            '2'
            '1'
            '4'
            '2'
            '3'
            '2.1.4.2.3'
            '- Konsumsi Rapat'
            0.000000000000000000
            nil)
          (
            2
            '73010220030000002'
            '7301022003000000202'
            '2'
            '2'
            ''
            ''
            ''
            '2.2'
            'Bidang Pelaksanaan Pembangunan Desa'
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000202'
            '730102200300000020201'
            '2'
            '2'
            '1'
            ''
            ''
            '2.2.1'
            'Perbaikan Saluran Irigasi'
            0.000000000000000000
            nil)
          (
            4
            '730102200300000020201'
            '73010220030000002020102'
            '2'
            '2'
            '1'
            '2'
            ''
            '2.2.1.2'
            'Belanja Barang dan jasa'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002020102'
            '73010220030000002020102001'
            '2'
            '2'
            '1'
            '2'
            '1'
            '2.2.1.2.1'
            '- Upah Kerja'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002020102'
            '73010220030000002020102002'
            '2'
            '2'
            '1'
            '2'
            '2'
            '2.2.1.2.2'
            '- Honor'
            0.000000000000000000
            nil)
          (
            4
            '730102200300000020201'
            '73010220030000002020103'
            '2'
            '2'
            '1'
            '3'
            ''
            '2.2.1.3'
            'Belanja Modal'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002020103'
            '73010220030000002020103001'
            '2'
            '2'
            '1'
            '3'
            '1'
            '2.2.1.3.1'
            '- Semen'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002020103'
            '73010220030000002020103002'
            '2'
            '2'
            '1'
            '3'
            '2'
            '2.2.1.3.2'
            '- Material'
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000202'
            '730102200300000020202'
            '2'
            '2'
            '2'
            ''
            ''
            '2.2.2'
            'Pengaspalan  jalan  desa '
            0.000000000000000000
            nil)
          (
            4
            '730102200300000020202'
            '73010220030000002020202'
            '2'
            '2'
            '2'
            '2'
            ''
            '2.2.2.2'
            'Belanja Barang dan Jasa :'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002020202'
            '73010220030000002020202001'
            '2'
            '2'
            '2'
            '2'
            '1'
            '2.2.2.2.1'
            '- Upah Kerja'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002020202'
            '73010220030000002020202002'
            '2'
            '2'
            '2'
            '2'
            '2'
            '2.2.2.2.2'
            '- Honor'
            0.000000000000000000
            nil)
          (
            4
            '730102200300000020202'
            '73010220030000002020203'
            '2'
            '2'
            '2'
            '3'
            ''
            '2.2.2.3'
            'Belanja  Modal:'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002020203'
            '73010220030000002020203001'
            '2'
            '2'
            '2'
            '3'
            '1'
            '2.2.2.3.1'
            '- Aspal '
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002020203'
            '73010220030000002020203002'
            '2'
            '2'
            '2'
            '3'
            '2'
            '2.2.2.3.2'
            '- Pasir '
            0.000000000000000000
            nil)
          (
            2
            '73010220030000002'
            '7301022003000000203'
            '2'
            '3'
            ''
            ''
            ''
            '2.3'
            'Bidang Pembinaan Kemasyarakatan '
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000203'
            '730102200300000020301'
            '2'
            '3'
            '1'
            ''
            ''
            '2.3.1'
            'Kegiatan Pembinaan Ketentraman dan Ketertiban'
            0.000000000000000000
            nil)
          (
            4
            '730102200300000020301'
            '73010220030000002030102'
            '2'
            '3'
            '1'
            '2'
            ''
            '2.3.1.2'
            'Belanja Barang dan Jasa:'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002030102'
            '73010220030000002030102001'
            '2'
            '3'
            '1'
            '2'
            '1'
            '2.3.1.2.1'
            '- Honor Pelatih '
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002030102'
            '73010220030000002030102002'
            '2'
            '3'
            '1'
            '2'
            '2'
            '2.3.1.2.2'
            '- Konsumsi '
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002030102'
            '73010220030000002030102003'
            '2'
            '3'
            '1'
            '2'
            '3'
            '2.3.1.2.3'
            '- Bahan Pelatihan'
            0.000000000000000000
            nil)
          (
            2
            '73010220030000002'
            '7301022003000000204'
            '2'
            '4'
            ''
            ''
            ''
            '2.4'
            'Bidang Pemberdayaan Masyarakat '
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000204'
            '730102200300000020401'
            '2'
            '4'
            '1'
            ''
            ''
            '2.4.1'
            'Kegiatan Pelatihan Kepala Desa dan Perangkat'
            0.000000000000000000
            nil)
          (
            4
            '730102200300000020401'
            '73010220030000002040102'
            '2'
            '4'
            '1'
            '2'
            ''
            '2.4.1.2'
            'Belanja Barang  dan Jasa:'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002040102'
            '73010220030000002040102001'
            '2'
            '4'
            '1'
            '2'
            '1'
            '2.4.1.2.1'
            '- Honor pelatih'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002040102'
            '73010220030000002040102002'
            '2'
            '4'
            '1'
            '2'
            '2'
            '2.4.1.2.2'
            '- Konsumsi  '
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002040102'
            '73010220030000002040102003'
            '2'
            '4'
            '1'
            '2'
            '3'
            '2.4.1.2.3'
            '- Bahan pelatihan '
            0.000000000000000000
            nil)
          (
            2
            '73010220030000002'
            '7301022003000000205'
            '2'
            '5'
            ''
            ''
            ''
            '2.5'
            'Bidang Tak Terduga '
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000205'
            '730102200300000020501'
            '2'
            '5'
            '1'
            ''
            ''
            '2.5.1'
            'Kegiatan Kejadian Luar Biasa '
            0.000000000000000000
            nil)
          (
            4
            '730102200300000020501'
            '73010220030000002050102'
            '2'
            '5'
            '1'
            '2'
            ''
            '2.5.1.2'
            'Belanja Barang  dan Jasa:'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002050102'
            '73010220030000002050102001'
            '2'
            '5'
            '1'
            '2'
            '1'
            '2.5.1.2.1'
            '- Honor tim '
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002050102'
            '73010220030000002050102002'
            '2'
            '5'
            '1'
            '2'
            '2'
            '2.5.1.2.2'
            '- Konsumsi'
            0.000000000000000000
            nil)
          (
            5
            '73010220030000002050102'
            '73010220030000002050102003'
            '2'
            '5'
            '1'
            '2'
            '3'
            '2.5.1.2.3'
            '- Obat-obatan '
            0.000000000000000000
            nil)
          (
            1
            '0'
            '73010220030000003'
            '3'
            ''
            ''
            ''
            ''
            '3'
            'PEMBIAYAAN '
            0.000000000000000000
            nil)
          (
            2
            '73010220030000003'
            '7301022003000000301'
            '3'
            '1'
            ''
            ''
            ''
            '3.1'
            'Penerimaan Pembiayaan '
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000301'
            '730102200300000030101'
            '3'
            '1'
            '1'
            ''
            ''
            '3.1.1'
            'SILPA '
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000301'
            '730102200300000030102'
            '3'
            '1'
            '2'
            ''
            ''
            '3.1.2'
            'Pencairan Dana Cadangan '
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000301'
            '730102200300000030103'
            '3'
            '1'
            '3'
            ''
            ''
            '3.1.3'
            'Hasil Kekayaan Desa Yang dipisahkan '
            0.000000000000000000
            nil)
          (
            2
            '73010220030000003'
            '7301022003000000302'
            '3'
            '2'
            ''
            ''
            ''
            '3.2'
            'Pengeluaran   Pembiayaan '
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000302'
            '730102200300000030201'
            '3'
            '2'
            '1'
            ''
            ''
            '3.2.1'
            'Pembentukan Dana Cadangan '
            0.000000000000000000
            nil)
          (
            3
            '7301022003000000302'
            '730102200300000030202'
            '3'
            '2'
            '2'
            ''
            ''
            '3.2.2'
            'Penyertaan Modal Desa '
            0.000000000000000000
            nil)
          (
            1
            '0'
            '73711400992015011'
            '1'
            ''
            ''
            ''
            ''
            '1'
            'PENDAPATAN'
            10.000000000000000000
            nil)
          (
            2
            '73711400992015011'
            '7371140099201501101'
            '1'
            '1'
            ''
            ''
            ''
            '1.1'
            'Pendapatan Asli Desa'
            10.000000000000000000
            nil)
          (
            3
            '7371140099201501101'
            '737114009920150110101'
            '1'
            '1'
            '1'
            ''
            ''
            '1.1.1'
            'Hasil Usaha'
            0.000000000000000000
            nil)
          (
            3
            '7371140099201501101'
            '737114009920150110102'
            '1'
            '1'
            '2'
            ''
            ''
            '1.1.2'
            'Swadaya,  Partisipasi dan Gotong  Royong'
            10.000000000000000000
            nil)
          (
            4
            '737114009920150110102'
            '73711400992015011010201'
            '1'
            '1'
            '2'
            '1'
            ''
            '1.1.2.1'
            'Dana Swadaya'
            10.000000000000000000
            nil)
          (
            5
            '73711400992015011010201'
            '73711400992015011010201001'
            '1'
            '1'
            '2'
            '1'
            '1'
            '1.1.2.1.1'
            '- Dana Swadaya Masyarakat'
            10.000000000000000000
            nil)
          (
            5
            '73711400992015011010201'
            '73711400992015011010201002'
            '1'
            '1'
            '2'
            '1'
            '2'
            '1.1.2.1.2'
            '- Sumbangan Gotong Royong'
            nil
            nil)
          (
            3
            '7371140099201501101'
            '737114009920150110103'
            '1'
            '1'
            '3'
            ''
            ''
            '1.1.3'
            'Lain-lain Pendapatan Asli Desa yang sah'
            0.000000000000000000
            nil)
          (
            4
            '737114009920150110103'
            '73711400992015011010301'
            '1'
            '1'
            '3'
            '1'
            ''
            '1.1.3.1'
            'Pendapatan Bunga Bank'
            0.000000000000000000
            nil)
          (
            5
            '73711400992015011010301'
            '73711400992015011010301001'
            '1'
            '1'
            '3'
            '1'
            '1'
            '1.1.3.1.1'
            '- Pendapatan Bunga Bank'
            nil
            nil)
          (
            2
            '73711400992015011'
            '7371140099201501102'
            '1'
            '2'
            ''
            ''
            ''
            '1.2'
            'Pendapatan Transfer'
            0.000000000000000000
            nil)
          (
            3
            '7371140099201501102'
            '737114009920150110201'
            '1'
            '2'
            '1'
            ''
            ''
            '1.2.1'
            'Dana Desa'
            0.000000000000000000
            nil)
          (
            3
            '7371140099201501102'
            '737114009920150110202'
            '1'
            '2'
            '2'
            ''
            ''
            '1.2.2'
            'Bagian dari hasil pajak &retribusi daerah kabupaten/ kota'
            0.000000000000000000
            nil)
          (
            3
            '7371140099201501102'
            '737114009920150110203'
            '1'
            '2'
            '3'
            ''
            ''
            '1.2.3'
            'Alokasi Dana Desa'
            0.000000000000000000
            nil)
          (
            3
            '7371140099201501102'
            '737114009920150110204'
            '1'
            '2'
            '4'
            ''
            ''
            '1.2.4'
            'Bantuan Keuangan'
            0.000000000000000000
            nil)
          (
            4
            '737114009920150110204'
            '73711400992015011020401'
            '1'
            '2'
            '4'
            '1'
            ''
            '1.2.4.1'
            'Bantuan Provinsi'
            0.000000000000000000
            nil)
          (
            4
            '737114009920150110204'
            '73711400992015011020402'
            '1'
            '2'
            '4'
            '2'
            ''
            '1.2.4.2'
            'Bantuan Kabupaten / Kota'
            0.000000000000000000
            nil)
          (
            2
            '73711400992015011'
            '7371140099201501103'
            '1'
            '3'
            ''
            ''
            ''
            '1.3'
            'Pendapatan Lain lain'
            0.000000000000000000
            nil)
          (
            3
            '7371140099201501103'
            '737114009920150110301'
            '1'
            '3'
            '1'
            ''
            ''
            '1.3.1'
            'Hibah dan Sumbangan dari pihak ke-3 yang tidak mengikat'
            0.000000000000000000
            nil)
          (
            3
            '7371140099201501103'
            '737114009920150110302'
            '1'
            '3'
            '2'
            ''
            ''
            '1.3.2'
            'Lain-lain Pendapatan Desa yang sah'
            0.000000000000000000
            nil)
          (
            4
            '737114009920150110302'
            '73711400992015011030201'
            '1'
            '3'
            '2'
            '1'
            ''
            '1.3.2.1'
            'Bunga Bank'
            0.000000000000000000
            nil)
          (
            5
            '73711400992015011030201'
            '73711400992015011030201001'
            '1'
            '3'
            '2'
            '1'
            '1'
            '1.3.2.1.1'
            '- Bunga Bank'
            nil
            nil)
          (
            1
            '0'
            '73711400992015012'
            '2'
            ''
            ''
            ''
            ''
            '2'
            'BELANJA'
            12600000.000000000000000000
            nil)
          (
            2
            '73711400992015012'
            '7371140099201501201'
            '2'
            '1'
            ''
            ''
            ''
            '2.1'
            'Bidang Penyelenggaraan Pemerintahan Desa'
            0.000000000000000000
            nil)
          (
            3
            '7371140099201501201'
            '737114009920150120101'
            '2'
            '1'
            '1'
            ''
            ''
            '2.1.1'
            'Penghasilan Tetap dan Tunjangan'
            0.000000000000000000
            nil)
          (
            4
            '737114009920150120101'
            '73711400992015012010101'
            '2'
            '1'
            '1'
            '1'
            ''
            '2.1.1.1'
            'Belanja Pegawai:'
            0.000000000000000000
            nil)
          (
            5
            '73711400992015012010101'
            '73711400992015012010101001'
            '2'
            '1'
            '1'
            '1'
            '1'
            '2.1.1.1.1'
            '- Penghasilan Tetap Kepala Desa  dan Perangkat'
            nil
            nil)
          (
            5
            '73711400992015012010101'
            '73711400992015012010101002'
            '2'
            '1'
            '1'
            '1'
            '2'
            '2.1.1.1.2'
            '- Tunjangan BPD '
            nil
            nil)
          (
            5
            '73711400992015012010101'
            '73711400992015012010101003'
            '2'
            '1'
            '1'
            '1'
            '3'
            '2.1.1.1.3'
            '- Tunjangan Hari Tukang'
            nil
            nil)
          (
            3
            '7371140099201501201'
            '737114009920150120102'
            '2'
            '1'
            '2'
            ''
            ''
            '2.1.2'
            'Operasional Perkantoran'
            0.000000000000000000
            nil)
          (
            4
            '737114009920150120102'
            '73711400992015012010202'
            '2'
            '1'
            '2'
            '2'
            ''
            '2.1.2.2'
            'Belanja Barang dan Jasa'
            0.000000000000000000
            nil)
          (
            5
            '73711400992015012010202'
            '73711400992015012010202001'
            '2'
            '1'
            '2'
            '2'
            '1'
            '2.1.2.2.1'
            '- Alat Tulis Kantor'
            nil
            nil)
          (
            5
            '73711400992015012010202'
            '73711400992015012010202002'
            '2'
            '1'
            '2'
            '2'
            '2'
            '2.1.2.2.2'
            '- Benda POS'
            nil
            nil)
          (
            5
            '73711400992015012010202'
            '73711400992015012010202003'
            '2'
            '1'
            '2'
            '2'
            '3'
            '2.1.2.2.3'
            '- Pakaian Dinas dfan Atribut'
            nil
            nil)
          (
            5
            '73711400992015012010202'
            '73711400992015012010202004'
            '2'
            '1'
            '2'
            '2'
            '4'
            '2.1.2.2.4'
            '- Pakaian Dinas'
            nil
            nil)
          (
            5
            '73711400992015012010202'
            '73711400992015012010202005'
            '2'
            '1'
            '2'
            '2'
            '5'
            '2.1.2.2.5'
            '- Alat dan Bahan Kebersihan'
            nil
            nil)
          (
            5
            '73711400992015012010202'
            '73711400992015012010202006'
            '2'
            '1'
            '2'
            '2'
            '6'
            '2.1.2.2.6'
            '- Perjalanan Dinas'
            nil
            nil)
          (
            5
            '73711400992015012010202'
            '73711400992015012010202007'
            '2'
            '1'
            '2'
            '2'
            '7'
            '2.1.2.2.7'
            '- Pemeliharaan'
            nil
            nil)
          (
            5
            '73711400992015012010202'
            '73711400992015012010202008'
            '2'
            '1'
            '2'
            '2'
            '8'
            '2.1.2.2.8'
            '- Air, Listrik,dasn Telepon'
            nil
            nil)
          (
            5
            '73711400992015012010202'
            '73711400992015012010202009'
            '2'
            '1'
            '2'
            '2'
            '9'
            '2.1.2.2.9'
            '- Honor'
            nil
            nil)
          (
            4
            '737114009920150120102'
            '73711400992015012010203'
            '2'
            '1'
            '2'
            '3'
            ''
            '2.1.2.3'
            'Belanja Modal'
            0.000000000000000000
            nil)
          (
            5
            '73711400992015012010203'
            '73711400992015012010203001'
            '2'
            '1'
            '2'
            '3'
            '1'
            '2.1.2.3.1'
            '- Komputer'
            nil
            nil)
          (
            5
            '73711400992015012010203'
            '73711400992015012010203002'
            '2'
            '1'
            '2'
            '3'
            '2'
            '2.1.2.3.2'
            '- Meja dan Kursi'
            nil
            nil)
          (
            5
            '73711400992015012010203'
            '73711400992015012010203003'
            '2'
            '1'
            '2'
            '3'
            '3'
            '2.1.2.3.3'
            '- Mesin TIK'
            nil
            nil)
          (
            3
            '7371140099201501201'
            '737114009920150120103'
            '2'
            '1'
            '3'
            ''
            ''
            '2.1.3'
            'Operasional BPD'
            0.000000000000000000
            nil)
          (
            4
            '737114009920150120103'
            '73711400992015012010302'
            '2'
            '1'
            '3'
            '2'
            ''
            '2.1.3.2'
            'Belanja Barang dan Jasa'
            0.000000000000000000
            nil)
          (
            5
            '73711400992015012010302'
            '73711400992015012010302001'
            '2'
            '1'
            '3'
            '2'
            '1'
            '2.1.3.2.1'
            '- ATK'
            nil
            nil)
          (
            5
            '73711400992015012010302'
            '73711400992015012010302002'
            '2'
            '1'
            '3'
            '2'
            '2'
            '2.1.3.2.2'
            '- Penggandaan'
            nil
            nil)
          (
            5
            '73711400992015012010302'
            '73711400992015012010302003'
            '2'
            '1'
            '3'
            '2'
            '3'
            '2.1.3.2.3'
            '- Konsumsi Rapat'
            nil
            nil)
          (
            4
            '737114009920150120103'
            '73711400992015012010303'
            '2'
            '1'
            '3'
            '3'
            ''
            '2.1.3.3'
            'Belaja Operasional Nagntuk'
            0.000000000000000000
            nil)
          (
            3
            '7371140099201501201'
            '737114009920150120104'
            '2'
            '1'
            '4'
            ''
            ''
            '2.1.4'
            'Operasional RT/ RW'
            0.000000000000000000
            nil)
          (
            4
            '737114009920150120104'
            '73711400992015012010402'
            '2'
            '1'
            '4'
            '2'
            ''
            '2.1.4.2'
            'Belanja Barang dan Jasa'
            0.000000000000000000
            nil)
          (
            5
            '73711400992015012010402'
            '73711400992015012010402001'
            '2'
            '1'
            '4'
            '2'
            '1'
            '2.1.4.2.1'
            '- ATK'
            nil
            nil)
          (
            5
            '73711400992015012010402'
            '73711400992015012010402002'
            '2'
            '1'
            '4'
            '2'
            '2'
            '2.1.4.2.2'
            '- Penggandaan'
            nil
            nil)
          (
            5
            '73711400992015012010402'
            '73711400992015012010402003'
            '2'
            '1'
            '4'
            '2'
            '3'
            '2.1.4.2.3'
            '- Konsumsi Rapat'
            nil
            nil)
          (
            3
            '7371140099201501201'
            '737114009920150120105'
            '2'
            '1'
            '5'
            ''
            ''
            '2.1.5'
            'Pembangunan Kantor Desa'
            0.000000000000000000
            nil)
          (
            4
            '737114009920150120105'
            '73711400992015012010501'
            '2'
            '1'
            '5'
            '1'
            ''
            '2.1.5.1'
            'Belanja Pegawai'
            0.000000000000000000
            nil)
          (
            4
            '737114009920150120105'
            '73711400992015012010502'
            '2'
            '1'
            '5'
            '2'
            ''
            '2.1.5.2'
            'Belanja Barang dan Jasa'
            0.000000000000000000
            nil)
          (
            4
            '737114009920150120105'
            '73711400992015012010503'
            '2'
            '1'
            '5'
            '3'
            ''
            '2.1.5.3'
            'Belanja Modal'
            0.000000000000000000
            nil)
          (
            2
            '73711400992015012'
            '7371140099201501202'
            '2'
            '2'
            ''
            ''
            ''
            '2.2'
            'Bidang Pelaksanaan Pembangunan Desa'
            12600000.000000000000000000
            nil)
          (
            3
            '7371140099201501202'
            '737114009920150120202'
            '2'
            '2'
            '2'
            ''
            ''
            '2.2.2'
            'Pengaspalan  jalan  desa '
            12600000.000000000000000000
            nil)
          (
            4
            '737114009920150120202'
            '73711400992015012020202'
            '2'
            '2'
            '2'
            '2'
            ''
            '2.2.2.2'
            'Belanja Barang dan Jasa :'
            0.000000000000000000
            nil)
          (
            5
            '73711400992015012020202'
            '73711400992015012020202001'
            '2'
            '2'
            '2'
            '2'
            '1'
            '2.2.2.2.1'
            '- Upah Kerja'
            nil
            nil)
          (
            5
            '73711400992015012020202'
            '73711400992015012020202002'
            '2'
            '2'
            '2'
            '2'
            '2'
            '2.2.2.2.2'
            '- Honor'
            nil
            nil)
          (
            4
            '737114009920150120202'
            '73711400992015012020203'
            '2'
            '2'
            '2'
            '3'
            ''
            '2.2.2.3'
            'Belanja  Modal:'
            12600000.000000000000000000
            nil)
          (
            5
            '73711400992015012020203'
            '73711400992015012020203001'
            '2'
            '2'
            '2'
            '3'
            '1'
            '2.2.2.3.1'
            '- Aspal '
            11200000.000000000000000000
            nil)
          (
            5
            '73711400992015012020203'
            '73711400992015012020203002'
            '2'
            '2'
            '2'
            '3'
            '2'
            '2.2.2.3.2'
            '- Pasir '
            1400000.000000000000000000
            nil)
          (
            2
            '73711400992015012'
            '7371140099201501203'
            '2'
            '3'
            ''
            ''
            ''
            '2.3'
            'Bidang Pembinaan Kemasyarakatan '
            0.000000000000000000
            nil)
          (
            3
            '7371140099201501203'
            '737114009920150120301'
            '2'
            '3'
            '1'
            ''
            ''
            '2.3.1'
            'Kegiatan Pembinaan Ketentraman dan Ketertiban'
            0.000000000000000000
            nil)
          (
            4
            '737114009920150120301'
            '73711400992015012030102'
            '2'
            '3'
            '1'
            '2'
            ''
            '2.3.1.2'
            'Belanja Barang dan Jasa:'
            0.000000000000000000
            nil)
          (
            5
            '73711400992015012030102'
            '73711400992015012030102001'
            '2'
            '3'
            '1'
            '2'
            '1'
            '2.3.1.2.1'
            '- Honor Pelatih '
            nil
            nil)
          (
            5
            '73711400992015012030102'
            '73711400992015012030102002'
            '2'
            '3'
            '1'
            '2'
            '2'
            '2.3.1.2.2'
            '- Konsumsi '
            nil
            nil)
          (
            5
            '73711400992015012030102'
            '73711400992015012030102003'
            '2'
            '3'
            '1'
            '2'
            '3'
            '2.3.1.2.3'
            '- Bahan Pelatihan'
            nil
            nil)
          (
            2
            '73711400992015012'
            '7371140099201501204'
            '2'
            '4'
            ''
            ''
            ''
            '2.4'
            'Bidang Pemberdayaan Masyarakat '
            0.000000000000000000
            nil)
          (
            3
            '7371140099201501204'
            '737114009920150120401'
            '2'
            '4'
            '1'
            ''
            ''
            '2.4.1'
            'Kegiatan Pelatihan Kepala Desa dan Perangkat'
            0.000000000000000000
            nil)
          (
            4
            '737114009920150120401'
            '73711400992015012040102'
            '2'
            '4'
            '1'
            '2'
            ''
            '2.4.1.2'
            'Belanja Barang  dan Jasa:'
            0.000000000000000000
            nil)
          (
            5
            '73711400992015012040102'
            '73711400992015012040102001'
            '2'
            '4'
            '1'
            '2'
            '1'
            '2.4.1.2.1'
            '- Honor pelatih'
            nil
            nil)
          (
            5
            '73711400992015012040102'
            '73711400992015012040102002'
            '2'
            '4'
            '1'
            '2'
            '2'
            '2.4.1.2.2'
            '- Konsumsi  '
            nil
            nil)
          (
            5
            '73711400992015012040102'
            '73711400992015012040102003'
            '2'
            '4'
            '1'
            '2'
            '3'
            '2.4.1.2.3'
            '- Bahan pelatihan '
            nil
            nil)
          (
            2
            '73711400992015012'
            '7371140099201501205'
            '2'
            '5'
            ''
            ''
            ''
            '2.5'
            'Bidang Tak Terduga '
            0.000000000000000000
            nil)
          (
            3
            '7371140099201501205'
            '737114009920150120501'
            '2'
            '5'
            '1'
            ''
            ''
            '2.5.1'
            'Kegiatan Kejadian Luar Biasa '
            0.000000000000000000
            nil)
          (
            4
            '737114009920150120501'
            '73711400992015012050102'
            '2'
            '5'
            '1'
            '2'
            ''
            '2.5.1.2'
            'Belanja Barang  dan Jasa:'
            0.000000000000000000
            nil)
          (
            5
            '73711400992015012050102'
            '73711400992015012050102001'
            '2'
            '5'
            '1'
            '2'
            '1'
            '2.5.1.2.1'
            '- Honor tim '
            nil
            nil)
          (
            5
            '73711400992015012050102'
            '73711400992015012050102002'
            '2'
            '5'
            '1'
            '2'
            '2'
            '2.5.1.2.2'
            '- Konsumsi'
            nil
            nil)
          (
            5
            '73711400992015012050102'
            '73711400992015012050102003'
            '2'
            '5'
            '1'
            '2'
            '3'
            '2.5.1.2.3'
            '- Obat-obatan '
            nil
            nil)
          (
            3
            '7371140099201501205'
            '737114009920150120502'
            '2'
            '5'
            '2'
            ''
            ''
            '2.5.2'
            'Kegiatan Tidak Terduga Lainnya'
            0.000000000000000000
            nil)
          (
            4
            '737114009920150120502'
            '73711400992015012050201'
            '2'
            '5'
            '2'
            '1'
            ''
            '2.5.2.1'
            'Belanja Administrasi Tidak Terduga'
            0.000000000000000000
            nil)
          (
            5
            '73711400992015012050201'
            '73711400992015012050201001'
            '2'
            '5'
            '2'
            '1'
            '1'
            '2.5.2.1.1'
            '- Belanja Pajak Bank'
            nil
            nil)
          (
            5
            '73711400992015012050201'
            '73711400992015012050201002'
            '2'
            '5'
            '2'
            '1'
            '2'
            '2.5.2.1.2'
            '- Belanja Administrasi Bank'
            nil
            nil)
          (
            1
            '0'
            '73711400992015013'
            '3'
            ''
            ''
            ''
            ''
            '3'
            'PEMBIAYAAN '
            36000.000000000000000000
            nil)
          (
            2
            '73711400992015013'
            '7371140099201501301'
            '3'
            '1'
            ''
            ''
            ''
            '3.1'
            'Penerimaan Pembiayaan '
            26000.000000000000000000
            nil)
          (
            3
            '7371140099201501301'
            '737114009920150130101'
            '3'
            '1'
            '1'
            ''
            ''
            '3.1.1'
            'SILPA '
            0.000000000000000000
            nil)
          (
            3
            '7371140099201501301'
            '737114009920150130102'
            '3'
            '1'
            '2'
            ''
            ''
            '3.1.2'
            'Pencairan Dana Cadangan '
            26000.000000000000000000
            nil)
          (
            4
            '737114009920150130102'
            '73711400992015013010201'
            '3'
            '1'
            '2'
            '1'
            ''
            '3.1.2.1'
            'Cair x'
            26000.000000000000000000
            nil)
          (
            5
            '73711400992015013010201'
            '73711400992015013010201001'
            '3'
            '1'
            '2'
            '1'
            '1'
            '3.1.2.1.1'
            '- Cairkan !'
            26000.000000000000000000
            nil)
          (
            3
            '7371140099201501301'
            '737114009920150130103'
            '3'
            '1'
            '3'
            ''
            ''
            '3.1.3'
            'Hasil Kekayaan Desa Yang dipisahkan '
            0.000000000000000000
            nil)
          (
            2
            '73711400992015013'
            '7371140099201501302'
            '3'
            '2'
            ''
            ''
            ''
            '3.2'
            'Pengeluaran   Pembiayaan '
            10000.000000000000000000
            nil)
          (
            3
            '7371140099201501302'
            '737114009920150130201'
            '3'
            '2'
            '1'
            ''
            ''
            '3.2.1'
            'Pembentukan Dana Cadangan '
            0.000000000000000000
            nil)
          (
            3
            '7371140099201501302'
            '737114009920150130202'
            '3'
            '2'
            '2'
            ''
            ''
            '3.2.2'
            'Penyertaan Modal Desa '
            10000.000000000000000000
            nil)
          (
            4
            '737114009920150130202'
            '73711400992015013020201'
            '3'
            '2'
            '2'
            '1'
            ''
            '3.2.2.1'
            'Modal Desa'
            10000.000000000000000000
            nil)
          (
            5
            '73711400992015013020201'
            '73711400992015013020201001'
            '3'
            '2'
            '2'
            '1'
            '1'
            '3.2.2.1.1'
            '- Modal Desa ke BUMDes'
            10000.000000000000000000
            nil)
          (
            1
            '0'
            '73711400992019001'
            '1'
            ''
            ''
            ''
            ''
            '1'
            'PENDAPATAN'
            10.000000000000000000
            nil)
          (
            2
            '73711400992019001'
            '7371140099201900101'
            '1'
            '1'
            ''
            ''
            ''
            '1.1'
            'Pendapatan Asli Desa'
            10.000000000000000000
            nil)
          (
            3
            '7371140099201900101'
            '737114009920190010101'
            '1'
            '1'
            '1'
            ''
            ''
            '1.1.1'
            'Hasil Usaha'
            0.000000000000000000
            nil)
          (
            3
            '7371140099201900101'
            '737114009920190010102'
            '1'
            '1'
            '2'
            ''
            ''
            '1.1.2'
            'Swadaya,  Partisipasi dan Gotong  Royong'
            10.000000000000000000
            nil)
          (
            4
            '737114009920190010102'
            '73711400992019001010201'
            '1'
            '1'
            '2'
            '1'
            ''
            '1.1.2.1'
            'Dana Swadaya'
            10.000000000000000000
            nil)
          (
            5
            '73711400992019001010201'
            '73711400992019001010201001'
            '1'
            '1'
            '2'
            '1'
            '1'
            '1.1.2.1.1'
            '- Dana Swadaya Masyarakat'
            10.000000000000000000
            nil)
          (
            5
            '73711400992019001010201'
            '73711400992019001010201002'
            '1'
            '1'
            '2'
            '1'
            '2'
            '1.1.2.1.2'
            '- Sumbangan Gotong Royong'
            nil
            nil)
          (
            3
            '7371140099201900101'
            '737114009920190010103'
            '1'
            '1'
            '3'
            ''
            ''
            '1.1.3'
            'Lain-lain Pendapatan Asli Desa yang sah'
            0.000000000000000000
            nil)
          (
            4
            '737114009920190010103'
            '73711400992019001010301'
            '1'
            '1'
            '3'
            '1'
            ''
            '1.1.3.1'
            'Pendapatan Bunga Bank'
            0.000000000000000000
            nil)
          (
            5
            '73711400992019001010301'
            '73711400992019001010301001'
            '1'
            '1'
            '3'
            '1'
            '1'
            '1.1.3.1.1'
            '- Pendapatan Bunga Bank'
            nil
            nil)
          (
            2
            '73711400992019001'
            '7371140099201900102'
            '1'
            '2'
            ''
            ''
            ''
            '1.2'
            'Pendapatan Transfer'
            0.000000000000000000
            nil)
          (
            3
            '7371140099201900102'
            '737114009920190010201'
            '1'
            '2'
            '1'
            ''
            ''
            '1.2.1'
            'Dana Desa'
            0.000000000000000000
            nil)
          (
            3
            '7371140099201900102'
            '737114009920190010202'
            '1'
            '2'
            '2'
            ''
            ''
            '1.2.2'
            'Bagian dari hasil pajak &retribusi daerah kabupaten/ kota'
            0.000000000000000000
            nil)
          (
            3
            '7371140099201900102'
            '737114009920190010203'
            '1'
            '2'
            '3'
            ''
            ''
            '1.2.3'
            'Alokasi Dana Desa'
            0.000000000000000000
            nil)
          (
            3
            '7371140099201900102'
            '737114009920190010204'
            '1'
            '2'
            '4'
            ''
            ''
            '1.2.4'
            'Bantuan Keuangan'
            0.000000000000000000
            nil)
          (
            4
            '737114009920190010204'
            '73711400992019001020401'
            '1'
            '2'
            '4'
            '1'
            ''
            '1.2.4.1'
            'Bantuan Provinsi'
            0.000000000000000000
            nil)
          (
            4
            '737114009920190010204'
            '73711400992019001020402'
            '1'
            '2'
            '4'
            '2'
            ''
            '1.2.4.2'
            'Bantuan Kabupaten / Kota'
            0.000000000000000000
            nil)
          (
            2
            '73711400992019001'
            '7371140099201900103'
            '1'
            '3'
            ''
            ''
            ''
            '1.3'
            'Pendapatan Lain lain'
            0.000000000000000000
            nil)
          (
            3
            '7371140099201900103'
            '737114009920190010301'
            '1'
            '3'
            '1'
            ''
            ''
            '1.3.1'
            'Hibah dan Sumbangan dari pihak ke-3 yang tidak mengikat'
            0.000000000000000000
            nil)
          (
            3
            '7371140099201900103'
            '737114009920190010302'
            '1'
            '3'
            '2'
            ''
            ''
            '1.3.2'
            'Lain-lain Pendapatan Desa yang sah'
            0.000000000000000000
            nil)
          (
            4
            '737114009920190010302'
            '73711400992019001030201'
            '1'
            '3'
            '2'
            '1'
            ''
            '1.3.2.1'
            'Bunga Bank'
            0.000000000000000000
            nil)
          (
            5
            '73711400992019001030201'
            '73711400992019001030201001'
            '1'
            '3'
            '2'
            '1'
            '1'
            '1.3.2.1.1'
            '- Bunga Bank'
            nil
            nil)
          (
            1
            '0'
            '73711400992019002'
            '2'
            ''
            ''
            ''
            ''
            '2'
            'BELANJA'
            12600000.000000000000000000
            nil)
          (
            2
            '73711400992019002'
            '7371140099201900201'
            '2'
            '1'
            ''
            ''
            ''
            '2.1'
            'Bidang Penyelenggaraan Pemerintahan Desa'
            0.000000000000000000
            nil)
          (
            3
            '7371140099201900201'
            '737114009920190020101'
            '2'
            '1'
            '1'
            ''
            ''
            '2.1.1'
            'Penghasilan Tetap dan Tunjangan'
            0.000000000000000000
            nil)
          (
            4
            '737114009920190020101'
            '73711400992019002010101'
            '2'
            '1'
            '1'
            '1'
            ''
            '2.1.1.1'
            'Belanja Pegawai:'
            0.000000000000000000
            nil)
          (
            5
            '73711400992019002010101'
            '73711400992019002010101001'
            '2'
            '1'
            '1'
            '1'
            '1'
            '2.1.1.1.1'
            '- Penghasilan Tetap Kepala Desa  dan Perangkat'
            nil
            nil)
          (
            5
            '73711400992019002010101'
            '73711400992019002010101002'
            '2'
            '1'
            '1'
            '1'
            '2'
            '2.1.1.1.2'
            '- Tunjangan BPD '
            nil
            nil)
          (
            5
            '73711400992019002010101'
            '73711400992019002010101003'
            '2'
            '1'
            '1'
            '1'
            '3'
            '2.1.1.1.3'
            '- Tunjangan Hari Tukang'
            nil
            nil)
          (
            3
            '7371140099201900201'
            '737114009920190020102'
            '2'
            '1'
            '2'
            ''
            ''
            '2.1.2'
            'Operasional Perkantoran'
            0.000000000000000000
            nil)
          (
            4
            '737114009920190020102'
            '73711400992019002010202'
            '2'
            '1'
            '2'
            '2'
            ''
            '2.1.2.2'
            'Belanja Barang dan Jasa'
            0.000000000000000000
            nil)
          (
            5
            '73711400992019002010202'
            '73711400992019002010202001'
            '2'
            '1'
            '2'
            '2'
            '1'
            '2.1.2.2.1'
            '- Alat Tulis Kantor'
            nil
            nil)
          (
            5
            '73711400992019002010202'
            '73711400992019002010202002'
            '2'
            '1'
            '2'
            '2'
            '2'
            '2.1.2.2.2'
            '- Benda POS'
            nil
            nil)
          (
            5
            '73711400992019002010202'
            '73711400992019002010202003'
            '2'
            '1'
            '2'
            '2'
            '3'
            '2.1.2.2.3'
            '- Pakaian Dinas dfan Atribut'
            nil
            nil)
          (
            5
            '73711400992019002010202'
            '73711400992019002010202004'
            '2'
            '1'
            '2'
            '2'
            '4'
            '2.1.2.2.4'
            '- Pakaian Dinas'
            nil
            nil)
          (
            5
            '73711400992019002010202'
            '73711400992019002010202005'
            '2'
            '1'
            '2'
            '2'
            '5'
            '2.1.2.2.5'
            '- Alat dan Bahan Kebersihan'
            nil
            nil)
          (
            5
            '73711400992019002010202'
            '73711400992019002010202006'
            '2'
            '1'
            '2'
            '2'
            '6'
            '2.1.2.2.6'
            '- Perjalanan Dinas'
            nil
            nil)
          (
            5
            '73711400992019002010202'
            '73711400992019002010202007'
            '2'
            '1'
            '2'
            '2'
            '7'
            '2.1.2.2.7'
            '- Pemeliharaan'
            nil
            nil)
          (
            5
            '73711400992019002010202'
            '73711400992019002010202008'
            '2'
            '1'
            '2'
            '2'
            '8'
            '2.1.2.2.8'
            '- Air, Listrik,dasn Telepon'
            nil
            nil)
          (
            5
            '73711400992019002010202'
            '73711400992019002010202009'
            '2'
            '1'
            '2'
            '2'
            '9'
            '2.1.2.2.9'
            '- Honor'
            nil
            nil)
          (
            4
            '737114009920190020102'
            '73711400992019002010203'
            '2'
            '1'
            '2'
            '3'
            ''
            '2.1.2.3'
            'Belanja Modal'
            0.000000000000000000
            nil)
          (
            5
            '73711400992019002010203'
            '73711400992019002010203001'
            '2'
            '1'
            '2'
            '3'
            '1'
            '2.1.2.3.1'
            '- Komputer'
            nil
            nil)
          (
            5
            '73711400992019002010203'
            '73711400992019002010203002'
            '2'
            '1'
            '2'
            '3'
            '2'
            '2.1.2.3.2'
            '- Meja dan Kursi'
            nil
            nil)
          (
            5
            '73711400992019002010203'
            '73711400992019002010203003'
            '2'
            '1'
            '2'
            '3'
            '3'
            '2.1.2.3.3'
            '- Mesin TIK'
            nil
            nil)
          (
            3
            '7371140099201900201'
            '737114009920190020103'
            '2'
            '1'
            '3'
            ''
            ''
            '2.1.3'
            'Operasional BPD'
            0.000000000000000000
            nil)
          (
            4
            '737114009920190020103'
            '73711400992019002010302'
            '2'
            '1'
            '3'
            '2'
            ''
            '2.1.3.2'
            'Belanja Barang dan Jasa'
            0.000000000000000000
            nil)
          (
            5
            '73711400992019002010302'
            '73711400992019002010302001'
            '2'
            '1'
            '3'
            '2'
            '1'
            '2.1.3.2.1'
            '- ATK'
            nil
            nil)
          (
            5
            '73711400992019002010302'
            '73711400992019002010302002'
            '2'
            '1'
            '3'
            '2'
            '2'
            '2.1.3.2.2'
            '- Penggandaan'
            nil
            nil)
          (
            5
            '73711400992019002010302'
            '73711400992019002010302003'
            '2'
            '1'
            '3'
            '2'
            '3'
            '2.1.3.2.3'
            '- Konsumsi Rapat'
            nil
            nil)
          (
            4
            '737114009920190020103'
            '73711400992019002010303'
            '2'
            '1'
            '3'
            '3'
            ''
            '2.1.3.3'
            'Belaja Operasional Nagntuk'
            0.000000000000000000
            nil)
          (
            3
            '7371140099201900201'
            '737114009920190020104'
            '2'
            '1'
            '4'
            ''
            ''
            '2.1.4'
            'Operasional RT/ RW'
            0.000000000000000000
            nil)
          (
            4
            '737114009920190020104'
            '73711400992019002010402'
            '2'
            '1'
            '4'
            '2'
            ''
            '2.1.4.2'
            'Belanja Barang dan Jasa'
            0.000000000000000000
            nil)
          (
            5
            '73711400992019002010402'
            '73711400992019002010402001'
            '2'
            '1'
            '4'
            '2'
            '1'
            '2.1.4.2.1'
            '- ATK'
            nil
            nil)
          (
            5
            '73711400992019002010402'
            '73711400992019002010402002'
            '2'
            '1'
            '4'
            '2'
            '2'
            '2.1.4.2.2'
            '- Penggandaan'
            nil
            nil)
          (
            5
            '73711400992019002010402'
            '73711400992019002010402003'
            '2'
            '1'
            '4'
            '2'
            '3'
            '2.1.4.2.3'
            '- Konsumsi Rapat'
            nil
            nil)
          (
            2
            '73711400992019002'
            '7371140099201900202'
            '2'
            '2'
            ''
            ''
            ''
            '2.2'
            'Bidang Pelaksanaan Pembangunan Desa'
            12600000.000000000000000000
            nil)
          (
            3
            '7371140099201900202'
            '737114009920190020202'
            '2'
            '2'
            '2'
            ''
            ''
            '2.2.2'
            'Pengaspalan  jalan  desa '
            12600000.000000000000000000
            nil)
          (
            4
            '737114009920190020202'
            '73711400992019002020202'
            '2'
            '2'
            '2'
            '2'
            ''
            '2.2.2.2'
            'Belanja Barang dan Jasa :'
            0.000000000000000000
            nil)
          (
            5
            '73711400992019002020202'
            '73711400992019002020202001'
            '2'
            '2'
            '2'
            '2'
            '1'
            '2.2.2.2.1'
            '- Upah Kerja'
            nil
            nil)
          (
            5
            '73711400992019002020202'
            '73711400992019002020202002'
            '2'
            '2'
            '2'
            '2'
            '2'
            '2.2.2.2.2'
            '- Honor'
            nil
            nil)
          (
            4
            '737114009920190020202'
            '73711400992019002020203'
            '2'
            '2'
            '2'
            '3'
            ''
            '2.2.2.3'
            'Belanja  Modal:'
            12600000.000000000000000000
            nil)
          (
            5
            '73711400992019002020203'
            '73711400992019002020203001'
            '2'
            '2'
            '2'
            '3'
            '1'
            '2.2.2.3.1'
            '- Aspal '
            11200000.000000000000000000
            nil)
          (
            5
            '73711400992019002020203'
            '73711400992019002020203002'
            '2'
            '2'
            '2'
            '3'
            '2'
            '2.2.2.3.2'
            '- Pasir '
            1400000.000000000000000000
            nil)
          (
            2
            '73711400992019002'
            '7371140099201900203'
            '2'
            '3'
            ''
            ''
            ''
            '2.3'
            'Bidang Pembinaan Kemasyarakatan '
            0.000000000000000000
            nil)
          (
            3
            '7371140099201900203'
            '737114009920190020301'
            '2'
            '3'
            '1'
            ''
            ''
            '2.3.1'
            'Kegiatan Pembinaan Ketentraman dan Ketertiban'
            0.000000000000000000
            nil)
          (
            4
            '737114009920190020301'
            '73711400992019002030102'
            '2'
            '3'
            '1'
            '2'
            ''
            '2.3.1.2'
            'Belanja Barang dan Jasa:'
            0.000000000000000000
            nil)
          (
            5
            '73711400992019002030102'
            '73711400992019002030102001'
            '2'
            '3'
            '1'
            '2'
            '1'
            '2.3.1.2.1'
            '- Honor Pelatih '
            nil
            nil)
          (
            5
            '73711400992019002030102'
            '73711400992019002030102002'
            '2'
            '3'
            '1'
            '2'
            '2'
            '2.3.1.2.2'
            '- Konsumsi '
            nil
            nil)
          (
            5
            '73711400992019002030102'
            '73711400992019002030102003'
            '2'
            '3'
            '1'
            '2'
            '3'
            '2.3.1.2.3'
            '- Bahan Pelatihan'
            nil
            nil)
          (
            2
            '73711400992019002'
            '7371140099201900204'
            '2'
            '4'
            ''
            ''
            ''
            '2.4'
            'Bidang Pemberdayaan Masyarakat '
            0.000000000000000000
            nil)
          (
            3
            '7371140099201900204'
            '737114009920190020401'
            '2'
            '4'
            '1'
            ''
            ''
            '2.4.1'
            'Kegiatan Pelatihan Kepala Desa dan Perangkat'
            0.000000000000000000
            nil)
          (
            4
            '737114009920190020401'
            '73711400992019002040102'
            '2'
            '4'
            '1'
            '2'
            ''
            '2.4.1.2'
            'Belanja Barang  dan Jasa:'
            0.000000000000000000
            nil)
          (
            5
            '73711400992019002040102'
            '73711400992019002040102001'
            '2'
            '4'
            '1'
            '2'
            '1'
            '2.4.1.2.1'
            '- Honor pelatih'
            nil
            nil)
          (
            5
            '73711400992019002040102'
            '73711400992019002040102002'
            '2'
            '4'
            '1'
            '2'
            '2'
            '2.4.1.2.2'
            '- Konsumsi  '
            nil
            nil)
          (
            5
            '73711400992019002040102'
            '73711400992019002040102003'
            '2'
            '4'
            '1'
            '2'
            '3'
            '2.4.1.2.3'
            '- Bahan pelatihan '
            nil
            nil)
          (
            2
            '73711400992019002'
            '7371140099201900205'
            '2'
            '5'
            ''
            ''
            ''
            '2.5'
            'Bidang Tak Terduga '
            0.000000000000000000
            nil)
          (
            3
            '7371140099201900205'
            '737114009920190020501'
            '2'
            '5'
            '1'
            ''
            ''
            '2.5.1'
            'Kegiatan Kejadian Luar Biasa '
            0.000000000000000000
            nil)
          (
            4
            '737114009920190020501'
            '73711400992019002050102'
            '2'
            '5'
            '1'
            '2'
            ''
            '2.5.1.2'
            'Belanja Barang  dan Jasa:'
            0.000000000000000000
            nil)
          (
            5
            '73711400992019002050102'
            '73711400992019002050102001'
            '2'
            '5'
            '1'
            '2'
            '1'
            '2.5.1.2.1'
            '- Honor tim '
            nil
            nil)
          (
            5
            '73711400992019002050102'
            '73711400992019002050102002'
            '2'
            '5'
            '1'
            '2'
            '2'
            '2.5.1.2.2'
            '- Konsumsi'
            nil
            nil)
          (
            5
            '73711400992019002050102'
            '73711400992019002050102003'
            '2'
            '5'
            '1'
            '2'
            '3'
            '2.5.1.2.3'
            '- Obat-obatan '
            nil
            nil)
          (
            3
            '7371140099201900205'
            '737114009920190020502'
            '2'
            '5'
            '2'
            ''
            ''
            '2.5.2'
            'Kegiatan Tidak Terduga Lainnya'
            0.000000000000000000
            nil)
          (
            4
            '737114009920190020502'
            '73711400992019002050201'
            '2'
            '5'
            '2'
            '1'
            ''
            '2.5.2.1'
            'Belanja Administrasi Tidak Terduga'
            0.000000000000000000
            nil)
          (
            5
            '73711400992019002050201'
            '73711400992019002050201001'
            '2'
            '5'
            '2'
            '1'
            '1'
            '2.5.2.1.1'
            '- Belanja Pajak Bank'
            nil
            nil)
          (
            5
            '73711400992019002050201'
            '73711400992019002050201002'
            '2'
            '5'
            '2'
            '1'
            '2'
            '2.5.2.1.2'
            '- Belanja Administrasi Bank'
            nil
            nil)
          (
            1
            '0'
            '73711400992019003'
            '3'
            ''
            ''
            ''
            ''
            '3'
            'PEMBIAYAAN '
            36000.000000000000000000
            nil)
          (
            2
            '73711400992019003'
            '7371140099201900301'
            '3'
            '1'
            ''
            ''
            ''
            '3.1'
            'Penerimaan Pembiayaan '
            26000.000000000000000000
            nil)
          (
            3
            '7371140099201900301'
            '737114009920190030101'
            '3'
            '1'
            '1'
            ''
            ''
            '3.1.1'
            'SILPA '
            0.000000000000000000
            nil)
          (
            3
            '7371140099201900301'
            '737114009920190030102'
            '3'
            '1'
            '2'
            ''
            ''
            '3.1.2'
            'Pencairan Dana Cadangan '
            26000.000000000000000000
            nil)
          (
            4
            '737114009920190030102'
            '73711400992019003010201'
            '3'
            '1'
            '2'
            '1'
            ''
            '3.1.2.1'
            'Cair x'
            26000.000000000000000000
            nil)
          (
            5
            '73711400992019003010201'
            '73711400992019003010201001'
            '3'
            '1'
            '2'
            '1'
            '1'
            '3.1.2.1.1'
            '- Cairkan !'
            26000.000000000000000000
            nil)
          (
            3
            '7371140099201900301'
            '737114009920190030103'
            '3'
            '1'
            '3'
            ''
            ''
            '3.1.3'
            'Hasil Kekayaan Desa Yang dipisahkan '
            0.000000000000000000
            nil)
          (
            2
            '73711400992019003'
            '7371140099201900302'
            '3'
            '2'
            ''
            ''
            ''
            '3.2'
            'Pengeluaran   Pembiayaan '
            10000.000000000000000000
            nil)
          (
            3
            '7371140099201900302'
            '737114009920190030201'
            '3'
            '2'
            '1'
            ''
            ''
            '3.2.1'
            'Pembentukan Dana Cadangan '
            0.000000000000000000
            nil)
          (
            3
            '7371140099201900302'
            '737114009920190030202'
            '3'
            '2'
            '2'
            ''
            ''
            '3.2.2'
            'Penyertaan Modal Desa '
            10000.000000000000000000
            nil)
          (
            4
            '737114009920190030202'
            '73711400992019003020201'
            '3'
            '2'
            '2'
            '1'
            ''
            '3.2.2.1'
            'Modal Desa'
            10000.000000000000000000
            nil)
          (
            5
            '73711400992019003020201'
            '73711400992019003020201001'
            '3'
            '2'
            '2'
            '1'
            '1'
            '3.2.2.1.1'
            '- Modal Desa ke BUMDes'
            10000.000000000000000000
            nil))
      end
    end
  end
end
