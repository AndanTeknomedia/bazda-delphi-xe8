unit u_show_plain_text;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, ValEdit;

type
  TFShowPlainText = class(TForm)
    ValueListEditor1: TValueListEditor;
    Panel1: TPanel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ShowPairedText(Strings: TStringList; ACaption: String = 'Informasi');

implementation

{$R *.dfm}

procedure ShowPairedText;
begin
  with TFShowPlainText.Create(Application) do
  begin
    try
      ValueListEditor1.Strings.Assign(Strings);
      Caption := ACaption;
      // Mouse.CursorPos := ClientToScreen(Point(Button1.Left + 5, Button1.Top + 5));
      ShowModal;
    finally
      Free;
    end;
  end;
end;


procedure TFShowPlainText.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
