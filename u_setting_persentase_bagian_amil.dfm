object FSettingPersentaseBagianAmil: TFSettingPersentaseBagianAmil
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pengaturan Persentase Bagian Amil'
  ClientHeight = 198
  ClientWidth = 372
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
  object Label2: TLabel
    Left = 25
    Top = 21
    Width = 165
    Height = 13
    Caption = 'Bagian Amil Dari Penerimaan Zakat'
  end
  object Label1: TLabel
    Left = 25
    Top = 44
    Width = 208
    Height = 13
    Caption = 'Bagian Amil Dari Penerimaan Infak/Sedekah'
  end
  object Label3: TLabel
    Left = 25
    Top = 67
    Width = 162
    Height = 13
    Caption = 'Bagian Amil Dari Penerimaan DSKL'
  end
  object Label4: TLabel
    Left = 25
    Top = 90
    Width = 158
    Height = 13
    Caption = 'Bagian Amil Dari Penerimaan CSR'
  end
  object Label5: TLabel
    Left = 25
    Top = 113
    Width = 165
    Height = 13
    Caption = 'Bagian Amil Dari Penerimaan Hibah'
  end
  object Label6: TLabel
    Left = 319
    Top = 21
    Width = 11
    Height = 13
    Caption = '%'
  end
  object Label7: TLabel
    Left = 319
    Top = 44
    Width = 11
    Height = 13
    Caption = '%'
  end
  object Label8: TLabel
    Left = 319
    Top = 67
    Width = 11
    Height = 13
    Caption = '%'
  end
  object Label9: TLabel
    Left = 319
    Top = 90
    Width = 11
    Height = 13
    Caption = '%'
  end
  object Label10: TLabel
    Left = 319
    Top = 113
    Width = 11
    Height = 13
    Caption = '%'
  end
  object eZakat: TJvCalcEdit
    Left = 248
    Top = 18
    Width = 65
    Height = 21
    DisplayFormat = '#,#0.00 ;(#,#0.00) ; '
    ShowButton = False
    TabOrder = 0
    DecimalPlacesAlwaysShown = False
  end
  object eIS: TJvCalcEdit
    Left = 248
    Top = 41
    Width = 65
    Height = 21
    DisplayFormat = '#,#0.00 ;(#,#0.00) ; '
    ShowButton = False
    TabOrder = 1
    DecimalPlacesAlwaysShown = False
  end
  object eDSKL: TJvCalcEdit
    Left = 248
    Top = 64
    Width = 65
    Height = 21
    DisplayFormat = '#,#0.00 ;(#,#0.00) ; '
    ShowButton = False
    TabOrder = 2
    DecimalPlacesAlwaysShown = False
  end
  object eCSR: TJvCalcEdit
    Left = 248
    Top = 87
    Width = 65
    Height = 21
    DisplayFormat = '#,#0.00 ;(#,#0.00) ; '
    ShowButton = False
    TabOrder = 3
    DecimalPlacesAlwaysShown = False
  end
  object eHibah: TJvCalcEdit
    Left = 248
    Top = 110
    Width = 65
    Height = 21
    DisplayFormat = '#,#0.00 ;(#,#0.00) ; '
    ShowButton = False
    TabOrder = 4
    DecimalPlacesAlwaysShown = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 157
    Width = 372
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 5
    ExplicitLeft = 252
    ExplicitTop = 268
    ExplicitWidth = 535
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 372
      Height = 8
      Align = alTop
      Shape = bsTopLine
      ExplicitWidth = 535
    end
    object Button1: TButton
      Left = 121
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 255
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Save'
      Default = True
      TabOrder = 1
      OnClick = Button2Click
    end
  end
end
