unit u_input_ttd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, JvExControls, JvEnterTab, DateUtils,
  Mask, JvExMask, JvSpin, JvComponentBase;

type
  TTandaTangan = record
    NamaPerusahaan: String[200];
    Alamat: String[255];
    Jabatan,
    Nama: String[150];
    Nip: String[50];
    Tempat: String[200];
    Tanggal: String[150];
    Hari: String;
    TTDImage: TBitmap;
    JumlahLampiran: Integer;
    procedure Clear;
  end;

  TFInputTTD = class(TForm)
    eNama: TEdit;
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
    Label3: TLabel;
    Label6: TLabel;
    ePerusahaan: TEdit;
    eAlamat: TMemo;
    Label7: TLabel;
    JvSpinEdit1: TJvSpinEdit;
    Label8: TLabel;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure JvEnterAsTab1HandleEnter(Sender: TObject; AControl: TWinControl;
      var Handled: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function InputTTD(var TTD: TTandaTangan): Boolean;

implementation

uses u_utils;

{$R *.dfm}

function InputTTD(var TTD: TTandaTangan): Boolean;
var
  s: string;
  d: TDate;
  i: integer;
begin
  Result := False;
  with TFInputTTD.Create(Application) do
  begin
    try
      ePerusahaan.Text := ttd.NamaPerusahaan;
      eAlamat.Text  := TTD.Alamat;
      eNama.Text    := TTD.Nama;
      eJabatan.Text := TTD.Jabatan;
      eTempat.Text  := TTD.Tempat;
      eTanggal.Text := TTD.Tanggal;
      DateTimePicker1.DateTime := Date();
      DateTimePicker1Change(DateTimePicker1);
      JvSpinEdit1.Value := ttd.JumlahLampiran;
      Tag := mrNone;
      ShowModal;
      Result := Tag = mrOk;
      if Result then
      begin
        TTD.NamaPerusahaan := ePerusahaan.Text;
        TTD.Alamat  := eAlamat.Text;
        TTD.Nama    := eNama.Text;
        TTD.Jabatan := eJabatan.Text;
        TTD.Tempat  := eTempat.Text;
        TTD.Tanggal := eTanggal.Text;
        i := DayOfWeek(DateTimePicker1.Date);
        ttd.Hari    := FormatSettings.LongDayNames[i];
        ttd.JumlahLampiran := trunc(JvSpinEdit1.Value);
      end;
    finally
      Free;
    end;
  end;
end;

procedure TFInputTTD.Button1Click(Sender: TObject);
begin
  Tag := mrOk;
  Close;
end;

procedure TFInputTTD.Button2Click(Sender: TObject);
begin
  Tag := mrCancel;
  Close;
end;

procedure TFInputTTD.DateTimePicker1Change(Sender: TObject);
begin
  eTanggal.Text := DateIndo(DateTimePicker1.Date);
end;

procedure TFInputTTD.FormCreate(Sender: TObject);
begin
  DateTimePicker1.DateTime := Now;
end;

procedure TFInputTTD.JvEnterAsTab1HandleEnter(Sender: TObject;
  AControl: TWinControl; var Handled: Boolean);
begin
  Handled := AControl = Button1;
end;

procedure TFInputTTD.Label8Click(Sender: TObject);
begin

end;

{ TTandaTangan }

procedure TTandaTangan.Clear;
begin
  self.Jabatan := '';
  self.Nama := '';
  self.Nip := '';
  self.Tempat := '';
  self.Tanggal := '';
  self.TTDImage := nil;
  self.Hari := '';
end;

end.
