unit u_utils;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Dialogs, Forms, Controls, StdCtrls,
  DB, DAScript, UniScript, MemDS, DBGridEh, System.Variants,
  StrUtils, DateUtils, datafile, math, TypInfo, IdHashMessageDigest, idHash,
  Character, ShellAPI, ShlObj, ShFolder, ActiveX, ComObj, pngimage, Uni, UniProvider,
  ExtCtrls, ActnList, menus, JvBaseEdits, ComCtrls, ActnMan, ActnMenus, Buttons, frxClass;

const

  APP_NAME = 'SIBAZ';
  APP_NAME_LONG = 'Sistem Informasi BAZ';
  APP_VERSION = '0.0.0';
  APP_NAME_WITH_VERSION = APP_NAME +' v'+APP_VERSION;
  APP_NAME_WITH_VERSION_LONG = APP_NAME_WITH_VERSION;
  //excel:


  xlBottom = -4107;
  xlLeft = -4131;
  xlRight = -4152;
  xlTop = -4160;
  xlHAlignCenter = -4108;
  xlVAlignCenter = -4108;

  xlPasteAll= -4104;
  xlPasteAllExceptBorders = 7;
  xlPasteAllMergingConditionalFormats=14;
  xlPasteAllUsingSourceTheme=13;
  xlPasteColumnWidths=8;
  xlPasteComments=-4144;
  xlPasteFormats=-4122;
  xlPasteFormulas=-4123;
  xlPasteFormulasAndNumberFormats=11;
  xlPasteValidation=6;
  xlPasteValues=-4163;
  xlPasteValuesAndNumberFormats=12;

  xlTotal_Formula ='SUBTOTAL(9,%s%u:%s%u)';
  xlMean_Formula  ='SUBTOTAL(1,%s%u:%s%u)';
  xlCount_Formula  ='SUBTOTAL(3,%s%u:%s%u)';


  crBussy = 857;
  INVALID_DATE_VALUE: TDate = 0;
  INVALID_TIME_VALUE: TTime = 0;
  INVALID_DATETIME_VALUE: TDateTime = 0;


  FORMAT_FLOAT   = '#,#0.00';
  FORMAT_FINANCE = '#,#0.00 ;(#,#0.00) ;  ';
  FORMAT_INTEGER = '#,#0 ;(#,#0) ;-';
  FORMAT_FINANCE2 = '#,#0.## ;(#,#0.##); ';
  FORMAT_DATE_DISPLAY = 'dd/MM/yyyy';
  FORMAT_DATE_MASK = '!90/90/0000;1;_';

  NamaBulanPanjang: array[1..12] of string = (
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  );
  NamaBulanPendek: array[1..12] of string = (
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des'
  );


var
  ____i: integer;



type
  TUser = record
    NamaCabang: String[200];
    KodeCabang: String[3];
    ID: Integer;
    GrupName,
    UserName,
    Password: String[50];
    FullName: String[100];
    Grup: String[3];
    AlamatCabang: string[250];
    SuperVisorID: Integer;
    SuperVisorUserName,
    SuperVisorGrupName,
    SuperVisorPassword: String[50];
    SuperVisorFullName: String[100];
    SuperVisorGrup: String[3];
    AllowLogin:  boolean;
    procedure Clear;
    function Accessible(const AccessName: String): Boolean;
  end;

  TStringArr = array of string;
  //class helper for TstringList:
  TStringListEnumProc = TProc <Integer,String>;
  TPairList = record
  private
    FList: TStringList;
  public
    Constructor  New(StringList: tstringlist);
    //procedure Each(proc: TstringListEnumProc);
    procedure    Each(proc: TProc<Integer,String>);
  end;

  TNamaNipNPWP = record
    Nama: String[100];
    NIP : String[25];
    NPWP: String[100];
    procedure Clear;
  end;
  tperkiraan = record
    kode: string[8];
    vkode: string[20];
    Rekening: string[255];
  end;

  {*
  *   Utilitas untuk GUI
  *}

  const
  _BUTTONED_EDIT_DEFAULT = '';

{ IMPLEMENT MRU functionality on TEdit & TButtonedEdit }

const
  IID_IAutoComplete: TGUID = '{00bb2762-6a77-11d0-a535-00c04fd7d062}';
  IID_IAutoComplete2: TGUID = '{EAC04BC0-3791-11d2-BB95-0060977B464C}';
  CLSID_IAutoComplete: TGUID = '{00BB2763-6A77-11D0-A535-00C04FD7D062}';

  IID_IACList: TGUID = '{77A130B0-94FD-11D0-A544-00C04FD7d062}';
  IID_IACList2: TGUID = '{470141a0-5186-11d2-bbb6-0060977b464c}';

  CLSID_ACLHistory: TGUID = '{00BB2764-6A77-11D0-A535-00C04FD7D062}';
  CLSID_ACListISF: TGUID = '{03C036F1-A186-11D0-824A-00AA005B4383}';
  CLSID_ACLMRU: TGUID = '{6756a641-de71-11d0-831b-00aa005b4383}';

type

  IACList = interface(IUnknown)
  ['{77A130B0-94FD-11D0-A544-00C04FD7d062}']
    function Expand(pszExpand : POLESTR) : HResult; stdcall;
  end;

const
  //options for IACList2
  ACLO_NONE = 0;          // don't enumerate anything
  ACLO_CURRENTDIR = 1;    // enumerate current directory
  ACLO_MYCOMPUTER = 2;    // enumerate MyComputer
  ACLO_DESKTOP = 4;       // enumerate Desktop Folder
  ACLO_FAVORITES = 8;     // enumerate Favorites Folder
  ACLO_FILESYSONLY = 16;  // enumerate only the file system

type
  IACList2 = interface(IACList)
  ['{470141a0-5186-11d2-bbb6-0060977b464c}']
    function SetOptions(dwFlag: DWORD): HResult; stdcall;
    function GetOptions(var pdwFlag: DWORD): HResult; stdcall;
  end;

  IAutoComplete = interface(IUnknown)
  ['{00bb2762-6a77-11d0-a535-00c04fd7d062}']
    function Init(hwndEdit: HWND; const punkACL: IUnknown;
      pwszRegKeyPath, pwszQuickComplete: POLESTR): HResult; stdcall;
    function Enable(fEnable: BOOL): HResult; stdcall;
  end;

const
  //options for IAutoComplete2
  ACO_NONE = 0;
  ACO_AUTOSUGGEST = $1;
  ACO_AUTOAPPEND = $2;
  ACO_SEARCH = $4;
  ACO_FILTERPREFIXES = $8;
  ACO_USETAB = $10;
  ACO_UPDOWNKEYDROPSLIST = $20;
  ACO_RTLREADING = $40;

type

  // Stringlist Utils:

  IAutoComplete2 = interface(IAutoComplete)
  ['{EAC04BC0-3791-11d2-BB95-0060977B464C}']
    function SetOptions(dwFlag: DWORD): HResult; stdcall;
    function GetOptions(out pdwFlag: DWORD): HResult; stdcall;
  end;

  TEnumString = class(TInterfacedObject, IEnumString)
  private
    FStrings: TStringList;
    FCurrIndex: integer;
  public
    //IEnumString
    function Next(celt: Longint; out elt;
        pceltFetched: PLongint): HResult; stdcall;
    function Skip(celt: Longint): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out enm: IEnumString): HResult; stdcall;
    //VCL
    constructor Create;
    destructor Destroy;override;
  end;

  TACOption = (acAutoAppend, acAutoSuggest, acUseArrowKey);
  TACOptions = set of TACOption;

  TACSource = (acsList, acsHistory, acsMRU, acsShell);

// new TButtonedEdit & TEdit

type
  TProcOnPrivateEditKeyDown = TProc<TDBGridEh,Word,TShiftState>;
  TDummyWinControl = class(TWinControl);

  TAction = class(ActnList.TAction)
  public
    constructor Create(AOwner: TComponent); override;

  end;

  TButtonedEdit = class(ExtCtrls.TButtonedEdit)
  private
    type
      TEditButton = class( ExtCtrls.TEditButton )
      public
        property Glyph {: TGlyph read FGlyph };
      end;
  private
    FHiddenText: String;
    FHiddenInt: Int64;
    FHiddenFloat: Double;
    FTagString: String;
    //
    FACList: TEnumString;
    FAutoComplete: IAutoComplete;
    FACEnabled: boolean;
    FACOptions: TACOptions;
    FACSource: TACSource;
    function GetACStrings: TStringList;
    procedure SetACEnabled(const Value: boolean);
    procedure SetACOptions(const Value: TACOptions);
    procedure SetACSource(const Value: TACSource);
    procedure SetACStrings(const Value: TStringList);
    //
    procedure beEnter(Sender: TObject);
    procedure beExit (Sender: TObject);
  protected
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure KeyPress(var Key: Char); override;

  public
    constructor Create(Aowner:TComponent); override;
    destructor  Destroy; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    function IsEmpty: Boolean;
    procedure Focus;
    function WarnForEmpty(const AText: String = ''): Boolean;
    function GetOption: String;
    function SetOption: String;
    procedure Clear; override;
    procedure SetEnabled(value: Boolean); override;
    procedure SetValues(AText: String; const AHiddenText: String = ''; const AHiddenInt: Integer = 0; const AHiddenFloat: Double = 0.00);
    procedure setReadOnly(RO: Boolean = true);
    property HiddenText: String read FHiddenText write FHiddenText;
    property HiddenFloat: Double read FHiddenFloat write FHiddenFloat;
    property HiddenInt: Int64 read FHiddenInt write FHiddenInt;
    property TagString : String read FTagString write FTagString;
  published
    property ACEnabled: boolean read FACEnabled write SetACEnabled;
    property ACOptions: TACOptions read FACOptions write SetACOptions;
    property ACSource: TACSource read FACSource write SetACSource;
    property ACStrings: TStringList read GetACStrings write SetACStrings;
  end;

  TEdit = class(StdCtrls.TEdit)
  private
    FHiddenText: String;
    FHiddenInt: Int64;
    FHiddenFloat: Double;
    //
    FACList: TEnumString;
    FAutoComplete: IAutoComplete;
    FACEnabled: boolean;
    FACOptions: TACOptions;
    FACSource: TACSource;
    FTagString: String;
    function GetACStrings: TStringList;
    procedure SetACEnabled(const Value: boolean);
    procedure SetACOptions(const Value: TACOptions);
    procedure SetACSource(const Value: TACSource);
    procedure SetACStrings(const Value: TStringList);
    procedure SetTagString(const Value: String);
    //
  protected
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

  public
    constructor Create(Aowner:TComponent); override;
    destructor  Destroy; override;
    function IsEmpty: Boolean;
    procedure Focus;
    function WarnForEmpty(const AText: String = ''): Boolean;
    function GetOption: String;
    function SetOption: String;
    procedure Clear; override;
    procedure SetValues(AText: String; const AHiddenText: String = ''; const AHiddenInt: Integer = 0; const AHiddenFloat: Double = 0.00);
    procedure setReadOnly(RO: Boolean = true);
    property HiddenText: String read FHiddenText write FHiddenText;
    property HiddenFloat: Double read FHiddenFloat write FHiddenFloat;
    property HiddenInt: Int64 read FHiddenInt write FHiddenInt;
    property TagString : String read FTagString write SetTagString;
  published
    property ACEnabled: boolean read FACEnabled write SetACEnabled;
    property ACOptions: TACOptions read FACOptions write SetACOptions;
    property ACSource: TACSource read FACSource write SetACSource;
    property ACStrings: TStringList read GetACStrings write SetACStrings;
  end;

  TComboBox = class(StdCtrls.TComboBox)
  private
    FStoredItems: TStringList;
    procedure FilterItems;
    procedure StoredItemsChange(Sender: TObject);
    procedure SetStoredItems(const Value: TStringList);
    procedure CNCommand(var AMessage: TWMCommand); message CN_COMMAND;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property StoredItems: TStringList read FStoredItems write SetStoredItems;
  end;

  TJvCalcEdit = class(JvBaseEdits.TJvCalcEdit)
  public
    constructor Create(AOwner: TComponent); override;
    procedure setReadOnly(RO: Boolean = true);
  end;

  // save & load UI controls:
const
  UCCOntrolUACTableName =  'log_02_uac_items';

type
  TUIControlsType = (uictMainMenu, uictPopupMenu, uictActionManagers, uictButtons, uictOtherEnabledControls);
  TUIControlsTypes = set of TUIControlsType;

//fungsi-fungsi koneksi & database;

procedure SetGlobalConnection(Connection : TUniConnection);
function  GetGlobalConnection: TUniConnection;
function  Query: TUniQuery;
function  ExecSQL(const ASQL: String): TUniQuery; overload;
function  ExecSQL(const ASQL: TStringList): Boolean; overload;
function  ExecFunction(const AFunction: String; resultType: TFieldType = ftString): variant;
function  ExecSQLAndFetchOneValueAsString(const SQL: String; const Default:String = ''): String;
function  ExecSQLAndFetchOneValueAsInteger(const SQL: String; const Default:Integer = 0): Integer;
function  ExecSQLAndFetchOneValueAsFloat(const SQL: String; const Default:Double = 0.00): Double;
// fetches enum values, example:
// GetEnumFieldValuesAsArray('ProjectTypes',  'ProjectTypes = ''1%''');
function  GetEnumFieldValuesAsArray(AFieldType:String; const Filter: string = ''): TStringArr;
function  GetEnumFieldValuesAsStrings(AFieldType:String; const Filter: string = ''): TStringList;
function  GetOption(Opsi: String; const LocalFile: Boolean = False):String;
function  GetMultipleOptions(OptionNames: TStringArr; const LocalFile: Boolean = False): TStringArr;
function  SetOption(Opsi, value: String; const LocalFile: Boolean = False):String;
function  SetMultipleOptions(OptionNames, OptionValues: TStringArr; const LocalFile: Boolean = False):boolean;
function  DelOption(Opsi: String; const LocalFile: Boolean = False):String;

{
function  OptionExists(Opsi: String; const LocalFile: Boolean = False): Boolean;
}

function  GenUID(Tahun:Word; SKPD: String): String;
procedure StartTrans;
procedure CommitTrans;
procedure RollBackTrans;

procedure Debug(const debugmsg: String = 'Tested.');
function  INVALID_DATE: TDateTime;
function  ServerDateTime: TDateTime;
function  ServerDate: TDateTime;
function  XorData(AText: String): String;

{
type
  TDatasetOnSetTxt = procedure (Sender: TField; const Text: string) of object;

function  UpdateDatasetDateChangeHandler(ADataset: TDataset; AProc: TDatasetOnSetTxt);
}

//

type
  T2DigitYear = string[2];

procedure SendCtrlF;

function  GenerateTransNum (const IDDesa: String; const Tahun, Semester: Integer; NamaKode: String; Prefix: String; Update: Boolean = true): String;
function  GenerateDatasetSearchFilter(Fields: array of String; Values: array of String; useQuote: Boolean = True): String; overload;
function  GenerateDatasetSearchFilter(Fields: array of String; Values: TstringList; useQuote: Boolean = True): String; overload;

function  GenerateDatasetSearchFilterLocal(Fields: array of String; Values: array of String; useQuote: Boolean = True): String;

procedure DeleteFromGrid(Grid: TDBGridEh; Tabel, Field: string);

//fungsi-fungsi utilitas string dsb...

function  Persen(const Nilai, Terhadap: Double): DOuble;
function  Persentase(const Persen, Dari: Double): DOuble;

function  rp(const value: currency): string; overload;
function  rp(const value: string): string; overload;

function  FloatToFinance(const F: Double; const DuaAngkaBelakangKoma: Boolean = true): String;
function  FloatToSQL(const F:DOuble): String;
function  FloatToIndo(const F: Double; const endTail: Boolean = true) :String;
function  FloatToEnglish(const F: Double; const endTail: Boolean = true):String;
function  _Q(const AText: String = ''): String;
function  LPad(const AText: String; const ALength: Integer; const AChars:String):String;
function  RPad(const AText: String; const ALength: Integer; const AChars:String):String;

