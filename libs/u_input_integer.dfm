object FInputInteger: TFInputInteger
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Input Bilangan Bulat'
  ClientHeight = 105
  ClientWidth = 235
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
    Left = 8
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 8
    Top = 61
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 89
    Top = 61
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Batal'
    ModalResult = 2
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 8
    Top = 27
    Width = 156
    Height = 21
    NumbersOnly = True
    TabOrder = 0
    Text = '0'
  end
end
