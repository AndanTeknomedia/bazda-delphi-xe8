object FKoneksi: TFKoneksi
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Setting Koneksi'
  ClientHeight = 250
  ClientWidth = 434
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
    Left = 36
    Top = 24
    Width = 106
    Height = 13
    Caption = 'Host Server Database'
  end
  object Label2: TLabel
    Left = 36
    Top = 73
    Width = 48
    Height = 13
    Caption = 'Username'
  end
  object Label3: TLabel
    Left = 36
    Top = 48
    Width = 69
    Height = 13
    Caption = 'Port Database'
  end
  object Label4: TLabel
    Left = 36
    Top = 97
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label5: TLabel
    Left = 36
    Top = 121
    Width = 76
    Height = 13
    Caption = 'Database Name'
  end
  object eHost: TEdit
    Left = 168
    Top = 21
    Width = 225
    Height = 21
    TabOrder = 0
  end
  object ePort: TSpinEdit
    Left = 168
    Top = 45
    Width = 85
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
  object eUser: TEdit
    Left = 168
    Top = 70
    Width = 225
    Height = 21
    TabOrder = 2
  end
  object ePassword: TEdit
    Left = 168
    Top = 94
    Width = 225
    Height = 21
    PasswordChar = #9679
    TabOrder = 3
  end
  object eDatabase: TEdit
    Left = 168
    Top = 118
    Width = 225
    Height = 21
    TabOrder = 4
  end
  object Button1: TButton
    Left = 37
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Test'
    Default = True
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 220
    Top = 168
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 6
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 318
    Top = 168
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 7
    TabStop = False
    OnClick = Button3Click
  end
  object UniConnection1: TUniConnection
    ProviderName = 'PostgreSQL'
    Options.DisconnectedMode = True
    Options.KeepDesignConnected = False
    Left = 152
    Top = 204
  end
  object PostgreSQLUniProvider1: TPostgreSQLUniProvider
    Left = 244
    Top = 208
  end
end
