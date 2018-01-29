object FDisplayText: TFDisplayText
  Left = 0
  Top = 0
  ActiveControl = Button1
  Caption = 'Informasi'
  ClientHeight = 431
  ClientWidth = 680
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
  object Memo1: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 674
    Height = 384
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
    ExplicitWidth = 422
    ExplicitHeight = 178
  end
  object Panel1: TPanel
    Left = 0
    Top = 390
    Width = 680
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 184
    ExplicitWidth = 428
    object Button1: TButton
      Left = 15
      Top = 10
      Width = 75
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 96
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Batal'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
end
