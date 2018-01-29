object FJenisDistribusiDana: TFJenisDistribusiDana
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Jenis Distribusi Dana'
  ClientHeight = 177
  ClientWidth = 469
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
  object Label11: TLabel
    Left = 18
    Top = 51
    Width = 52
    Height = 13
    Caption = 'Jenis Dana'
  end
  object eJenisDana: TDBLookupComboBox
    Left = 84
    Top = 49
    Width = 357
    Height = 21
    KeyField = 'kode'
    ListField = 'vkode;rekening'
    ListFieldIndex = 1
    ListSource = dsJenisDana
    TabOrder = 0
  end
  object Button1: TButton
    Left = 248
    Top = 108
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Batal'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 366
    Top = 108
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = Button2Click
  end
  object dsJenisDana: TDataSource
    DataSet = qJenisDana
    Left = 255
    Top = 31
  end
  object qJenisDana: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      
        'select kode, format_vkode(kode)::varchar(20) vkode, rekening fro' +
        'm v_coa_2 where kode in ('#39'51'#39','#39'52'#39') order by kode asc')
    Left = 299
    Top = 30
    object qJenisDanakode: TMemoField
      FieldName = 'kode'
      BlobType = ftMemo
    end
    object qJenisDanavkode: TStringField
      FieldName = 'vkode'
      ReadOnly = True
    end
    object qJenisDanarekening: TStringField
      FieldName = 'rekening'
      Size = 100
    end
  end
end
