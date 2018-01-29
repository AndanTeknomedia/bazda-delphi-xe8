object PInputFloat: TPInputFloat
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Input Float Value'
  ClientHeight = 281
  ClientWidth = 431
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
  object Panel2: TPanel
    Left = 0
    Top = 225
    Width = 431
    Height = 56
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Bevel2: TBevel
      Left = 0
      Top = 0
      Width = 431
      Height = 6
      Align = alTop
      Shape = bsBottomLine
      ExplicitTop = 35
      ExplicitWidth = 647
    end
    object Button1: TButton
      Left = 35
      Top = 17
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      ImageIndex = 23
      Images = FMain.ilWin
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 116
      Top = 17
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ImageIndex = 21
      Images = FMain.ilWin
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 431
    Height = 225
    ActivePage = TabSheet1
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Input Nilai'
      object Label1: TLabel
        Left = 31
        Top = 9
        Width = 31
        Height = 13
        Caption = 'Label1'
      end
      object Label2: TLabel
        Left = 31
        Top = 54
        Width = 31
        Height = 13
        Caption = 'Label1'
      end
      object JvCalcEdit1: TJvCalcEdit
        Left = 31
        Top = 24
        Width = 156
        Height = 21
        Flat = False
        ParentFlat = False
        DisplayFormat = '0.00'
        ShowButton = False
        TabOrder = 0
        DecimalPlacesAlwaysShown = True
      end
      object JvCalcEdit2: TJvCalcEdit
        Left = 31
        Top = 69
        Width = 156
        Height = 21
        DisplayFormat = '0.00'
        ShowButton = False
        TabOrder = 1
        DecimalPlacesAlwaysShown = True
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Bayar'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label3: TLabel
        Left = 31
        Top = 9
        Width = 31
        Height = 13
        Caption = 'Label1'
      end
      object Label4: TLabel
        Left = 31
        Top = 33
        Width = 31
        Height = 13
        Caption = 'Label1'
      end
      object Label5: TLabel
        Left = 31
        Top = 60
        Width = 31
        Height = 13
        Caption = 'Label1'
      end
      object Label6: TLabel
        Left = 31
        Top = 87
        Width = 31
        Height = 13
        Caption = 'Label1'
      end
      object Label7: TLabel
        Left = 31
        Top = 114
        Width = 38
        Height = 13
        Caption = 'Tanggal'
      end
      object Label8: TLabel
        Left = 31
        Top = 142
        Width = 43
        Height = 13
        Caption = 'Bayar Ke'
      end
      object SpeedButton1: TSpeedButton
        Left = 107
        Top = 165
        Width = 157
        Height = 27
        Hint = 'Rekening Lainnya'
        Caption = 'Rekening Lainnya'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF4D74AB234179C5ABA7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF4173AF008EEC009AF41F4B80FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFF2F6EB22BA7
          F516C0FF00A0F3568BC3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFEFFFF2974BB68C4F86BD4FF279CE66696C8FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3D8FD5A4E3FEB5EEFF4CAA
          E7669DD2FFFFFFFFFFFFFFFFFFFFFFFFFEFEFEA188898A6A6A93736E866567B0
          9595BAA8B1359EE8BDF5FF77C4EF63A1DAFFFFFFFFFFFFFFFFFFFFFFFFD7CDCD
          7E5857DFD3CBFFFFF7FFFFE7FFFEDBD6BB9E90584D817B8E1794E46BB5E9FFFF
          FFFFFFFFFFFFFFFFFFFFEDE9E9886565FFFFFFFFFFFFFDF8E8FAF2DCF8EDCFFF
          F1CFF6DEBA9F5945C0C7D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA38889F6EFEA
          FFFFFFFEFBF5FBF7E8F9F4DAF5EBCCE6CEACF3DAB8E2BD99AB8B8EFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF937674FFFFFFFDFBF1FCF8EEFAF3E1FCF5E3F7F0D7F0
          DFC1E7C9A9F0D1ABA87E75F8F6F6FFFFFFFFFFFFFFFFFFFFFFFF997D7AFFFFFC
          F9F2E1FAF3DEFAF7E5FAF1DCF1DFC0EDD9BAECD8B9EDCAA5AF8679EDE8E9FFFF
          FFFFFFFFFFFFFFFFFFFF9C807BFFFFEBF9EED5FAF1D7F9F2DAF2E3C6FEFBF9FF
          FFF0EFDFC0E9C69EB0857BF5F2F3FFFFFFFFFFFFFFFFFFFFFFFFAF9596F7EAC8
          F9EBCCEFDCBEF4E4C7F0E1C5FDFCECFAF5DDEFDCBCDFB087B59A9AFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFDED4D7BA998CFDECC4EDD4B0E5CAA8EFDBBFF2E3C4F2
          DEBCEABF93BB8E7DE7DFE2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCEBFC5
          BE9A8DE6C7A5EFCBA3ECC8A2E8BE94DCAA86BE9585DFD6D7FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E4E6C9B3B4B99C93C3A097BF9F96CC
          B9B7F1EEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton1Click
      end
      object JvCalcEdit3: TJvCalcEdit
        Left = 107
        Top = 3
        Width = 156
        Height = 21
        Flat = False
        ParentFlat = False
        DisplayFormat = '#,#0.00 ;(#,#0.00) ;- '
        Enabled = False
        ShowButton = False
        TabOrder = 0
        DisabledColor = 15066597
        DecimalPlacesAlwaysShown = False
      end
      object JvCalcEdit4: TJvCalcEdit
        Left = 107
        Top = 30
        Width = 156
        Height = 21
        DisplayFormat = '#,#0.00 ;(#,#0.00) ;- '
        Enabled = False
        ShowButton = False
        TabOrder = 1
        DisabledColor = 15066597
        DecimalPlacesAlwaysShown = False
      end
      object JvCalcEdit5: TJvCalcEdit
        Left = 107
        Top = 57
        Width = 156
        Height = 21
        Flat = False
        ParentFlat = False
        DisplayFormat = '#,#0.00 ;(#,#0.00) ;- '
        Enabled = False
        ShowButton = False
        TabOrder = 2
        DisabledColor = 15066597
        DecimalPlacesAlwaysShown = False
      end
      object JvCalcEdit6: TJvCalcEdit
        Left = 107
        Top = 84
        Width = 156
        Height = 21
        DisplayFormat = '#,#0.00 ;(#,#0.00) ;- '
        ShowButton = False
        TabOrder = 3
        DecimalPlacesAlwaysShown = False
      end
      object dp1: TDateTimePicker
        Left = 107
        Top = 111
        Width = 97
        Height = 21
        Date = 41351.028605891200000000
        Format = 'dd/MM/yyyy'
        Time = 41351.028605891200000000
        TabOrder = 4
      end
      object eBayar: TButtonedEdit
        Tag = 2
        Left = 107
        Top = 138
        Width = 294
        Height = 21
        MaxLength = 100
        ReadOnly = True
        TabOrder = 5
        OnRightButtonClick = eBayarRightButtonClick
      end
    end
  end
end
