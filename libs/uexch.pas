unit uexch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, JvExControls, JvXPCore, JvXPButtons, StdCtrls,
  JvComponentBase, JvErrorIndicator, pngimage;

type
  TFExceptionH = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Panel2: TPanel;
    Image2: TImage;
    Panel3: TPanel;
    Button1: TButton;
    Button2: TButton;
    Bevel2: TBevel;
    Panel4: TPanel;
    Bevel3: TBevel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Memo1: TMemo;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure DummyException(Sender: TObject; E: Exception);
  public
    { Public declarations }
  end;

var
  FExceptionH: TFExceptionH;

procedure ShowException(Sender: TObject; E: Exception);

implementation

{$R *.dfm}

var
  tempExcH: TExceptionEvent;

procedure ShowException(Sender: TObject; E: Exception);
var
  b: TBitmap;
  f: TForm;
begin
  tempExcH := Application.OnException;
  Application.OnException := FExceptionH.DummyException;
  try
    FExceptionH := TFExceptionH.Create(Application);
    try
      b := TBitmap.Create;
      try
        Application.OnException := FExceptionH.DummyException;
        with FExceptionH do
        begin
          Edit2.Text := Sender.ClassName;
          if Sender is TControl then
            Edit3.Text := TControl(Sender).Name +'@'+ TControl(Sender).Owner.Name
          else
            Edit3.Text := 'Unknown';
          with Memo1.Lines do
          begin
            Add(E.Message);
          end;
          if Screen.FormCount>0 then
          begin
            f := Screen.ActiveForm;
            if Assigned(f) then
            begin
              b.Width := f.ClientWidth;
              b.Height := f.ClientHeight;
              b.Canvas.CopyRect(rect(0,0, f.ClientWidth, f.ClientHeight), f.Canvas, rect(0,0,b.Width, b.Height));
              Image2.Picture.Assign(b);
            end;
          end;
          ShowModal;
        end;
      finally
        b.Free;
      end;
    finally
      FExceptionH.Free;
    end;
  finally
    Application.OnException := tempExcH;
  end;
end;

procedure TFExceptionH.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TFExceptionH.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TFExceptionH.DummyException(Sender: TObject; E: Exception);
begin
  //
end;

end.
