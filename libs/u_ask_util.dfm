object FaskUtil: TFaskUtil
  Left = 0
  Top = 0
  ActiveControl = Button2
  Caption = 'FaskUtil'
  ClientHeight = 143
  ClientWidth = 467
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
    Left = 93
    Top = 12
    Width = 346
    Height = 73
    AutoSize = False
    Caption = 'Label1'
    WordWrap = True
  end
  object Button1: TButton
    Left = 87
    Top = 102
    Width = 75
    Height = 25
    Caption = 'Ya'
    Default = True
    ModalResult = 6
    TabOrder = 0
  end
  object Button2: TButton
    Left = 168
    Top = 102
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Tidak'
    ModalResult = 7
    TabOrder = 1
  end
  object CheckBox1: TCheckBox
    Left = 270
    Top = 106
    Width = 169
    Height = 17
    Caption = 'Jangan tampilkan lagi.'
    TabOrder = 2
  end
end
