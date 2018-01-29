object FAddRek: TFAddRek
  Left = 0
  Top = 0
  ActiveControl = eNamaAnak
  BorderStyle = bsDialog
  Caption = 'Tambah Rekening'
  ClientHeight = 149
  ClientWidth = 449
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
  object lbKodeInduk: TLabel
    Left = 20
    Top = 19
    Width = 48
    Height = 13
    Caption = 'Rek Induk'
  end
  object lbKodeAnak: TLabel
    Left = 20
    Top = 42
    Width = 64
    Height = 13
    Caption = 'No. Rekening'
  end
  object Label1: TLabel
    Left = 20
    Top = 65
    Width = 74
    Height = 13
    Caption = 'Nama Rekening'
  end
  object JvEnterAsTab1: TJvEnterAsTab
    Left = 350
    Top = 95
    Width = 28
    Height = 28
    OnHandleEnter = JvEnterAsTab1HandleEnter
  end
  object Label2: TLabel
    Left = 160
    Top = 43
    Width = 266
    Height = 13
    Caption = '* Pastikan kode belum digunakan oleh rekening lainnya.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object eKodeInduk: TEdit
    Left = 100
    Top = 16
    Width = 326
    Height = 21
    Color = 15329769
    ReadOnly = True
    TabOrder = 0
  end
  object eKodeAnak: TEdit
    Left = 100
    Top = 39
    Width = 51
    Height = 21
    NumbersOnly = True
    TabOrder = 1
  end
  object eNamaAnak: TEdit
    Left = 100
    Top = 62
    Width = 326
    Height = 21
    MaxLength = 100
    TabOrder = 2
  end
  object Button1: TButton
    Left = 100
    Top = 95
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 181
    Top = 95
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Batal'
    TabOrder = 4
    OnClick = Button2Click
  end
end
