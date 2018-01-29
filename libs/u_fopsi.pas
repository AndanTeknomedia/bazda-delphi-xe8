unit u_fopsi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ActnList, PlatformDefaultStyleActnCtrls, ActnMan;

type
  TFPilihOpsi = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ActionManager1: TActionManager;
    acOK: TAction;
    ListBox1: TListBox;
    procedure Button2Click(Sender: TObject);
    procedure acOKExecute(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function PilihOpsi(const ACaption: String; const Opsi: array of string; const DefaultIndex: Integer = -1): Integer;

implementation

uses u_utils;

{$R *.dfm}

function PilihOpsi;
var
  i: Integer;
begin
  Result := -1;
  with TFPilihOpsi.Create(Application) do
  begin
    try
      Caption := ACaption;
      ListBox1.Items.Clear;
      for i:= 0 to Length(Opsi)-1 do
      begin
        ListBox1.Items.Add(opsi[i]);
      end;
      if (DefaultIndex > -1) and (DefaultIndex < Length(opsi)) then
        ListBox1.ItemIndex := DefaultIndex
      else
        ListBox1.ItemIndex := -1;
      ShowModal;
      if tag = mrOk then
        Result := ListBox1.ItemIndex;
    finally
      Free;
    end;
  end;
end;

procedure TFPilihOpsi.acOKExecute(Sender: TObject);
begin
  tag := mrOk;
  Close;
end;

procedure TFPilihOpsi.Button2Click(Sender: TObject);
begin
  tag := mrCancel;
  Close;
end;

procedure TFPilihOpsi.ListBox1DblClick(Sender: TObject);
begin
  acOK.Execute;
end;

end.