function  PadNum(const i: int64; const TextToAppend: String = ''): String;
function  PadStr(const i: String; const TextToAppend: String = ''): String;
function  GetPadNum(const AText: String): Int64;
function  GetPadStr(const AText: String): String;
function  StripPadNum(const AText: String): String;
function  StripPadStr(const AText: String): String;

function  _IIF(const ACondition: Boolean; const ATrueVal, AFalseVal: String):String; overload;
function  _IIF(const ACondition: Boolean; const ATrueVal, AFalseVal: Integer):Integer; overload;
function  _IIF(const ACondition: Boolean; const ATrueVal, AFalseVal: Double):Double; overload;
function  _d(a1: string; a2: string): string; overload;
function  _d(a1: integer; a2: integer): integer; overload;
function  _d(a1: double; a2: Double): Double; overload;
function  _L(const AText:String):String;
function  _U(const AText:String):String;
function  _i(const AString:String; def:integer = 0):Integer;
function  _f(const AString:String; def:Double= 0):Double;
function  _s(const AValue:Int64; const Pad0Count: Integer = 0):string; overload;
function  _s(const AValue:Double; decimals: byte = 2):string; overload;
function  _s(AFormat: string; ADateTime: TDateTime): String; overload;
function  _empty(AValue:String): Boolean;
function  _r(value, find, replaceTo:String; flags: TReplaceFlags):String;


function  _USentence(const AText: String): String;
function  _LSentence(const AText: String): String;
function  _UWords(const AText: String): String;
function  _LWords(const AText: String): String;
function  _trim(const AText: String): String;
function  Trim(const AText: String): String;

function  isNumbersOnly(const AText:String):Boolean;

function  DateToSQL(const ADate: TDate):String;
function  DateFromSQL(const ASQLDate: String): TDateTime;
function  TimeToSQL(const ATime: TTime): String;
function  DateTimeToSQL(const ADateTime: TDateTime):String;
function  DateIndo (const ADate: TDate; const Padding0: boolean = false):String;
function  DateIndoShort (const ADate: TDate; const Padding0: boolean = true):String;
function  DateIndoRange(const ADate1, ADate2: TDate; const Padding0: boolean = true):String;
function  Usia(const TglLahir, TglKini: TDate): Integer;
function  Tahun(ADate: TDate): Integer;
function  Bulan(ADate: TDate): Integer;
function  Hari(ADate: TDate):Integer;
function  NamaBulan(ADate: TDate): String;
function  NamaHari(ADate: TDate): String;
function  AwalTahun(ADate: TDate): TDate; overload;
function  AwalTahun(ATahun: Word): TDate; overload;
function  AwalBulan(ADate: TDate): TDate;
function  AkhirBulan(ADAte: TDate): TDate; overload;
function  AkhirBulan(ATahun, ABulan: Word): Word; overload;
function  AkhirTahun(ADate: TDate): TDate;
function JangkaBulan(Date1, Date2: TDateTime): Integer;
function JangkaHari(Date1, Date2: TDateTime): Integer;

function  SexBySalutation(const ASal: String; const PrefixOnly: Boolean = False): String;

//bukan pembulatan angka di belakang koma!!!
//pembulatan di sini: 1098 => bulatAtas(atas,3) => 2000
function  BulatAtas (value: Double; NDigitFaktor: integer = 1): Double;
function  BulatBawah(value: Double; NDigitFaktor: integer = 1): Double;


function  KodeRekByLevel(const ARek: String; ALevel: Integer):String;
function  LevelByKodeRek(const ARek: String): Integer;
function  FormatKodeRek(const ARek: String; full: boolean = false):String;
function  StripDots(const AText:String):String;

function  Ask(const QUestion:String; const Handle : Integer = 0; const btnYes:String = 'Ya'; btnNo:String = 'Tidak'): Integer;
function  Ask3Options(const QUestion:String; const Handle : Integer = 0; const btnYes:String = 'Ya'; btnNo:String = 'Tidak'; btnCancel:String = 'Batal'): Integer;
procedure Warn(const Warning: String; const Handle : Integer = 0);
procedure Deny(const Denial:String; const Handle : Integer = 0);
procedure ShowDefaultError;
procedure Inform(const Information:String; const Handle : Integer = 0);
procedure TampilkanText(AText: String);

function  ConfirmActionWithJurnal(Handle : Integer = 0): Integer;

function  IndentAkun(const Akun:String; const Level: Integer): STring;
function  Explode(const AText: String; Pemisah: String): TStringList;
function  CommaTextToStrings(const Atext: String; const Delimiter: Char = ','): TStringList;
function  StringsToCommaText(List: TStringList; const Delimiter: Char = ','; const Apit:Char = #0): String;
procedure EmptyDataset(Dataset: TDataSet);
procedure FillEmptyRecord(QT: TDataset);
procedure RefreshDatasets(Datasets: array of TDataSet; ReOpen: Boolean = False);

Function  FetchBulan(const IndexOnly: Boolean = False): TStringList;
procedure FetchTahun(List: TStringList);
procedure FetchPrefix(List: TstringList; const ATable, AField: String; const AUpperCase: Boolean = True; const ALength: Integer = 1 {Use -1 displays all}; const Asc: Boolean = True; const useAll: Boolean = true);
procedure FetchFieldValues(List: TStringList; const ATable, AField: String; const Distinct: Boolean = true; sort: boolean = false);
function  FetchSysVar(const VarName: String): TStringList;
function  FetchCountry: TStringList;

function  FindInList(List: TstringLIst; const Prefix: String; const CaseSensitif: Boolean = True): Integer;

{FUNGSI-FUNGSI SISTEM}
procedure BlobFromPng(Field: TBlobField; PNG: TPngImage);
function  PNGFromBlob(Field: TBlobField): TPngImage;

function GetUnitLogo(KodeUnit: String; const DefaultLogoPath: String = ''): TPngImage;
(*
procedure ResizeBitmap(b: TBItmap; W, H: Integer; Margin: Integer = 0);
procedure ReplaceColor(bmp: TBitmap; ClSource, ClTarget: TColor; Tolerance: Integer = 5 {0..100});
*)

function FileSize(AFile: String): Int64;
function SystemPath(const ARemoveTrailingPathDelimiter: boolean = True): String;
function WindowsPath(const ARemoveTrailingPathDelimiter: boolean = True): String;
function TempPath(const ARemoveTrailingPathDelimiter: boolean = True): String;
function AppPath(const ARemoveTrailingPathDelimiter: boolean = True): String;
function ConfigPath(const ARemoveTrailingPathDelimiter: boolean = True): String;
function TempFile(const BasePath: String = ''; const Ext: String = '.tmp'): String;
function ListFilesInFolder(const Folder: String; const FileMask: String): TstringList;
procedure FocusTo(AControl: TWinControl);

function _INVALID_DATE :TDateTime;
function PeriodeStart: Word;
function PeriodeEnd  : Word;
function FiskalStart(const UnitKerja: String; const Tahun: Word): TDate;

procedure InitAirpotsCache;
procedure CleanupAirportCache;

//utils:
function RefineDBErrorMessage(AError:String; AStart:String  = '#'; const AEnd: String = '#'): String;

function  MD5(const AText: String = ''): String;
function  RandomPassword(const ALength: Integer): String;
procedure CleanupTempTables(const ASessionID: String; ClearSessionTables: Boolean = False);

//cursor for busy state:
procedure ScreenBussy;
procedure ScreenIdle;

function  WarnForEmpty(const AText: String): Boolean; overload;
function  WarnForEmpty(const ANumber: Int64): Boolean; overload;
function  WarnForEmpty(Memo: TMemo): boolean; overload;
function  WarnForEmpty(const ANumber: Double): Boolean; overload;

//recordset flags caching:

function  InitRecordsetFlags(const ATableOrGroupName: String): Boolean;
procedure ClearRecordsetFlags(const ATableOrGroupName: String);
procedure SetRecordFlag(const ATableOrGroupName: String; const ARecordID: Int64; const aFlag: String);

function CreateShortcutFile(const AFile, Target: String; const Param: string = ''; const Description: string = ''): String;
procedure MsgBoxTimeout(Caption, Information: String; TimeoutInSeconds: integer = 5);

function _dir(FileOrDirName: String): String;
function _path(FileOrDirName: String): String;
function _appDataPath: String;

function WordReplaceTexts(WordFile: String; ReplaceParams: TStringList): boolean; overload;
function WordReplaceTexts(WordApp, WordDoc: OLEVariant; ReplaceParams: TStringList): boolean; overload;
function OpenWordFile(WordFile: String; var WordApp, WordDoc: OleVariant): Boolean;
function WordShowReport(WordFile: String; ShowAsPreview: Boolean = false): boolean; overload;
function WordShowReport(WordDoc, WordApp: OleVariant; ShowAsPreview: Boolean = false): boolean; overload;
function WordCombineFiles(AFile1, Afile2, AOutputFile: String; const UsePageBreak: Boolean = true): Boolean;

function ExcelShowReport(ExcelFile: String; ShowAsPreview: Boolean = false): boolean;
function ExcelMergeCells(WorkSheet: OleVariant; RangeStr: String): {Return Range} OleVariant;
function ExcelMergeAndCenter(WorkSheet: OleVariant; RangeStr:String): {Returns Range} OleVariant;

var
  OldDecimalSeparator,
  OldThousandSeparator : char;


function  GetLocalIP: String;
function  GetComputerName: String;
function  GetLocalIPAndHostName(var IP, HostName: String):Boolean;

function  AccessibleBy(const User: TUser; const AccessName: String): Boolean; overload;
function  AccessibleBy(const User: TUser; const AccessNames: array of String): Boolean; overload;

function ExcelColumnByIndex(aIndex: Integer): string;

type
  TOnProgressProc = TProc;

var
  BeginProgress : procedure (Text: String=''; proc: TOnProgressProc = nil) of object;
  EndProgress: procedure of object;
  AddMDIReport : function(Report: TFrxReport; const Title: String): Tform of object;

var
  CurrentUser: TUser;

implementation

uses winsock, u_display_text;

// {$R u_utils.TButtonedEdit.icon.res u_utils.TButtonedEdit.icon.rc}
{$R u_utils.res}

var
  __icon: TIcon;
  __cursorFile: String;
  __glyphs: TImageList;
  _GLOBAL_CONNECTION : TUniConnection;
  __pos: integer;
  __str: String;
  {
    Thousand airports needed to be parsed for
    splitting transit_ids. Too slow to retrieve them
    from database everytime needed.

  }
  _AirPortsCache: TUniQuery;
  ___OldScreenCursor: TCursor;

function CreateShortcutFile;
var
  IObject : IUnknown;
  ISLink : IShellLink;
  IPFile : IPersistFile;
  TargetName : String;
  LinkName : WideString;
begin
  TargetName := Target;

  IObject := CreateComObject(CLSID_ShellLink) ;
  ISLink := IObject as IShellLink;
  IPFile := IObject as IPersistFile;

  with ISLink do
  begin
    SetPath(pChar(TargetName)) ;
    SetWorkingDirectory(pChar(ExtractFilePath(TargetName))) ;
    SetArguments(PWChar(Param));
    SetDescription(PWChar(Description));
  end;

  {
  // if we want to place a link on the Desktop
  SHGetSpecialFolderLocation(0, CSIDL_DESKTOPDIRECTORY, PIDL) ;
  SHGetPathFromIDList(PIDL, InFolder) ;
  }
  IPFile.Save(PWChar(AFile), false) ;
end;

procedure MsgBoxTimeout(Caption, Information: String; TimeoutInSeconds: integer = 5);
var
  tmrID, tmrCAP: UINT_PTR;
  pmsg: TMessage;
  msgBoxHandle: HWND;
  tickCount,
  tmo: Integer;
  F: TFOrm;
  c: TComponent;
  procedure CloseCallback(wnd: HWND; msg: UINT; event: UINT_PTR; ticks: DWORD); stdcall;
  var
    activeWnd: HWND;
  begin
    KillTimer(wnd, event);
    activeWnd := GetActiveWindow;
    if IsWindow(activeWnd) and IsWindowEnabled(activeWnd) then
      PostMessage(activeWnd, WM_CLOSE, 0, 0);
  end;
  procedure CaptionCallback(wnd: HWND; msg: UINT; event: UINT_PTR; ticks: DWORD); stdcall;
  var
    activeWnd,
    btnHandle: HWND;
    s,t: string;
    p:PChar;
    i: integer;
  begin
    activeWnd := GetActiveWindow;
    if IsWindow(activeWnd)
    and IsWindowEnabled(activeWnd)
    and IsWindowVisible(activeWnd) then
    begin
      btnHandle := FindWindowEx(activeWnd, 0, 'TButton', nil);
      if btnHandle<>INVALID_HANDLE_VALUE then
      begin
        GetMem(p, 100);
        GetWindowText(btnHandle, p, 99);
        s := string(p);
        FreeMem(p, 100);
        if s<>'' then
        begin
          delete(s,1,5);
          delete(s, length(s), 1);
          // SetWindowText(activeWnd, s);
          i := _i(s)-1;
          if i<=0 then
            i := 0;
          SetWindowText(btnHandle, PChar('OKE ('+_s(i)+')'));
        end;
      end;
    end
    else
      KillTimer(wnd, event);
  end;
begin
  tmo := TimeoutInSeconds;
  tickCount := 0;
  if tmo<=1 then
    tmo := 5;
  tmrID := SetTimer(0, 0, tmo*1000, @CloseCallback);
  if tmrID<>0 then
    tmrCAP := SetTimer(0, 0, 1000, @CaptionCallback);
  f := TForm(CreateMessageDialog(Information, mtInformation, [mbOK], mbOK));
  msgBoxHandle := f.Handle;
  try
    c := f.FindComponent('Ok');
    if c<>nil then
    begin
      TButton(c).Caption := 'OKE ('+_s(tmo-1)+')';

    end;
    F.Caption := 'Informasi';
    f.ShowModal;
  finally
    F.Free;
  end;
  if tmrCAP<>0 then
    KillTimer(0, tmrCAP);
  if tmrID<>0 then
    KillTimer(0, tmrID);
end;

function _dir;
begin
  Result := ExtractFileDir(FileOrDirName);
end;

function _path;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFileDir(FileOrDirName));
end;

function _appDataPath;
var
  path: array[0..MAX_PATH] of char;
begin
  Result := AppPath(false)+APP_NAME_WITH_VERSION+'-config';
  if not DirectoryExists(Result) then
    ForceDirectories(Result);
  exit;
  {JokoRivai - May change according to Win8 (and newer) docs}
  SHGetFolderPath(0, CSIDL_COMMON_APPDATA, 0, SHGFP_TYPE_CURRENT, @path);
  Result := IncludeTrailingPathDelimiter(path)+APP_NAME_WITH_VERSION;
  if not DirectoryExists(Result) then
    ForceDirectories(Result);
end;

function WordReplaceTexts(WordFile: String; ReplaceParams: TStringList): boolean; overload;
const
  wdFindContinue = 1;
  wdReplaceOne = 1;
  wdReplaceAll = 2;
  wdDoNotSaveChanges = 0;
var
  table,
  wordapp,
  WordDoc : OLEVariant;
  v, tmpFile: String;
  i: integer;
begin
  Result := False;
  if not FileExists(WordFile) then
    exit;
  try
    WordApp := CreateOleObject('Word.Application');
    // wordapp.displayAlerts := false;
    wordapp.Visible:=false;
    WordDoc:=WordApp.Documents.Open(WordFile);
    WordApp.Selection.Find.ClearFormatting;
    WordApp.Selection.Find.Replacement.ClearFormatting;
    for i := 0 to ReplaceParams.Count-1 do
    begin
      v := ReplaceParams.ValueFromIndex[i];
      {
      if v = '' then
        v := ' - ';
      }
      WordApp.Selection.Find.Execute(
        ReplaceParams.Names[i], // text to find
        True,                   // match case
        False,                  // whole world
        False,                  // match wildcards
        False,                  // match sounds like
        False,                  // match all words form
        True,                   // forward
        1,                      // wrap
        False,                  // format
        v,
                                // replaceWith,
        2                       //
      );
      Application.processmessages;
    end;
    WordDoc.Save;
    wordapp.quit({OleVariant(False)});
    WordDoc := Unassigned;
    WordApp := Unassigned;
    Result := true;
  except

  end;
