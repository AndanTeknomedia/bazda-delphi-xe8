object FInputTTD: TFInputTTD
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Penandatangan'
  ClientHeight = 311
  ClientWidth = 522
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 55
    Top = 135
    Width = 42
    Height = 13
    Caption = 'Jabatan '
  end
  object Label2: TLabel
    Left = 55
    Top = 158
    Width = 27
    Height = 13
    Caption = 'Nama'
  end
  object Label4: TLabel
    Left = 55
    Top = 181
    Width = 36
    Height = 13
    Caption = 'Tempat'
  end
  object Label5: TLabel
    Left = 55
    Top = 204
    Width = 38
    Height = 13
    Caption = 'Tanggal'
  end
  object Label10: TLabel
    Left = 25
    Top = 115
    Width = 89
    Height = 13
    Caption = 'Penandatangan'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 25
    Top = 15
    Width = 122
    Height = 13
    Caption = 'Identitas Perusahaan'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 55
    Top = 37
    Width = 57
    Height = 13
    Caption = 'Perusahaan'
  end
  object Label7: TLabel
    Left = 55
    Top = 60
    Width = 33
    Height = 13
    Caption = 'Alamat'
  end
  object Label8: TLabel
    Left = 55
    Top = 231
    Width = 79
    Height = 13
    Caption = 'Jumlah Lampiran'
    OnClick = Label8Click
  end
  object Label9: TLabel
    Left = 217
    Top = 231
    Width = 26
    Height = 13
    Caption = 'Eksp.'
    OnClick = Label8Click
  end
  object eNama: TEdit
    Left = 140
    Top = 159
    Width = 341
    Height = 21
    TabOrder = 3
  end
  object eJabatan: TEdit
    Left = 140
    Top = 136
    Width = 341
    Height = 21
    TabOrder = 2
  end
  object eTempat: TEdit
    Left = 140
    Top = 182
    Width = 341
    Height = 21
    TabOrder = 4
  end
  object eTanggal: TEdit
    Left = 140
    Top = 205
    Width = 325
    Height = 21
    TabOrder = 5
  end
  object DateTimePicker1: TDateTimePicker
    Left = 461
    Top = 205
    Width = 20
    Height = 21
    Date = 42325.952195659720000000
    Time = 42325.952195659720000000
    TabOrder = 6
    TabStop = False
    OnChange = DateTimePicker1Change
  end
  object Panel2: TPanel
    Left = 0
    Top = 255
    Width = 522
    Height = 56
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 8
    ExplicitTop = 235
    ExplicitWidth = 504
    object Bevel2: TBevel
      AlignWithMargins = True
      Left = 10
      Top = 3
      Width = 502
      Height = 6
      Margins.Left = 10
      Margins.Right = 10
      Align = alTop
      Shape = bsBottomLine
      ExplicitLeft = 0
      ExplicitTop = 35
      ExplicitWidth = 647
    end
    object Button1: TButton
      Left = 305
      Top = 20
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 386
      Top = 20
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Batal'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object ePerusahaan: TEdit
    Left = 140
    Top = 34
    Width = 341
    Height = 21
    TabOrder = 0
  end
  object eAlamat: TMemo
    Left = 140
    Top = 57
    Width = 341
    Height = 45
    TabOrder = 1
  end
  object JvSpinEdit1: TJvSpinEdit
    Left = 140
    Top = 228
    Width = 71
    Height = 21
    MaxValue = 99.000000000000000000
    TabOrder = 7
  end
  object JvEnterAsTab1: TJvEnterAsTab
    OnHandleEnter = JvEnterAsTab1HandleEnter
    Left = 441
    Top = 8
  end
end
