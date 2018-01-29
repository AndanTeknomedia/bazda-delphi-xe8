unit u_sys_vars;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, DB, MemDS, DBAccess, StdCtrls, u_utils,
  ActnList, PlatformDefaultStyleActnCtrls, ActnMan, umain, Mask, JvExMask,
  JvToolEdit, JvBaseEdits, pngimage, Uni;

type
  TFSysVars = class(TForm)
    PageControl1: TPageControl;
    Panel1: TPanel;
    Bevel1: TBevel;
    TabSheet3: TTabSheet;
    qID: TUniQuery;
    qIDkode: TStringField;
    qIDnama: TStringField;
    qIDkota: TStringField;
    qIDalamat: TStringField;
    qIDemail: TStringField;
    qIDtelepon: TStringField;
    qIDtelepon2: TStringField;
    qIDfax: TStringField;
    qIDtagline: TMemoField;
    qIDlogo: TBlobField;
    Button1: TButton;
    Button2: TButton;
    eNama: TEdit;
    eALamat: TEdit;
    eemail: TEdit;
    eTelp1: TEdit;
    eTelp2: TEdit;
    eFax: TEdit;
    eTaline: TEdit;
    Panel2: TPanel;
    Image1: TImage;
    eKota: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ActionManager1: TActionManager;
    Action1: TAction;
    Action2: TAction;
    Label9: TLabel;
    Edit1: TEdit;
    qIDprefix: TStringField;
    qIDmobile1: TStringField;
    qIDmobile2: TStringField;
    qIDlogo_path: TStringField;
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
  private
    { Private declarations }
    _koneksi: TUniConnection;
    _unit: String;
  public
    { Public declarations }
  end;

var
  FSysVars: TFSysVars;

function SystemSetup(KOneksi:TUniConnection; const KodeUnit: String): Boolean;

implementation


{$R *.dfm}

function SystemSetup;
var
  b: TBitmap;
  tagline: String;
  p:integer;
  LogoPath: String;
  png: TPngImage;
begin
  Result := False;
  with TFSysVars.Create(Application) do
  begin
    try
      _koneksi := KOneksi;
      PageControl1.ActivePageIndex := 0;
      _unit := KodeUnit;
      qID.Connection := _koneksi;
      qid.ParamByName('kdunit').AsString := _unit;
      qID.Open;
      //Load company id's:
      eNama.Text := qIDnama.AsString;
      eKota.Text := qIDkota.AsString;
      eALamat.Text := qIDalamat.AsString;
      eemail.Text := qIDemail.AsString;
      eTelp1.Text := qIDtelepon.AsString;
      eTelp2.Text := qIDtelepon2.AsString;
      eFax.Text := qIDfax.AsString;
      eTaline.Text := _IIF(qIDtagline.AsString<>'', qIDtagline.AsString, 'Masukkan semboyan/slogan di sini.');
      // LogoPath:= qIDlogo_path.AsString;
      // b := BitmapFromBlob(qIDlogo);
      png := PNGFromBlob(qIDlogo);
      if Assigned(png) then
      begin
        Image1.Picture.Assign(png);
      end;
      Tag := mrNone;

      _koneksi.StartTransaction;
      ShowModal;
      Result := Tag = mrOk;
      if Result then
      begin
        //data usaha:
        qID.Edit;
        qIDnama.AsString    :=eNama.Text;
        qIDkota.AsString    :=eKota.Text;
        qIDalamat.AsString  :=eALamat.Text;
        qIDemail.AsString   :=eemail.Text;
        qIDtelepon.AsString :=eTelp1.Text;
        qIDtelepon2.AsString:=eTelp2.Text;
        qIDfax.AsString     :=eFax.Text;
        qIDtagline.AsString :=eTaline.Text;
        qID.Post;
        qID.Close;

        // commit changes:
        _koneksi.Commit;
      end
      else
        _koneksi.Rollback;
    finally
      png.Free;
      Free;
    end;
  end;
end;

procedure TFSysVars.Action1Execute(Sender: TObject);
begin
  if trim(eNama.Text) = '' then
  begin
    Warn('Nama Instansi masih kosong.', Handle);
    eNama.SetFocus;
    eNama.SelectAll;
    Exit;
  end;
  if trim(eKota.Text) = '' then
  begin
    Warn('Kota tempat Instansi masih kosong.', Handle);
    eKota.SetFocus;
    eKota.SelectAll;
    Exit;
  end;
  //
  Tag := mrOk;
  Close;
end;

procedure TFSysVars.Action2Execute(Sender: TObject);
begin
  if ask('Batalkan perubahan dan tutup?', handle) = ID_NO then
    exit;
  Tag := mrCancel;
  Close;
end;

end.
