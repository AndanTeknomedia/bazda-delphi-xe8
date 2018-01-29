object FGetDesaTahun: TFGetDesaTahun
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Desa dan Tahun Anggaran'
  ClientHeight = 436
  ClientWidth = 630
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 390
    Width = 630
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      630
      46)
    object Bevel2: TBevel
      Left = 0
      Top = 0
      Width = 630
      Height = 6
      Align = alTop
      Shape = bsTopLine
      ExplicitTop = 35
      ExplicitWidth = 647
    end
    object Label1: TLabel
      Left = 20
      Top = 19
      Width = 30
      Height = 13
      Caption = 'Tahun'
    end
    object Button1: TButton
      Left = 345
      Top = 12
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 426
      Top = 12
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Batal'
      TabOrder = 1
      OnClick = Button2Click
    end
    object cbTahun: TComboBox
      Left = 56
      Top = 14
      Width = 60
      Height = 21
      Style = csDropDownList
      ItemHeight = 0
      TabOrder = 3
    end
    object Button3: TButton
      Left = 539
      Top = 12
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Baru...'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 0
    Width = 630
    Height = 286
    Margins.Top = 24
    Align = alClient
    AllowedOperations = []
    AllowedSelections = [gstRecordBookmarks]
    DataSource = dsWil
    DrawMemoText = True
    DynProps = <>
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    FooterParams.Color = 15532021
    GridLineParams.VertEmptySpaceStyle = dessNonEh
    IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    EmptyDataInfo.Active = True
    OddRowColor = 16316664
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove]
    ParentFont = False
    PopupMenu = PopupMenu1
    ReadOnly = True
    SearchPanel.Enabled = True
    SearchPanel.FilterOnTyping = True
    SumList.Active = True
    TabOrder = 0
    OnAdvDrawDataCell = DBGridEh1AdvDrawDataCell
    OnDblClick = DBGridEh1DblClick
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'tipe'
        Footers = <>
        Title.Caption = 'Tingkat'
        Width = 93
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'id'
        Footers = <>
        Title.Caption = 'Kode'
        Width = 88
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'nama'
        Footers = <>
        Title.Caption = 'Nama Wilayah Administrasi'
        Width = 340
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 286
    Width = 630
    Height = 104
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    ExplicitTop = 360
    object Label2: TLabel
      Left = 13
      Top = 14
      Width = 37
      Height = 13
      Caption = 'Provinsi'
    end
    object Label3: TLabel
      Left = 13
      Top = 34
      Width = 78
      Height = 13
      Caption = 'Kabupaten/Kota'
    end
    object Label4: TLabel
      Left = 13
      Top = 53
      Width = 53
      Height = 13
      Caption = 'Kecamatan'
    end
    object Label5: TLabel
      Left = 13
      Top = 72
      Width = 24
      Height = 13
      Caption = 'Desa'
    end
    object SpeedButton1: TSpeedButton
      Left = 575
      Top = 10
      Width = 23
      Height = 22
      Cursor = crHandPoint
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF0000584E9FDF4CBFF81467D4556FC6FF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8AADDC
        C3FFFF95EBFF58D0FD0773D93556BDFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF92BAE5FFFFFF79DFFF0EA4EE0B6DD50E7FE033
        61C5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5D7ECF
        DBFFFF06DFFA00C3FC119EEA1272D70D80E13C6BCBFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF4A5AC235B9E40AFFFF00D8F600C8FE119CEA12
        71D60D7FDF3767CBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        2F4DBF3AD2EC12FFFF00D9F600C8FE119CEA1271D50D80DE3E6FCFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3A52C339D4ED12FFFF00D8F600
        C8FE119CEA1271D50D7FDF386BD1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF3551C33AD1EC0CFFFD00D9F600C8FE119CEA126FD50C80DF4278
        D4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3F5AC959F0F607
        FFFB00D8F600C8FE119CEA1371D60B7FE32562D2FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF4966CD67F6F803FFFA00D8F600C8FE0EA9F70052
        BE627590749ADBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF52
        6ED268F8F905FFFA00E6FF00A4E9627992FFFFE97976B8FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4D6CD266FFFF00E9E1639AA3FFFF
        FC6B6FAA0000DDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF4576D880B6BCFFFFFC6D7CAD0000DAFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6089E884A6BC0C6C
        E2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 575
      Top = 32
      Width = 23
      Height = 22
      Cursor = crHandPoint
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF0000584E9FDF4CBFF81467D4556FC6FF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8AADDC
        C3FFFF95EBFF58D0FD0773D93556BDFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF92BAE5FFFFFF79DFFF0EA4EE0B6DD50E7FE033
        61C5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5D7ECF
        DBFFFF06DFFA00C3FC119EEA1272D70D80E13C6BCBFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF4A5AC235B9E40AFFFF00D8F600C8FE119CEA12
        71D60D7FDF3767CBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        2F4DBF3AD2EC12FFFF00D9F600C8FE119CEA1271D50D80DE3E6FCFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3A52C339D4ED12FFFF00D8F600
        C8FE119CEA1271D50D7FDF386BD1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF3551C33AD1EC0CFFFD00D9F600C8FE119CEA126FD50C80DF4278
        D4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3F5AC959F0F607
        FFFB00D8F600C8FE119CEA1371D60B7FE32562D2FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF4966CD67F6F803FFFA00D8F600C8FE0EA9F70052
        BE627590749ADBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF52
        6ED268F8F905FFFA00E6FF00A4E9627992FFFFE97976B8FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4D6CD266FFFF00E9E1639AA3FFFF
        FC6B6FAA0000DDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF4576D880B6BCFFFFFC6D7CAD0000DAFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6089E884A6BC0C6C
        E2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = SpeedButton1Click
    end
    object SpeedButton3: TSpeedButton
      Left = 575
      Top = 54
      Width = 23
      Height = 22
      Cursor = crHandPoint
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF0000584E9FDF4CBFF81467D4556FC6FF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8AADDC
        C3FFFF95EBFF58D0FD0773D93556BDFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF92BAE5FFFFFF79DFFF0EA4EE0B6DD50E7FE033
        61C5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5D7ECF
        DBFFFF06DFFA00C3FC119EEA1272D70D80E13C6BCBFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF4A5AC235B9E40AFFFF00D8F600C8FE119CEA12
        71D60D7FDF3767CBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        2F4DBF3AD2EC12FFFF00D9F600C8FE119CEA1271D50D80DE3E6FCFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3A52C339D4ED12FFFF00D8F600
        C8FE119CEA1271D50D7FDF386BD1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF3551C33AD1EC0CFFFD00D9F600C8FE119CEA126FD50C80DF4278
        D4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3F5AC959F0F607
        FFFB00D8F600C8FE119CEA1371D60B7FE32562D2FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF4966CD67F6F803FFFA00D8F600C8FE0EA9F70052
        BE627590749ADBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF52
        6ED268F8F905FFFA00E6FF00A4E9627992FFFFE97976B8FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4D6CD266FFFF00E9E1639AA3FFFF
        FC6B6FAA0000DDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF4576D880B6BCFFFFFC6D7CAD0000DAFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6089E884A6BC0C6C
        E2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = SpeedButton1Click
    end
    object SpeedButton4: TSpeedButton
      Left = 575
      Top = 76
      Width = 23
      Height = 22
      Cursor = crHandPoint
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000C1761BC27519
        BD6B13B96504B96504B96504BA6504BA6504BA6504BA6504BA6504BA6504BA65
        04BC690AB96A15C3791FD5933DEFB736CDC6C0E9F8FFDBE5F6DBE8F8DBE8F8DB
        E8F9DBE8F8DAE7F8DBE7F8D8E4F5E9F6FFCDC6C0EAA714C0761DCD9551E8AE3C
        DCD7D4ECE8E9ADA0A2A79B9E9E939594898C8A818583797C7B7276685F64ECE8
        E9DCD7D4E59E20C77B25D09653EAB447DCD7D4EFF0EFDFDEDCE1E0DFE0DFDEDF
        E0DDE0DFDDDFDEDDDFE0DEDBD9D9EDEDEDDCD7D4E7A62BC9802BD49B58EBB950
        DCD7D4ECE8E9A99D9FA4999E9A919492888B897F8582797C7A7177655C62ECE8
        E9DCD7D4E8AC37CC8531D69E5BEDBD5ADCD7D4FFFFFFFFFEFEFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCD7D4EAB340D08B34D9A45EF0C263
        DCD7D4ECE8E9A99D9FA4999E9A919492888B897F8582797C7A7177655C62ECE8
        E9DCD7D4EDB749D2903AD8A35CF0C66DDCD7D4FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCD7D4EEBD54D7963EDEAC69F9D281
        C1975C9A7B6095775E97795D97795D97795D97795D97795C97795C95775E9A7A
        5EC19A64F7CA6BD99B44DDAB67F6D58BFFD056C0A887C8C5C9CEC6BFCDC6C0CD
        C6C0CDC6BFD6D0CAD6D3D0CFCED4C0A888FFD25DF3CC75DCA148DCA966F6D993
        FBC85DC2B4A2D7DEEBDDDDDDDCDDDEDCDBDDE7E8EAC8BAA7A29692C2B4A2C6BC
        A9FBCB63F3D07EE0A74CE5B973F6DA97FBCC62C8BAA7DDE0E9E1DFDDE0DFDEDF
        DDDCEFF3F99F886FE5AF479E9189C7BDB2FDCF6AF5D484E3AC51E9BC75F8DD9E
        FDCF69CEC0AFE3E7EFE7E5E3E6E5E4E5E4E2F1F6FFBAA386FFE873B5AB9ECAC0
        B8FFD26EF9DA8EE7B25BEAC079F8E09BFBD165D3C4AFEAEEF6ECEBE8ECEBE9EB
        E9E6FBFFFFA28E78DEAF4FA89C95D1C7B9FFDA78F5D889E2A442ECC47EFEF4D5
        FFE290DCD7D4F5FFFFF6FEFFF6FEFFF6FDFFFFFFFFDFDDDCC8BAA7DFDDDCE5E4
        E2FFDE88E4AA45FCF5ECECC681F0CA82F4CA7DE8C788EFCF94EFD498EDCF92EE
        D092EED093F2D396F7D79BF6D69BE6C48AEBB552FDF9F2FFFFFF}
      OnClick = SpeedButton1Click
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 148
      Top = 10
      Width = 421
      Height = 21
      DropDownRows = 12
      KeyField = 'id'
      ListField = 'nama'
      ListSource = DataSource1
      TabOrder = 0
    end
    object DBLookupComboBox2: TDBLookupComboBox
      Left = 148
      Top = 32
      Width = 421
      Height = 21
      DropDownRows = 12
      KeyField = 'id'
      ListField = 'nama'
      ListSource = DataSource2
      TabOrder = 1
    end
    object DBLookupComboBox3: TDBLookupComboBox
      Left = 148
      Top = 54
      Width = 421
      Height = 21
      DropDownRows = 12
      KeyField = 'id'
      ListField = 'nama'
      ListSource = DataSource3
      TabOrder = 2
    end
    object eKdDesa: TEdit
      Left = 148
      Top = 76
      Width = 63
      Height = 21
      MaxLength = 4
      NumbersOnly = True
      TabOrder = 3
    end
    object eNamaDesa: TEdit
      Left = 211
      Top = 76
      Width = 358
      Height = 21
      MaxLength = 100
      TabOrder = 4
    end
  end
  object mtWil: TMemTableEh
    Active = True
    Params = <>
    TreeList.Active = True
    TreeList.KeyFieldName = 'id'
    TreeList.RefParentFieldName = 'id_parent'
    Left = 55
    Top = 120
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object tipe: TMTStringDataFieldEh
          FieldName = 'tipe'
          StringDataType = fdtStringEh
          DisplayLabel = 'tipe'
          DisplayWidth = 3
          Size = 3
          Transliterate = True
        end
        object id_parent: TMTBlobDataFieldEh
          FieldName = 'id_parent'
          DisplayLabel = 'id_parent'
          DisplayWidth = 10
          BlobType = ftMemo
          GraphicHeader = True
          Transliterate = True
        end
        object id: TMTBlobDataFieldEh
          FieldName = 'id'
          DisplayLabel = 'id'
          DisplayWidth = 10
          BlobType = ftMemo
          GraphicHeader = True
          Transliterate = True
        end
        object nama: TMTStringDataFieldEh
          FieldName = 'nama'
          StringDataType = fdtStringEh
          DisplayLabel = 'nama'
          DisplayWidth = 100
          Size = 100
          Transliterate = True
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            'PRO'
            '0'
            '73'
            'Sulawesi Selatan')
          (
            'KAB'
            '73'
            '7371'
            'Kota Makasar')
          (
            'KEC'
            '7371'
            '737114'
            'Tamalanrea')
          (
            'DES'
            '737114'
            '7371140099'
            'Desa Tanpa Kepala'))
      end
    end
  end
  object QWil: TUniQuery
    SQL.Strings = (
      'SELECT distinct v.tipe, v.id_parent, v.id, v.nama'
      
        '  FROM vw_wil_administrasi v inner join desa d on d.id like (v.i' +
        'd||'#39'%'#39')'
      '  order by v.id_parent asc, v.id asc;')
    Left = 50
    Top = 80
    object QWiltipe: TStringField
      FieldName = 'tipe'
      Size = 3
    end
    object QWilid_parent: TMemoField
      FieldName = 'id_parent'
      BlobType = ftMemo
    end
    object QWilid: TMemoField
      FieldName = 'id'
      BlobType = ftMemo
    end
    object QWilnama: TStringField
      FieldName = 'nama'
      Size = 100
    end
  end
  object dsWil: TDataSource
    AutoEdit = False
    DataSet = mtWil
    Left = 55
    Top = 160
  end
  object ActionManager1: TActionManager
    Left = 380
    Top = 195
    StyleName = 'Platform Default'
    object acRefresh: TAction
      Caption = 'Refresh'
      ShortCut = 116
      OnExecute = acRefreshExecute
    end
  end
  object UniQuery1: TUniQuery
    SQL.Strings = (
      'select id, nama from provinsi order by id asc')
    Left = 195
    Top = 195
    object UniQuery1id: TStringField
      FieldName = 'id'
      Required = True
      Size = 2
    end
    object UniQuery1nama: TStringField
      FieldName = 'nama'
      Required = True
      Size = 100
    end
  end
  object UniQuery2: TUniQuery
    SQL.Strings = (
      'select id, id_prov, nama from kabupaten order by id asc')
    MasterSource = DataSource1
    MasterFields = 'id'
    DetailFields = 'id_prov'
    Left = 230
    Top = 195
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
      end>
    object UniQuery2id: TStringField
      FieldName = 'id'
      Required = True
      Size = 4
    end
    object UniQuery2id_prov: TStringField
      FieldName = 'id_prov'
      Required = True
      Size = 2
    end
    object UniQuery2nama: TStringField
      FieldName = 'nama'
      Required = True
      Size = 100
    end
  end
  object UniQuery3: TUniQuery
    SQL.Strings = (
      'select id, id_kabupaten, nama from kecamatan order by id asc')
    MasterSource = DataSource2
    MasterFields = 'id'
    DetailFields = 'id_kabupaten'
    Left = 265
    Top = 195
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
      end>
    object UniQuery3id: TStringField
      FieldName = 'id'
      Required = True
      Size = 6
    end
    object UniQuery3id_kabupaten: TStringField
      FieldName = 'id_kabupaten'
      Required = True
      Size = 4
    end
    object UniQuery3nama: TStringField
      FieldName = 'nama'
      Required = True
      Size = 100
    end
  end
  object DataSource1: TDataSource
    DataSet = UniQuery1
    Left = 195
    Top = 240
  end
  object DataSource2: TDataSource
    DataSet = UniQuery2
    Left = 230
    Top = 240
  end
  object DataSource3: TDataSource
    DataSet = UniQuery3
    Left = 270
    Top = 240
  end
  object PopupMenu1: TPopupMenu
    Left = 435
    Top = 160
    object Refresh1: TMenuItem
      Action = acRefresh
    end
  end
end
