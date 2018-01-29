object FSelectMasterDetail: TFSelectMasterDetail
  Left = 0
  Top = 0
  ClientHeight = 383
  ClientWidth = 683
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 336
    Width = 683
    Height = 47
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Bevel2: TBevel
      Left = 0
      Top = 0
      Width = 683
      Height = 6
      Align = alTop
      Shape = bsBottomLine
      ExplicitTop = 35
      ExplicitWidth = 647
    end
    object Button2: TButton
      Left = 9
      Top = 12
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 90
      Top = 13
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = Button3Click
    end
  end
  object gep: TDBGridEh
    Left = 0
    Top = 0
    Width = 683
    Height = 336
    Align = alClient
    AllowedOperations = [alopUpdateEh, alopDeleteEh, alopAppendEh]
    AllowedSelections = [gstRecordBookmarks, gstAll]
    DataGrouping.Font.Charset = DEFAULT_CHARSET
    DataGrouping.Font.Color = clWindowText
    DataGrouping.Font.Height = -11
    DataGrouping.Font.Name = 'Tahoma'
    DataGrouping.Font.Style = []
    DataGrouping.ParentFont = False
    DataGrouping.ShiftFolldataGroupRow = False
    DataSource = DataSource1
    DrawMemoText = True
    DynProps = <>
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    FooterRowCount = 1
    FooterParams.Color = 15532021
    HorzScrollBar.ExtraPanel.Visible = True
    HorzScrollBar.ExtraPanel.VisibleItems = [gsbiRecordsInfoEh, gsbiSelAggregationInfoEh]
    IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    EmptyDataInfo.Active = True
    OddRowColor = 15987699
    Options = [dgTitles, dgIndicator, dgColumnResize, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
    ParentFont = False
    ReadOnly = True
    SearchPanel.Enabled = True
    SearchPanel.FilterOnTyping = True
    SumList.Active = True
    TabOrder = 0
    OnAdvDrawDataCell = gepAdvDrawDataCell
    OnDblClick = gepDblClick
    OnKeyDown = gepKeyDown
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        Footers = <>
        MaxWidth = 50
        MinWidth = 50
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object MemTableEh1: TMemTableEh
    Params = <>
    TreeList.DefaultNodeExpanded = True
    TreeList.FullBuildCheck = False
    Left = 305
    Top = 160
    object MemTableEh1pkode: TStringField
      FieldName = 'pkode'
      Size = 23
    end
    object MemTableEh1kode: TMemoField
      FieldName = 'kode'
      BlobType = ftMemo
    end
    object MemTableEh1vkode: TStringField
      FieldName = 'vkode'
    end
    object MemTableEh1uraian: TStringField
      FieldName = 'uraian'
      Size = 255
    end
    object MemTableEh1jumlah: TFloatField
      FieldName = 'jumlah'
    end
    object MemTableEh1tipe: TIntegerField
      FieldName = 'tipe'
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object pkode: TMTStringDataFieldEh
          FieldName = 'pkode'
          StringDataType = fdtStringEh
          DisplayLabel = 'pkode'
          DisplayWidth = 23
          Size = 23
          Transliterate = True
        end
        object kode: TMTBlobDataFieldEh
          FieldName = 'kode'
          DisplayLabel = 'kode'
          DisplayWidth = 10
          BlobType = ftMemo
          Transliterate = True
        end
        object vkode: TMTStringDataFieldEh
          FieldName = 'vkode'
          StringDataType = fdtStringEh
          DisplayLabel = 'vkode'
          DisplayWidth = 20
          Transliterate = True
        end
        object uraian: TMTStringDataFieldEh
          FieldName = 'uraian'
          StringDataType = fdtStringEh
          DisplayLabel = 'uraian'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object jumlah: TMTNumericDataFieldEh
          FieldName = 'jumlah'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'jumlah'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object tipe: TMTNumericDataFieldEh
          FieldName = 'tipe'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'tipe'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            '73711400992015012020'
            '73711400992015012020202'
            '2.02.02.02'
            'Belanja Barang dan Jasa :'
            0.000000000000000000
            1)
          (
            '73711400992015012020202'
            '73711400992015012020202001'
            '2.02.02.02.001'
            '- Upah Kerja'
            nil
            2)
          (
            '73711400992015012020202'
            '73711400992015012020202002'
            '2.02.02.02.002'
            '- Honor'
            nil
            2)
          (
            '73711400992015012020'
            '73711400992015012020203'
            '2.02.02.03'
            'Belanja  Modal:'
            0.000000000000000000
            1)
          (
            '73711400992015012020203'
            '73711400992015012020203001'
            '2.02.02.03.001'
            '- Aspal '
            nil
            2)
          (
            '73711400992015012020203'
            '73711400992015012020203002'
            '2.02.02.03.002'
            '- Pasir '
            nil
            2))
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 345
    Top = 160
  end
  object UniQuery1: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      
        'select substr(v.kode,1,length(v.kode)-3)::varchar(23) pkode, v.k' +
        'ode, v.vkode,'
      
        #9'(case substr(v.kode,15,2) when '#39'02'#39' then v.uraian2 else v.uraia' +
        'n end) uraian,'
      
        '  (case substr(v.kode,15,2) when '#39'02'#39' then v.jumlah2::numeric(15' +
        ',2)  else v.jumlah::numeric(15,2)  end)jumlah,'
      '  v.tipe   '
      
        'from vw_4_5 v where substr(v.kode,1,21) = '#39'737114009920150120202' +
        #39' order by v.kode asc')
    Left = 230
    Top = 170
  end
  object DataSource2: TDataSource
    DataSet = UniQuery1
    Left = 205
    Top = 205
  end
end
