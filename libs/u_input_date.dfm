object FInputDate: TFInputDate
  Left = 0
  Top = 0
  Caption = 'Tanggal'
  ClientHeight = 107
  ClientWidth = 207
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
  object DateTimePicker1: TDateTimePicker
    Left = 21
    Top = 30
    Width = 156
    Height = 21
    Date = 41415.876227673610000000
    Format = 'dd/MM/yyyy'
    Time = 41415.876227673610000000
    TabOrder = 0
  end
  object Button1: TButton
    Left = 21
    Top = 66
    Width = 75
    Height = 25
    Caption = 'Save'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 102
    Top = 66
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Batal'
    ModalResult = 2
    TabOrder = 2
  end
end
