unit u_setting_persentase_bagian_amil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, JvExMask,
  JvToolEdit, JvBaseEdits, Vcl.ExtCtrls, u_utils;

type
  TFSettingPersentaseBagianAmil = class(TForm)
    eZakat: TJvCalcEdit;
    Label2: TLabel;
    eIS: TJvCalcEdit;
    Label1: TLabel;
    eDSKL: TJvCalcEdit;
    Label3: TLabel;
    eCSR: TJvCalcEdit;
    Label4: TLabel;
    eHibah: TJvCalcEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Panel1: TPanel;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ShowSettingPersentaseBagianAmil: Boolean;

implementation

{$R *.dfm}

uses umain;

function ShowSettingPersentaseBagianAmil: Boolean;
begin
  with TFSettingPersentaseBagianAmil.Create(Application) do
  begin
    try
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TFSettingPersentaseBagianAmil.Button1Click(Sender: TObject);
begin
  tag := mrCancel;
  Close;
end;

procedure TFSettingPersentaseBagianAmil.Button2Click(Sender: TObject);
begin
  if ask('Semua data sudah benar?') = mrYes then
  begin
    SetOption(CurrentUser.KodeCabang+'persen-amil-zakat', FloatToSQL(eZakat.Value/100));
    SetOption(CurrentUser.KodeCabang+'persen-amil-infak-sedekah', FloatToSQL(eIS.Value/100));
    SetOption(CurrentUser.KodeCabang+'persen-amil-dskl', FloatToSQL(eDSKL.Value/100));
    SetOption(CurrentUser.KodeCabang+'persen-amil-csr', FloatToSQL(eCSR.Value/100));
    SetOption(CurrentUser.KodeCabang+'persen-amil-hibah', FloatToSQL(eHibah.Value/100));
    tag := mrOk;
    Close;
  end;
end;

procedure TFSettingPersentaseBagianAmil.FormCreate(Sender: TObject);
begin
  eZakat.Value  := _f(GetOption(CurrentUser.KodeCabang+'persen-amil-zakat'), 0.125)*100;
  eIS.Value     := _f(GetOption(CurrentUser.KodeCabang+'persen-amil-infak-sedekah'),    0.200)*100;
  eDSKL.Value   := _f(GetOption(CurrentUser.KodeCabang+'persen-amil-dskl'),  0.200)*100;
  eCSR.Value    := _f(GetOption(CurrentUser.KodeCabang+'persen-amil-csr'),   0.100)*100;
  eHibah.Value  := _f(GetOption(CurrentUser.KodeCabang+'persen-amil-hibah'), 0.200)*100;
end;

end.