end;

function WordReplaceTexts(WordApp, WordDoc: OLEVariant; ReplaceParams: TStringList): boolean; overload;
const
  wdFindContinue = 1;
  wdReplaceOne = 1;
  wdReplaceAll = 2;
  wdDoNotSaveChanges = 0;
var
  v, tmpFile: String;
  i: integer;
begin
  Result := False;
  try
    WordApp.Selection.Find.ClearFormatting;
    WordApp.Selection.Find.Replacement.ClearFormatting;
    for i := 0 to ReplaceParams.Count-1 do
    begin
      v := ReplaceParams.ValueFromIndex[i];
      WordApp.Selection.Find.Execute(
        ReplaceParams.Names[i], // text to find
        True,                   // match case
        False,                  // whole world
        False,                  // match wildcards
        False,                  // match sounds like
        False,                  // match all words form
        True,                   // forward
        1,                      // wrap
        False,                  // format
        v,
                                // replaceWith,
        2                       //
      );
      Application.processmessages;
    end;
    WordDoc.Save;
    Result := true;
  except

  end;
end;

function OpenWordFile(WordFile: String; var WordApp, WordDoc: OleVariant): Boolean;
begin
  Result := False;
  try
    WordApp := CreateOleObject('Word.Application');
    // wordapp.Visible:=false;
    WordDoc:=WordApp.Documents.Open(WordFile);
    Result := true;
  except

  end;
end;

function WordShowReport(WordFile: String; ShowAsPreview: Boolean = false): boolean; overload;
const
  wdFindContinue = 1;
  wdReplaceOne = 1;
  wdReplaceAll = 2;
  wdDoNotSaveChanges = 0;
var
  table,
  wordapp,
  WordDoc : OLEVariant;
  tmpFile: String;
  i: integer;
begin
  Result := False;
  if not FileExists(WordFile) then
    exit;

  try
    WordApp := CreateOleObject('Word.Application');
    // wordapp.displayAlerts := false;
    wordapp.Visible:=false;
    WordDoc:=WordApp.Documents.Open(WordFile);
    wordapp.Visible:=true;
    if ShowAsPreview then
      WordDoc.PrintPreview;
    WordDoc := Unassigned;
    WordApp := Unassigned;
    result := true;
  except

  end;
end;

function WordShowReport(WordDoc, WordApp: OleVariant; ShowAsPreview: Boolean = false): boolean; overload;
const
  wdFindContinue = 1;
  wdReplaceOne = 1;
  wdReplaceAll = 2;
  wdDoNotSaveChanges = 0;
var
  tmpFile: String;
  i: integer;
begin
  Result := False;
  try
    // wordapp.displayAlerts := false;
    // wordapp.Visible:=true;
    if ShowAsPreview then
      WordDoc.PrintPreview;
    result := true;
  except

  end;
end;

function ExcelShowReport(ExcelFile: String; ShowAsPreview: Boolean = false): boolean;
const
  wdFindContinue = 1;
  wdReplaceOne = 1;
  wdReplaceAll = 2;
  wdDoNotSaveChanges = 0;
var
  table,
  xl,
  xld,
  xsheet : OLEVariant;
  tmpFile: String;
  i: integer;
begin
  Result := False;
  if not FileExists(ExcelFile) then
    exit;

  try
    xl := CreateOleObject('Excel.Application');
    xld := XL.workbooks.open(ExcelFile);
    // xsheet := xld.WorkSheets[1];
    // xsheet.Visible:=true;
    if ShowAsPreview then
      xl.PrintPreview;
    xld := Unassigned;
    xl := Unassigned;
    result := true;
  except

  end;
end;

function ExcelMergeCells;
begin
  Result := WorkSheet.range[RangeStr];
  Result.merge;
end;
function ExcelMergeAndCenter;
begin
  Result := ExcelMergeCells(WorkSheet, RangeStr);
  Result.HorizontalAlignment := xlHAlignCenter;
  Result.VerticalAlignment := xlVAlignCenter;
 end;

function WordCombineFiles;
const
  wdFindContinue = 1;
  wdReplaceOne = 1;
  wdReplaceAll = 2;
  wdDoNotSaveChanges = 0;
  wdStory = $00000006;
  PageBreak = $00000001;
var
  table,
  wordapp,
  WordDoc : OLEVariant;
  tmpFile: String;
  i: integer;
begin
  Result := False;
  if not FileExists(AFile1) then
    exit;
  if not FileExists(AFile2) then
    exit;
  if FileExists(AOutputFile) then
    DeleteFile(AOutputFile);
  try
    WordApp := CreateOleObject('Word.Application');
    wordapp.displayAlerts := false;
    wordapp.Visible:=false;
    WordDoc:=WordApp.Documents.Open(AFile1);
    wordapp.selection.endkey(wdStory);
    if UsePageBreak then
      WordApp.selection.InsertBreak(PageBreak);
    wordapp.selection.insertFile(Afile2);
    WordDoc.saveAs(AOutputFile);
    wordapp.quit({OleVariant(False)});
    WordDoc := Unassigned;
    WordApp := Unassigned;
    result := true;
  except

  end;
end;

procedure ScreenBussy;
begin
  ___OldScreenCursor:= Screen.Cursor;
  Screen.Cursor := crBussy;
end;

procedure ScreenIdle;
begin
  Screen.Cursor := ___OldScreenCursor;
end;

function InitRecordsetFlags;
begin
  Result := False;
  // ShowMessage('OK');
  try
    ExecSQL('create table if not exists `udef_recordset_flags`( '+
               'rsf_table varchar(75) not null, '+
               'rsf_rec_id int(20) not null default 0, '+
               'rsf_rec_flag varchar (20) null ) ENGINE=InnoDB;')
      .Free;
    Result := True;
  except

  end;
end;

procedure SetRecordFlag(const ATableOrGroupName: String; const ARecordID: Int64; const aFlag: String);
var
  j: Integer;
  q: TUniQuery;
begin
  InitRecordsetFlags(ATableOrGroupName);
  try
    q := ExecSQL('select count(*) from `udef_recordset_flags` where rsf_table = '+_q(ATableOrGroupName)+
                 ' and rsf_rec_id = '+_s(ARecordID));
    j := q.Fields[0].AsInteger;
    q.Close;
    if j>0 then
      q.SQL.Text :=
                 'update `udef_recordset_flags` set rsf_rec_flag = ' + _q(aFlag) +
                 ' where rsf_table = ' + _q(ATableOrGroupName) +
                 ' and rsf_rec_id = '  + _s(ARecordID)
    else
      q.SQL.Text :=
                 'insert into `udef_recordset_flags` (rsf_table, rsf_rec_id, rsf_rec_flag) '+
                 'values ('+_q(ATableOrGroupName)+', '+_s(ARecordID)+','+_q(aFlag)+')';
    q.Execute;
    q.Free;
  except

  end;
end;

procedure ClearRecordsetFlags(const ATableOrGroupName: String);
begin
  ExecSQL('delete from `udef_recordset_flags` where rsf_table = '+_q(ATableOrGroupName))
    .Free;
end;

function  WarnForEmpty(const AText: String): Boolean; overload;
begin
  Result := not (trim(Atext) <> '');
  if Result then
    Application.MessageBox('Data kosong!','Warning', mb_ICONHAND);
end;

function  WarnForEmpty(const ANumber: Int64): Boolean; overload;
begin
  Result := not (ANumber <> 0);
  if Result then
    Application.MessageBox('Data tidak boleh NOL!','Warning', mb_ICONHAND);
end;

function  WarnForEmpty(const ANumber: Double): Boolean; overload;
begin
  Result := not (ANumber <> 0);
  if Result then
    Application.MessageBox('Data tidak boleh NOL!','Warning', mb_ICONHAND);
end;

function  WarnForEmpty(Memo: TMemo): boolean; overload;
var
  c1, c2: TColor;
  s: string;
begin
  s := Memo.Text;
  Result := not (s.trim()<>'');
  if Result then
  begin
    c1 := Memo.Color;
    c2 := Memo.Font.Color;
    Memo.Color := clRed;
    Memo.Font.Color := clWhite;
    Application.MessageBox('Data tidak boleh kosong!','Warning', mb_ICONHAND);
    Memo.Color := c1;
    Memo.Font.Color := c2;
    Memo.SetFocus;
    Memo.SelectAll;
  end;
end;

procedure InitAirpotsCache;
begin
  if Assigned(_AirPortsCache) then
  begin
    _AirPortsCache.Refresh;
    //ShowMessage('OK');
  end
  else
  begin
    _AirPortsCache := ExecSQL('select id, nama, iata, country_iso2 from sys_airport order by id asc');
    //ShowMessage('Open');
  end;
end;

procedure CleanupAirportCache;
begin
  if Assigned(_AirPortsCache) then
    FreeAndNil(_AirPortsCache);
end;

function RefineDBErrorMessage;
begin
  Result := AError;
end;

function  MD5;
var
  _md5 : TIdHashMessageDigest5;
begin
  _md5    := TIdHashMessageDigest5.Create;
  if AText = '' then
    Result := LowerCase(_md5.HashStringAsHex(DateTimeToStr(now)
      +FloatToStr(Random(9388)/random(7366))
      +FloatToStr(Random(8377)/random(3663))
      ))
  else
    Result := LowerCase(_md5.HashStringAsHex(Atext));
  _md5.Free;
end;

function  RandomPassword(const ALength: Integer): String;
var
  i,r: Integer;
  s1,
  s2: String;
  ap: array[0..1] of String;
begin
  s1 := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@!$%#&(-+_){}[];.,';
  s2 := s1;
  ap[0] := s1;
  ap[1] := s2;
  Randomize;
  i := 0;
  while i < ALength do
  begin
    r := 0;
    repeat r := Random(length(s1)); until (r>0);
    Result := Result + ap[random(2)][r];
    inc(i);
  end;
end;

procedure CleanupTempTables;
var
  uq:TUniQuery;
  ss: TStringList;
begin
  (*
  ScreenBussy;
  ss := TStringList.Create;
  try
    uq:= execSQL('select t.TABLE_NAME from information_schema.`TABLES` t where t.TABLE_SCHEMA = DATABASE() '+
        	' and upper(t.TABLE_TYPE) = ''BASE TABLE'' and ( '+
          ' (t.TABLE_NAME like '+ _q('%'+ASessionID+'%')+') '+
          _iif(ClearSessionTables,
            {if true: } ' or (t.TABLE_NAME like '+ _q('tbl_neraca%')+')',
            {if false: } ''
          )+
          ' )');
    if not uq.IsEmpty then
    begin
      uq.First;
      while not uq.Eof do
      begin
        ss.Add('drop table if exists `'+uq.Fields[0].AsString+'`;');
        uq.Next;
      end;
    end;
    uq.Close;
    uq.Free;
    if ss.Count>0 then
    begin
      execSQL(ss);
      //ShowText(ss.Text);
    end;
  finally
    ss.Free;
    ScreenIdle;
  end;
  *)
end;

procedure BlobFromPng(Field: TBlobField; PNG: TPngImage);
var
  st: TMemoryStream;
begin
  if not Assigned(PNG) then
    ShowMessage('na.');
  if PNG = nil then
    ShowMessage('nil');
  st := TMemoryStream.Create;
  try
    st.Position := 0;
    try
      PNG.SaveToStream(st);
      st.SaveToFile('c:\tesdata.bmp');
      Field.LoadFromStream(st);
    except
      ShowMessage('Parah masbro...');
    end;
  finally
    st.Free;
  end;
end;

function  PNGFromBlob(Field: TBlobField): TPngImage;
var
  st: TBlobStream;
begin
  Result := TPngImage.Create;
  st := TBlobStream.Create(Field, bmRead);
  try
    st.Position := 0;
    if st.Size > 0 then
      Result.LoadFromStream(st);
  finally
    st.Free;
  end;
end;

function GetUnitLogo;
var
  b: TPngImage;
  q: TUniQuery;
begin
  Result := TPngImage.Create;
  try
    q := execSQL('select logo from sys_unit where kode = '+_q(KodeUnit));
    b := PNGFromBlob(TBlobField(q.Fields[0]));
    q.Free;
    if Assigned(b) then
    begin
      if (b.Width>0) and (b.Height>0) then
        Result.Assign(b)
      else
      begin
        if FileExists(DefaultLogoPath) then
        begin
          Result.LoadFromFile(DefaultLogoPath);
          //ShowMessage(DefaultLogoPath);
        end;
      end;
    end
    else
    begin

    end;
  finally
    b.Free;
  end;
end;


(*
procedure ResizeBitmap;
var
  p: TBItmap;
  m: Integer;
begin
  m := Margin;
  if m<0 then m:=0;
  if (m>H) or (m>W) then m := 0;
  p:= TBitmap.Create;
  try
    if Assigned(b) then
    begin
      p.Width := W;
      p.Height:= H;
      if m>0 then
      begin
        with p.Canvas.Pen do
        begin
          Style := psSolid;
          Width := m;
          Color := clBlack;

        end;
        p.Canvas.PenPos:= Point(1,1);
        p.Canvas.LineTo(W,1);
        p.Canvas.LineTo(W,H);
        p.Canvas.LineTo(1,H);
        p.Canvas.LineTo(1,1);
      end;
      if StretchBlt(
        p.Canvas.Handle,
        m,m,W-(m*2), H-(m*2),
        b.Canvas.Handle,
        0,
        0,
        b.Width, b.Height,
        SRCCOPY
      ) then
        b.Assign(p);
    end;
  finally
    p.Free;
  end;
end;

*)

(*
procedure ReplaceColor;
var
  i,j: Integer;

  r, g, b: Integer;
  tLow, tHigh,
  c: TColor;
begin
  if Assigned(bmp) then
  begin
    for i := 0 to bmp.Width-1 do
    begin
      for j := 0 to bmp.Height-1 do
      begin
        c := bmp.Canvas.Pixels[i,j];
        r := GetRValue(c);
        g := GetGValue(c);
        b := GetBValue(c);
        //tLow :=
        {
        if (c>= tLow) and (c<=tHigh) then
          c := ClTarget;
        }
        if c = ClSource then
          c := ClTarget;
        bmp.Canvas.Pixels[i,j] := c;
      end;
    end;
  end;
end;
*)

function FileSize;
begin
  Result := 0;
  with TFileStream.Create(AFile, fmOpenRead) do
  begin
    try
      Result := Size;
    finally
      Free;
    end;
  end;
end;

function SystemPath;
var
  p: PChar;
begin
  GetMem(p, MAX_PATH+1);
  GetSystemDirectory(p, MAX_PATH);
  Result:= string(p);
  FreeMem(p, MAX_PATH+1);
  Result := ExcludeTrailingPathDelimiter(Result);
  if not ARemoveTrailingPathDelimiter then
    Result := Result + PathDelim;
end;

function WindowsPath;
var
  p: PChar;
begin
  GetMem(p, MAX_PATH+1);
  GetWindowsDirectory(p, MAX_PATH);
  Result:= string(p);
  FreeMem(p, MAX_PATH+1);
  Result := ExcludeTrailingPathDelimiter(Result);
  if not ARemoveTrailingPathDelimiter then
    Result := Result + PathDelim;
end;

function TempPath;
var
  p: PChar;
begin
  GetMem(p, MAX_PATH+1);
  GetTempPath(MAX_PATH, p);
  Result:= string(p);
  FreeMem(p, MAX_PATH+1);
  Result := ExcludeTrailingPathDelimiter(Result);
  if not ARemoveTrailingPathDelimiter then
    Result := Result + PathDelim;
end;

function AppPath;
begin
  if ARemoveTrailingPathDelimiter then
    Result := ExtractFileDir(Application.ExeName)
  else
    Result := ExtractFilePath(Application.ExeName);
end;

function ConfigPath;
begin
  Result := ExtractFilePath(AppPath())+'config';
end;

function TempFile(const BasePath: String = ''; const Ext: String = '.tmp'): String;
var
  s: string;
