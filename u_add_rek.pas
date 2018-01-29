unit u_add_rek;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExControls, JvEnterTab, u_utils, JvComponentBase;

type
  TFAddRek = class(TForm)
    lbKodeInduk: TLabel;
    lbKodeAnak: TLabel;
    Label1: TLabel;
    JvEnterAsTab1: TJvEnterAsTab;
    Label2: TLabel;
    eKodeInduk: TEdit;
    eKodeAnak: TEdit;
    eNamaAnak: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure JvEnterAsTab1HandleEnter(Sender: TObject; AControl: TWinControl;
      var Handled: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure eKodeAnakKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    _EditMode: Boolean;
    _Induk: String;
  public
    { Public declarations }
  end;

// returning inserted Kode
function AddRek (Induk: String; var AKode: string; var ANama: String): Boolean;
function EditRek(Kode: String; var ANama: String): Boolean;

implementation

{$R *.dfm}

function AddRek;
var
  F: TFAddRek;
  ka,
  s: String;
  level,
  i: integer;
begin
  Result := False;
  if induk = '' then
  begin
    Inform('Anda hanya dapat menambah Rekening Level 2 sampai Level 5');
    exit;
  end;
  f := TFAddRek.Create(Application);
  with f do
  begin
    try
      tag := mrNone;
      _EditMode := false;
      _Induk := '';
      with ExecSQL('select tingkat, pkode, kode, rekening, vkode from v_coa_2 where kode = '+_q(Induk)) do
      begin
        if not IsEmpty then
        begin
          First;
          _Induk := Induk;
          eKodeInduk.Text := Fields[4].AsString+' - '+Fields[3].AsString;
          level := Fields[0].AsInteger;
          if level<2 then
            eKodeAnak.MaxLength := 1
          else
            eKodeAnak.MaxLength := 2;
          Inc(level);
          ka := ExecSQLAndFetchOneValueAsString('select max(skode) from sys_coa_'+_s(level)+' where pkode = '+_q(_Induk));
          if isNumbersOnly(ka) then
          begin
            ka := lpad(IntToStr(_i(ka,0)+1), 2, '0');
            eKodeAnak.Text := ka;
          end
          else
            eKodeAnak.Text := '';
          eNamaAnak.Text := '';
          ShowModal;
          if f.Tag = mrOk then
          begin
            AKode := eKodeAnak.Text;
            ANama := eNamaAnak.Text;
            s := 'insert into sys_coa_'+_s(level)+' (pkode, skode, rekening) values('+_q(_Induk)+', '+_q(eKodeAnak.Text)+', '+_q(ANama)+') returning kode';
            AKode := ExecSQLAndFetchOneValueAsString(s);
            Result := true;
          end
          else
            Inform('Batal');
        end
        else
          Warn('Terjadi kesalahan. Coba lagi...');
      end;
    finally
      Free;
    end;
  end;
end;

function EditRek;
var
  F: TFAddRek;

  s: String;
  level,
  i: integer;
begin
  Result := False;
  if Kode = '' then
  begin
    Inform('Anda Kode Akun tidak valid');
    exit;
  end;
  f := TFAddRek.Create(Application);
  with f do
  begin
    try
      tag := mrNone;
      _EditMode := true;
      _Induk := '';
      with ExecSQL('select tingkat, pkode, kode, rekening, vkode, skode from v_coa_2 where kode = '+_q(Kode)) do
      begin
        if not IsEmpty then
        begin
          First;
          _Induk := Kode;
          eKodeInduk.Text := Fields[4].AsString+' - '+Fields[3].AsString;
          lbKodeInduk.Caption := 'Akun Asli';
          level := Fields[0].AsInteger;
          if level>2 then
            eKodeAnak.MaxLength := 2
          else
            eKodeAnak.MaxLength := 1;
          eKodeAnak.Text := Fields[5].AsString;
          Label2.Caption := 'Kode Tak Boleh Diedit.';
          eKodeAnak.setReadOnly();
          eNamaAnak.Text := Fields[3].AsString;
          eNamaAnak.SelectAll;
          Label1.Caption := 'Nama Rek. Baru';
          ShowModal;
          if f.Tag = mrOk then
          begin
            ANama := eNamaAnak.Text;
            // s := 'insert into sys_coa_'+_s(level)+' (pkode, skode, rekening) values('+_q(_Induk)+', '+_q(eKodeAnak.Text)+', '+_q(ANama)+') returning kode';
            s := 'update sys_coa_'+_s(level)+' set rekening = '+_q(ANama)+' where kode = '+_q(Kode);
            // AKode := ExecSQLAndFetchOneValueAsString(s);
            GetGlobalConnection.ExecSQL(s);
            Result := true;
          end;
        end
        else
          Warn('Akun tidak ditemukan. Coba lagi...');
      end;
    finally
      Free;
    end;
  end;
end;

procedure TFAddRek.Button1Click(Sender: TObject);
var
  j: integer;
begin
  // if eKodeAnak.WarnForEmpty() then exit;
  if not _EditMode then
  begin
    if Length(eKodeAnak.Text)<>eKodeAnak.MaxLength then
    begin
      Inform('Panjang Kode harus '+_s(eKodeAnak.MaxLength)+' digit!');
      FocusTo(eKodeAnak);
      exit;
    end;
    j := ExecSQLAndFetchOneValueAsInteger('select count(*) from v_coa_2 where pkode = '+_q(_Induk)+' and skode = '+_q(eKodeAnak.Text));
    if j>0 then
    begin
      Warn('No. rekening anak sudah digunakan oleh rekening lain.');
      FocusTo(eKodeAnak);
      exit;
    end;
  end;
  if eNamaAnak.WarnForEmpty() then
    exit;
  Tag := mrOk;
  Close;
end;

procedure TFAddRek.Button2Click(Sender: TObject);
begin
  tag := mrCancel;
  Close;
end;

procedure TFAddRek.eKodeAnakKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9','a'..'z','A'..'Z',#8, chr(VK_DELETE)]) then
    key := #0;
end;

procedure TFAddRek.JvEnterAsTab1HandleEnter(Sender: TObject;
  AControl: TWinControl; var Handled: Boolean);
begin
  Handled := (AControl = Button1) or (AControl = Button2);
end;

end.
