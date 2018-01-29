object FInputTeks: TFInputTeks
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Input Teks'
  ClientHeight = 134
  ClientWidth = 360
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
  object Memo1: TMemo
    Left = 8
    Top = 27
    Width = 341
    Height = 68
    Lines.Strings = (
      'Memo1')
    MaxLength = 200
    ScrollBars = ssVertical
    TabOrder = 0
    WantReturns = False
  end
  object Button1: TButton
    Left = 8
    Top = 101
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 89
    Top = 101
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Batal'
    ModalResult = 2
    TabOrder = 2
  end
end
