object FInputEmailSettings: TFInputEmailSettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Email Settings'
  ClientHeight = 265
  ClientWidth = 522
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
  object Label1: TLabel
    Left = 55
    Top = 115
    Width = 61
    Height = 13
    Caption = 'SMTP Server'
  end
  object Label2: TLabel
    Left = 55
    Top = 138
    Width = 48
    Height = 13
    Caption = 'Username'
  end
  object Label4: TLabel
    Left = 55
    Top = 161
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label10: TLabel
    Left = 25
    Top = 95
    Width = 82
    Height = 13
    Caption = 'Setting Server'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 25
    Top = 15
    Width = 39
    Height = 13
    Caption = 'Tujuan'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 55
    Top = 37
    Width = 60
    Height = 13
    Caption = 'Email Tujuan'
  end
  object Label8: TLabel
    Left = 55
    Top = 188
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Label5: TLabel
    Left = 55
    Top = 60
    Width = 56
    Height = 13
    Caption = 'Attachment'
  end
  object eSMTPUsername: TEdit
    Left = 140
    Top = 139
    Width = 341
    Height = 21
    TabOrder = 3
  end
  object eSMTPServer: TEdit
    Left = 140
    Top = 116
    Width = 341
    Height = 21
    TabOrder = 2
  end
  object eSMTPPassword: TEdit
    Left = 140
    Top = 162
    Width = 341
    Height = 21
    TabOrder = 4
  end
  object Panel2: TPanel
    Left = 0
    Top = 209
    Width = 522
    Height = 56
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    ExplicitTop = 255
    object Bevel2: TBevel
      AlignWithMargins = True
      Left = 10
      Top = 3
      Width = 502
      Height = 6
      Margins.Left = 10
      Margins.Right = 10
      Align = alTop
      Shape = bsBottomLine
      ExplicitLeft = 0
      ExplicitTop = 35
      ExplicitWidth = 647
    end
    object Button1: TButton
      Left = 305
      Top = 20
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 386
      Top = 20
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Batal'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object eMail: TEdit
    Left = 140
    Top = 34
    Width = 341
    Height = 21
    TabOrder = 0
  end
  object eAttachment: TButtonedEdit
    Left = 140
    Top = 57
    Width = 341
    Height = 21
    TabOrder = 1
  end
  object eSMTPPort: TSpinEdit
    Left = 140
    Top = 185
    Width = 77
    Height = 22
    MaxValue = 65000
    MinValue = 10
    TabOrder = 5
    Value = 0
  end
  object JvEnterAsTab1: TJvEnterAsTab
    OnHandleEnter = JvEnterAsTab1HandleEnter
    Left = 441
    Top = 8
  end
end
