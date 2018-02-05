object FSalurZis: TFSalurZis
  Left = 0
  Top = 0
  Caption = 'Penyaluran Dana ZIS'
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
    Top = 161
    Width = 753
    Height = 320
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Panel2: TPanel
      Left = 0
      Top = 274
      Width = 753
      Height = 46
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
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
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 753
      Height = 274
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
    end
    object geRek: TDBGridEh
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 747
      Height = 268
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
      SearchPanel.FilterOnTyping = True
      SumList.Active = True
      TabOrder = 1
      TitleParams.MultiTitle = True
      Columns = <
        item
          CellButtons = <>
          Color = 15329769
          DynProps = <>
          EditButton.Style = ebsPlusEh
          EditButton.Visible = True
          EditButtons = <>
          FieldName = 'NPWZ'
          Footer.Value = 'Ket.: '
          Footer.ValueType = fvtStaticText
          Footers = <>
          ReadOnly = True
          Title.Caption = 'NPM'
          Width = 102
        end
        item
          CellButtons = <>
          Color = 16318448
          DynProps = <>
          EditButtons = <>
          FieldName = 'Nama'
          Footers = <>
          ReadOnly = True
          Title.Caption = 'Nama Mustahik'
          Width = 135
        end
        item
          CellButtons = <>
          Color = 16318448
          DynProps = <>
          EditButtons = <>
          FieldName = 'Alamat'
          Footers = <>
          Width = 193
        end
        item
          AlwaysShowEditButton = True
          CellButtons = <>
          DynProps = <>
          EditButton.Images.NormalIndex = 75
          EditButton.Images.HotIndex = 75
          EditButton.Images.PressedIndex = 75
          EditButton.Style = ebsMinusEh
          EditButton.Visible = True
          EditButton.Width = 16
          EditButtons = <>
          Footers = <>
          ReadOnly = True
          Title.Caption = '...'
          Width = 16
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object cap1: TJvCaptionPanel
    Left = 0
    Top = 28
    Width = 753
    Height = 133
    Align = alTop
    Buttons = []
    BorderStyle = bsNone
    Caption = 'Jurnal Penyaluran Dana ZIS'
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
      Top = 75
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
      Top = 119
      Width = 93
      Height = 13
      Caption = 'Rincian Penerimaan'
    end
    object Label1: TLabel
      Left = 13
      Top = 52
      Width = 66
      Height = 13
      Caption = 'Disalurkan Via'
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
      Top = 72
      Width = 501
      Height = 41
      Lines.Strings = (
        'Memo1'
        'Memo2')
      ScrollBars = ssVertical
      TabOrder = 2
    end
    object eVia: TButtonedEdit
      Left = 92
      Top = 49
      Width = 501
      Height = 21
      TabOrder = 1
      OnRightButtonClick = eViaRightButtonClick
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
    Left = 331
    Top = 287
  end
  object PopupMenu1: TPopupMenu
    Left = 356
    Top = 318
    object Add1: TMenuItem
      Caption = 'Tambah Mustahik'
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
    Left = 281
    Top = 275
    Data = {03000000000000000000}
    object vtAddNPWZ: TStringField
      FieldName = 'NPWZ'
      Size = 15
    end
    object vtAddNama: TStringField
      FieldName = 'Nama'
      Size = 100
    end
    object vtAddAlamat: TStringField
      FieldName = 'Alamat'
      Size = 200
    end
  end
  object QDet: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      
        'SELECT kode, ref_jurnal, skode, kode_rek, debet, kredit, uraian,' +
        ' ref_table, '
      '       ref_kode, nama'
      '  FROM acc_jurnal_u_detail where ref_jurnal = '#39#39)
    Left = 367
    Top = 282
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
