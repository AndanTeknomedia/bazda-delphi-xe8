object FEditUser: TFEditUser
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Edit User'
  ClientHeight = 245
  ClientWidth = 470
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
  object Label11: TLabel
    Left = 15
    Top = 41
    Width = 48
    Height = 13
    Caption = 'Username'
  end
  object Label13: TLabel
    Left = 15
    Top = 64
    Width = 70
    Height = 13
    Caption = 'Nama Lengkap'
  end
  object Label18: TLabel
    Left = 15
    Top = 86
    Width = 54
    Height = 13
    Caption = 'Password'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel2: TBevel
    Left = 80
    Top = 93
    Width = 371
    Height = 13
    Shape = bsTopLine
  end
  object SpeedButton1: TSpeedButton
    Left = 368
    Top = 107
    Width = 83
    Height = 44
    Cursor = crHandPoint
    Caption = 'Generate'
    Flat = True
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000426382FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000577894FF85CEE6FF577894FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005D849FFF82CCE5FF7DCAE4FF5D84
      9FFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005687A4FF82CCE5FF5687A4FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004984A3FF82CCE5FF7AC4DDFF4984
      A3FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A86A4FF82CCE5FF4A86A4FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004E89A6FF82CCE5FF66B8D5FF4E89
      A6FF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000538CA9FF82CCE5FF61B3D2FF538C
      A9FF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000069A7C2FF86C7E2FF72BCDAFF5BAECEFF64B5
      D5FF5BA1BFFF0000000000000000000000000000000000000000000000000000
      0000000000000000000076B6D0FF96DAF5FF88CCEEFF67B2D3FF4CA2C5FF4DAF
      D7FF62C6EDFF62ADCEFF00000000000000000000000000000000000000000000
      0000000000007AADC7FF9CE0F7FF9ADEF8FF96DAF5FF81CAE5FF6EBDDAFF6AC3
      E4FF69CAF0FF6DCEF4FF7AADC7FF000000000000000000000000000000000000
      0000000000006EA9C7FFA1E5FEFF3DABBFFF36A7BAFF36A7BAFF36A7BAFF36A7
      BAFF38AABFFF6ED3FAFF6EA9C7FF000000000000000000000000000000000000
      0000000000000000000095DAF2FF5DB6D1FF7DC1D0FF00000000000000007DC1
      D0FF45AECEFF75CEF0FF00000000000000000000000000000000000000000000
      0000000000000000000074B8D8FF9DE1F9FF62B0CFFF4F9DBDFF4D9CBBFF4BA5
      C6FF77D1F3FF70B6D7FF00000000000000000000000000000000000000000000
      000000000000000000000000000077BCDCFF8ED4EDFF8ED4EDFF82CCE5FF80CB
      E8FF75BBDCFF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007DBDDEFF7DBDDEFF0000
      0000000000000000000000000000000000000000000000000000}
    Layout = blGlyphTop
    OnClick = SpeedButton1Click
  end
  object Label19: TLabel
    Left = 15
    Top = 133
    Width = 98
    Height = 13
    Caption = 'Konfirmasi Password'
  end
  object Label20: TLabel
    Left = 15
    Top = 110
    Width = 71
    Height = 13
    Caption = 'Password Baru'
  end
  object Label21: TLabel
    Left = 130
    Top = 172
    Width = 321
    Height = 17
    AutoSize = False
    Caption = 
      '* Edit User  : Bila tidak ingin mengubah password, biarkan koson' +
      'g.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label1: TLabel
    Left = 15
    Top = 19
    Width = 62
    Height = 13
    Caption = 'Profile Group'
  end
  object Label6: TLabel
    Left = 131
    Top = 153
    Width = 321
    Height = 17
    AutoSize = False
    Caption = '* Add User : Password harus diisi.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Panel6: TPanel
    Left = 0
    Top = 197
    Width = 470
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    ExplicitLeft = 28
    ExplicitTop = 201
    object Bevel5: TBevel
      Left = 0
      Top = 0
      Width = 470
      Height = 6
      Align = alTop
      Shape = bsTopLine
      ExplicitWidth = 393
    end
    object Button3: TButton
      Left = 376
      Top = 12
      Width = 75
      Height = 25
      Caption = '&Save'
      Default = True
      TabOrder = 1
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 130
      Top = 12
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Cancel'
      TabOrder = 0
      OnClick = Button4Click
    end
  end
  object eUid: TEdit
    Left = 130
    Top = 38
    Width = 176
    Height = 21
    MaxLength = 50
    TabOrder = 1
    OnKeyPress = eUidKeyPress
  end
  object ENama: TEdit
    Left = 130
    Top = 61
    Width = 176
    Height = 21
    MaxLength = 50
    TabOrder = 3
  end
  object ePass1: TEdit
    Left = 130
    Top = 107
    Width = 176
    Height = 21
    Hint = 'Masukkan password Anda.'
    MaxLength = 30
    ParentShowHint = False
    PasswordChar = '*'
    ShowHint = True
    TabOrder = 4
  end
  object ePass2: TEdit
    Left = 130
    Top = 130
    Width = 176
    Height = 21
    Hint = 'Masukkan password Anda.'
    MaxLength = 30
    ParentShowHint = False
    PasswordChar = '*'
    ShowHint = True
    TabOrder = 5
  end
  object eProfile: TDBLookupComboBox
    Left = 130
    Top = 15
    Width = 176
    Height = 21
    KeyField = 'group_kode'
    ListField = 'group_name'
    ListSource = DataSource1
    TabOrder = 0
  end
  object ckAllow: TCheckBox
    Left = 316
    Top = 40
    Width = 97
    Height = 17
    Caption = 'Diijinkan Login'
    TabOrder = 2
  end
  object UniQuery1: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      
        'select  group_kode, group_name from usr_group where group_kode <' +
        '> '#39'DEV'#39
      'order by pkode asc')
    ReadOnly = True
    Left = 330
    Top = 67
    object UniQuery1group_kode: TStringField
      FieldName = 'group_kode'
      Required = True
      FixedChar = True
      Size = 3
    end
    object UniQuery1group_name: TStringField
      FieldName = 'group_name'
      Required = True
      Size = 50
    end
  end
  object DataSource1: TDataSource
    DataSet = UniQuery1
    Left = 360
    Top = 72
  end
end
