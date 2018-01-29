object FInputUraianDanNilai: TFInputUraianDanNilai
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Uraian dan Nilai'
  ClientHeight = 151
  ClientWidth = 419
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
    Left = 25
    Top = 13
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Edit1: TEdit
    Left = 65
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object tsPendapatanBeNilai: TJvCalcEdit
    Left = 100
    Top = 117
    Width = 121
    Height = 21
    DisplayFormat = '#,#0.## ;(#,#0.##); '
    ShowButton = False
    TabOrder = 1
    DecimalPlacesAlwaysShown = False
  end
end
