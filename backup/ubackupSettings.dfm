object FBackupSettings: TFBackupSettings
  Left = 214
  Top = 276
  BorderStyle = bsDialog
  Caption = 'Backup Settings'
  ClientHeight = 275
  ClientWidth = 510
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object AdvPageControl1: TAdvPageControl
    AlignWithMargins = True
    Left = 3
    Top = 0
    Width = 504
    Height = 233
    Margins.Top = 0
    ActivePage = AdvTabSheet2
    ActiveFont.Charset = DEFAULT_CHARSET
    ActiveFont.Color = clWindowText
    ActiveFont.Height = -11
    ActiveFont.Name = 'Tahoma'
    ActiveFont.Style = []
    Align = alTop
    DoubleBuffered = True
    MultiLine = True
    ActiveColor = 15395562
    TabBackGroundColor = clBtnFace
    TabMargin.RightMargin = 0
    TabOverlap = 0
    TabStyle = tsDelphi
    Version = '2.0.0.6'
    PersistPagesState.Location = plRegistry
    PersistPagesState.Enabled = False
    TabOrder = 0
    object AdvTabSheet1: TAdvTabSheet
      Caption = '  Backup Settings  '
      Color = 15395562
      ColorTo = clNone
      TabColor = clBtnFace
      TabColorTo = clNone
      object Label1: TLabel
        Left = 15
        Top = 65
        Width = 59
        Height = 13
        Caption = 'Backup Time'
      end
      object Label2: TLabel
        Left = 60
        Top = 152
        Width = 356
        Height = 26
        AutoSize = False
        WordWrap = True
      end
      object Label3: TLabel
        Left = 15
        Top = 152
        Width = 39
        Height = 13
        Caption = 'Contoh:'
      end
      object edDir: TLabeledEdit
        Left = 15
        Top = 30
        Width = 386
        Height = 21
        EditLabel.Width = 81
        EditLabel.Height = 13
        EditLabel.Caption = 'Backup Directory'
        TabOrder = 0
      end
      object JvXPButton1: TJvXPButton
        Left = 407
        Top = 30
        Cursor = crHandPoint
        Action = acBrowse
        TabOrder = 1
      end
      object Tmedit: TJvTimeEdit
        Left = 15
        Top = 84
        Width = 96
        Height = 21
        TabOrder = 2
      end
      object edFormat: TLabeledEdit
        Left = 15
        Top = 125
        Width = 386
        Height = 21
        EditLabel.Width = 101
        EditLabel.Height = 13
        EditLabel.Caption = 'Backup Name Format'
        TabOrder = 3
        Text = 'Postgre_%db%_backup_%year%-%month%-%date%'
        OnChange = edFormatChange
      end
      object JvXPButton2: TJvXPButton
        Left = 407
        Top = 125
        Cursor = crHandPoint
        Action = acResetFormat
        TabOrder = 4
      end
    end
    object AdvTabSheet2: TAdvTabSheet
      Caption = '  Connection Setting  '
      Color = 15395562
      ColorTo = clNone
      TabColor = clBtnFace
      TabColorTo = clNone
      object eHost: TLabeledEdit
        Left = 15
        Top = 30
        Width = 151
        Height = 21
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = 'Host Name'
        TabOrder = 0
      end
      object eUser: TLabeledEdit
        Left = 15
        Top = 70
        Width = 151
        Height = 21
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = 'User Name'
        TabOrder = 2
      end
      object ePassword: TLabeledEdit
        Left = 15
        Top = 110
        Width = 151
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Password'
        PasswordChar = #9679
        TabOrder = 3
      end
      object ePort: TLabeledEdit
        Left = 172
        Top = 30
        Width = 54
        Height = 21
        Alignment = taRightJustify
        EditLabel.Width = 20
        EditLabel.Height = 13
        EditLabel.Caption = 'Port'
        NumbersOnly = True
        TabOrder = 1
        Text = '5432'
      end
      object eDatabase: TLabeledEdit
        Left = 15
        Top = 150
        Width = 151
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Database'
        TabOrder = 4
      end
      object JvXPButton3: TJvXPButton
        Left = 407
        Top = 150
        Cursor = crHandPoint
        Caption = 'Test'
        TabOrder = 5
        OnClick = JvXPButton3Click
      end
    end
  end
  object JvXPButton4: TJvXPButton
    Left = 335
    Top = 239
    Cursor = crHandPoint
    Caption = 'Save'
    TabOrder = 1
    OnClick = JvXPButton4Click
  end
  object JvXPButton5: TJvXPButton
    Left = 414
    Top = 239
    Cursor = crHandPoint
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = JvXPButton5Click
  end
  object ActionManager1: TActionManager
    Left = 85
    Top = 140
    StyleName = 'Platform Default'
    object acBrowse: TAction
      Caption = 'Browse'
      OnExecute = acBrowseExecute
    end
    object acResetFormat: TAction
      Caption = 'Reset'
      OnExecute = acResetFormatExecute
    end
    object Action3: TAction
      Caption = 'Action3'
    end
  end
end
