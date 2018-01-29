unit u_pembuat_dokumen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ToolWin, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  ExtCtrls, StdCtrls, DBGridEhGrouping, GridsEh, DBGridEh, DB, MemDS,
  DBAccess, Menus, ToolCtrlsEh,
  DBGridEhToolCtrls, DBAxisGridsEh, DynVarsEh, Uni, umain, u_utils,
  frxClass, frxDBSet, Grids, DBGrids, System.Actions, EhLibVCL, Vcl.DBCtrls,
  JvComponentBase, JvEnterTab, Vcl.ComCtrls, Vcl.Mask, JvExMask, JvToolEdit,
  JvBaseEdits, JvSpin, Vcl.Buttons, System.DateUtils, JvExExtCtrls,
  JvExtComponent, JvCaptionPanel, VirtualTable, System.Win.ComObj,
  u_dbgrideh_dac_helper;

type
  TPembuatDokumen = record
    Fungsi: String[100];
    Nama: String[200];
    Jabatan: String[100];
    procedure Clear;
  end;
  TPembuatDokumenArray = array of TPembuatDokumen;

  TFPembuatDokumen = class(TForm)
    DataSource2: TDataSource;
    VirtualTable1: TVirtualTable;
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    VirtualTable1Fungsi: TStringField;
    VirtualTable1Nama: TStringField;
    VirtualTable1Jabatan: TStringField;
    procedure DBGridEh1Columns1EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function InputPembuatDokumen(TTDs: TPembuatDokumenArray): Boolean;

implementation

uses u_display_text, u_select_kode_name, u_frutils, u_select_master_detail;

{$R *.dfm}

function InputPembuatDokumen;
var
  i: Integer;
begin
  Result := false;
  if length(ttds)= 0 then exit;
  with TFPembuatDokumen.Create(Application) do
  begin
    try
      if not VirtualTable1.Active then
        VirtualTable1.Open;
      VirtualTable1.DisableControls;
      EmptyDataset(VirtualTable1);
      try
        for i := 0 to Length(TTDs)-1 do
        begin
          VirtualTable1.AppendRecord([TTDs[i].Fungsi, TTDs[i].Nama,TTDs[i].Jabatan]);
        end;
      finally
        VirtualTable1.EnableControls;
      end;
      if not VirtualTable1.IsEmpty then
        VirtualTable1.First;
      Tag := mrNone;
      ShowModal;
      if tag = mrOk then
      begin
        VirtualTable1.First;
        i := 0;
        while not VirtualTable1.Eof do
        begin
          ttds[i].Clear;
          ttds[i].Fungsi := VirtualTable1Fungsi.AsString;
          ttds[i].Nama := VirtualTable1Nama.AsString;
          ttds[i].Jabatan := VirtualTable1Jabatan.AsString;
          inc(i);
          VirtualTable1.Next;
        end;
        Result := true;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TFPembuatDokumen.Button1Click(Sender: TObject);
begin
  tag := mrcancel;
  close;
end;

procedure TFPembuatDokumen.Button2Click(Sender: TObject);
begin
  tag := mrOk;
  close;
end;

procedure TFPembuatDokumen.DBGridEh1Columns1EditButtonClick(Sender: TObject;
  var Handled: Boolean);
var
  sl: TStringList;
begin
  sl := SelectKodeName(GetGlobalConnection, 'select "Nama Lengkap","Jabatan" from vw_pegawai_ringkas where substr("NRP",1,3) = '+QuotedStr(CurrentUser.KodeCabang),
      ['Nama Lengkap', 'Jabatan'], ['Nama Lengkap', 'Jabatan'],[150,150]);
  if sl.Count>0 then
  begin
    if VirtualTable1.State<>dsEdit then
    begin
      VirtualTable1.Edit;
      VirtualTable1Nama.AsString := sl[0];
      VirtualTable1Jabatan.AsString := sl[1];
    end;
  end;
  FreeAndNil(sl);
end;

{ TPembuatDokumen }

procedure TPembuatDokumen.Clear;
begin
  self.Fungsi := '';
  self.Nama := '';
  self.Jabatan := '';
end;

end.