begin
  {
  if BasePath = '' then
    s := TempPath(False)
  else
  begin
    s := BasePath;
    if not DirectoryExists(s) then
    begin
      try
        ForceDirectories(s);
      except
        s := '';
      end;
    end;
  end;
  if s = '' then
    exit;
  }
  s := AppPath()+'\tmp';
  if not DirectoryExists(s) then
    ForceDirectories(s);
  s := IncludeTrailingPathDelimiter(s);
  Randomize;
  s := s + IntToStr(Random(9899))+'~';
  Randomize;
  Result := s + IntToStr(Random(765)) + Ext;
end;

function ListFilesInFolder;
var
  sr: TSearchRec;
  p: String;
begin
  Result := TStringList.Create;
  p := ExcludeTrailingPathDelimiter(Folder);
  if FindFirst(p + '\' + FileMask, faAnyFile, sr)<>0 then
    exit;
  repeat
    if (sr.Attr <> faDirectory) then
    begin
      if (sr.Name<>'.') and (sr.Name<>'..') then
      begin
        Result.Add(p+'\'+sr.Name);
      end;
    end;
  until FindNext(sr)<>0;
  FindClose(sr);
end;

procedure FocusTo;
begin
  if AControl.CanFocus and AControl.Visible and AControl.Enabled then
    if AControl.Owner is TForm then
      TForm(AControl.Owner).ActiveControl := AControl;
end;

function _INVALID_DATE;
begin
  Result := EncodeDate(1899,01,01);
end;

function PeriodeStart;
begin
  Result := 0;
  with execSQL('select min(th) as thn1 from ( '+
    'select distinct year(tanggal) as th from trans_pesanan '+
    'union select distinct year(tanggal) as th  from trans_po ) thn')
  do
  begin
    Result := Fields[0].AsInteger;
    Free;
  end;
end;

function PeriodeEnd;
begin
  Result := 0;
  with execSQL('select max(th) as thn1 from ( '+
    'select distinct year(tanggal) as th from trans_pesanan '+
    'union select distinct year(tanggal) as th  from trans_po ) thn')
  do
  begin
    Result := Fields[0].AsInteger;
    Free;
  end;
end;

function FiskalStart;
var
  s: String;
begin
  Result := EncodeDate(tahun,01,01);
  s :=  getoption(UnitKerja + 'tahunfiskal');
  if length(s)= 8 then
  begin
    try
      Result := EncodeDate(Tahun, _i(Copy(s,5,2)), _i(Copy(s,7,2)));
    except

    end;
  end;
end;

function  FloatToFinance;
begin
  if DuaAngkaBelakangKoma then
    Result := FormatFloat(FORMAT_FINANCE, F)
  else
    Result := FormatFloat(FORMAT_FINANCE2, F);
end;

function  FloatToSQL(const F:DOuble): String;
var
  fs : TFormatSettings;
begin
  fs.ThousandSeparator := ',';
  fs.DecimalSeparator  := '.';
  Result := FloatToStr(F, fs);
end;

function  FloatToIndo;
var
  x,
  tmp: String;
  i: integer;
begin
  Result := '';
  if frac(F)>0.5 then
    tmp := floattostr(trunc(abs(F+1)))
  else
    tmp := floattostr(trunc(abs(F)));
  tmp := ReverseString(tmp);
  x := '';
  for i := 1 to length(tmp) do
  begin
    x := x + tmp[i];
    if length(x)=3 then
    begin
      Result := Result + x+'.';
      x := '';
    end;
  end;
  Result := ReverseString(Result + x);
  if Result[1]='.' then
    delete(Result,1,1);
  if F<0 then
    Result := '('+Result+')';
  if endTail then
    Result := Result+',-';

end;

function  FloatToEnglish;
var
  x,
  tmp: String;
  i: integer;
begin
  Result := '';
  if frac(F)>0.5 then
    tmp := floattostr(trunc(abs(F+1)))
  else
    tmp := floattostr(trunc(abs(F)));
  tmp := ReverseString(tmp);
  x := '';
  for i := 1 to length(tmp) do
  begin
    x := x + tmp[i];
    if length(x)=3 then
    begin
      Result := Result + x+',';
      x := '';
    end;
  end;
  Result := ReverseString(Result + x);
  if Result[1]=',' then
    delete(Result,1,1);
  if F<0 then
    Result := '('+Result+')';
  if endTail then
    Result := Result+',-';

end;

Function FetchBulan;
var
  i: integer;
begin
  Result := TStringList.Create;
  Result.Clear;
  Result.BeginUpdate;
  try
    for i := 1 to 12 do
    begin
      if IndexOnly then
        Result.Add(_s(i))
      else
        Result.Add(FormatSettings .LongMonthNames[i]);
    end;
  finally
    Result.EndUpdate;
  end;
end;

procedure FetchTahun(List: TStringList);
begin
  //
end;

procedure FetchPrefix;
var
  i: integer;
  q: TUniQuery;
  sql: String;
begin
  List.Clear;
  List.BeginUpdate;
  if useAll then
    List.Add('ALL');
  sql := 'select distinct left('+_IIF(AUpperCase,'upper','')+'('+AField+'),'+ _IIF(ALength<=0, 'length('+AField+')',_s(ALength) )+') as pf from '+ATable+' order by '+AField+' '+_IIF(Asc,'asc','desc');
  //ShowMessage(sql);
  q := ExecSQL(sql);
  try
    if not q.IsEmpty then
    begin
      q.First;
      while not q.Eof do
      begin
        List.Add(q.Fields[0].AsString);
        q.Next;
      end;
    end;
  finally
    q.free;
    List.EndUpdate;
  end;
end;

procedure FetchFieldValues;
var
  q: TUniQuery;
begin
  list.Clear;
  list.BeginUpdate;
  Q := ExecSQL('select "'+AField+'" from "'+ATable+'" order by "'+AField+'" asc');
  try
    if not q.IsEmpty then
    begin
      q.First;
      while not q.Eof do
      begin
        list.Add(q.Fields[0].AsString);
        q.Next;
      end;
      if sort then
        List.Sort;
    end;
  finally
    q.Free;
    List.EndUpdate;
  end;

end;

function  FetchSysVar;
var
  q: TUniQuery;
begin
  q := execSQL('select nama from sys_variables where upper(tipe) = '+_q(_u(VarName))+' order by nama asc');
  Result := TStringList.Create;
  if not q.IsEmpty then
  begin
    q.First;
    while not q.Eof do
    begin
      Result.Add(q.Fields[0].AsString);
      q.Next;
    end;
  end;
  q.Free;
end;

function  FetchCountry;
var
  q: TUniQuery;
begin
  q := execSQL('select iso2, country from sys_country order by iso2 asc');
  Result := TStringList.Create;
  if not q.IsEmpty then
  begin
    q.First;
    while not q.Eof do
    begin
      Result.Add(q.Fields[0].AsString+' : '+q.Fields[1].AsString);
      q.Next;
    end;
  end;
  q.Free;
end;


function  FindInList;
var
  i: integer;
begin
  Result := -1;
  if List.Count = 0 then
    exit;
  for i := 0 to List.Count-1 do
  begin
    if CaseSensitif then
    begin
      if copy(List[i], 1, length(Prefix)) = Prefix then
      begin
        Result := i;
        exit;
      end;
    end
    else
    begin
      if _u(copy(List[i], 1, length(Prefix))) = _u(Prefix) then
      begin
        Result := i;
        exit;
      end;
    end;
  end;
end;

procedure EmptyDataset;
begin
  if Dataset.State in dsEditModes then
    Dataset.Cancel;
  if Dataset.IsEmpty then
    exit;
  try
    Dataset.DisableControls;
    Dataset.First;
    while not Dataset.IsEmpty do
    begin
      Dataset.Delete;
    end;
  finally
    Dataset.EnableControls;
  end;
end;

procedure FillEmptyRecord(QT: TDataset);
var
  i: integer;
begin
  if not (QT.State in [dsEdit, dsInsert]) then
    exit;
  for i := 0 to QT.FieldCount-1 do
  begin
    if (QT.Fields[i] is TFloatField)
    or (qt.Fields[i] is TNumericField)
    or (qt.Fields[i] is TIntegerField)
    or (qt.Fields[i] is TLargeintField) then
      qt.Fields[i].Value := 0
    else
    if (QT.Fields[i] is TMemoField)
    or (qt.Fields[i] is TStringField) then
      QT.Fields[i].Value := ''
    else
    if qt.Fields[i] is TDateField then
      QT.Fields[i].AsDateTime := INVALID_DATE_VALUE
    else
    if qt.Fields[i] is TDateTimeField then
      QT.Fields[i].AsDateTime := INVALID_DATETIME_VALUE
    else
    if qt.Fields[i] is TTimeField then
      QT.Fields[i].AsDateTime := INVALID_TIME_VALUE
  end;
end;


procedure RefreshDatasets;
var
  i: integer;
  dm: array of TBookmark;
begin
  if length(Datasets) = 0 then
    exit;
  SetLength(dm, length(Datasets));
  if ReOpen then
  begin
    for i := Length(Datasets) -1 downto 0 do
    begin
      //ShowMessage(Datasets[i].Name);
      if Datasets[i].Active then
      begin
        dm[i] := Datasets[i].GetBookmark;
        Datasets[i].Close;
      end;
    end;
    for i := 0 to Length(Datasets) -1 do
    begin
      Datasets[i].Open;
      //ShowMessage('Open '+Datasets[i].Name);
      if Datasets[i].Active then
      begin
        if Datasets[i].BookmarkValid(dm[i]) then
          Datasets[i].GotoBookmark(dm[i]);
      end;
    end;
  end
  else
  begin
    for i := Length(Datasets) -1 downto 0 do
    begin
      if Datasets[i].Active then
      begin
        dm[i] := Datasets[i].GetBookmark;
        Datasets[i].Refresh;
      end;
    end;
    for i := 0 to Length(Datasets) -1 do
    begin
      if Datasets[i].Active then
      begin
        if Datasets[i].BookmarkValid(dm[i]) then
          Datasets[i].GotoBookmark(dm[i]);
      end;
    end;
  end;
  SetLength(dm, 0);
end;

function Explode;
var
  dx : integer;
  ns : string;
  txt : string;
  delta : integer;
begin
  Result := TStringList.Create;
  delta := Length(Pemisah) ;
  txt := AText + Pemisah;

  Result.BeginUpdate;
  Result.Clear;
  try
    while Length(txt) > 0 do
    begin
      dx := Pos(Pemisah, txt) ;
      ns := Copy(txt,0,dx-1) ;

      Result.Add( ns );
      txt := Copy(txt,dx+delta,MaxInt) ;
    end;
  finally
    ns := trim(Result.Text);
    if ns = '' then
      Result.Clear;
    Result.EndUpdate;
  end;
end;

function  CommaTextToStrings;
{
var
  i: Integer;
}
begin
  Result := Explode(Atext, Delimiter);
  {
  Result := TStringList.Create;
  Result.Delimiter := Delimiter;
  Result.CommaText := Atext;
  if Result.Count > 0 then
  begin
    for i := 0 to Result.Count -1 do
    begin
      Result[i] := trim(Result[i]);
    end;
  end;
  }
end;

function  StringsToCommaText;
var
  i: integer;
begin
  Result := '';
  if List.Count = 0 then
    exit;
  for i:= 0 to List.Count-1 do
  begin
    Result := Result + _IIF(Apit<>#0,Apit,'')+List[i]+_IIF(Apit<>#0,Apit,'')+Delimiter;
  end;
  Delete(Result, length(Result),1);
end;

function  IndentAkun;
begin
  Result := lpad('', Level * 4, ' ');
  Result := Result + Akun;
end;

function  Ask;
var
  h: Integer;
  f: TForm;
  c: TComponent;
begin
  {
  if Handle = 0 then
    h := Application.Handle
  else
    h := Handle;
  Result := MessageBox(h, Pchar(Question), 'Question', MB_YESNO or  MB_ICONQUESTION);
  }
  f := TForm(CreateMessageDialog(Question, mtConfirmation, mbYesNo, mbYes));
  c := f.FindComponent('Yes');
  if c<>nil then TButton(c).Caption := btnYes;
  c := f.FindComponent('No');
  if c<>nil then TButton(c).Caption := btnNo;
  {
  'Yes', 'No', 'OK', 'Cancel', 'Abort', 'Retry', 'Ignore', 'All', 'NoToAll',
    'YesToAll', 'Help', 'Close');
  }
  F.Caption := 'Konfirmasi';
  Result := f.ShowModal;
  F.Free;
end;

function  Ask3Options;
var
  h: Integer;
  f: TForm;
  c: TComponent;
begin
  {
  if Handle = 0 then
    h := Application.Handle
  else
    h := Handle;
  Result := MessageBox(h, Pchar(Question), 'Question', MB_YESNO or  MB_ICONQUESTION);
  }
  f := TForm(CreateMessageDialog(Question, mtConfirmation, mbYesNoCancel, mbYes));
  c := f.FindComponent('Yes');
  if c<>nil then TButton(c).Caption := btnYes;
  c := f.FindComponent('No');
  if c<>nil then TButton(c).Caption := btnNo;
  c := f.FindComponent('Cancel');
  if c<>nil then TButton(c).Caption := btnCancel;
  if QUestion = '' then
    F.Caption := 'Konfirmasi Pilihan'
  else
    F.Caption := QUestion;
  Result := f.ShowModal;
  F.Free;
end;

procedure Warn;
var
  f: TForm;
  c: TComponent;
begin
  f := TForm(CreateMessageDialog(Warning, mtWarning, [mbOK], mbOK));
  c := f.FindComponent('Ok');
  if c<>nil then TButton(c).Caption := 'OKE';
  F.Caption := 'Peringatan';
  f.ShowModal;
  f.Free;
end;

procedure Deny;
var
  f: TForm;
  c: TComponent;
begin
  f := TForm(CreateMessageDialog(Denial, mtError, [mbOK], mbOK));
  c := f.FindComponent('Ok');
  if c<>nil then TButton(c).Caption := 'OKE';
  F.Caption := 'Error';
  f.ShowModal;
  F.Free;
end;

procedure ShowDefaultError;
begin
  Deny('Terjadi Kesalahan.');
end;

procedure Inform;
var
  f: TForm;
  c: TComponent;
begin
  f := TForm(CreateMessageDialog(Information, mtInformation, [mbOK], mbOK));
  c := f.FindComponent('Ok');
  if c<>nil then TButton(c).Caption := 'OKE';
  F.Caption := 'Informasi';
  f.ShowModal;
  F.Free;
end;

procedure TampilkanText(AText: String);
begin
  u_display_text.ShowText(AText);
end;

function  ConfirmActionWithJurnal;
begin
  Result := Ask('Proses ini akan mempengaruhi Jurnal, Buku Besar (GL) dan Laporan Keuangan.'#13'Anda yakin untuk melanjutkan?', Handle);
end;

procedure DeleteSelected;
begin

end;

function _Q;
begin
  Result := QuotedStr(AText);
end;

function _L;
begin
  Result := LowerCase(AText);
end;

function _U;
begin
  Result := UpperCase(AText);
end;

function  _i;
begin
  Result := StrToIntDef(AString,
    StrToInt64Def(AString, def)
  );
end;

function  _f(const AString:String; def:Double= 0):Double;
var
  f: TFormatSettings;
begin
  f.ThousandSeparator := ',';
  f.DecimalSeparator  := '.';
  Result := StrToFloatDef(AString, def, f);
end;


function  _s(const AValue:Int64; const Pad0Count: Integer = 0):string;
begin
  Result := IntToStr(AValue);
  if Pad0Count > Length(Result) then
    Result := lpad(Result, Pad0Count, '0');
end;

function  _s(const AValue:Double; decimals: byte = 2):string; overload;
var
  s: String;
begin
  //Result := FloatToStr(AValue);
  s := RPAd('', decimals, '0');
  Result := FormatFloat('#,#0.'+s, AValue);
  Result := _r(Result, FormatSettings .ThousandSeparator,'',[rfReplaceAll]);
  Result := _r(Result, FormatSettings .DecimalSeparator,'.',[rfReplaceAll]);
end;

function  _empty;
begin
  Result := trim(AValue) = '';
end;

function  _r;
begin
  Result := StringReplace(value, find, replaceTo, flags);
end;

function  _s(AFormat: string; ADateTime: TDateTime): String; overload;
begin
  Result := FormatDateTime(AFormat, ADateTime);
end;

function  _USentence;
begin
  Result := _U(AText[1])+copy(_L(AText),2, length(Atext)-1);
end;

function  _LSentence;
begin
  Result := _L(AText[1])+copy(AText,2, length(Atext)-1);
end;

function  _UWords(const AText: String): String;
var
  i: integer;
  ss: TStringList;
begin
  {
  Result := StringReplace( Atext, #13, ' ', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace( Result, #10, ' ', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace( Result, #9, ' ', [rfReplaceAll, rfIgnoreCase]);
  while pos('  ', Result) > 0 do
    Result := StringReplace( Result, '  ', ' ', [rfReplaceAll, rfIgnoreCase]);
  ss := TStringList.Create;
  try
    ss.Delimiter := ' ';
    ss.CommaText := Result;
    ss.
    for i:= 0 to ss.Count -1 do
    begin
      ss[i][1] := uppercase(ss[i][1]);
    end;
  finally
    ss.Free;
  end;
  }
end;

function  _LWords;
begin

end;

function  _trim(const AText: String): String;
var
  i: integer;
  function _isWhiteSpace(c: Char): Boolean;
  begin
    // Result := (C = ' ') or ((C >= #$0009) and (C <= #$000D)) or (C = #$00A0) or (C = #$0085);
    Result := (C = ' ') or ((C >= #$09) and (C <= #$0D)); // spasi, tab, enter
  end;
begin
  Result := Trim(AText);
  exit;
  Result := '';
  if AText = '' then
    exit;
  Result := AText;
  ShowMessage(Result+ ': '+ _s(Length(Result)));
  while _IsWhiteSpace(Result[1]) do
    Delete(Result,1,1);
  if Result = '' then exit;
  // i := Length(Result);
  while _IsWhiteSpace(Result[length(Result)]) do
    Delete(Result, length(Result), 1);
  // ShowMessage(Result);
end;

function  Trim;
begin
  //Result := _trim(AText);
  Result := SysUtils.Trim(AText);
end;

function  isNumbersOnly;
var
  i: integer;
begin
  Result := False;
  if AText = '' then exit;
  for i:= 1 to Length(AText) do
  begin
    if not (AText[i] in ['0'..'9']) then
    begin
      exit;
    end;
  end;
  Result := True;
end;

function  DateToSQL(const ADate: TDate):String;
begin
  Result := FormatDateTime('yyyy-MM-dd', ADate);
end;

function  DateFromSQL;
begin
  Result := EncodeDate(
    _i(Copy(ASQLDate,1,4)),
    _i(Copy(ASQLDate,6,2)),
    _i(Copy(ASQLDate,9,2))
  );
end;

function  TimeToSQL;
begin
  Result := FormatDateTime('hh:nn:ss', ATime);
end;

function  DateTimeToSQL(const ADateTime: TDateTime):String;
begin
  Result := FormatDateTime('yyyy-MM-dd hh:nn:ss', ADateTime);
end;

function  DateIndo ;

begin
  Result := _iif(Padding0, FormatDateTime('dd', ADate), FormatDateTime('d', ADate))+' '+
            // LongMonthNames[StrToInt(FormatDateTime('MM',ADate))]+' '+
            NamaBulanPanjang[_i(FormatDateTime('MM',ADate))]+' '+
            FormatDateTime('yyyy', ADate);
end;

function  DateIndoShort ;
begin
  Result := _iif(Padding0, FormatDateTime('dd/MM/yyyy', ADate), FormatDateTime('d/M/yyyy', ADate));
end;

function  DateIndoRange ;
var
  s1, s2: String;
begin
  if ADate1 = awalBulan(Adate1) then
  begin
    s1 := NamaBulanPanjang[_i(FormatDateTime('MM',ADate1))];
    if tahun(ADate1)<>tahun(ADate2) then
      s1 := s1 + ' '+ FormatDateTime('yyyy', ADate1);
  end
  else
    s1 := DateIndo(ADate1, Padding0);
  if ADate2 = awalBulan(Adate2) then
    s2 := NamaBulanPanjang[_i(FormatDateTime('MM',ADate2))]+' '+ FormatDateTime('yyyy', ADate2)
  else
    s2 := DateIndo(ADate2, Padding0);
  Result := s1 + ' s.d. '+s2;
end;

function  Usia(const TglLahir, TglKini: TDate): Integer;
begin
  Result := DateUtils.YearsBetween(TglLahir, TglKini) + 1;
end;

function  Tahun;
begin
  Result := YearOf(ADate);
end;

function  Bulan;
begin
  Result := MonthOf(ADate);
end;

function  Hari;
begin
  Result := DayOf(ADate);
end;

function  NamaBulan;
begin
  Result := FormatSettings .LongMonthNames[Bulan(ADate)];
end;

function  NamaHari(ADate: TDate): String;
begin
  Result := FormatSettings .LongDayNames[DayOfWeek(ADate)];
end;

function  AwalTahun(ADate: TDate): TDate; overload;
var
  y: Word;
begin
  y := tahun(ADate);
  Result := AwalTahun(y);
end;

function  AwalTahun(ATahun: Word): TDate; overload;
begin
  Result := EncodeDate(ATahun,01,01);
end;

function  AwalBulan(ADate: TDate): TDate;
begin
  Result := StartOfTheMonth(ADate);
end;

function  AkhirBulan(ADAte: TDate): TDate; overload;
begin
  Result := EndOfTheMonth(ADAte);
end;

function  AkhirBulan(ATahun, ABulan: Word): Word; overload;
begin
  Result := DaysInAMonth(ATahun, ABulan);
end;

function  AkhirTahun(ADate: TDate): TDate;
begin
  Result := EndOfTheYear(ADate);
end;


function JangkaBulan(Date1, Date2: TDateTime): Integer;
var
  t,
  dt1, dt2: TDateTime;
  y1, y2,
  m1, m2,
  d1, d2: Word;
  jmlBln: Integer;
begin
  Result := 0;
  dt1 := Date1;
  dt2 := Date2;

  if dt1 > dt2 then
  begin
    t := dt1;
    dt1 := dt2;
    dt2 := t;
  end;
  DecodeDate(dt1, y1, m1, d1);
  DecodeDate(dt2, y2, m2, d2);
  // hitung selisih bulan:
  jmlBln := ((y2-y1)*12) + (m2-m1);
  if d2>d1 then
    inc(jmlBln);
  Result := jmlBln;
  if date1>date2 then
    Result := Result * -1;
end;

function JangkaHari(Date1, Date2: TDateTime): Integer;
var
  t,
  dt1, dt2: TDateTime;
  y1, y2,
  m1, m2,
  d1, d2: Word;
  jmlBln: Integer;
begin
  Result := 0;
  dt1 := Date1;
  dt2 := Date2;

  if dt1 > dt2 then
  begin
    t := dt1;
    dt1 := dt2;
    dt2 := t;
  end;
  result := DaysBetween(dt1, dt2);
end;

// function WaktuKini(Tahun: Integer): TDateTime;


function  SexBySalutation;
var
  r: String;
begin
  r := _l(ASal);
  if (r = 'mr.')
  or (r = 'tn.')
  or (r = 'mstr.')
  or (trim(r) = '')
  then
  begin
    if PrefixOnly then
      Result := 'L'
    else
      Result := 'Laki-Laki';
  end
  else
  begin
    if PrefixOnly then
      Result := 'P'
    else
      Result := 'Perempuan';
  end;
end;

function  BulatAtas ;
var
  f: double;
begin
  Result := value;
  if NDigitFaktor <= 0 then
    exit;
  f := value / Power(10, NDigitFaktor);
  Result := trunc(f) * Power(10, NDigitFaktor);
  f := frac(f);
  if f > 0 then
    Result := Result + Power(10, NDigitFaktor);
end;

function  BulatBawah;
var
  f: double;
begin
  Result := value;
  if NDigitFaktor <= 0 then
    exit;
  f := value / Power(10, NDigitFaktor);
  Result := trunc(f) * Power(10, NDigitFaktor);
end;

///////////////////////

function  KodeRekByLevel;
begin
  case ALevel of
    1: Result := StripDots(ARek)[1];
    2: Result := Copy(StripDots(ARek),1,2);
    3: Result := Copy(StripDots(ARek),1,4);
    4: Result := Copy(StripDots(ARek),1,6);
    5: Result := Copy(StripDots(ARek),1,8);
  end;
end;

function  LevelByKodeRek;
var
  s: String;
begin
  s := StripDots(ARek);
  s := rpad(s, 8, '0');
  Result := -1;
  {
  Result := ExecSQLAndFetchOneValueAsInteger(
    'select tingkat from v_coa_2 where full_kode = '+_q(s),
    -1);
  }
  if copy(s,2,8) = '0000000' then Result := 1 else
  if copy(s,3,8) = '000000' then Result := 2 else
  if copy(s,5,8) = '0000' then Result := 3 else
  if copy(s,7,8) = '00' then Result := 4 else
    Result := 5;
end;

function  FormatKodeRek;
var
  s: String;
  i: integer;
begin
  i := LevelByKodeRek(ARek);
  s := stripdots(ARek);
  if full then
  begin
    case i of
      1: Result := s[1]+'.0.00.00.00';
      2: Result := s[1]+'.'+s[2]+'.00.00.00';
      3: Result := s[1]+'.'+s[2]+'.'+copy(s,3,2)+'.00.00';
      4: Result := s[1]+'.'+s[2]+'.'+copy(s,3,2)+'.'+copy(s,5,2)+'.00';
      5: Result := s[1]+'.'+s[2]+'.'+copy(s,3,2)+'.'+copy(s,5,2)+'.'+copy(s,7,2);
      else
        Result := '';
    end;
  end
  else
  begin
    case i of
      1: Result := s[1];
      2: Result := s[1]+'.'+s[2];
      3: Result := s[1]+'.'+s[2]+'.'+copy(s,3,2);
      4: Result := s[1]+'.'+s[2]+'.'+copy(s,3,2)+'.'+copy(s,5,2);
      5: Result := s[1]+'.'+s[2]+'.'+copy(s,3,2)+'.'+copy(s,5,2)+'.'+copy(s,7,2);
      else
        Result := '';
    end;
  end;
end;

function  StripDots;
begin
  Result := _r(AText, '.','',[rfReplaceAll]);
end;

procedure _SaveAllUIControls(ApplicationID: String; COntrolType :TUIControlsTypes);
var
  tableexists: Boolean;
  i, j, k: integer;
  c: TControl;
  ls: TStringList;
  mm: TMainMenu;
  q : TUniQuery;
  s: string;
begin
  tableexists :=ExecSQLAndFetchOneValueAsInteger('select count(*) from information_schema.tables where table_name = '+_q(UCCOntrolUACTableName))>0;
  if not tableexists then
  begin
    execsql('create table '+UCCOntrolUACTableName+' ('+
      'app_id varchar(50) not null default '''','+
      'form_name varchar(50) not null default '''','+
      'item_type varchar(10) not null default '''','+
      'item_name varchar(50) not null default '''','+
      'enabled char(1) not null default ''N'''+
      ')WITH ( OIDS=FALSE );').Free;
  end;
  ls := TStringList.Create;
  q := execSQL('select * from log_02_uac_items where app_id = '+_q(ApplicationID));
  try
    for i := 0 to Application.ComponentCount-1 do
    begin
      s := Application.Components[i].ClassName+#9+Application.Components[i].Name;
      if Assigned(Application.Components[i].Owner) then
        s := s+#9+Application.Components[i].Owner.Name
      else
        s := s+#9'NIL';
      if Application.Components[i] is TControl then
      begin
        if Assigned(TControl(Application.Components[i]).Parent) then
          s := s + #9+TControl(Application.Components[i]).Parent.Name
        else
          s := s+#9'NIL';
      end;
      ls.Add(s);
    end;
    ls.SaveToFile('d:/test-list-uac.txt');
    if uictMainMenu in COntrolType then
    begin
      for i:= 0 to  Application.ComponentCount-1 do
      begin
        if Application.Components[i] is TForm then
        begin
          for j := 0 to TForm(Application.Components[i]).ComponentCount-1 do
          begin
            if TForm(Application.Components[i]).Components[j] is TMainMenu then
            begin
              mm := TMainMenu(TForm(Application.Components[i]).Components[j]);
              // for k := 0 to mm.Items.Count-1
              // if not q.Locate('app_id;form_name;item_name)
            end;
          end;
        end;
      end;
    end;
  finally
    q.Free;
    ls.Free;
  end;
end;

procedure _LoadAllUIControls(ApplicationID: String; COntrolType :TUIControlsTypes; TreeView: TTreeView);
begin

end;

procedure SetGlobalConnection;
begin
  _GLOBAL_CONNECTION := Connection;
end;

function  GetGlobalConnection;
begin
  Result := _GLOBAL_CONNECTION;
end;

function  Query;
begin
  Result:= TUniQuery.Create(Application);
  Result.Connection := GetGlobalConnection;
end;

function  ExecSQL(const ASQL: String): TUniQuery;
var
  Qr: TUniQuery;
  s : String;
begin
  s := UpperCase(trim(ASQL));
  if s = '' then
    raise Exception.Create('SQL is empty.');
  Result:= TUniQuery.Create(Application);
  Result.Connection := GetGlobalConnection;
  Result.SQL.Text := ASQL;
  s := copy(s,1,5);
  if (s = 'INSERT')                  //
  and (pos(ASQL,'RETURNING ')>0) // PostgreSQL only
  then
    Result.Open
  else
  if (s = 'UPDAT')
  or (s = 'INSER')
  or (s = 'DELET')
  or (s = 'ALTER')
  or (s = 'CREAT')
  or (s = 'CALL ')
  or (s = 'DROP ') then
    Result.Execute
  else
  if (s = 'SELEC')
  or (s = 'CALL ')
  or (s = 'OPEN ')
  or (s = 'SHOW ')
  or (s = 'WITH ')
  or (s = 'DESCR')
  then
    Result.Open;
end;

function  ExecSQL(const ASQL: TStringList): Boolean;
var
  Qr: TUniScript;
  s : String;
begin
  Result := False;
  Qr  := TUniScript.Create(Application);
  try
    Qr.Connection := GetGlobalConnection;
    qr.SQL.Assign(ASQL);
    try
      qr.Execute;
      Result := True;
    Except
      Result := False;
    end;
  finally
    qr.Free;
  end;
end;

function  ExecFunction;
var
  q: TUniQuery;
begin
  //InputBox('','',AFunction);
  q:= ExecSQL(AFunction);
  if q.Fields.Count > 0 then
    case resultType of
      ftString      : Result := q.Fields[0].AsString;
      ftInteger     : Result := q.Fields[0].AsInteger;
      ftFloat       : Result := q.Fields[0].AsFloat;
      ftDate        : Result := q.Fields[0].AsDateTime;
    end;
  q.Close;
  q.Free;
end;

function  ExecSQLAndFetchOneValueAsString(const SQL: String; const Default:String = ''): String;
begin
  Result:= Default;
  try
    with ExecSQL(sql) do
    begin

      if not IsEmpty then
      begin
        First;
        Result := Fields[0].AsString;
      end;
      Free;
    end;
  except

  end;
end;

function  ExecSQLAndFetchOneValueAsInteger(const SQL: String; const Default:Integer = 0): Integer;
begin
  Result:= Default;
  try
    with ExecSQL(sql) do
    begin
      if not IsEmpty then
      begin
        First;
        Result := Fields[0].AsInteger;
      end;
      Free;
    end;
  except

  end;
end;

function  ExecSQLAndFetchOneValueAsFloat(const SQL: String; const Default:Double = 0.00): Double;
begin
  Result:= Default;
  try
    with ExecSQL(sql) do
    begin
      if not IsEmpty then
      begin
        First;
        Result := Fields[0].AsFloat;
      end;
      Free;
    end;
  except

  end;
end;

function  GetEnumFieldValuesAsArray;
var
  SQL: String;
  List: TStringList;
  i: integer;
begin
  try
    List := GetEnumFieldValuesAsStrings(AFieldType, Filter);
    try
      SetLength(Result, List.Count);
      for i:= 0 to List.Count-1 do
        Result[i] := List[i];
    finally
      List.Free;
    end;
  except
    SetLength(Result, 0);
  end;
end;

function  GetEnumFieldValuesAsStrings;
var
  SQL: String;
begin
  Result := TStringList.Create;
  if Filter = '' then
    SQL := 'SELECT unnest(enum_range(NULL::"'+AFieldType+'")) e order by e asc;'
  else
    SQL := 'with x as (SELECT unnest(enum_range(NULL::"'+AFieldType+'"))::text '+AFieldType+') select '+AFieldType+' from x where '+filter+' order by '+AFieldType+' asc;';
  // ShowText(sql);
  try
    with ExecSQL(SQL) do
    begin
      if not IsEmpty then
      begin
        First;
        while not eof do
        begin
          Result.Add(Fields[0].AsString);
          Next;
        end;
      end;
    end;
  except
    raise;
  end;
end;

function  GetOption;
var
  d: string;
begin
  if not LocalFile then
    result := ExecFunction('select get_option( '+
            _Q(Opsi) +')'
            )
  else
  begin
    Result := '';
    with TStringList.Create do
    begin
      try
        d := _appDataPath()+'\_options.cfg';
        if FileExists(d) then
        begin
          LoadFromFile(d);
          Text := XorData(Text);
          Result := Values[Opsi];
        end;
      finally
        Free;
      end;
    end;
  end;
end;

function  SetOption;
var
  d: String;
begin
  if not LocalFile then
    result := ExecFunction('select set_option( '+
            _Q(Opsi)+','+
            _Q(value) +')'
            )
  else
  begin
    Result := 'N';
    with TStringList.Create do
    begin
      try
        d := _appDataPath()+'\_options.cfg';
        if FileExists(d) then
        begin
          LoadFromFile(d);
          Text := XorData(Text);
        end;
        Values[Opsi] := value;
        // Inform(Opsi+'='+Value);
        Text := XorData(Text);
        SaveToFile(d);
        Result := 'Y';
      finally
        Free;
      end;
    end;
  end;
end;

function  GetMultipleOptions;
var
  d: string;
  i: integer;
begin
  SetLength(Result, 0);
  if not LocalFile then
  begin
    d := '';
    for i := 0 to length(OptionNames)-1 do
      d := d+', get_option( '+_Q(OptionNames[i]) +')';
    delete(d,1,1);
    d := 'select '+d;
    with ExecSQL(d) do
    begin
      if not IsEmpty then
      begin
        SetLength(Result, FieldCount);
        first;
        for i := 0 to FieldCount-1 do
        begin
          Result[i] := Fields[i].AsString;
        end;
      end;
      Free;
    end;
  end
  else
  begin
    with TStringList.Create do
    begin
      try
        d := _appDataPath()+'\_options.cfg';
        if FileExists(d) then
        begin
          LoadFromFile(d);
          Text := XorData(Text);
          setlength(Result, length(OptionNames));
          for i := 0 to Length(OptionNames)-1 do
          begin
            if IndexOfName(OptionNames[i])<>-1 then
              Result[i] := Values[OptionNames[i]];
          end;
        end;
      finally
        Free;
      end;
    end;
  end;
end;

function  SetMultipleOptions;
var
  d: string;
  i: integer;
begin
  Result := false;
  if length(OptionNames)<>Length(OptionValues) then
    exit;
  if not LocalFile then
  begin
    d := '';
    for i := 0 to length(OptionNames)-1 do
      d := d+', set_option( '+_Q(OptionNames[i]) +', '+_q(OptionValues[i])+')';
    delete(d,1,1);
    d := 'select '+d;
    try ExecSQL(d).free; Result := true; except end;
  end
  else
  begin
    with TStringList.Create do
    begin
      try
        d := _appDataPath()+'\_options.cfg';
        if FileExists(d) then
        begin
          LoadFromFile(d);
          Text := XorData(Text);
        end;
        for i := 0 to Length(OptionNames)-1 do
        begin
          Values[OptionNames[i]] := OptionValues[i];
        end;
        Text := XorData(Text);
        SaveToFile(d);
      finally
        Free;
      end;
    end;
  end;
end;

function  DelOption;
var
  d: string;
begin
  if not LocalFile then
    result := ExecFunction('select delete_option( '+
            _Q(Opsi) +')'
            )
  else
  begin
    Result := 'N';
    with TStringList.Create do
    begin
      try
        d := _appDataPath()+'\_options.cfg';
        if FileExists(d) then
        begin
          LoadFromFile(d);
          Text := XorData(Text);
        end;
        if IndexOfName(opsi) > 0 then
          Delete(IndexOfName(opsi));
        Text := XorData(Text);
        SaveToFile(d);
      finally
        Free;
      end;
    end;
  end;
end;

function  GenUID;
begin
  result := ExecFunction('select gen_uid('+_q(IntToStr(Tahun))+','+_q(Skpd)+');');
end;

procedure StartTrans;
begin
  with GetGlobalConnection() do
    if not InTransaction then
      StartTransaction;
end;

procedure CommitTrans;
begin
  with GetGlobalConnection() do
  begin
    if InTransaction then
    begin
      try
        Commit;
      except on e: exception do
        Deny('Terjadi error saat menyimpan transaksi:'#13+e.Message);
      end;
    end;
  end;
end;

procedure RollBackTrans;
begin
  with GetGlobalConnection() do
    if InTransaction then
      Rollback;
end;


function  INVALID_DATE: TDateTime;
begin
  //Result := EncodeDateTime(1900,12,31,0,0,0,0);
  // Result := INVALID_DATE_VALUE;
  Result := EncodeDateTime(1899, 12, 30, 0, 0, 0, 0);
end;

function  ServerDateTime: TDateTime;
begin
  with ExecSQL('select current_timestamp::timestamp without time zone') do
  begin
    Result := Fields[0].AsDateTime;
    Free;
  end;
end;

function  ServerDate: TDateTime;
begin
  with ExecSQL('select current_date') do
  begin
    Result := Fields[0].AsDateTime;
    Free;
  end;
end;

function  XorData(AText: String): String;
{var
  i: Integer;
begin
  Result := AText;
  if length(Result) = 0 then exit;
  for i := 1 to length(Result) do
    Result[i] := chr(ord(result[i]) xor 67);
}
(*
const
  base = 'cDd9!@#YyZzHh$- EeFfGUuVvW}\~wXx].,/A1aRrSsTt012BbC345678%^g&*()_+[{`:?;"'#13#10#9;
var
  x: string;
  i,p: integer;
begin
  x := AText;
  for i := 1 to length(x) do
  begin
    p := pos(x[i], base);
    if p>0 then
      x[i] := base[76-p];
  end;
  Result := x;
  *)
  var
  i: Integer;
  _x: string;
begin
  Result := '';
  if length(AText)=0 then
    exit;
  if (Atext[1]='#') then
  //encrypted
  begin
    _x := Atext;
    delete(_x,1,1);
    while not (_x[length(_x)] in ['0'..'9']) do
      delete(_x, length(_x),1);
    if Odd(length(_x)) then
      exit;
    if (length(_x) mod 4)<>0 then
      exit;
    while length(_x)>0 do
    begin
      Result := Result+chr(StrToInt('$'+copy(_x,1,4)) xor 67);
      delete(_x,1,4);
    end;
  end
  else
  //plain
  begin
    for i := 1 to length(AText) do
      Result := Result + IntToHex(ord(AText[i]) xor 67, 4);
    Result := '#'+Result;
  end
  ;
end;

function  GenerateTransNum;
var
  l: Integer;
  s: string;
begin
  Result := '';
  if length(IDDesa)<>10 then
    raise Exception.Create('Kode desa harus 3 digit.');
  if tahun = 0 then
    raise Exception.Create('Tahun harus diisi.');
  if semester = 0 then
    raise Exception.Create('Semester harus diisi.');
  if length(Prefix)<>3 then
    raise Exception.Create('Prefix nomor harus 3 digit.');
  l := length(NamaKode);
  if (l = 0) or (l>40) then
    raise Exception.Create('Nama Kode Transaksi tidak valid, harus 1-40 karakter.');
  try
    s := 'select gen_trans_number('+
        _q(IDDesa)+'::character varying, '+
        _s(tahun)+'::smallint, '+
        _s(semester)+'::smallint, '+
        _q(namaKode)+'::character varying,'+
        _q(prefix)+'::character varying, '+
        _q(_iif(Update, 'Y','N'))+'::character(1));';
    Result := ExecFunction(s);
  except
    Result := '';
  end;
end;

function  GenerateDatasetSearchFilter(Fields: array of String; Values: array of String; useQuote: Boolean = True): String;
var
  i, j: Integer;
  p: String;
begin
  Result := '';
  if length(Fields) = 0 then
    exit;
  for i := 0 to Length(Fields)- 1 do
  begin
    if length(Values) = 0 then
      p := _IIF(useQuote,
               'upper('+Fields[i]+ ') like ' + _q(''),
               Fields[i]+' = ' + ''
           )

      // '('+Fields[i]+ '=' + _IIF(useQuote, _q(''), '') + ')'
    else
    begin
      p:= '';
      for j := 0 to length(Values) - 1 do
      begin
        //p := p + '(upper('+Fields[i]+ ') ' + _IIF(useQuote, _q(' like %'+Values[j]+'%'), ' = '+Values[j]) + ') or ';
        p := p + _IIF (
                      useQuote,
                      '(upper('+Fields[i]+ ') like '+_q('%'+ _u(Values[j])+'%')+')',
                      '('+Fields[i]+ ' = ' + _u(Values[j]) +')'
                      //, ' = '+Values[j]) + ') or ';
                     ) + ' or ';
      end;
      delete(p, length(p)-2,3);
    end;
    Result := Result + '( ' + p + ' ) or ';
  end;
  delete(result, length(result)-2,3);
  Result := '('+Result +')';
end;

function  GenerateDatasetSearchFilter(Fields: array of String; Values: TstringList; useQuote: Boolean = True): String; overload;
var
  i, j: Integer;
  p: String;
begin
  Result := '';
  if length(Fields) = 0 then
    exit;
  for i := 0 to Length(Fields)- 1 do
  begin
    if Values.Count = 0 then
      p := _IIF(useQuote,
               'upper('+Fields[i]+ ') like ' + _q(''),
               Fields[i]+' = ' + ''
           )

      // '('+Fields[i]+ '=' + _IIF(useQuote, _q(''), '') + ')'
    else
    begin
      p:= '';
      for j := 0 to Values.Count - 1 do
      begin
        //p := p + '(upper('+Fields[i]+ ') ' + _IIF(useQuote, _q(' like %'+Values[j]+'%'), ' = '+Values[j]) + ') or ';
        p := p + _IIF (
                      useQuote,
                      '(upper('+Fields[i]+ ') like '+_q('%'+ _u(Values[j])+'%')+')',
                      '('+Fields[i]+ ' = ' + _u(Values[j]) +')'
                      //, ' = '+Values[j]) + ') or ';
                     ) + ' or ';
      end;
      delete(p, length(p)-2,3);
    end;
    Result := Result + '( ' + p + ' ) or ';
  end;
  delete(result, length(result)-2,3);
  Result := '('+Result +')';
end;

function  GenerateDatasetSearchFilterLocal(Fields: array of String; Values: array of String; useQuote: Boolean = True): String;
var
  i, j: Integer;
  p: String;
begin
  Result := '';
  if length(Fields) = 0 then
    exit;
  for i := 0 to Length(Fields)- 1 do
  begin
    if length(Values) = 0 then
      p := _IIF(useQuote,
               Fields[i]+' like ' + _q(''),
               Fields[i]+' = ' + ''
           )

    else
    begin
      p:= '';
      for j := 0 to length(Values) - 1 do
      begin
        //p := p + '(upper('+Fields[i]+ ') ' + _IIF(useQuote, _q(' like %'+Values[j]+'%'), ' = '+Values[j]) + ') or ';
        p := p + _IIF (
                      useQuote,
                      '('+Fields[i]+ ' like '+_q('%'+ _u(Values[j])+'%')+')',
                      '('+Fields[i]+ ' = ' + _u(Values[j]) +')'
                     ) + ' or ';
      end;
      delete(p, length(p)-2,3);
    end;
    Result := Result + '( ' + p + ' ) or ';
  end;
  delete(result, length(result)-2,3);
  Result := '('+Result +')';
end;

procedure DeleteFromGrid;
var
  i: integer;
  ss: TStringList;
  Dataset: TDataset;
begin

  Dataset := Grid.DataSource.DataSet;
  if Dataset.IsEmpty then exit;

  if grid.SelectedRows.Count = 0 then exit;
  if Ask ('Akan menghapus data dipilih?', Grid.Handle) = ID_NO then
    exit;
  ss := TStringList.Create;
  Dataset.DisableControls;
  try
    if (Dataset is TUniQuery)
    or (Dataset is TUniTable) then
    begin
      for i:= 0 to grid.SelectedRows.Count - 1 do
      begin
        Dataset.Bookmark := grid.SelectedRows[i];
        ss.Add(Dataset.FieldByName(Field).AsString);
      end;
      for i := 0 to ss.Count-1 do
      begin
        if Dataset.FieldByName(Field).DataType in [ftString, ftWideString, ftWideMemo, ftMemo] then
          ExecSQL('delete from '+Tabel+' where '+Field+' = '+_q(ss[i])).Free
        else
          ExecSQL('delete from '+Tabel+' where '+Field+' = '+ss[i]).Free;
      end;
    end
    else
    begin
      grid.SelectedRows.Delete;
    end;
  finally
    Dataset.EnableControls;
    ss.Free;
  end;
end;

function LPad;
begin
  Result := AText;
  while length(Result)<ALength do
    Result := AChars+Result;
  while length(Result)>ALength do
    delete(Result,1,1);
end;

function RPad;
begin
  Result := AText;
  while length(Result)<ALength do
    Result := Result + AChars;
  Result := Copy(Result,1, ALength);
end;

function  PadNum;
var
  p: int64;
begin
  Result := '0';
  p := abs(i);
  if p >= 999999999999 then
    Result := _s(p, 15)
  else
  if p >= 999999999 then
    Result := _s(p,12)
  else
  if p >= 999999 then
    Result := _s(p,9)
  else
  if p >= 999 then
    Result := _s(p,6)
  else
    Result := _s(p,3);
  if i<0 then
    Result := '-'+Result;
  if TextToAppend<> '' then
    Result := Result + ' '+TextToAppend;
end;

function  PadStr;
begin
  Result := i;
  if TextToAppend<>'' then
    Result := Result + ' '+TextToAppend;
end;

function  GetPadNum;
var
  p,x: String;
  sign, i: integer;
begin
  Result := 0;
  p := trim(AText);
  if trim(p) = '' then
    exit;
  if p[1] = '-' then
  begin
    sign := -1;
    Delete(p,1,1); //remove minus sign (-)
  end
  else
    sign := 1;
  x := '';
  i := 1;
  while p[i] in ['0'..'9'] do
  begin
    x := x + p[i];
    inc(i);
  end;
  Result := _i(x, 0) * sign;
end;

function GetPadStr;
var
  i: Integer;
begin
  Result := Trim(AText);
  i := Pos(' ', Result);
  if i > 0 then
    Delete(Result,1,i)
  else
    Result := '';

end;

function  StripPadNum;
begin
  Result := trim(AText);
  if Result = '' then   exit;
  if pos(' ', Result)>0 then
    delete(Result, 1, pos(' ', Result));
end;

function  StripPadStr;
begin
  Result := StripPadNum(AText);
end;

function _IIF(const ACondition: Boolean; const ATrueVal, AFalseVal: String):String;
begin
  if ACondition then
    Result := ATrueVal
  else
    Result := AFalseVal;
end;

function  _IIF(const ACondition: Boolean; const ATrueVal, AFalseVal: Integer):Integer; overload;
begin
  if ACondition then
    Result := ATrueVal
  else
    Result := AFalseVal;
end;

function  _IIF(const ACondition: Boolean; const ATrueVal, AFalseVal: Double):Double; overload;
begin
  if ACondition then
    Result := ATrueVal
  else
    Result := AFalseVal;
end;

function  _d(a1: string; a2: string): string; overload;
begin
  if a1 = '' then Result := a2 else Result := a1;
end;

function  _d(a1: integer; a2: integer): integer; overload;
begin
  if a1 = 0 then Result := a2 else Result := a1;
end;

function  _d(a1: double; a2: Double): Double; overload;
begin
  if a1 = 0 then Result := a2 else Result := a1;
end;

function  Persen(const Nilai, Terhadap: Double): DOuble;
var
  n,d, p: Double;
begin
  if Nilai = 0 then
    p := 0
  else
  begin
    n := {abs}(Nilai);
    d := {abs}(Terhadap);
    if d = 0 then
      p := 100
    else
      p := n/d *100;
  end;
  Result := p;
end;

function  Persentase(const Persen, Dari: Double): DOuble;
var
  n,d, p: Double;
begin
  n := {abs}(Persen);
  d := {abs}(Dari);
  p := n/100*d;
  Result := p;
end;

//////////////////////////////////////////////////
///  ////
///  ////

const
  nol = '0';
  sembilan = '9';
  numeric = [nol..sembilan];
  space = ' ';
  _se = 'se';
{$J+}
  monetary: set of Char = numeric;
  monetary_ext: set of Char = numeric;
{$J-}

function triplex(const n: word): string;
const
  satu = 'satu';
  belas = 'belas';
  puluh = 'puluh' + space;
  ratus = 'ratus' + space;
  cblok: array[0..9] of string = ('', _se, 'dua ', 'tiga ', 'empat ', 'lima ',
    'enam ', 'tujuh ', 'delapan ', 'sembilan ');
var
  x, y, z: byte;
  sy, sz: string;
begin
  x := n div 100;
  y := n mod 100 div 10;
  z := n mod 10;
  if z > 0 then
    sz := cblok[z]
  else
    sz := '';
  if y > 0 then
    sy := cblok[y] + puluh
  else
    sy := '';
  if y = 1 then begin
    if z > 0 then begin
      sy := sz;
      sz := belas;
    end;
  end
  else if z = 1 then
    sz := satu;
  Result := trim(sy + sz);
  if x > 0 then
    Result := trim(cblok[x] + ratus + Result);
end;

function rps(const value: string): string; overload;
type
  tmoneybucket = (cgsatuan, mbribu, mbjuta, mbmilyar, mbtriliun, mbquadrillion,
    mbquintillion, mbhexillion, mbheptillion, mboctillion, mbnonillion, mbdecillion,
    mbunodecillion, mbduodecillion, mbtredecillion, mbkuatuordecillion, mbquindecillion,
    mbsexdecillion, mbseptendecillion, mboktodecillion, mbnovemdecillion, mbvigintillion,
    mbunvigintillion, mbdovigintillion, mbtrevigintillion, mbquattuorvigintillion,
    mbquinvigintillion, mbsexvigintillion, mbseptenvigintillion, mboktovigintillion,
    mbnovemvigintillion, mbtrigintillion, mbtoomany);
const
  blok = 3;
  _rupiah = '';//' rupiah';
  _sen = ' sen';
  triplez = '000';
  zerone = '001';
  moneybuck: array[tmoneybucket] of string = (
    '', 'ribu', 'juta', 'miliar', 'triliun', 'kuadriliun', 'kuintiliun',
    'heksiliun', 'heptiliun', 'oktiliun', 'noniliun', 'desiliun', 'unodesiliun',
    'duodesiliun', 'tredesiliun', 'kuatuordesiliun', 'kuindesiliun', 'seksdesiliun',
    'septendesiliun', 'oktodesiliun', 'novemdesiliun', 'vigintiliun', 'unvigintiliun',
    'dovigintiliun', 'trevigintiliun', 'kuatuorvigintiliun', 'kuinvigintiliun',
    'seksvigintiliun', 'septenvigintiliun', 'oktovigintiliun', 'novemvigintiliun',
    'trigintiliun', 'BuanyakBuangetDah'
    );
var
  i, j, k, n: word;
  S, l, r: ShortString;
  negative: boolean;
begin
  r := '';
  Result := '';
  if value = '' then
    exit
  else
    S := value;
  negative := S[1] = '-';
  if negative then
    delete(S, 1, 1);
  if pos(FormatSettings .decimalseparator, S) > 0 then begin
    l := copy(S, 1, pos(FormatSettings .decimalseparator, S) - 1);
    r := copy(S, pos(FormatSettings .decimalseparator, S) + 1, length(S));
    if length(r) = 1 then
      r := r + nol
    else if length(r) > 2 then
      r := copy(r, 1, 2);
  end
  else
    l := S;
  while length(l) mod blok > 0 do
    l := nol + l;
  Result := '';
  j := length(l) div blok;
  for
    i := j downto 1 do begin
    S := (copy(l, (j - i) * blok + 1, blok));
    n := strtointdef(S, 0);
    if n = 0 then
      continue;
    k := i - 1;
    if (n = 1) and (k = 1) then
      S := _se
    else
      S := triplex(n);
    if S <> '' then begin
      if k > byte(mbtoomany) then k := byte(mbtoomany);
      if i < j then Result := Result + space;
      if S <> _se then S := S + space;
      Result := trim(Result + S + moneybuck[tmoneybucket(k)]);
    end;
  end;
  if Result <> '' then
    Result := Result + _rupiah;
  n := strtointdef(r, 0);
  if (n > 0) then begin
    if Result <> '' then Result := Result + ', ';
    Result := Result + triplex(n) + _sen;
  end;
  if negative then Result := '( ' + trim(Result) + ' )';
end;

function rp(const value: string): string; overload;
const
  ext = 'E';
var
  i, n: integer;
  f: currency;
  l, r: string;
  flagset:
  boolean;
begin
  Result := '';
  for i := 1 to length(value) do
    if value[i] in monetary_ext then
      Result := Result + value[i];
  if pos(ext, uppercase(value)) > 0 then Result := currtostr(strtocurr(value));
  n := pos(FormatSettings .decimalseparator, Result);
  if n = length(Result) then begin
    delete(Result, length(Result), 1);
    n := pos(FormatSettings .decimalseparator, Result);
  end;
  if n > 0 then begin
    l := copy(Result, 1, n - 1);
    r := copy(Result, n, length(Result));
    f := strtocurr(r);
    r := format('%F', [f]);
    if r = '1.00' then begin
      flagset := TRUE;
      for i := length(l) downto 0 do begin
        if flagset = FALSE then break;
        if i = 0 then
          l := '1' + l
        else begin
          flagset := l[i] = sembilan;
          if flagset = TRUE then
            l[i] := nol
          else
            l[i] := Char(ord(l[i]) + 1);
        end;
      end;
    end;
    r := copy(r, length(r) - 2, 3);
    Result := l + r;
  end;
  Result := rps(Result);
end;

function rp(const value: currency): string; overload;
const
  ext = 'E';
var
  S: string;
begin
  S := format('%F', [value]);
  Result := rps(S);
end;

{ TNamaNipNPWP }

procedure TNamaNipNPWP.Clear;
begin
  self.Nama := '';
  Self.NIP  := '';
  Self.NPWP := '';
end;


{ TStringList }

procedure TPairList.Each;//(proc: TstringListEnumProc);
var
  i: Integer;
begin
  if FList.Count = 0 then
    exit;
  for i:=0 to FList.Count - 1 do
    proc(i, FList[i]);
end;

Constructor  TPairList.New(StringList: tstringlist);
begin
  self.FList := StringList;
end;

//

procedure SendCtrlF;
var
  Inputs: array [0..3] of TInput;
begin
  Inputs[0].Itype := INPUT_KEYBOARD;
  Inputs[0].ki.wVk := VK_CONTROL;
  Inputs[0].ki.dwFlags := 0;

  Inputs[1].Itype := INPUT_KEYBOARD;
  Inputs[1].ki.wVk := Ord('F');
  Inputs[1].ki.dwFlags := 0;

  // release
  Inputs[2].Itype := INPUT_KEYBOARD;
  Inputs[2].ki.wVk := Ord('F');
  Inputs[2].ki.dwFlags := KEYEVENTF_KEYUP;

  Inputs[3].Itype := INPUT_KEYBOARD;
  Inputs[3].ki.wVk := VK_CONTROL;
  Inputs[3].ki.dwFlags := KEYEVENTF_KEYUP;

  SendInput(Length(Inputs), Inputs[0], SizeOf(TInput));
end;

procedure Debug;
begin
  ShowMessage('Debug: '+ debugmsg);
end;


{*
*   Utilitas GUI (implementation):
*}

{ TButtonedEdit }

procedure TButtonedEdit.beEnter(Sender: TObject);
begin
  if Self.Text = _BUTTONED_EDIT_DEFAULT then
    Self.Text := ''
  else
    Self.SelectAll;
  self.Font.Color := clWindowText;
  self.Font.Style := [];
end;

procedure TButtonedEdit.beExit(Sender: TObject);
begin
  if Self.Text = '' then
    Self.Text := _BUTTONED_EDIT_DEFAULT;
  self.Font.Color := clGrayText;
end;

procedure TButtonedEdit.Clear;
begin
  inherited Clear;
  FHiddenText := '';
  FHiddenInt := 0;
  FHiddenFLoat := 0;
end;

constructor TButtonedEdit.Create(Aowner: TComponent);
var
  btn: TEditButton;
begin
  inherited Create(Aowner);
  FHiddenText := '';
  FHiddenInt := 0;
  FHiddenFLoat := 0;

  if self.ReadOnly then
    self.Color := clSilver
  else
    self.Color := clWindow;
  //
  FACList := TEnumString.Create;
  FACEnabled := True;
  FACOptions := [acAutoAppend, acAutoSuggest, acUseArrowKey];
  //
  self.Images := __glyphs;
  Self.RightButton.ImageIndex := 0;
  Self.LeftButton.ImageIndex := 1;

  Self.RightButton.Visible := True;
  Self.Cursor := crHandPoint;
  Self.Text := _BUTTONED_EDIT_DEFAULT;
  self.OnEnter := beEnter;
  Self.OnExit := beExit;
  //
  self.Hint := 'Panah Bawah untuk memilih.';
  self.ShowHint := true;
  beExit(Self);
end;

procedure TButtonedEdit.CreateWnd;
var
  Dummy: IUnknown;
  Strings: IEnumString;
begin
  inherited;
  if HandleAllocated then
  begin
    try
      Dummy := CreateComObject(CLSID_IAutoComplete);
      if (Dummy <> nil) and
         (Dummy.QueryInterface(IID_IAutoComplete, FAutoComplete) = S_OK) then
      begin
        case FACSource of
          acsHistory: Strings := CreateComObject(CLSID_ACLHistory) as
            IEnumString;
          acsMRU: Strings := CreateComObject(CLSID_ACLMRU) as
            IEnumString;
          acsShell: Strings := CreateComObject(CLSID_ACListISF) as
            IEnumString;
        else
          Strings := FACList as IEnumString;
        end;
        if S_OK = FAutoComplete.Init(Handle, Strings, nil, nil) then
        begin
          SetACEnabled(FACEnabled);
          SetACOptions(FACOptions);
        end;
      end;
    except
      //CLSID_IAutoComplete is not available
    end;
  end;
end;

destructor TButtonedEdit.Destroy;
begin
  FACList := nil;
  inherited;
end;

procedure TButtonedEdit.DestroyWnd;
begin
  if (FAutoComplete <> nil) then
  begin
    FAutoComplete.Enable(False);
    FAutoComplete := nil;
  end;
  inherited;
end;

procedure TButtonedEdit.Focus;
begin
  self.SetFocus;
  self.SelectAll;
end;

function TButtonedEdit.GetACStrings: TStringList;
begin
  Result := FACList.FStrings;
end;

function TButtonedEdit.GetOption: String;
begin
  Self.Text := u_utils.GetOption(self.Owner.Name+ '-'+self.Parent.Name+'-'+ self.Name);
  Result    := self.Text;
end;

function TButtonedEdit.IsEmpty: Boolean;
begin
  Result := (_U(self.Text) = _U(_BUTTONED_EDIT_DEFAULT)) or (trim(Self.Text) = '');
end;

procedure TButtonedEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DOWN then
  begin
    if Assigned(Self.OnRightButtonClick) then
    begin
      self.OnRightButtonClick(Self);
    end;
  end
  else
  begin
    inherited KeyDown(key, shift);

  end;
end;

procedure TButtonedEdit.KeyPress(var Key: Char);
begin
  inherited;
  if key in [#13, chr(VK_DOWN)] then
    key := #0;

end;

procedure TButtonedEdit.SetACEnabled(const Value: boolean);
begin
  if (FAutoComplete <> nil) then
  begin
    FAutoComplete.Enable(FACEnabled);
  end;
  FACEnabled := Value;
end;

procedure TButtonedEdit.SetACOptions(const Value: TACOptions);
const
  Options : array[TACOption] of integer = (ACO_AUTOAPPEND,
                                           ACO_AUTOSUGGEST,
                                           ACO_UPDOWNKEYDROPSLIST);
var
  Option:TACOption;
  Opt: DWORD;
  AC2: IAutoComplete2;
begin
  if (FAutoComplete <> nil) then
  begin
    if S_OK = FAutoComplete.QueryInterface(IID_IAutoComplete2, AC2) then
    begin
      Opt := ACO_NONE;
      for Option := Low(Options) to High(Options) do
      begin
        if (Option in FACOptions) then
          Opt := Opt or DWORD(Options[Option]);
      end;
      opt := opt and (not ACO_UPDOWNKEYDROPSLIST);
      AC2.SetOptions(Opt);
    end;
  end;
  FACOptions := Value;

end;

procedure TButtonedEdit.SetACSource(const Value: TACSource);
begin
  if FACSource <> Value then
  begin
    FACSource := Value;
    RecreateWnd;
  end;
end;

procedure TButtonedEdit.SetACStrings(const Value: TStringList);
begin
  if Value <> FACList.FStrings then
    FACList.FStrings.Assign(Value);
end;

procedure TButtonedEdit.SetEnabled(value: Boolean);
begin
  inherited SetEnabled(value);
  if value then
    if self.ReadOnly then
      self.Color := clSilver
    else
      self.Color := clWindow
  else
    self.Color := clGray;
end;

function TButtonedEdit.SetOption: String;
begin
  u_utils.SetOption(self.Owner.Name+ '-'+self.Parent.Name+'-'+ self.Name,self.Text);
  Result    := self.Text;
end;

procedure TButtonedEdit.setReadOnly;
begin
  if RO then
    Color := $00E9E9E9
  else
    Color := clWindow;
  ReadOnly := RO;
end;

procedure TButtonedEdit.SetValues(AText: String; const AHiddenText: String;
  const AHiddenInt: Integer; const AHiddenFloat: Double);
begin
  Text := AText;
  HiddenText := AHiddenText;
  HiddenFloat := AHiddenFloat;
  HiddenInt := AHiddenInt;
end;

function TButtonedEdit.WarnForEmpty;
var
  fc,
  c: TColor;
  fs: TFontStyles;
begin
  Result := self.IsEmpty;
  if Result then
  begin
    c := Self.Color;
    fs := Self.Font.Style;
    fc := Self.Font.Color;
    self.Text := 'KOSONG!';
    self.Focus;
    self.Color := clRed;
    self.Font.Color := clWhite;
    Self.Font.Style := [fsBold];
    if AText = '' then
      MessageBox(self.Handle, 'Data ini masih kosong!','Warning',MB_ICONHAND)
    else
      MessageBox(self.Handle, Pchar(Atext),'Warning',MB_ICONHAND);
    self.Color := c;
    self.Text := '';
    self.Font.Color := fc;
    Self.Font.Style := fs;
  end;
end;

{ TEdit }

procedure TEdit.Clear;
begin
  inherited Clear;
  FHiddenText := '';
  FHiddenInt := 0;
  FHiddenFLoat := 0;
end;

constructor TEdit.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);
  FHiddenText := '';
  FHiddenInt := 0;
  FHiddenFLoat := 0;
  //
  FACList := TEnumString.Create;
  FACEnabled := True;
  FACOptions := [acAutoAppend, acAutoSuggest, acUseArrowKey];
  //
  Self.Text := '';
end;

procedure TEdit.CreateWnd;
var
  Dummy: IUnknown;
  Strings: IEnumString;
begin
  inherited;
  if HandleAllocated then
  begin
    try
      Dummy := CreateComObject(CLSID_IAutoComplete);
      if (Dummy <> nil) and
         (Dummy.QueryInterface(IID_IAutoComplete, FAutoComplete) = S_OK) then
      begin
        case FACSource of
          acsHistory: Strings := CreateComObject(CLSID_ACLHistory) as
            IEnumString;
          acsMRU: Strings := CreateComObject(CLSID_ACLMRU) as
            IEnumString;
          acsShell: Strings := CreateComObject(CLSID_ACListISF) as
            IEnumString;
        else
          Strings := FACList as IEnumString;
        end;
        if S_OK = FAutoComplete.Init(Handle, Strings, nil, nil) then
        begin
          SetACEnabled(FACEnabled);
          SetACOptions(FACOptions);
        end;
      end;
    except
      //CLSID_IAutoComplete is not available
    end;
  end;

end;

destructor TEdit.Destroy;
begin
  FACList := nil;
  inherited;
end;

procedure TEdit.DestroyWnd;
begin
  if (FAutoComplete <> nil) then
  begin
    FAutoComplete.Enable(False);
    FAutoComplete := nil;
  end;
  inherited;
end;

procedure TEdit.Focus;
begin
  self.SetFocus;
  self.SelectAll;
end;

function TEdit.GetACStrings: TStringList;
begin
  Result := FACList.FStrings;
end;

function TEdit.GetOption: String;
begin
  Self.Text := u_utils.GetOption(self.Owner.Name+ '-'+self.Parent.Name+'-'+ self.Name);
  Result    := self.Text;
end;

function TEdit.IsEmpty: Boolean;
begin
  Result := Trim(self.Text) = '';
end;

procedure TEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DOWN then
  begin
    if Assigned(Self.OnDblClick) then
      OnDblClick(self);
  end
  else
    inherited KeyDown(key, Shift);
end;

procedure TEdit.KeyPress(var Key: Char);
begin
  inherited;
  if key = #13 then
    key := #0;
end;

procedure TEdit.SetACEnabled(const Value: boolean);
begin
  if (FAutoComplete <> nil) then
  begin
    FAutoComplete.Enable(FACEnabled);
  end;
  FACEnabled := Value;
end;

procedure TEdit.SetACOptions(const Value: TACOptions);
const
  Options : array[TACOption] of integer = (ACO_AUTOAPPEND,
                                           ACO_AUTOSUGGEST,
                                           ACO_UPDOWNKEYDROPSLIST);
var
  Option:TACOption;
  Opt: DWORD;
  AC2: IAutoComplete2;
begin
  if (FAutoComplete <> nil) then
  begin
    if S_OK = FAutoComplete.QueryInterface(IID_IAutoComplete2, AC2) then
    begin
      Opt := ACO_NONE;
      for Option := Low(Options) to High(Options) do
      begin
        if (Option in FACOptions) then
          Opt := Opt or DWORD(Options[Option]);
      end;
      opt := opt and (not ACO_UPDOWNKEYDROPSLIST);
      AC2.SetOptions(Opt);
    end;
  end;
  FACOptions := Value;
end;

procedure TEdit.SetACSource(const Value: TACSource);
begin
  if FACSource <> Value then
  begin
    FACSource := Value;
    RecreateWnd;
  end;
end;

procedure TEdit.SetACStrings(const Value: TStringList);
begin
  if Value <> FACList.FStrings then
    FACList.FStrings.Assign(Value);
end;

function TEdit.SetOption: String;
begin
  u_utils.SetOption(self.Owner.Name+ '-'+self.Parent.Name+'-'+ self.Name,self.Text);
  Result    := self.Text;
end;

procedure TEdit.setReadOnly;
begin
  if RO then
    Color := $00E9E9E9
  else
    Color := clWindow;
  ReadOnly := RO;
end;

procedure TEdit.SetTagString(const Value: String);
begin
  FTagString := Value;
end;

procedure TEdit.SetValues(AText: String; const AHiddenText: String;
  const AHiddenInt: Integer; const AHiddenFloat: Double);
begin
  Text := AText;
  HiddenText := AHiddenText;
  HiddenFloat := AHiddenFloat;
  HiddenInt := AHiddenInt;
end;

function TEdit.WarnForEmpty;
var
  fc,
  c: TColor;
  fs: TFontStyles;
begin
  Result := self.IsEmpty;
  if Result then
  begin
    c := Self.Color;
    fs := Self.Font.Style;
    fc := Self.Font.Color;
    self.Text := 'KOSONG!';
    self.Focus;
    self.Color := clRed;
    self.Font.Color := clWhite;
    Self.Font.Style := [fsBold];
    if AText = '' then
      MessageBox(self.Handle, 'Data ini masih kosong!','Warning',MB_ICONHAND)
    else
      MessageBox(self.Handle, Pchar(Atext),'Warning',MB_ICONHAND);
    self.Color := c;
    self.Text := '';
    self.Font.Color := fc;
    Self.Font.Style := fs;
  end;
end;

procedure TComboBox.CNCommand(var AMessage: TWMCommand);
begin
  inherited;
  // if we received the CBN_EDITUPDATE notification
  if AMessage.NotifyCode = CBN_EDITUPDATE then
  begin
    // fill the items with the matches
    SetDroppedDown(True);
    FilterItems;
  end;
end;

constructor TComboBox.Create(AOwner: TComponent);
begin
  inherited;
  AutoComplete := False;
  FStoredItems := TStringList.Create;
  FStoredItems.OnChange := StoredItemsChange;
  AutoDropDown := true;
end;

destructor TComboBox.Destroy;
begin
  FStoredItems.Free;
  inherited;
end;

procedure TComboBox.FilterItems;
var
  I: Integer;
  Selection: TSelection;
begin
  // store the current combo edit selection
  SendMessage(Handle, CB_GETEDITSEL, WPARAM(@Selection.StartPos),
    LPARAM(@Selection.EndPos));
  // begin with the items update
  Items.BeginUpdate;
  try
    // if the combo edit is not empty, then clear the items
    // and search through the FStoredItems
    if Text <> '' then
    begin
      // clear all items
      Items.Clear;
      // iterate through all of them
      for I := 0 to FStoredItems.Count - 1 do
        // check if the current one contains the text in edit
        if ContainsText(FStoredItems[I], Text) then
          // and if so, then add it to the items
          Items.Add(FStoredItems[I]);
    end
    // else the combo edit is empty
    else
      // so then we'll use all what we have in the FStoredItems
      Items.Assign(FStoredItems)
  finally
    // finish the items update
    Items.EndUpdate;
  end;
  // and restore the last combo edit selection
  SendMessage(Handle, CB_SETEDITSEL, 0, MakeLParam(Selection.StartPos,
    Selection.EndPos));
end;

procedure TComboBox.SetStoredItems(const Value: TStringList);
begin
  if Assigned(FStoredItems) then
    FStoredItems.Assign(Value)
  else
    FStoredItems := Value;
end;

procedure TComboBox.StoredItemsChange(Sender: TObject);
begin
  if Assigned(FStoredItems) then
    FilterItems;
end;

{ TEnumString }

function TEnumString.Clone(out enm: IEnumString): HResult;
begin
  Result := E_NOTIMPL;
  Pointer(enm) := nil;
end;

constructor TEnumString.Create;
begin
  inherited Create;
  FStrings := TStringList.Create;
  FCurrIndex := 0;
end;

destructor TEnumString.Destroy;
begin
  FStrings.Free;
  inherited;
end;

function TEnumString.Next(celt: Integer; out elt;
  pceltFetched: PLongint): HResult;
var
  I: Integer;
  wStr: WideString;
begin
  I := 0;
  while (I < celt) and (FCurrIndex < FStrings.Count) do
  begin
    wStr := FStrings[FCurrIndex];
    TPointerList(elt)[I] := CoTaskMemAlloc(2 * (Length(wStr) + 1));
    StringToWideChar(wStr, TPointerList(elt)[I], 2 * (Length(wStr) + 1));
    Inc(I);
    Inc(FCurrIndex);
  end;
  if pceltFetched <> nil then
    pceltFetched^ := I;
  if I = celt then
    Result := S_OK
  else
    Result := S_FALSE;

end;

function TEnumString.Reset: HResult;
begin
  FCurrIndex := 0;
  Result := S_OK;
end;

function TEnumString.Skip(celt: Integer): HResult;
begin
  if (FCurrIndex + celt) <= FStrings.Count then
  begin
    Inc(FCurrIndex, celt);
    Result := S_OK;
  end
  else
  begin
    FCurrIndex := FStrings.Count;
    Result := S_FALSE;
  end;
end;

{ TAction }

constructor TAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if self.ShortCut<>0 then
    self.Hint := _IIF(self.Caption<>'', self.Caption, '') + ShortCutToText(self.ShortCut)
  else
    self.Hint := _IIF(self.Caption<>'', self.Caption, '');
end;

function  GetLocalIP: String;
type
  pu_long = ^u_long;
var
  varTWSAData : TWSAData;
  varPHostEnt : PHostEnt;
  varTInAddr : TInAddr;
  // namebuf : Array[0..255] of char;
  namebuf : PAnsiChar;
begin
  If WSAStartup($101,varTWSAData) <> 0 Then
  Result := 'Unknown IP'
  Else
  Begin
    GetMem(namebuf, 256);
    gethostname(namebuf,255);
    varPHostEnt := gethostbyname(namebuf);
    freemem(namebuf, 256);
    varTInAddr.S_addr := u_long(pu_long(varPHostEnt^.h_addr_list^)^);
    Result := inet_ntoa(varTInAddr);
  End;
  WSACleanup;
end;

function  GetComputerName: String;
var
    Buffer: array [0..63] of AnsiChar;
    i: Integer;
    GInitData: TWSADATA;
begin
    Result := '';
    WSAStartup($101, GInitData);
    GetHostName(Buffer, SizeOf(Buffer));
    Result:=Buffer;
    WSACleanup;
{
var
  buffer: array[0..255] of char;
  size: dword;
begin
  size := 256;
  if GetComputerName(buffer, size) then
    Result := buffer
  else
    Result := 'Unknown';
}
end;

function  GetLocalIPAndHostName(var IP, HostName: String):Boolean;
type
  pu_long = ^u_long;
var
  varTWSAData : TWSAData;
  varPHostEnt : PHostEnt;
  varTInAddr : TInAddr;
  // namebuf : Array[0..255] of char;
  namebuf : PAnsiChar;
begin
  Result := False;
  If WSAStartup($101,varTWSAData) <> 0 Then
  begin
    IP := 'Unknown IP';
    HostName := 'Unknown host';
  end
  Else
  Begin
    GetMem(namebuf, 256);
    gethostname(namebuf,255);
    HostName := String(namebuf);
    varPHostEnt := gethostbyname(namebuf);
    freemem(namebuf, 256);
    varTInAddr.S_addr := u_long(pu_long(varPHostEnt^.h_addr_list^)^);
    IP := inet_ntoa(varTInAddr);
    Result := true;
  End;
  WSACleanup;

end;


function  AccessibleBy(const User: TUser; const AccessName: String): Boolean; overload;
begin
  ExecSQL('select add_access_item('+AccessName.QuotedString+')').Free;
  if User.Grup='DEV' then
    Result := true
  else
  begin
    result := ExecSQLAndFetchOneValueAsString('select accessible_by('+user.ID.ToString+', '+AccessName.QuotedString+')') = 'Y';
  end;
end;

function  AccessibleBy(const User: TUser; const AccessNames: array of String): Boolean;
var
  i: integer;
  s1,
  s2: string;
begin
  Result := false;
  {
  if User.Grup='DEV' then
  begin
    Result := true;
    exit;
  end;
  if length(AccessNames) = 0 then exit;
  s1 := '';
  s2 := '';
  for i := 0 to Length(AccessNames)-1 do
    s1 := s1 + ' add_access_item('+AccessNames[i].QuotedString+'),';
  s1 := 'select '+copy(s1,1, length(s1)-1);
  ExecSQL(s1).Free;
  result := ExecSQLAndFetchOneValueAsString('select accessible_by('+user.ID.ToString+', '+AccessName.QuotedString+')') = 'Y';
  }
end;

function ExcelColumnByIndex(aIndex: Integer): string;
var
  _c: string; _x, _y: integer;
begin
  _c := '';
  _x := aIndex;
  while _x>0 do
  begin
    _y := (_x-1) mod 26;
    _c := chr(65+_y)+_c;
    _x := (_x-_y) div 26;
  end;
  Result := _c;
end;

{ TJvCalcEdit }

constructor TJvCalcEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.DisplayFormat := FORMAT_FINANCE;
end;

procedure TJvCalcEdit.setReadOnly;
begin
  if RO then
    Color := $00E9E9E9
  else
    Color := clWindow;
  ReadOnly := RO;
end;

{ TUser }

function TUser.Accessible(const AccessName: String): Boolean;
begin
  Result := AccessibleBy(self, AccessName);
end;

procedure TUser.Clear;
begin
  Self.KodeCabang:='';
  Self.ID:=0;
  Self.GrupName:='';
  Self.UserName:='';
  Self.Password:='';
  Self.Grup:='';
  self.FullName := '';
  self.NamaCabang := '';
  self.AlamatCabang := '';
  self.SuperVisorID := 0;
  self.SuperVisorUserName := '';
  self.SuperVisorGrupName := '';
  self.SuperVisorPassword := '';
  self.SuperVisorFullName := '';
  self.SuperVisorGrup := '';
end;


initialization

// ShowMessage(APP_NAME_WITH_VERSION_LONG);

__icon:= TIcon.Create;
__glyphs := TImageList.Create(nil);
__glyphs.Width  := 16;
__glyphs.Height := 16;
__glyphs.Masked := true;

__icon.LoadFromResourceName(HInstance, 'u_utils_TButtonedEdit_icon');
__glyphs.AddIcon(__icon);
__icon.LoadFromResourceName(HInstance, 'u_utils_TButtonedEdit_clear');
__glyphs.AddIcon(__icon);
// Application.Icon.Assign( __icon );
with FormatSettings do
begin
  ShortDateFormat:='dd-MM-yyyy';
  CurrencyString:='Rp';
  CurrencyFormat:=2;
  CurrencyDecimals:=2;

  OldDecimalSeparator  := DecimalSeparator;
  OldThousandSeparator := ThousandSeparator;

  DecimalSeparator:=',';
  ThousandSeparator:='.';

  LongMonthNames[1] :='Januari';
  LongMonthNames[2] :='Februari';
  LongMonthNames[3] :='Maret';
  LongMonthNames[4] :='April';
  LongMonthNames[5] :='Mei';
  LongMonthNames[6] :='Juni';
  LongMonthNames[7] :='Juli';
  LongMonthNames[8] :='Agustus';
  LongMonthNames[9] :='September';
  LongMonthNames[10]:='Oktober';
  LongMonthNames[11]:='November';
  LongMonthNames[12]:='Desember';

  LongDayNames  [1] :='Minggu';
  LongDayNames  [2] :='Senin';
  LongDayNames  [3] :='Selasa';
  LongDayNames  [4] :='Rabu';
  LongDayNames  [5] :='Kamis';
  LongDayNames  [6] :='Jumat';
  LongDayNames  [7] :='Sabtu';

  monetary := [decimalseparator] + ['+', '-'] + numeric;
  monetary_ext := monetary + ['e', 'E'];
end;
Application.UpdateFormatSettings := false;

// INVALID_DATE_VALUE := EncodeDateTime(1899,12,31, 0, 0, 0, 0);
// set cursor for crBussy:
__cursorFile := AppPath(false)+'u_utils.crBussy.ani';
if not FileExists(__cursorFile) then
begin
  with TResourceStream.Create(HInstance, 'u_utils_crBussy_any', 'ANICURSOR') do
  begin
    try
      SaveToFile(__cursorFile);
    finally
      Free;
    end;
  end;
end;

Screen.Cursors[crBussy] := LoadImage(0, PChar(__cursorFile), IMAGE_CURSOR, 0, 0, LR_DEFAULTSIZE or LR_LOADFROMFILE);

finalization
  __glyphs.Free;
  __icon.Free;
//

end.
