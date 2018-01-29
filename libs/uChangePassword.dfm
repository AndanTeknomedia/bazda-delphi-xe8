object PasswordDlg: TPasswordDlg
  Left = 245
  Top = 108
  ActiveControl = eOldP
  BorderStyle = bsDialog
  Caption = 'Ganti Password'
  ClientHeight = 149
  ClientWidth = 384
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 9
    Width = 74
    Height = 13
    Caption = 'Password Lama'
  end
  object Label2: TLabel
    Left = 8
    Top = 36
    Width = 71
    Height = 13
    Caption = 'Password Baru'
  end
  object Label3: TLabel
    Left = 8
    Top = 63
    Width = 123
    Height = 13
    Caption = 'Konfirmasi Password Baru'
  end
  object JvEnterAsTab1: TJvEnterAsTab
    Left = 64
    Top = 96
    Width = 28
    Height = 28
    OnHandleEnter = JvEnterAsTab1HandleEnter
  end
  object eOldP: TEdit
    Left = 140
    Top = 8
    Width = 217
    Height = 21
    MaxLength = 30
    PasswordChar = '*'
    TabOrder = 0
  end
  object OKBtn: TButton
    Left = 140
    Top = 99
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 3
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 220
    Top = 99
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = CancelBtnClick
  end
  object eNewP: TEdit
    Left = 140
    Top = 35
    Width = 217
    Height = 21
    MaxLength = 30
    PasswordChar = '*'
    TabOrder = 1
  end
  object eNewPC: TEdit
    Left = 140
    Top = 62
    Width = 217
    Height = 21
    MaxLength = 30
    PasswordChar = '*'
    TabOrder = 2
  end
end
