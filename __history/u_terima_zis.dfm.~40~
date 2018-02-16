object FTerimaZIS: TFTerimaZIS
  Left = 0
  Top = 0
  Caption = 'Penerimaan ZIS Langsung'
  ClientHeight = 559
  ClientWidth = 908
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
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
    Width = 908
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
  object Panel7: TPanel
    Left = 0
    Top = 201
    Width = 908
    Height = 358
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Panel2: TPanel
      Left = 0
      Top = 312
      Width = 908
      Height = 46
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      DesignSize = (
        908
        46)
      object Bevel2: TBevel
        Left = 0
        Top = 0
        Width = 908
        Height = 6
        Align = alTop
        Shape = bsBottomLine
        ExplicitTop = 35
        ExplicitWidth = 647
      end
      object Button3: TButton
        Left = 19
        Top = 12
        Width = 75
        Height = 25
        Action = acSave
        Anchors = [akLeft, akBottom]
        TabOrder = 0
      end
      object Button4: TButton
        Left = 100
        Top = 12
        Width = 75
        Height = 25
        Action = acNew
        Anchors = [akLeft, akBottom]
        TabOrder = 1
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 259
      Width = 908
      Height = 53
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 1
      object Label4: TLabel
        Left = 14
        Top = 9
        Width = 67
        Height = 13
        Caption = 'Dana Diterima'
      end
      object Label9: TLabel
        Left = 14
        Top = 34
        Width = 77
        Height = 13
        Caption = 'Hak Amil Baznas'
      end
      object eTerima: TJvCalcEdit
        Left = 185
        Top = 6
        Width = 149
        Height = 21
        DisplayFormat = '#,#0.## ;(#,#0.##) ; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ShowButton = False
        TabOrder = 0
        DecimalPlacesAlwaysShown = False
        OnChange = eTerimaChange
      end
      object eHakAmilBaznas: TPersenDanNilai
        Left = 110
        Top = 30
        Width = 224
        Height = 21
        BevelOuter = bvNone
        Caption = 'esbNilaiJaminan'
        Constraints.MaxHeight = 21
        Enabled = False
        ShowCaption = False
        TabOrder = 1
        TabStop = True
        PemisahRibuan = '.'
        PemisahPecahan = ','
      end
    end
    object geAdd: TDBGridEh
      Left = 0
      Top = 0
      Width = 908
      Height = 259
      Align = alClient
      AllowedOperations = [alopUpdateEh]
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
      PopupMenu = pmAdd
      SearchPanel.FilterOnTyping = True
      SumList.Active = True
      TabOrder = 0
      TitleParams.MultiTitle = True
      Columns = <
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'Kode Akun'
          Footers = <>
          ReadOnly = True
          Width = 86
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'Jenis Penerimaan'
          Footers = <>
          Width = 341
        end
        item
          CellButtons = <>
          DisplayFormat = '#,#0.## ;(#,#0.##) ;  '
          DynProps = <>
          EditButtons = <>
          FieldName = 'Jumlah'
          Footer.DisplayFormat = '#,#0.## ;(#,#0.##) ;  '
          Footer.ValueType = fvtSum
          Footers = <>
          Width = 147
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object cap1: TJvCaptionPanel
    Left = 0
    Top = 28
    Width = 908
    Height = 173
    Align = alTop
    Buttons = []
    BorderStyle = bsNone
    Caption = 'Jurnal Penerimaan Dana ZIS'
    CaptionColor = clGreen
    CaptionPosition = dpTop
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWhite
    CaptionFont.Height = -13
    CaptionFont.Name = 'Tahoma'
    CaptionFont.Style = [fsBold]
    OutlookLook = False
    TabOrder = 1
    object Label11: TLabel
      Left = 13
      Top = 52
      Width = 32
      Height = 13
      Caption = 'Muzaki'
    end
    object Label12: TLabel
      Left = 13
      Top = 121
      Width = 31
      Height = 13
      Caption = 'Uraian'
    end
    object Label13: TLabel
      Left = 13
      Top = 30
      Width = 38
      Height = 13
      Caption = 'Tanggal'
    end
    object Label1: TLabel
      Left = 13
      Top = 98
      Width = 56
      Height = 13
      Caption = 'Diterima Via'
    end
    object Label3: TLabel
      Left = 12
      Top = 76
      Width = 68
      Height = 13
      Caption = 'Alamat Muzaki'
    end
    object eTanggal: TDateTimePicker
      Left = 92
      Top = 26
      Width = 176
      Height = 21
      Date = 42329.621222118050000000
      Format = 'dd/MM/yyyy'
      Time = 42329.621222118050000000
      TabOrder = 0
    end
    object eUraian: TMemo
      Left = 92
      Top = 118
      Width = 501
      Height = 41
      Lines.Strings = (
        'Memo1'
        'Memo2')
      ScrollBars = ssVertical
      TabOrder = 5
    end
    object eVia: TButtonedEdit
      Left = 92
      Top = 95
      Width = 501
      Height = 21
      ReadOnly = True
      TabOrder = 4
      OnRightButtonClick = eViaRightButtonClick
    end
    object eAlamat: TEdit
      Left = 92
      Top = 72
      Width = 501
      Height = 21
      Color = 15329769
      ReadOnly = True
      TabOrder = 3
      Text = 'eAlamat'
    end
    object GroupBox1: TGroupBox
      Left = 619
      Top = 49
      Width = 278
      Height = 108
      Caption = 'Bagian Amil Atas'
      TabOrder = 2
      object Label8: TLabel
        Left = 16
        Top = 27
        Width = 245
        Height = 30
        AutoSize = False
        Caption = 'Bagian Amil'
        WordWrap = True
      end
      object ePersenAmil: TJvCalcEdit
        Left = 16
        Top = 63
        Width = 113
        Height = 27
        TabStop = False
        Color = 15329769
        DisplayFormat = '#,#0.## %;(#,#0.## %) ; 0 %'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ShowButton = False
        TabOrder = 0
        DecimalPlacesAlwaysShown = False
      end
    end
    object eMZK: TButtonedEdit
      Left = 92
      Top = 49
      Width = 501
      Height = 21
      ReadOnly = True
      TabOrder = 1
      OnRightButtonClick = eMZKRightButtonClick
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
            Action = acNew
            Caption = '&Baru'
            ImageIndex = 16
            ShortCut = 16462
          end
          item
            Action = acSave
            Caption = '&Save'
            ImageIndex = 22
            ShortCut = 16467
          end>
        ActionBar = ActionToolBar1
      end>
    Images = FMain.ilWin
    Left = 490
    Top = 116
    StyleName = 'Platform Default'
    object acClose: TAction
      Caption = 'Close'
      ImageIndex = 4
      ShortCut = 16499
      OnExecute = acCloseExecute
    end
    object acNew: TAction
      Caption = 'Baru'
      ImageIndex = 16
      ShortCut = 16462
      OnExecute = acNewExecute
    end
    object acSave: TAction
      Caption = 'Save'
      ImageIndex = 22
      ShortCut = 16467
      OnExecute = acSaveExecute
    end
  end
  object dsAdd: TDataSource
    DataSet = vtAdd
    Left = 215
    Top = 127
  end
  object pmAdd: TPopupMenu
    Left = 112
    Top = 226
    object HapusSemua1: TMenuItem
      Caption = 'Kosongkan Jumlah'
      ShortCut = 24622
      OnClick = HapusSemua1Click
    end
  end
  object vtAdd: TVirtualTable
    Options = [voPersistentData, voStored, voSkipUnSupportedFieldTypes]
    AfterPost = vtAddAfterDelete
    AfterDelete = vtAddAfterDelete
    Left = 213
    Top = 111
    Data = {03000000000000000000}
    object vtAddKode: TStringField
      FieldName = 'Kode'
      Size = 8
    end
    object vtAddKodeAkun: TStringField
      FieldName = 'Kode Akun'
    end
    object vtAddJenisPenerimaan: TStringField
      FieldName = 'Jenis Penerimaan'
      Size = 200
    end
    object vtAddJumlah: TFloatField
      FieldName = 'Jumlah'
    end
  end
  object QDet: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      
        'SELECT kode, ref_jurnal, skode, kode_rek, debet, kredit, uraian,' +
        ' ref_table, '
      '       ref_kode, nama'
      '  FROM acc_jurnal_u_detail where ref_jurnal = '#39#39)
    Left = 339
    Top = 38
    object QDetkode: TStringField
      FieldName = 'kode'
      Size = 33
    end
    object QDetref_jurnal: TStringField
      FieldName = 'ref_jurnal'
      Required = True
      Size = 29
    end
    object QDetskode: TIntegerField
      FieldName = 'skode'
    end
    object QDetkode_rek: TStringField
      FieldName = 'kode_rek'
      Required = True
      Size = 8
    end
    object QDetdebet: TFloatField
      FieldName = 'debet'
    end
    object QDetkredit: TFloatField
      FieldName = 'kredit'
    end
    object QDeturaian: TMemoField
      FieldName = 'uraian'
      Required = True
      BlobType = ftMemo
    end
    object QDetref_table: TStringField
      FieldName = 'ref_table'
      Size = 45
    end
    object QDetref_kode: TStringField
      FieldName = 'ref_kode'
      Size = 100
    end
    object QDetnama: TStringField
      FieldName = 'nama'
      Required = True
      Size = 100
    end
  end
  object QKel: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      
        'select kode, (nama||'#39', '#39'||kecamatan)::varchar(100) nama from v_k' +
        'elurahan order by kode asc')
    Active = True
    Left = 375
    Top = 42
    object QKelkode: TStringField
      FieldName = 'kode'
      Size = 10
    end
    object QKelnama: TStringField
      FieldName = 'nama'
      Size = 100
    end
  end
  object dsKel: TDataSource
    DataSet = QKel
    Left = 376
    Top = 92
  end
  object qUPZ: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      'with x as('
      #9'select'
      
        #9#9#39'XX'#39'::varchar(100) jenis, '#39'BARU'#39'::varchar(18) npwz, '#39'Tambah Mu' +
        'zaki Baru...'#39'::varchar(100) nama,  '#39#39'::text alamat,  '#39#39'::varchar' +
        '(10) kelurahan '
      #9'union'
      
        #9'select t.uraian jenis, m.npwz, m.nama, (v.nama||'#39', '#39'||v.kecamat' +
        'an)::text alamat, m.kelurahan from baz_muzakki m '
      '      inner join baz_jenis_muzakki t on t.kode = m.tipe'
      '      inner join v_kelurahan v on v.kode = m.kelurahan '
      '      where m.tipe <> '#39'00'#39
      ') select * from x  order by npwz asc')
    Left = 428
    Top = 120
    object qUPZjenis: TStringField
      FieldName = 'jenis'
      ReadOnly = True
      Size = 100
    end
    object qUPZnpwz: TStringField
      FieldName = 'npwz'
      ReadOnly = True
      Size = 18
    end
    object qUPZnama: TStringField
      FieldName = 'nama'
      ReadOnly = True
      Size = 100
    end
    object qUPZalamat: TMemoField
      FieldName = 'alamat'
      ReadOnly = True
      BlobType = ftMemo
    end
    object qUPZkelurahan: TStringField
      FieldName = 'kelurahan'
      ReadOnly = True
      Size = 10
    end
  end
  object dsUpz: TDataSource
    DataSet = qUPZ
    Left = 436
    Top = 152
  end
end
