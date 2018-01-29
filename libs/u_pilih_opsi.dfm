object FPilihBulan: TFPilihBulan
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pilih Bulan'
  ClientHeight = 162
  ClientWidth = 394
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
  object clBulan: TCheckListBox
    Left = 15
    Top = 15
    Width = 361
    Height = 91
    OnClickCheck = clBulanClickCheck
    Columns = 2
    ItemHeight = 13
    TabOrder = 0
  end
  object Button1: TButton
    Left = 15
    Top = 122
    Width = 61
    Height = 25
    Caption = 'Check All'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 220
    Top = 122
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object Button3: TButton
    Left = 301
    Top = 122
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object Button4: TButton
    Left = 82
    Top = 122
    Width = 61
    Height = 25
    Caption = 'Clear All'
    TabOrder = 2
    OnClick = Button4Click
  end
end
