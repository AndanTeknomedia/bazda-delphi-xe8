object FInputTanggal: TFInputTanggal
  Left = 0
  Top = 0
  ActiveControl = dp1
  Caption = 'Tanggal'
  ClientHeight = 115
  ClientWidth = 283
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 19
    Top = 16
    Width = 86
    Height = 13
    Caption = 'Tanggal Transaksi'
  end
  object dp1: TDateTimePicker
    Left = 19
    Top = 35
    Width = 142
    Height = 21
    Date = 41351.028605891200000000
    Format = 'dd/MM/yyyy'
    Time = 41351.028605891200000000
    TabOrder = 0
  end
  object Button1: TButton
    Left = 19
    Top = 82
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 100
    Top = 82
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Batal'
    ModalResult = 2
    TabOrder = 2
  end
end
