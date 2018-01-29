unit u_input_float;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, JvExMask, JvToolEdit, JvBaseEdits, ExtCtrls, ComCtrls, u_utils, umain,
  Buttons;

type
  TPInputFloat = class(TForm)
    Panel2: TPanel;
    Bevel2: TBevel;
    Button1: TButton;
    Button2: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    JvCalcEdit1: TJvCalcEdit;
    JvCalcEdit2: TJvCalcEdit;
    Label3: TLabel;
    JvCalcEdit3: TJvCalcEdit;
    Label4: TLabel;
    JvCalcEdit4: TJvCalcEdit;
    Label5: TLabel;
    JvCalcEdit5: TJvCalcEdit;
    Label6: TLabel;
    JvCalcEdit6: TJvCalcEdit;
    dp1: TDateTimePicker;
    Label7: TLabel;
    eBayar: TButtonedEdit;
    Label8: TLabel;
    SpeedButton1: TSpeedButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure eBayarRightButtonClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PInputFloat: TPInputFloat;

function InputFloat(const ACaption, ALabel1 :String; var AValue: Double): Boolean;
function InputFloat2(const ACaption, ALabel1, ALabel2: String; var AValue1, AValue2: Double): Boolean;
function InputBayar(const ACaption, LabelNilai, LabelTerbayar, LabelSisa, LabelBayar: String;
                    const ValNilai, ValTerbayar, ValSisa: DOuble;
                    var   ValBayar: DOuble; var Valtanggal: TDate; var ValAkun: String; const Editable: Boolean = True): Boolean;
function EditBayar(const ACaption, LabelBayar: String; const LimitMaxBayar: Double; var ValBayar: DOuble; var Valtanggal: TDate; var ValAkun, ValRek: String): Boolean;

implementation

{$R *.dfm}

function InputFloat;
begin
  Result                := False;
  with TPInputFloat.Create(Application) do
  begin
    try
      PageControl1.Pages[1].TabVisible := False;
      Caption           := ACaption;
      Label1.Caption    := ALabel1;
      Label1.AutoSize   := true;
      JvCalcEdit1.Value := AValue;
      dp1.Hide;
      Label7.Hide;
      Label2.Hide;
      JvCalcEdit2.Hide;
      Tag               := mrNone;
      Width             := 240;
      Height            := 205;
      AValue            := 0;
      focusto(JvCalcEdit1);
      ShowModal;
      if Tag = mrOk then
      begin
        AValue          := JvCalcEdit1.Value;
        Result          := True;
      end;
    finally
      Free;
    end;
  end;
end;

function InputFloat2;
begin
  Result                := False;
  with TPInputFloat.Create(Application) do
  begin
    try
      PageControl1.Pages[1].TabVisible := False;
      Caption           := ACaption;
      Label1.Caption    := ALabel1;
      JvCalcEdit1.Value := AValue1;
      Label2.Caption    := ALabel2;
      JvCalcEdit2.Value := AValue2;
      Label7.Hide;
      dp1.Hide;
      focusto(JvCalcEdit1);
      Width             := 225;
      Height            := 205;
      Tag               := mrNone;
      AValue1           := 0;
      AValue2           := 0;
      ShowModal;
      if Tag = mrOk then
      begin
        AValue1         := JvCalcEdit1.Value;
        AValue2         := JvCalcEdit2.Value;
        Result          := True;
      end;
    finally
      Free;
    end;
  end;
end;

function InputBayar;
var
  d: String;
