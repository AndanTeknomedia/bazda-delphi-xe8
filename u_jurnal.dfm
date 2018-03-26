object FJurnal: TFJurnal
  Left = 0
  Top = 0
  Caption = 'Jurnal Umum'
  ClientHeight = 445
  ClientWidth = 712
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
    Width = 712
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
    Top = 28
    Width = 712
    Height = 417
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object geRek: TDBGridEh
      AlignWithMargins = True
      Left = 3
      Top = 124
      Width = 706
      Height = 244
      Align = alClient
      AllowedOperations = [alopUpdateEh, alopDeleteEh]
      AllowedSelections = [gstRectangle, gstColumns, gstAll]
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
      GridLineParams.VertEmptySpaceStyle = dessNonEh
      HorzScrollBar.ExtraPanel.NavigatorButtons = [nbFirstEh, nbPriorEh, nbNextEh, nbLastEh]
      HorzScrollBar.ExtraPanel.Visible = True
      HorzScrollBar.VisibleMode = sbAlwaysShowEh
      IndicatorTitle.ShowDropDownSign = True
      IndicatorTitle.TitleButton = True
      EmptyDataInfo.Active = True
      OddRowColor = clWhite
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize, dghColumnMove]
      ParentFont = False
      PopupMenu = PopupMenu1
      SearchPanel.FilterOnTyping = True
      SumList.Active = True
      TabOrder = 1
      Columns = <
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'fkode'
          Footer.Value = 'Ket.: '
          Footer.ValueType = fvtStaticText
          Footers = <>
          ReadOnly = True
          Title.Caption = 'Kode'
          Width = 82
        end
        item
          CellButtons = <>
          Color = 16318448
          DynProps = <>
          EditButtons = <
            item
              OnClick = geRekColumns1EditButtons0Click
            end>
          FieldName = 'uraian'
          Footers = <>
          Title.Caption = 'Uraian Rekening'
          Width = 339
        end
        item
          CellButtons = <>
          Color = 16318448
          DisplayFormat = '#,#0.## ;(#,#0.##) ; '
          DynProps = <>
          EditButtons = <>
          FieldName = 'debet'
          Footer.DisplayFormat = '#,#0.## ;(#,#0.##) ; '
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = 'Debet'
          Width = 124
        end
        item
          CellButtons = <>
          Color = 16318448
          DisplayFormat = '#,#0.## ;(#,#0.##) ; '
          DynProps = <>
          EditButtons = <>
          FieldName = 'kredit'
          Footer.DisplayFormat = '#,#0.## ;(#,#0.##) ; '
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = 'Kredit'
          Width = 124
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 712
      Height = 121
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        712
        121)
      object Label11: TLabel
        Left = 20
        Top = 35
        Width = 43
        Height = 13
        Caption = 'No. Bukti'
      end
      object Label12: TLabel
        Left = 20
        Top = 57
        Width = 31
        Height = 13
        Caption = 'Uraian'
      end
      object Label13: TLabel
        Left = 20
        Top = 14
        Width = 38
        Height = 13
        Caption = 'Tanggal'
      end
      object Label8: TLabel
        Left = 20
        Top = 106
        Width = 86
        Height = 13
        Caption = 'Rincian Transaksi:'
      end
      object eTanggal: TDateTimePicker
        Left = 100
        Top = 10
        Width = 176
        Height = 21
        Date = 42329.621222118050000000
        Format = 'dd/MM/yyyy'
        Time = 42329.621222118050000000
        TabOrder = 0
      end
      object eBukti: TEdit
        Left = 100
        Top = 32
        Width = 176
        Height = 21
        TabOrder = 1
      end
      object eUraian: TMemo
        Left = 100
        Top = 54
        Width = 461
        Height = 41
        ScrollBars = ssVertical
        TabOrder = 2
      end
      object Panel3: TPanel
        Left = 585
        Top = 99
        Width = 124
        Height = 19
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'Belum Balance!'
        Color = clYellow
        ParentBackground = False
        TabOrder = 3
        Visible = False
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 371
      Width = 712
      Height = 46
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      DesignSize = (
        712
        46)
      object Bevel2: TBevel
        Left = 0
        Top = 0
        Width = 712
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
      object ckAutoClose: TCheckBox
        Left = 192
        Top = 15
        Width = 225
        Height = 17
        Caption = 'Tutup Otomatis Setelah Save'
        TabOrder = 2
        Visible = False
        OnClick = ckAutoCloseClick
      end
    end
  end
  object ckApprove: TCheckBox
    Left = 585
    Top = 104
    Width = 97
    Height = 17
    Caption = 'Approve'
    TabOrder = 3
    Visible = False
  end
  object ckCek: TCheckBox
    Left = 585
    Top = 81
    Width = 97
    Height = 17
    Caption = 'Check'
    TabOrder = 2
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
    Left = 150
    Top = 200
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
    Left = 255
    Top = 175
  end
  object PopupMenu1: TPopupMenu
    Left = 80
    Top = 210
    object Add1: TMenuItem
      Caption = 'Tambah Rekening'
      ShortCut = 45
      OnClick = Add1Click
    end
    object Edit3: TMenuItem
      Caption = 'Tukar Debet <> Kredit'
      ShortCut = 119
      OnClick = Edit3Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Hapus1: TMenuItem
      Caption = 'Hapus'
      ShortCut = 16430
      OnClick = Hapus1Click
    end
    object HapusSemua1: TMenuItem
      Caption = 'Hapus Semua'
      ShortCut = 24622
      OnClick = HapusSemua1Click
    end
  end
  object vtAdd: TVirtualTable
    Options = [voPersistentData, voStored, voSkipUnSupportedFieldTypes]
    AfterPost = vtAddAfterPost
    AfterDelete = vtAddAfterPost
    FieldDefs = <
      item
        Name = 'kode'
        DataType = ftString
        Size = 45
      end
      item
        Name = 'fkode'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'uraian'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'debet'
        DataType = ftFloat
      end
      item
        Name = 'kredit'
        DataType = ftFloat
      end
      item
        Name = 'id'
        DataType = ftString
        Size = 50
      end>
    Left = 225
    Top = 175
    Data = {
      0300060004006B6F646501002D00000000000500666B6F646501001E00000000
      00060075726169616E0100FF0000000000050064656265740600000000000000
      06006B7265646974060000000000000002006964010032000000000000000000
      0000}
    object vtAddkode: TStringField
      FieldName = 'kode'
      Size = 45
    end
    object vtAddfkode: TStringField
      FieldName = 'fkode'
      Size = 30
    end
    object vtAdduraian: TStringField
      FieldName = 'uraian'
      Size = 255
    end
    object vtAdddebet: TFloatField
      FieldName = 'debet'
    end
    object vtAddkredit: TFloatField
      FieldName = 'kredit'
    end
    object vtAddid: TStringField
      FieldName = 'id'
      Size = 50
    end
  end
  object QDet: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      
        'SELECT kode, ref_jurnal, skode, kode_rek, debet, kredit, uraian,' +
        ' ref_table, '
      '       ref_kode'
      '  FROM acc_jurnal_u_detail where ref_jurnal = '#39#39)
    Left = 215
    Top = 250
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
  end
  object QJ: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      'select * from acc_jurnal_u where kode = :kd')
    Left = 460
    Top = 280
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'kd'
        Value = nil
      end>
    object QJid: TLargeintField
      FieldName = 'id'
    end
    object QJkode: TStringField
      FieldName = 'kode'
      Required = True
      Size = 29
    end
    object QJjenis_jurnal: TStringField
      FieldName = 'jenis_jurnal'
      Required = True
      FixedChar = True
      Size = 4
    end
    object QJbranch_kode: TStringField
      FieldName = 'branch_kode'
      Required = True
      FixedChar = True
      Size = 3
    end
    object QJtahun: TIntegerField
      FieldName = 'tahun'
      Required = True
    end
    object QJuser_id: TLargeintField
      FieldName = 'user_id'
      Required = True
    end
    object QJref_table: TStringField
      FieldName = 'ref_table'
      Required = True
      Size = 45
    end
    object QJref_kode: TStringField
      FieldName = 'ref_kode'
      Required = True
      Size = 100
    end
    object QJtanggal: TDateTimeField
      FieldName = 'tanggal'
      Required = True
    end
    object QJno_bukti: TStringField
      FieldName = 'no_bukti'
      Required = True
      Size = 50
    end
    object QJuraian: TMemoField
      FieldName = 'uraian'
      BlobType = ftMemo
    end
    object QJchecked: TStringField
      FieldName = 'checked'
      Required = True
      FixedChar = True
      Size = 1
    end
    object QJapproved: TStringField
      FieldName = 'approved'
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object QD: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      
        'select * from acc_jurnal_u_detail where ref_jurnal = :kd order b' +
        'y kode asc')
    Left = 492
    Top = 284
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'kd'
        Value = nil
      end>
    object QDkode: TStringField
      FieldName = 'kode'
      Required = True
      Size = 33
    end
    object QDref_jurnal: TStringField
      FieldName = 'ref_jurnal'
      Required = True
      Size = 29
    end
    object QDskode: TIntegerField
      FieldName = 'skode'
      Required = True
    end
    object QDkode_rek: TStringField
      FieldName = 'kode_rek'
      Required = True
      Size = 8
    end
    object QDdebet: TFloatField
      FieldName = 'debet'
    end
    object QDkredit: TFloatField
      FieldName = 'kredit'
    end
    object QDuraian: TMemoField
      FieldName = 'uraian'
      Required = True
      BlobType = ftMemo
    end
    object QDref_table: TStringField
      FieldName = 'ref_table'
      Required = True
      Size = 45
    end
    object QDref_kode: TStringField
      FieldName = 'ref_kode'
      Required = True
      Size = 100
    end
  end
end
