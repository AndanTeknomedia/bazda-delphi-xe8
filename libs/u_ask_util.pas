unit u_ask_util;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, uMain, u_Utils;

type
  TFaskUtil = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FaskUtil: TFaskUtil;

function AskOpt(const Question: String; const AHandle: Hwnd = 0; const OptDontShowAgain: Boolean = False): Integer;

implementation

{$R *.dfm}

function AskOpt(const Question: String; const AHandle: Hwnd = 0; const OptDontShowAgain: Boolean = False): Integer;
var
  opt_name,
  opt_show,
  opt_val: String;
begin
  Result := 0;
  Assert(trim(QUestion) <> '');
  opt_name := 'AskOpt-'+md5(Question);
  opt_show := GetOption(opt_name, True);
  if trim(opt_show) <> '' then
  begin
    opt_val  := _s(_i(GetOption(opt_show, True),0));
    if opt_val = '1' then
      Result := ID_Yes
    else
      Result := ID_No;
  end
  else
  begin
    opt_val := '0';
    if AHandle<>INVALID_HANDLE_VALUE then
    begin
      with TFaskUtil.Create(Application) do
      begin
        Caption := 'Konfirmasi';
        Label1.Caption := Question;
        ShowModal;
        if ModalResult = mrYes then
          Result := ID_YES
        else
          Result := ID_NO;
        opt_val  := _IIF(Result = ID_YES, '1','0');
        opt_show := _IIF( (* (Result = ID_YES) and *) CheckBox1.Checked, 'saved','not saved');
        Free;
      end;
    end
    else
    begin
      with TFaskUtil.Create(Application) do
      begin
        Caption := 'Konfirmasi';
        Label1.Caption := Question;
        ShowModal;
        if ModalResult = mrYes then
          Result := ID_YES
        else
          Result := ID_NO;
        opt_val := _IIF(Result = ID_YES, '1','0');
        opt_show := _IIF( (* (Result = ID_YES) and *)  CheckBox1.Checked, 'saved','not saved');
        Free;
      end;
    end;
    if opt_show = 'saved' then
    begin
      SetOption(opt_name, opt_name+'-value', true);
      SetOption(opt_name+'-value', opt_val, true);
    end;
  end;
end;

end.
