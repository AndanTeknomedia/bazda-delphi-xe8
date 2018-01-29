object FTTDDesa: TFTTDDesa
  Left = 0
  Top = 0
  AutoSize = True
  BorderStyle = bsDialog
  Caption = 'Penandatangan Dokumen'
  ClientHeight = 367
  ClientWidth = 494
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
  object Bevel2: TBevel
    AlignWithMargins = True
    Left = 6
    Top = 214
    Width = 482
    Height = 11
    Margins.Left = 6
    Margins.Top = 0
    Margins.Right = 6
    Margins.Bottom = 0
    Align = alTop
    Shape = bsBottomLine
    ExplicitLeft = 1
    ExplicitTop = 203
    ExplicitWidth = 408
  end
  object pKD: TPanel
    AlignWithMargins = True
    Left = 15
    Top = 33
    Width = 464
    Height = 40
    Margins.Left = 15
    Margins.Right = 15
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 361
    object Label1: TLabel
      AlignWithMargins = True
      Left = 0
      Top = 3
      Width = 59
      Height = 13
      Margins.Left = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Kepala Desa'
    end
    object eKD: TEdit
      AlignWithMargins = True
      Left = 0
      Top = 19
      Width = 464
      Height = 21
      Margins.Left = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      TabOrder = 0
      ExplicitLeft = 75
      ExplicitTop = 9
      ExplicitWidth = 291
    end
  end
  object PBD: TPanel
    AlignWithMargins = True
    Left = 15
    Top = 79
    Width = 464
    Height = 40
    Margins.Left = 15
    Margins.Right = 15
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 75
    ExplicitWidth = 361
    object Label2: TLabel
      AlignWithMargins = True
      Left = 0
      Top = 3
      Width = 79
      Height = 13
      Margins.Left = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Bendahara Desa'
    end
    object EBD: TEdit
      AlignWithMargins = True
      Left = 0
      Top = 19
      Width = 464
      Height = 21
      Margins.Left = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      TabOrder = 0
      ExplicitLeft = 75
      ExplicitTop = 10
      ExplicitWidth = 291
    end
  end
  object PSD: TPanel
    AlignWithMargins = True
    Left = 15
    Top = 125
    Width = 464
    Height = 40
    Margins.Left = 15
    Margins.Right = 15
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitWidth = 361
    object Label3: TLabel
      AlignWithMargins = True
      Left = 0
      Top = 3
      Width = 75
      Height = 13
      Margins.Left = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Sekretaris Desa'
    end
    object ESD: TEdit
      AlignWithMargins = True
      Left = 0
      Top = 19
      Width = 464
      Height = 21
      Margins.Left = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      TabOrder = 0
      ExplicitLeft = 75
      ExplicitTop = 10
      ExplicitWidth = 291
    end
  end
  object PPK: TPanel
    AlignWithMargins = True
    Left = 15
    Top = 171
    Width = 464
    Height = 40
    Margins.Left = 15
    Margins.Right = 15
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 4
    ExplicitTop = 167
    ExplicitWidth = 361
    object Label4: TLabel
      AlignWithMargins = True
      Left = 0
      Top = 3
      Width = 93
      Height = 13
      Margins.Left = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Pelaksana Kegiatan'
    end
    object EPK: TEdit
      AlignWithMargins = True
      Left = 0
      Top = 19
      Width = 464
      Height = 21
      Margins.Left = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      TabOrder = 0
      ExplicitLeft = 75
      ExplicitTop = 10
      ExplicitWidth = 291
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 494
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 391
    object Label5: TLabel
      Left = 10
      Top = 13
      Width = 153
      Height = 13
      Caption = 'Nama Penandatangan Dokumen'
    end
  end
  object pTempat: TPanel
    AlignWithMargins = True
    Left = 15
    Top = 228
    Width = 464
    Height = 40
    Margins.Left = 15
    Margins.Right = 15
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 5
    ExplicitLeft = 20
    ExplicitTop = 176
    ExplicitWidth = 390
    object Label6: TLabel
      AlignWithMargins = True
      Left = 0
      Top = 3
      Width = 36
      Height = 13
      Margins.Left = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Tempat'
    end
    object ETempat: TEdit
      AlignWithMargins = True
      Left = 0
      Top = 19
      Width = 464
      Height = 21
      Margins.Left = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      TabOrder = 0
      ExplicitWidth = 390
    end
  end
  object pTanggal: TPanel
    AlignWithMargins = True
    Left = 15
    Top = 274
    Width = 464
    Height = 40
    Margins.Left = 15
    Margins.Right = 15
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 6
    ExplicitWidth = 390
    DesignSize = (
      464
      40)
    object Label7: TLabel
      AlignWithMargins = True
      Left = 0
      Top = 3
      Width = 464
      Height = 13
      Margins.Left = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Tanggal'
      ExplicitWidth = 38
    end
    object ETanggal: TEdit
      AlignWithMargins = True
      Left = 0
      Top = 19
      Width = 464
      Height = 21
      Margins.Left = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      TabOrder = 0
      ExplicitWidth = 390
    end
    object DateTimePicker1: TDateTimePicker
      Left = 444
      Top = 19
      Width = 19
      Height = 21
      Anchors = [akTop, akRight]
      Date = 42362.797295775460000000
      Time = 42362.797295775460000000
      TabOrder = 1
      OnChange = DateTimePicker1Change
      ExplicitLeft = 370
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 317
    Width = 494
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 7
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 494
      Height = 6
      Align = alTop
      Shape = bsBottomLine
    end
    object Button1: TButton
      Left = 15
      Top = 16
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 96
      Top = 16
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Batal'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
end
