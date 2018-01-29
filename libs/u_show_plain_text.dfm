object FShowPlainText: TFShowPlainText
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 243
  ClientWidth = 492
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
  object ValueListEditor1: TValueListEditor
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 486
    Height = 204
    Align = alClient
    BorderStyle = bsNone
    Ctl3D = False
    DisplayOptions = [doAutoColResize]
    Options = [goHorzLine, goColSizing, goEditing, goThumbTracking]
    ParentCtl3D = False
    Strings.Strings = (
      'sd=sd')
    TabOrder = 0
    ExplicitHeight = 196
    ColWidths = (
      242
      242)
  end
  object Panel1: TPanel
    Left = 0
    Top = 210
    Width = 492
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Button1: TButton
      Left = 3
      Top = 3
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
