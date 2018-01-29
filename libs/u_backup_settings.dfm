object FBackupSettings: TFBackupSettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Backup Settings'
  ClientHeight = 328
  ClientWidth = 457
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 457
    Height = 287
    ActivePage = TabSheet1
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Auto Backup'
      object ckStart: TCheckBox
        Left = 8
        Top = 15
        Width = 245
        Height = 17
        Caption = 'Backup Otomatis Saat Program Dijalankan'
        TabOrder = 0
      end
      object ckEnd: TCheckBox
        Left = 8
        Top = 33
        Width = 245
        Height = 17
        Caption = 'Backup Otomatis Saat Program Ditutup'
        TabOrder = 1
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Restore'
      ImageIndex = 1
      object Label2: TLabel
        Left = 0
        Top = 0
        Width = 125
        Height = 13
        Caption = 'File Data Backup Otomatis'
      end
      object PageControl2: TPageControl
        AlignWithMargins = True
        Left = 3
        Top = 20
        Width = 443
        Height = 233
        Margins.Top = 20
        ActivePage = TabSheet3
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 0
        object TabSheet3: TTabSheet
          Caption = 'Saat Program Dijalankan'
          object cbStart: TListBox
            AlignWithMargins = True
            Left = 0
            Top = 0
            Width = 435
            Height = 202
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            ItemHeight = 13
            TabOrder = 0
          end
        end
        object TabSheet4: TTabSheet
          Caption = 'Saat Program Ditutup'
          ImageIndex = 1
          object cbEnd: TListBox
            AlignWithMargins = True
            Left = 0
            Top = 0
            Width = 435
            Height = 202
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            ItemHeight = 13
            TabOrder = 0
          end
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 287
    Width = 457
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 457
      Height = 4
      Align = alTop
      Shape = bsTopLine
    end
    object Button1: TButton
      Left = 12
      Top = 10
      Width = 75
      Height = 25
      Action = acSave
      Default = True
      TabOrder = 0
    end
    object Button2: TButton
      Left = 93
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Cancel'
      Default = True
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object bOpsi: TButton
    Left = 278
    Top = 44
    Width = 75
    Height = 25
    Caption = 'Pilihan'
    DropDownMenu = PopupMenu1
    Style = bsSplitButton
    TabOrder = 1
    TabStop = False
  end
  object ActionManager1: TActionManager
    Left = 330
    Top = 65530
    StyleName = 'Platform Default'
    object acSave: TAction
      Caption = 'Save'
      ShortCut = 16467
      OnExecute = acSaveExecute
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 297
    Top = 51
    object Restore1: TMenuItem
      Caption = 'Restore'
    end
    object Hapus1: TMenuItem
      Caption = 'Hapus'
      OnClick = Hapus1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Clear1: TMenuItem
      Caption = 'Clear'
      Enabled = False
    end
  end
end
