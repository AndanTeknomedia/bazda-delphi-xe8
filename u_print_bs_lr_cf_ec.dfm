object FPrintBsLrCfEc: TFPrintBsLrCfEc
  Left = 0
  Top = 0
  Caption = 'Laporan Keuangan'
  ClientHeight = 506
  ClientWidth = 750
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object ActionToolBar1: TActionToolBar
    Left = 0
    Top = 0
    Width = 750
    Height = 28
    ActionManager = ActionManager1
    ColorMap.HighlightColor = 14410210
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = 14410210
    EdgeBorders = [ebBottom]
    EdgeOuter = esLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Spacing = 0
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 60
    Width = 750
    Height = 446
    ActivePage = TabSheet4
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Laporan Posisi Keuangan'
    end
    object TabSheet2: TTabSheet
      Caption = 'Laporan Perubahan Dana'
      ImageIndex = 1
    end
    object TabSheet3: TTabSheet
      Caption = 'Arus Kas'
      ImageIndex = 2
    end
    object TabSheet4: TTabSheet
      Caption = 'Perubahan Aset Kelolaan'
      ImageIndex = 3
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 28
    Width = 750
    Height = 32
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label10: TLabel
      Left = 15
      Top = 8
      Width = 117
      Height = 13
      Caption = 'Sampai Bulan/Tahun'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dpBs: TDateTimePicker
      Left = 138
      Top = 4
      Width = 92
      Height = 21
      Date = 42578.606255474540000000
      Format = 'dd/MM/yyyy'
      Time = 42578.606255474540000000
      TabOrder = 0
    end
    object ckDetail: TCheckBox
      Left = 248
      Top = 6
      Width = 63
      Height = 17
      Caption = '&Detail'
      Enabled = False
      TabOrder = 1
    end
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = acClose
            Caption = '&Close'
            ImageIndex = 4
            ShortCut = 16499
          end
          item
            Caption = '-'
          end
          item
            Action = acTampilkan
            Caption = '&Refresh'
            ImageIndex = 60
            ShortCut = 116
          end>
        ActionBar = ActionToolBar1
      end>
    Images = FMain.ilWin
    Left = 335
    Top = 95
    StyleName = 'Platform Default'
    object acClose: TAction
      Caption = 'Close'
      ImageIndex = 4
      ShortCut = 16499
      OnExecute = acCloseExecute
    end
    object acTampilkan: TAction
      Caption = 'Refresh'
      ImageIndex = 60
      ShortCut = 116
      OnExecute = acTampilkanExecute
    end
  end
  object QBS: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      'select * from gen_bs_aset(:cabang, :tgl1, :tgl2, :level,:thn1);'
      
        '-- select * from gen_bs('#39'031'#39', '#39'2016-07-01'#39', '#39'2016-07-31'#39', 3,'#39'N'#39 +
        ');')
    Left = 120
    Top = 205
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cabang'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'tgl1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'tgl2'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'level'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'thn1'
        Value = nil
      end>
    object QBStingkat: TIntegerField
      FieldName = 'tingkat'
      ReadOnly = True
    end
    object QBSnomor: TMemoField
      FieldName = 'nomor'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QBSkode_rek: TMemoField
      FieldName = 'kode_rek'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QBSvkode: TMemoField
      FieldName = 'vkode'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QBSnama_rek: TMemoField
      FieldName = 'nama_rek'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QBSsaldo: TFloatField
      FieldName = 'saldo'
      ReadOnly = True
    end
    object QBSsaldo_n: TFloatField
      FieldName = 'saldo_n'
      ReadOnly = True
    end
  end
  object DataSource1: TDataSource
    DataSet = QBS
    Left = 430
    Top = 90
  end
  object frBS: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41350.956592233800000000
    ReportOptions.LastChange = 43104.856828726850000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    OnPreview = frBSPreview
    Left = 169
    Top = 139
  end
  object QLr: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      'select * from gen_lr(:cabang, :tgl1, :tgl2)'
      '-- select * from gen_bs(:cabang, :tgl1, :tgl2, :level,:thn1);')
    Left = 120
    Top = 255
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cabang'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'tgl1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'tgl2'
        Value = nil
      end>
    object QLrkode_rek: TMemoField
      FieldName = 'kode_rek'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QLrvkode: TMemoField
      FieldName = 'vkode'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QLrnama_rek: TMemoField
      FieldName = 'nama_rek'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QLrsaldo_n: TFloatField
      FieldName = 'saldo_n'
      ReadOnly = True
    end
    object QLrlvl: TIntegerField
      FieldName = 'lvl'
      ReadOnly = True
    end
    object QLrtipe: TMemoField
      FieldName = 'tipe'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QLrnomor: TMemoField
      FieldName = 'nomor'
      ReadOnly = True
      BlobType = ftMemo
    end
  end
  object QCf: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      '-- select * from gen_cf('#39'031'#39', '#39'2016-01-01'#39', current_date);'
      'select * from gen_cf(:cabang, :tgl1, :tgl2);')
    Left = 120
    Top = 305
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cabang'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'tgl1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'tgl2'
        Value = nil
      end>
    object QCftingkat: TIntegerField
      FieldName = 'tingkat'
      ReadOnly = True
    end
    object QCfkode: TMemoField
      FieldName = 'kode'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QCfuraian: TMemoField
      FieldName = 'uraian'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QCfjumlah: TFloatField
      FieldName = 'jumlah'
      ReadOnly = True
    end
  end
  object QEc: TUniQuery
    Connection = FMain.Koneksi
    Left = 120
    Top = 355
  end
  object fxDBBs: TfrxDBDataset
    UserName = 'fxDBBs'
    CloseDataSource = False
    FieldAliases.Strings = (
      'tingkat=tingkat'
      'nomor=nomor'
      'kode_rek=kode_rek'
      'vkode=vkode'
      'nama_rek=nama_rek'
      'saldo=saldo'
      'saldo_n=saldo_n')
    DataSet = QBS
    BCDToCurrency = False
    Left = 155
    Top = 205
  end
  object fxDBLr: TfrxDBDataset
    UserName = 'fxDBLr'
    CloseDataSource = False
    FieldAliases.Strings = (
      'kode_rek=kode_rek'
      'vkode=vkode'
      'nama_rek=nama_rek'
      'saldo_n=saldo_n'
      'lvl=lvl'
      'tipe=tipe'
      'nomor=nomor')
    DataSet = QLr
    BCDToCurrency = False
    Left = 170
    Top = 255
  end
  object fxDBCf: TfrxDBDataset
    UserName = 'fxDBCf'
    CloseDataSource = False
    FieldAliases.Strings = (
      'tingkat=tingkat'
      'kode=kode'
      'uraian=uraian'
      'jumlah=jumlah')
    DataSet = QCf
    BCDToCurrency = False
    Left = 170
    Top = 305
  end
  object fxDBEc: TfrxDBDataset
    UserName = 'fxDBEc'
    CloseDataSource = False
    DataSet = QEc
    BCDToCurrency = False
    Left = 170
    Top = 355
  end
  object QBs2: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      
        'select * from gen_bs_non_aset(:cabang, :tgl1, :tgl2, :level,:thn' +
        '1);'
      
        '-- select * from gen_bs('#39'031'#39', '#39'2016-07-01'#39', '#39'2016-07-31'#39', 3,'#39'N'#39 +
        ');')
    Left = 200
    Top = 205
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cabang'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'tgl1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'tgl2'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'level'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'thn1'
        Value = nil
      end>
    object IntegerField1: TIntegerField
      FieldName = 'tingkat'
      ReadOnly = True
    end
    object MemoField1: TMemoField
      FieldName = 'nomor'
      ReadOnly = True
      BlobType = ftMemo
    end
    object MemoField2: TMemoField
      FieldName = 'kode_rek'
      ReadOnly = True
      BlobType = ftMemo
    end
    object MemoField3: TMemoField
      FieldName = 'vkode'
      ReadOnly = True
      BlobType = ftMemo
    end
    object MemoField4: TMemoField
      FieldName = 'nama_rek'
      ReadOnly = True
      BlobType = ftMemo
    end
    object FloatField1: TFloatField
      FieldName = 'saldo'
      ReadOnly = True
    end
    object FloatField2: TFloatField
      FieldName = 'saldo_n'
      ReadOnly = True
    end
  end
  object fxDBBs2: TfrxDBDataset
    UserName = 'fxDBBs2'
    CloseDataSource = False
    FieldAliases.Strings = (
      'tingkat=tingkat'
      'nomor=nomor'
      'kode_rek=kode_rek'
      'vkode=vkode'
      'nama_rek=nama_rek'
      'saldo=saldo'
      'saldo_n=saldo_n')
    DataSet = QBs2
    BCDToCurrency = False
    Left = 235
    Top = 205
  end
  object QBSDet: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      'select * from gen_bs_aset_detail(:cabang, :tgl1, :tgl2);'
      
        '-- select * from gen_bs_aset_detail('#39'031'#39', '#39'2016-07-01'#39', '#39'2016-0' +
        '7-31'#39');')
    Left = 290
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cabang'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'tgl1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'tgl2'
        Value = nil
      end>
    object QBSDettingkat: TIntegerField
      FieldName = 'tingkat'
      ReadOnly = True
    end
    object QBSDetnomor: TMemoField
      FieldName = 'nomor'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QBSDetkode_rek: TMemoField
      FieldName = 'kode_rek'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QBSDetvkode: TMemoField
      FieldName = 'vkode'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QBSDetnama_rek: TMemoField
      FieldName = 'nama_rek'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QBSDetsaldo: TFloatField
      FieldName = 'saldo'
      ReadOnly = True
    end
  end
  object fxDBBsDet: TfrxDBDataset
    UserName = 'fxDBBsDet'
    CloseDataSource = False
    FieldAliases.Strings = (
      'tingkat=tingkat'
      'nomor=nomor'
      'kode_rek=kode_rek'
      'vkode=vkode'
      'nama_rek=nama_rek'
      'saldo=saldo')
    DataSet = QBSDet
    BCDToCurrency = False
    Left = 340
    Top = 200
  end
  object QLRDet: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      'select * from gen_lr_detail(:cabang, :tgl1, :tgl2 );'
      '-- select * from gen_lr_detail(:cabang, :tgl1, :tgl2);')
    Left = 285
    Top = 255
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cabang'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'tgl1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'tgl2'
        Value = nil
      end>
    object QLRDetnomor: TMemoField
      FieldName = 'nomor'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QLRDetkode_rek: TMemoField
      FieldName = 'kode_rek'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QLRDetvkode: TMemoField
      FieldName = 'vkode'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QLRDetnama_rek: TMemoField
      FieldName = 'nama_rek'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QLRDetsaldo_n: TFloatField
      FieldName = 'saldo_n'
      ReadOnly = True
    end
    object QLRDetlvl: TIntegerField
      FieldName = 'lvl'
      ReadOnly = True
    end
    object QLRDettipe: TMemoField
      FieldName = 'tipe'
      ReadOnly = True
      BlobType = ftMemo
    end
  end
  object fxDBLrDet: TfrxDBDataset
    UserName = 'fxDBLrDet'
    CloseDataSource = False
    FieldAliases.Strings = (
      'nomor=nomor'
      'kode_rek=kode_rek'
      'vkode=vkode'
      'nama_rek=nama_rek'
      'saldo_n=saldo_n'
      'lvl=lvl'
      'tipe=tipe')
    DataSet = QLRDet
    BCDToCurrency = False
    Left = 340
    Top = 255
  end
  object QCfDet: TUniQuery
    Connection = FMain.Koneksi
    Left = 285
    Top = 305
  end
  object fxDBCfDet: TfrxDBDataset
    UserName = 'fxDBCfDet'
    CloseDataSource = False
    DataSet = QCfDet
    BCDToCurrency = False
    Left = 340
    Top = 300
  end
  object QECDet: TUniQuery
    Connection = FMain.Koneksi
    Left = 285
    Top = 355
  end
  object fxDBecDet: TfrxDBDataset
    UserName = 'fxDBecDet'
    CloseDataSource = False
    DataSet = QECDet
    BCDToCurrency = False
    Left = 335
    Top = 355
  end
  object QBSDet2: TUniQuery
    Connection = FMain.Koneksi
    SQL.Strings = (
      'select * from gen_bs_non_aset_detail(:cabang, :tgl1, :tgl2);'
      
        '-- select * from gen_bs_non_aset_detail('#39'031'#39', '#39'2016-07-01'#39', '#39'20' +
        '16-07-31'#39');')
    Left = 395
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cabang'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'tgl1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'tgl2'
        Value = nil
      end>
    object QBSDet2tingkat: TIntegerField
      FieldName = 'tingkat'
      ReadOnly = True
    end
    object QBSDet2nomor: TMemoField
      FieldName = 'nomor'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QBSDet2kode_rek: TMemoField
      FieldName = 'kode_rek'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QBSDet2vkode: TMemoField
      FieldName = 'vkode'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QBSDet2nama_rek: TMemoField
      FieldName = 'nama_rek'
      ReadOnly = True
      BlobType = ftMemo
    end
    object QBSDet2saldo: TFloatField
      FieldName = 'saldo'
      ReadOnly = True
    end
  end
  object fxDBBsDet2: TfrxDBDataset
    UserName = 'fxDBBsDet2'
    CloseDataSource = False
    FieldAliases.Strings = (
      'tingkat=tingkat'
      'nomor=nomor'
      'kode_rek=kode_rek'
      'vkode=vkode'
      'nama_rek=nama_rek'
      'saldo=saldo')
    DataSet = QBSDet2
    BCDToCurrency = False
    Left = 480
    Top = 195
  end
  object frLR: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41350.956592233800000000
    ReportOptions.LastChange = 43091.587811238400000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    OnPreview = frLRPreview
    Left = 201
    Top = 139
  end
  object frCF: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41350.956592233800000000
    ReportOptions.LastChange = 42620.584227812500000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    OnPreview = frCFPreview
    Left = 237
    Top = 139
  end
  object frEC: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41350.956592233800000000
    ReportOptions.LastChange = 42620.584227812500000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    OnPreview = frECPreview
    Left = 281
    Top = 139
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 192
    Top = 204
  end
end
