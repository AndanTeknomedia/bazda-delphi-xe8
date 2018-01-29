object FSysVars: TFSysVars
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Setup Variabel System'
  ClientHeight = 350
  ClientWidth = 760
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 760
    Height = 309
    ActivePage = TabSheet3
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    ExplicitWidth = 646
    ExplicitHeight = 320
    object TabSheet3: TTabSheet
      Caption = 'Setup Identitas Perusahaan'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 638
      ExplicitHeight = 289
      object Label1: TLabel
        Left = 15
        Top = 24
        Width = 60
        Height = 13
        Caption = 'Nama Usaha'
      end
      object Label2: TLabel
        Left = 15
        Top = 51
        Width = 95
        Height = 13
        Caption = 'Kota (Lokasi) Usaha'
      end
      object Label3: TLabel
        Left = 15
        Top = 105
        Width = 28
        Height = 13
        Caption = 'E-Mail'
      end
      object Label4: TLabel
        Left = 15
        Top = 78
        Width = 33
        Height = 13
        Caption = 'Alamat'
      end
      object Label5: TLabel
        Left = 15
        Top = 159
        Width = 47
        Height = 13
        Caption = 'Telepon 2'
      end
      object Label6: TLabel
        Left = 15
        Top = 132
        Width = 47
        Height = 13
        Caption = 'Telepon 1'
      end
      object Label7: TLabel
        Left = 15
        Top = 213
        Width = 97
        Height = 13
        Caption = 'Semboyan/Tagline 1'
      end
      object Label8: TLabel
        Left = 15
        Top = 186
        Width = 22
        Height = 13
        Caption = 'Fax.'
      end
      object Label9: TLabel
        Left = 15
        Top = 240
        Width = 97
        Height = 13
        Caption = 'Semboyan/Tagline 2'
        Visible = False
      end
      object eNama: TEdit
        Left = 132
        Top = 21
        Width = 250
        Height = 21
        TabOrder = 0
        Text = 'eNama'
      end
      object eALamat: TEdit
        Left = 132
        Top = 75
        Width = 376
        Height = 21
        TabOrder = 3
        Text = 'eALamat'
      end
      object eemail: TEdit
        Left = 132
        Top = 102
        Width = 142
        Height = 21
        TabOrder = 4
        Text = 'Edit2'
      end
      object eTelp1: TEdit
        Left = 132
        Top = 129
        Width = 142
        Height = 21
        TabOrder = 5
        Text = 'Edit2'
      end
      object eTelp2: TEdit
        Left = 132
        Top = 156
        Width = 142
        Height = 21
        TabOrder = 6
        Text = 'Edit2'
      end
      object eFax: TEdit
        Left = 132
        Top = 183
        Width = 142
        Height = 21
        TabOrder = 7
        Text = 'Edit2'
      end
      object eTaline: TEdit
        Left = 132
        Top = 210
        Width = 376
        Height = 21
        TabOrder = 8
        Text = 'Edit2'
      end
      object Panel2: TPanel
        Left = 525
        Top = 21
        Width = 216
        Height = 240
        BevelOuter = bvLowered
        TabOrder = 1
        object Image1: TImage
          Left = 1
          Top = 1
          Width = 214
          Height = 238
          Cursor = crHandPoint
          Align = alClient
          Center = True
          Proportional = True
          Stretch = True
          ExplicitLeft = -11
          ExplicitWidth = 98
          ExplicitHeight = 105
        end
      end
      object eKota: TEdit
        Left = 132
        Top = 48
        Width = 142
        Height = 21
        TabOrder = 2
        Text = 'eKota'
      end
      object Edit1: TEdit
        Left = 132
        Top = 237
        Width = 376
        Height = 21
        TabOrder = 9
        Text = 'Edit2'
        Visible = False
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 309
    Width = 760
    Height = 41
    Align = alBottom
    BevelEdges = []
    BevelOuter = bvNone
    TabOrder = 1
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 760
      Height = 4
      Align = alTop
      Shape = bsTopLine
      ExplicitWidth = 541
    end
    object Button1: TButton
      Left = 13
      Top = 9
      Width = 75
      Height = 25
      Action = Action1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 94
      Top = 9
      Width = 75
      Height = 25
      Action = Action2
      TabOrder = 1
    end
  end
  object qID: TUniQuery
    SQL.Strings = (
      'select * from sys_unit where kode = :kdunit')
    Left = 352
    Top = 124
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'kdunit'
      end>
    object qIDkode: TStringField
      FieldName = 'kode'
      FixedChar = True
      Size = 3
    end
    object qIDnama: TStringField
      FieldName = 'nama'
      Size = 150
    end
    object qIDkota: TStringField
      FieldName = 'kota'
      Size = 75
    end
    object qIDalamat: TStringField
      FieldName = 'alamat'
      Size = 200
    end
    object qIDemail: TStringField
      FieldName = 'email'
      Size = 75
    end
    object qIDtelepon: TStringField
      FieldName = 'telepon'
      Size = 15
    end
    object qIDtelepon2: TStringField
      FieldName = 'telepon2'
      Size = 15
    end
    object qIDfax: TStringField
      FieldName = 'fax'
      Size = 15
    end
    object qIDtagline: TMemoField
      FieldName = 'tagline'
      BlobType = ftMemo
    end
    object qIDlogo: TBlobField
      FieldName = 'logo'
    end
    object qIDprefix: TStringField
      FieldName = 'prefix'
      FixedChar = True
      Size = 2
    end
    object qIDmobile1: TStringField
      FieldName = 'mobile1'
      Size = 45
    end
    object qIDmobile2: TStringField
      FieldName = 'mobile2'
      Size = 45
    end
    object qIDlogo_path: TStringField
      FieldName = 'logo_path'
      Size = 250
    end
  end
  object ActionManager1: TActionManager
    Left = 320
    Top = 123
    StyleName = 'Platform Default'
    object Action1: TAction
      Caption = 'Save'
      Hint = 'Save'
      ShortCut = 16467
      OnExecute = Action1Execute
    end
    object Action2: TAction
      Caption = 'Batal'
      Hint = 'Batal'
      ShortCut = 115
      OnExecute = Action2Execute
    end
  end
end