begin
  Result                := False;
  with TPInputFloat.Create(Application) do
  begin
    try
      PageControl1.Pages[0].TabVisible := False;
      Caption           := ACaption;
      Label3.Caption    := LabelNilai;
      Label4.Caption    := LabelTerbayar;
      Label5.Caption    := LabelSisa;
      Label6.Caption    := LabelBayar;
      JvCalcEdit3.Value := ValNilai;
      JvCalcEdit4.Value := ValTerbayar;
      JvCalcEdit5.Value := ValSisa;
      JvCalcEdit6.Value := ValBayar;

      JvCalcEdit6.Enabled := Editable;
      if not Editable then
        JvCalcEdit6.DisabledColor := JvCalcEdit5.DisabledColor;
      focusto(JvCalcEdit6);

      Width             := 430;
      Height            := 306;
      Tag               := mrNone;
      ValBayar          := 0;
      Valtanggal        := INVALID_DATE_VALUE;
      ValAkun           := '';

      d                 := GetOption(Name+'_data@'+dp1.Name, true);
      if length(trim(d)) <> 10 then
        dp1.Date        := Date
      else
        dp1.Date        := encodeDate(_i(copy(d,1,4)), _i(copy(d,6,2)), _i(copy(d,9,2)));
      eBayar.HiddenText := GetOption(Name+'_data@'+eBayar.Name, true);
      eBayar.Text       := GetOption(Name+'_text@'+eBayar.Name, true);


      ShowModal;
      if Tag = mrOk then
      begin
        ValBayar        := JvCalcEdit6.Value;
        ValTanggal      := dp1.Date;
        ValAkun         := eBayar.HiddenText;
        SetOption(Name+'_data@'+eBayar.Name, eBayar.HiddenText, true);
        SetOption(Name+'_text@'+eBayar.Name, eBayar.Text, true);
        SetOption(Name+'_data@'+dp1.Name, DateToSQL(dp1.Date), true);
        Result          := True;
      end;
    finally
      Free;
    end;
  end;
end;

function EditBayar;
begin
  Result                := False;
  //ShowMessage(FloatToFinance(LimitMaxBayar));
  with TPInputFloat.Create(Application) do
  begin
    try
      PageControl1.Pages[0].TabVisible := False;
      Caption           := ACaption;
      Label3.Hide;
      Label4.Hide;
      Label5.Hide;
      JvCalcEdit3.Hide;
      JvCalcEdit4.Hide;
      JvCalcEdit5.Hide;

      Label6.Caption    := LabelBayar;
      Label6.Top        := Label3.Top;
      Label7.Top        := Label4.Top;
      Label8.Top        := Label5.Top;

      JvCalcEdit6.Top   := JvCalcEdit3.Top;
      dp1.Top           := JvCalcEdit4.Top;
      eBayar.Top        := JvCalcEdit5.Top;

      JvCalcEdit6.Value := ValBayar;
      dp1.Date          := Valtanggal;
      eBayar.HiddenText := ValAkun;
      eBayar.Text       := ValRek;
      eBayar.HiddenFloat:= LimitMaxBayar;
      eBayar.HiddenInt  := 1; //penanda mode edit.

      focusto(JvCalcEdit6);

      Width             := 430;
      Height            := 194;
      Tag               := mrNone;

      ShowModal;
      if Tag = mrOk then
      begin
        ValBayar        := JvCalcEdit6.Value;
        ValTanggal      := dp1.Date;
        ValAkun         := eBayar.HiddenText;
        SetOption(Name+'_data@'+eBayar.Name, eBayar.HiddenText, true);
        SetOption(Name+'_text@'+eBayar.Name, eBayar.Text, true);
        SetOption(Name+'_data@'+dp1.Name, DateToSQL(dp1.Date), true);
        Result          := True;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TPInputFloat.Button1Click(Sender: TObject);
begin
  if eBayar.HiddenInt = 1 then
  // mode edit:
  begin
    if JvCalcEdit6.Value > eBayar.HiddenFloat then
    begin
      Warn('Pembayaran melebihi sisa piutang.'#13'Sisa Piutang: Rp '+FloatToFinance(eBayar.HiddenFloat), handle);
      FocusTo(JvCalcEdit6);
      exit;
    end;
  end
  else
  begin
    if JvCalcEdit6.Value > JvCalcEdit5.Value then
    begin
      Warn('Pembayaran melebihi sisa piutang.', handle);
      FocusTo(JvCalcEdit6);
      exit;
    end;
  end;
  Tag := mrOk;
  Close;
end;

procedure TPInputFloat.Button2Click(Sender: TObject);
begin
  Tag := mrCancel;
  Close;
end;

procedure TPInputFloat.eBayarRightButtonClick(Sender: TObject);
begin
  //
end;

procedure TPInputFloat.SpeedButton1Click(Sender: TObject);
begin
  //
end;

end.
