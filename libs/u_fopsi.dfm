object FPilihOpsi: TFPilihOpsi
  Left = 0
  Top = 0
  ActiveControl = ListBox1
  BorderStyle = bsDialog
  Caption = 'Pilih Opsi'
  ClientHeight = 147
  ClientWidth = 305
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
  object Button1: TButton
    Left = 8
    Top = 111
    Width = 75
    Height = 25
    Action = acOK
    TabOrder = 1
    TabStop = False
  end
  object Button2: TButton
    Left = 89
    Top = 111
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Batal'
    TabOrder = 2
    TabStop = False
    OnClick = Button2Click
  end
  object ListBox1: TListBox
    Left = 8
    Top = 8
    Width = 289
    Height = 97
    BorderStyle = bsNone
    Color = clBtnFace
    Ctl3D = False
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 0
    OnDblClick = ListBox1DblClick
  end
  object ActionManager1: TActionManager
    Left = 272
    Top = 64
    StyleName = 'Platform Default'
    object acOK: TAction
      Caption = 'OK'
      ShortCut = 13
      OnExecute = acOKExecute
    end
  end
end
