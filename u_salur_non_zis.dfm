object FSalurNonZis: TFSalurNonZis
  Left = 0
  Top = 0
  Caption = 'Penggunaan Operasional'
  ClientHeight = 481
  ClientWidth = 753
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
    Width = 753
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
    Top = 185
    Width = 753
    Height = 296
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object geRek: TDBGridEh
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 747
      Height = 244
      Align = alClient
      AllowedOperations = [alopUpdateEh, alopDeleteEh]
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
      GridLineParams.VertEmptySpaceStyle = dessNonEh
      IndicatorTitle.ShowDropDownSign = True
      IndicatorTitle.TitleButton = True
      EmptyDataInfo.Active = True
      OddRowColor = clWhite
      Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize]
      ParentFont = False
      PopupMenu = PopupMenu1
      SearchPanel.FilterOnTyping = True
      SumList.Active = True
      TabOrder = 0
      Columns = <
        item
          CellButtons = <>
          Color = 15329769
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
          FieldName = 'jumlah'
          Footer.DisplayFormat = '#,#0.## ;(#,#0.##) ; '
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = 'Jumlah'
          Width = 124
        end
        item
          AlwaysShowEditButton = True
          CellButtons = <>
          DynProps = <>
          EditButton.Style = ebsMinusEh
          EditButton.Visible = True
          EditButton.Width = 16
          EditButton.OnClick = geRekColumns3EditButtons0Click
          EditButtons = <>
          Footers = <>
          ReadOnly = True
          Title.Caption = '...'
          Width = 16
          OnEditButtonClick = geRekColumns3EditButtons0Click
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 250
      Width = 753
      Height = 46
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        753
        46)
      object Bevel2: TBevel
        Left = 0
        Top = 0
        Width = 753
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
  end
  object cap1: TJvCaptionPanel
    Left = 0
    Top = 28
    Width = 753
    Height = 157
    Align = alTop
    Buttons = []
    BorderStyle = bsNone
    Caption = 'Jurnal Penyaluran Dana Operasional'
    CaptionColor = clGreen
    CaptionPosition = dpTop
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWhite
    CaptionFont.Height = -13
    CaptionFont.Name = 'Tahoma'
    CaptionFont.Style = [fsBold]
    OutlookLook = False
    TabOrder = 1
    object Label12: TLabel
      Left = 13
      Top = 102
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
    object Label8: TLabel
      Left = 13
      Top = 142
      Width = 93
      Height = 13
      Caption = 'Rincian Penerimaan'
    end
    object Label1: TLabel
      Left = 13
      Top = 71
      Width = 66
      Height = 13
      Caption = 'Disalurkan Via'
    end
    object Label2: TLabel
      Left = 13
      Top = 52
      Width = 43
      Height = 13
      Caption = 'No. Bukti'
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
      Top = 95
      Width = 501
      Height = 41
      Lines.Strings = (
        'Memo1'
        'Memo2')
      ScrollBars = ssVertical
      TabOrder = 3
    end
    object eVia: TButtonedEdit
      Left = 92
      Top = 72
      Width = 501
      Height = 21
      TabOrder = 2
      OnRightButtonClick = eViaRightButtonClick
    end
    object eBukti: TEdit
      Left = 92
      Top = 49
      Width = 176
      Height = 21
      TabOrder = 1
      Text = 'eBukti'
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
    Left = 466
    Top = 372
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
    Left = 571
    Top = 347
  end
  object PopupMenu1: TPopupMenu
    Left = 396
    Top = 382
    object Add1: TMenuItem
      Caption = 'Tambah Akun Distribusi'
      ShortCut = 45
      OnClick = Add1Click
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
        Name = 'jumlah'
        DataType = ftFloat
      end>
    Left = 541
    Top = 347
    Data = {
      0300040004006B6F646501002D00000000000500666B6F646501001E00000000
      00060075726169616E0100FF000000000006006A756D6C616806000000000000
      00000000000000}
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
    object vtAddjumlah: TFloatField
      FieldName = 'jumlah'
    end
  end
  object QDet: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      
        'SELECT kode, ref_jurnal, skode, kode_rek, debet, kredit, uraian,' +
        ' ref_table, '
      '       ref_kode, nama'
      '  FROM acc_jurnal_u_detail where ref_jurnal = '#39#39)
    Left = 411
    Top = 294
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
end
