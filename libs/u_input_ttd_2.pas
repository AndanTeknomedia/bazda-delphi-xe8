unit u_input_ttd_2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, JvExControls, JvEnterTab, DateUtils,
  Mask, JvExMask, JvSpin, JvComponentBase, u_utils;

type
  TTandaTangan2 = record
    Nama: String[150];
    Jabatan: String[200];
    Tempat: String[200];
    Tanggal: String[150];
    TanggalAsli: TDateTime;
    Hari: String;
    Keterangan: String[250];
    procedure Clear;
  end;

  TFInputTTD2 = class(TForm)
    eJabatan: TEdit;
    eTempat: TEdit;
    eTanggal: TEdit;
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel2: TPanel;
    Bevel2: TBevel;
    Button1: TButton;
    Button2: TButton;
    JvEnterAsTab1: TJvEnterAsTab;
    Label10: TLabel;
    eNama: TButtonedEdit;
    Memo1: TMemo;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure JvEnterAsTab1HandleEnter(Sender: TObject; AControl: TWinControl;
      var Handled: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure eNamaRightButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function InputTTD2(Title: String; var TTD: TTandaTangan2): Boolean;

implementation

uses u_select_kode_name;

{$R *.dfm}

function InputTTD2;
var
  s: string;
  d: TDate;
  i: integer;
  ar: TStringArr;
begin
  Result := False;
  with TFInputTTD2.Create(Application) do
  begin
    Caption := Title;
    SetLength(ar, 3);
    try
      ar[0] := CurrentUser.KodeCabang+'-lastTTDTempat-'+MD5(Caption);
      ar[1] := CurrentUser.KodeCabang+'-lastTTDNama-'+MD5(Caption);
      ar[2] := CurrentUser.KodeCabang+'-lastTTDJabatan-'+MD5(Caption);
      ar := GetMultipleOptions(ar);
      if TTD.Tempat = '' then
        eTempat.Text := ar[0]
      else
        eTempat.Text  := TTD.Tempat;
      if TTD.Nama = '' then
        eNama.Text := ar[1]
      else
        eNama.Text    := TTD.Nama;
      if TTD.Jabatan = '' then
        eJabatan.Text := ar[2]
      else
        eJabatan.Text := TTD.Jabatan;
      eTanggal.Text := TTD.Tanggal;
      Memo1.Text    := TTD.Keterangan;
      DateTimePicker1.DateTime := Date();
      DateTimePicker1Change(DateTimePicker1);
      Tag := mrNone;
      ShowModal;
      Result := Tag = mrOk;
      TTD.Clear;
      if Result then
      begin
        ar[0] := CurrentUser.KodeCabang+'-lastTTDTempat-'+MD5(Caption);
        ar[1] := CurrentUser.KodeCabang+'-lastTTDNama-'+MD5(Caption);
        ar[2] := CurrentUser.KodeCabang+'-lastTTDJabatan-'+MD5(Caption);
        SetMultipleOptions(ar, [eTempat.Text, eNama.Text, eJabatan.Text]);
        TTD.Nama    := eNama.Text;
        TTD.Jabatan := eJabatan.Text;
        TTD.Tempat  := eTempat.Text;
        TTD.Tanggal := eTanggal.Text;
        ttd.Keterangan
                    := Memo1.Text;
        TTD.TanggalAsli
                    := DateTimePicker1.Date;
        i           := DayOfWeek(DateTimePicker1.Date);
        ttd.Hari    := FormatSettings.LongDayNames[i];
      end;
    finally
      SetLength(ar, 0);
      Free;
    end;
  end;
end;

procedure TFInputTTD2.Button1Click(Sender: TObject);
begin
  Tag := mrOk;
  Close;
end;

procedure TFInputTTD2.Button2Click(Sender: TObject);
begin
  Tag := mrCancel;
  Close;
end;

procedure TFInputTTD2.DateTimePicker1Change(Sender: TObject);
begin
  eTanggal.Text := DateIndo(DateTimePicker1.Date);
end;

procedure TFInputTTD2.eNamaRightButtonClick(Sender: TObject);
var
  sl: TStringList;
begin
  sl := SelectKodeName(
    GetGlobalConnection,
    'select "Nama Lengkap","Jabatan" from vw_pegawai_ringkas where substr("NRP",1,3) = '+QuotedStr(CurrentUser.KodeCabang),
    ['Nama Lengkap', 'Jabatan'],
    ['Nama Lengkap', 'Jabatan'],
    [150,150]
  );
  if sl.Count>0 then
  begin
    eNama.Text := sl[0];
    eJabatan.Text := sl[1];
  end;
  FreeAndNil(sl);
end;

procedure TFInputTTD2.FormCreate(Sender: TObject);
begin
  DateTimePicker1.DateTime := Now;
end;

procedure TFInputTTD2.JvEnterAsTab1HandleEnter(Sender: TObject;
  AControl: TWinControl; var Handled: Boolean);
begin
  Handled := AControl = Button1;
end;

procedure TFInputTTD2.Label8Click(Sender: TObject);
begin

end;

{ TTandaTangan }

procedure TTandaTangan2.Clear;
begin
  self.Jabatan := '';
  self.TanggalAsli := Today;
  self.Nama := '';
  self.Tempat := '';
  self.Tanggal := '';
  self.Hari := '';
  self.Keterangan := '';
end;

end.
