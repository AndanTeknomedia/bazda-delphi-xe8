object FInputTTD2: TFInputTTD2
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Penandatangan'
  ClientHeight = 260
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
    Left = 47
    Top = 68
    Width = 42
    Height = 13
    Caption = 'Jabatan '
  end
  object Label2: TLabel
    Left = 47
    Top = 47
    Width = 27
    Height = 13
    Caption = 'Nama'
  end
  object Label4: TLabel
    Left = 47
    Top = 90
    Width = 36
    Height = 13
    Caption = 'Tempat'
  end
  object Label5: TLabel
    Left = 47
    Top = 112
    Width = 38
    Height = 13
    Caption = 'Tanggal'
  end
  object Label10: TLabel
    Left = 17
    Top = 23
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
    Left = 47
    Top = 140
    Width = 56
    Height = 13
    Caption = 'Keterangan'
  end
  object eJabatan: TEdit
    Left = 132
    Top = 66
    Width = 341
    Height = 21
    TabOrder = 1
  end
  object eTempat: TEdit
    Left = 132
    Top = 90
    Width = 341
    Height = 21
    TabOrder = 2
  end
  object eTanggal: TEdit
    Left = 132
    Top = 113
    Width = 325
    Height = 21
    TabOrder = 3
  end
  object DateTimePicker1: TDateTimePicker
    Left = 453
    Top = 113
    Width = 20
    Height = 21
    Date = 42325.952195659720000000
    Time = 42325.952195659720000000
    TabOrder = 4
    TabStop = False
    OnChange = DateTimePicker1Change
  end
  object Panel2: TPanel
    Left = 0
    Top = 204
    Width = 522
    Height = 56
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
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
      Left = 310
      Top = 15
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 398
      Top = 15
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Batal'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object eNama: TButtonedEdit
    Left = 132
    Top = 42
    Width = 341
    Height = 21
    TabOrder = 0
    OnRightButtonClick = eNamaRightButtonClick
  end
  object Memo1: TMemo
    Left = 132
    Top = 137
    Width = 341
    Height = 53
    MaxLength = 230
    ScrollBars = ssVertical
    TabOrder = 5
    WantReturns = False
  end
  object JvEnterAsTab1: TJvEnterAsTab
    OnHandleEnter = JvEnterAsTab1HandleEnter
    Left = 321
    Top = 65516
  end
end
