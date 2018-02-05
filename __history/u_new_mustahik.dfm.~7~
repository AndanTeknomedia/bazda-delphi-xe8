object FNewMustahik: TFNewMustahik
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Mustahik Baru'
  ClientHeight = 304
  ClientWidth = 535
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
    Left = 28
    Top = 19
    Width = 72
    Height = 13
    Caption = 'Nama Mustahik'
  end
  object Label2: TLabel
    Left = 28
    Top = 41
    Width = 69
    Height = 13
    Caption = 'Jenis Mustahik'
  end
  object Label3: TLabel
    Left = 28
    Top = 64
    Width = 105
    Height = 13
    Caption = 'Kelurahan/Kecamatan'
  end
  object Label4: TLabel
    Left = 20
    Top = 90
    Width = 90
    Height = 13
    Caption = 'Data Tambahan'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 28
    Top = 113
    Width = 17
    Height = 13
    Caption = 'NIK'
  end
  object Label7: TLabel
    Left = 28
    Top = 135
    Width = 32
    Height = 13
    Caption = 'No. KK'
  end
  object Label8: TLabel
    Left = 28
    Top = 159
    Width = 24
    Height = 13
    Caption = 'Telp.'
  end
  object Label9: TLabel
    Left = 28
    Top = 181
    Width = 76
    Height = 13
    Caption = 'Alamat Lengkap'
  end
  object eNama: TEdit
    Left = 140
    Top = 16
    Width = 349
    Height = 21
    TabOrder = 0
    Text = 'eNama'
  end
  object eTipe: TDBLookupComboBox
    Left = 140
    Top = 39
    Width = 349
    Height = 21
    KeyField = 'kode'
    ListField = 'kode;uraian'
    ListFieldIndex = 1
    ListSource = dsTipe
    TabOrder = 1
  end
  object eNik: TEdit
    Left = 140
    Top = 110
    Width = 349
    Height = 21
    TabOrder = 3
    Text = 'eNama'
  end
  object eKelurahan: TDBLookupComboBox
    Left = 140
    Top = 62
    Width = 349
    Height = 21
    KeyField = 'kode'
    ListField = 'kode;nama'
    ListFieldIndex = 1
    ListSource = dsKel2
    TabOrder = 2
  end
  object eAlamat: TMemo
    Left = 140
    Top = 179
    Width = 349
    Height = 45
    Lines.Strings = (
      'eAlamat')
    ScrollBars = ssVertical
    TabOrder = 6
  end
  object eNoKK: TEdit
    Left = 140
    Top = 133
    Width = 349
    Height = 21
    TabOrder = 4
    Text = 'eNoKK'
  end
  object eTelp: TEdit
    Left = 140
    Top = 156
    Width = 349
    Height = 21
    TabOrder = 5
    Text = 'eNoKK'
  end
  object Panel1: TPanel
    Left = 0
    Top = 263
    Width = 535
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 7
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 535
      Height = 8
      Align = alTop
      Shape = bsTopLine
    end
    object Button1: TButton
      Left = 280
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 414
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Save'
      Default = True
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object qKel2: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      
        'select kode, (nama||'#39', '#39'||kecamatan)::varchar(100) nama from v_k' +
        'elurahan order by kode asc')
    Left = 407
    Top = 46
    object qKel2kode: TStringField
      FieldName = 'kode'
      Size = 10
    end
    object qKel2nama: TStringField
      FieldName = 'nama'
      ReadOnly = True
      Size = 100
    end
  end
  object dsKel2: TDataSource
    DataSet = qKel2
    Left = 432
    Top = 48
  end
  object qTipe: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      'select kode, uraian from baz_jenis_muzakki order by kode asc')
    Left = 303
    Top = 46
    object qTipekode: TStringField
      FieldName = 'kode'
      Required = True
      FixedChar = True
      Size = 2
    end
    object qTipeuraian: TStringField
      FieldName = 'uraian'
      Required = True
      Size = 100
    end
  end
  object dsTipe: TDataSource
    DataSet = qTipe
    Left = 328
    Top = 48
  end
end
