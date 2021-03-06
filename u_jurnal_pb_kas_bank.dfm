object FJurnalPinbukKasBank: TFJurnalPinbukKasBank
  Left = 0
  Top = 0
  Caption = 'Jurnal Pindah Buku Kas-Bank'
  ClientHeight = 445
  ClientWidth = 709
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
    Width = 709
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
    Width = 709
    Height = 417
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 34
    object Label11: TLabel
      Left = 12
      Top = 59
      Width = 43
      Height = 13
      Caption = 'No. Bukti'
    end
    object Label12: TLabel
      Left = 12
      Top = 81
      Width = 31
      Height = 13
      Caption = 'Uraian'
    end
    object Label13: TLabel
      Left = 12
      Top = 38
      Width = 38
      Height = 13
      Caption = 'Tanggal'
    end
    object Label3: TLabel
      Left = 12
      Top = 15
      Width = 24
      Height = 13
      Caption = 'Jenis'
    end
    object Label4: TLabel
      Left = 12
      Top = 258
      Width = 61
      Height = 13
      Caption = 'Jumlah Dana'
    end
    object Panel2: TPanel
      Left = 0
      Top = 371
      Width = 709
      Height = 46
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 7
      ExplicitTop = 206
      DesignSize = (
        709
        46)
      object Bevel2: TBevel
        Left = 0
        Top = 0
        Width = 709
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
    object eTanggal: TDateTimePicker
      Left = 106
      Top = 34
      Width = 176
      Height = 21
      Date = 42329.621222118050000000
      Format = 'dd/MM/yyyy'
      Time = 42329.621222118050000000
      TabOrder = 1
    end
    object eBukti: TEdit
      Left = 106
      Top = 56
      Width = 176
      Height = 21
      TabOrder = 2
    end
    object eUraian: TMemo
      Left = 106
      Top = 78
      Width = 461
      Height = 41
      Lines.Strings = (
        'Memo1'
        'Memo2')
      ScrollBars = ssVertical
      TabOrder = 3
    end
    object gb1: TGroupBox
      Left = 12
      Top = 123
      Width = 555
      Height = 60
      Caption = 'gb1'
      TabOrder = 4
      object Label1: TLabel
        Left = 18
        Top = 25
        Width = 70
        Height = 13
        Caption = 'Rekening Bank'
      end
      object eBank: TButtonedEdit
        Left = 94
        Top = 22
        Width = 443
        Height = 21
        ReadOnly = True
        TabOrder = 0
        TextHint = '<Panah Bawah>'
        OnRightButtonClick = eBankRightButtonClick
      end
    end
    object gb2: TGroupBox
      Left = 12
      Top = 187
      Width = 555
      Height = 60
      Caption = 'GroupBox1'
      TabOrder = 5
      object Label2: TLabel
        Left = 18
        Top = 27
        Width = 64
        Height = 13
        Caption = 'Rekening Kas'
      end
      object eKas: TButtonedEdit
        Left = 94
        Top = 24
        Width = 443
        Height = 21
        ReadOnly = True
        TabOrder = 0
        TextHint = '<Panah Bawah>'
        OnRightButtonClick = eBankRightButtonClick
      end
    end
    object cbJenis: TComboBox
      Left = 106
      Top = 12
      Width = 461
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnChange = cbJenisChange
      Items.Strings = (
        'Setoran Tunai [ Setoran Bank ]'
        'Penarikan Tunai [ Pengisian Kas ]')
    end
    object eTerima: TJvCalcEdit
      Left = 106
      Top = 253
      Width = 176
      Height = 24
      DisplayFormat = '#,#0.## ;(#,#0.##) ; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ShowButton = False
      TabOrder = 6
      DecimalPlacesAlwaysShown = False
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
    Left = 150
    Top = 376
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
  object QDet: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      
        'SELECT kode, ref_jurnal, skode, kode_rek, debet, kredit, uraian,' +
        ' ref_table, '
      '       ref_kode'
      '  FROM acc_jurnal_u_detail where ref_jurnal = '#39#39)
    Left = 275
    Top = 362
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
end
