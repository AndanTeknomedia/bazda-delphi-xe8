unit u_rek_transaksi_kas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,
  MemTableDataEh, Db, MemTableEh, Menus, MemDS, DBAccess, Uni, StdCtrls,
  ExtCtrls, GridsEh, DBAxisGridsEh, DBGridEh, u_utils;

type
  
  TFRekTransaksiKas = class(TForm)
    gep: TDBGridEh;
    Panel3: TPanel;
    Button2: TButton;
    Button3: TButton;
    MyQuery1: TUniQuery;
    MyDataSource1: TDataSource;
    PopupMenu1: TPopupMenu;
    Find1: TMenuItem;
    Edit1: TMenuItem;
    mt: TMemTableEh;
    MyQuery1lvl: TIntegerField;
    MyQuery1pkode: TStringField;
    MyQuery1kode: TMemoField;
    MyQuery1f1: TStringField;
    MyQuery1f2: TStringField;
    MyQuery1f3: TStringField;
    MyQuery1f4: TStringField;
    MyQuery1f5: TStringField;
    MyQuery1fkode: TStringField;
    MyQuery1uraian: TStringField;
    MyQuery1jumlah: TFloatField;
    mtlvl: TIntegerField;
    mtpkode: TStringField;
    mtkode: TMemoField;
    mtf1: TStringField;
    mtf2: TStringField;
    mtf3: TStringField;
    mtf4: TStringField;
    mtf5: TStringField;
    mtfkode: TStringField;
    mturaian: TStringField;
    mtjumlah: TFloatField;
    MyQuery1vkode: TMemoField;
    mtvkode: TMemoField;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure gepAdvDrawDataCell(Sender: TCustomDBGridEh; Cell,
      AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
      var Params: TColCellParamsEh; var Processed: Boolean);
    procedure gepDblClick(Sender: TObject);
    procedure gepKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    _allowedLevel: Integer;
  public
    { Public declarations }
  end;

var
  FRekTransaksiKas: TFRekTransaksiKas;

function GetRekeningTransaksiKas(Kategori: TKategoriRekeningTransaksiR; const AllowedLevel:integer=5; const LevelFrom: Integer = 0; LevelTo: Integer = 0): TRekeningTransaksi;

implementation

uses u_display_text;

{$R *.dfm}

function GetRekeningTransaksiKas(Kategori: TKategoriRekeningTransaksiR; const AllowedLevel:integer=5; const LevelFrom: Integer = 0; LevelTo: Integer = 0): TRekeningTransaksi;
var
  sql: String;
  whereLevel: String;
begin
  Result.Clear;
  if Kategori = [] then
    exit;

  whereLevel := '';
  if (LevelFrom<=0) and (levelTo<=0) then
  begin
    whereLevel := '';
  end
  else
  begin
    if LevelFrom>0 then
      whereLevel :=  whereLevel +' and (tingkat >= '+_s(LevelFrom)+') ';
    if LevelTo>0 then
      if LevelFrom>0 then
      whereLevel :=  whereLevel +' and (tingkat<= '+_s(LevelTo)+') ';
  end;

  sql := '';
  if kategori = [krtNeraca] then
    sql := 'select * from v_coa_2 where substr(kode,1,1) in (''1'') ' + whereLevel
  else
  if kategori=[krtPengeluaran, krtPenerimaan] then
    sql := 'select * from v_coa_2 where substr(kode,1,1) in (''4'',''5'')' + whereLevel
  else
  if kategori = [krtPenerimaan] then
    sql := 'select * from v_coa_2 where substr(kode,1,1) in (''4'')' + whereLevel
  else
  if kategori = [krtPengeluaran] then
    sql := 'select * from v_coa_2 where substr(kode,1,1) in (''5'')' + whereLevel
  else
  if kategori = [krtPenerimaan, krtNeraca] then
    sql := 'select * from v_coa_2 where substr(kode,1,1) in (''1'',''4'')' + whereLevel
  else
  if kategori = [krtPengeluaran, krtNeraca] then
    sql := 'select * from v_coa_2 where substr(kode,1,1) in (''1'',''5'')' + whereLevel
  else
  if kategori = [krtPenerimaan, krtPengeluaran, krtNeraca] then
    sql := 'select * from v_coa_2 where (1=1) ' + whereLevel


  // sql := ShowText(sql);
  with TFRekTransaksiKas.Create(Application) do
  begin
    try
      MyQuery1.Connection := GetGlobalConnection;
      if MyQuery1.Active then
        MyQuery1.Close;
      MyQuery1.SQL.Text := sql;
      MyQuery1.Open;
      mt.LoadFromDataSet(MyQuery1, -1, lmCopy, false);
      mt.Open;
      _allowedLevel := AllowedLevel;
      tag := mrNone;
      ShowModal;
      if Tag = mrOk then
      begin
        with Result do
        begin
          Berisi := true;
          if AllowedLevel = 5 then
          begin
            apbd5.PKode  := mtpkode.AsString;
            apbd5.Kode  := mtkode.AsString;
            apbd5.FKode := mtfkode.AsString;
            apbd5.Uraian:= mturaian.AsString;
            apbd5.Jumlah:= mtjumlah.AsFloat;
            if mt.Locate('kode', APBD5.PKode, []) then
            begin
              apbd4.PKode  := mtpkode.AsString;
              apbd4.Kode  := mtkode.AsString;
              apbd4.FKode := mtfkode.AsString;
              apbd4.Uraian:= mturaian.AsString;
              apbd4.Jumlah:= mtjumlah.AsFloat;
              if mt.Locate('kode', APBD4.PKode, []) then
              begin
                apbd3.PKode  := mtpkode.AsString;
                apbd3.Kode  := mtkode.AsString;
                apbd3.FKode := mtfkode.AsString;
                apbd3.Uraian:= mturaian.AsString;
                apbd3.Jumlah:= mtjumlah.AsFloat;
                if mt.Locate('kode', APBD3.PKode, []) then
                begin
                  apbd2.PKode  := mtpkode.AsString;
                  apbd2.Kode  := mtkode.AsString;
                  apbd2.FKode := mtfkode.AsString;
                  apbd2.Uraian:= mturaian.AsString;
                  apbd2.Jumlah:= mtjumlah.AsFloat;
                  if mt.Locate('kode', APBD2.PKode, []) then
                  begin
                    apbd1.PKode  := mtpkode.AsString;
                    apbd1.Kode  := mtkode.AsString;
                    apbd1.FKode := mtfkode.AsString;
                    apbd1.Uraian:= mturaian.AsString;
                    apbd1.Jumlah:= mtjumlah.AsFloat;
                  end;
                end;
              end;
            end;
          end
          else
          if AllowedLevel = 4 then
          begin
            apbd4.PKode  := mtpkode.AsString;
            apbd4.Kode  := mtkode.AsString;
            apbd4.FKode := mtfkode.AsString;
            apbd4.Uraian:= mturaian.AsString;
            apbd4.Jumlah:= mtjumlah.AsFloat;
            if mt.Locate('kode', APBD4.PKode, []) then
            begin
              apbd3.PKode  := mtpkode.AsString;
              apbd3.Kode  := mtkode.AsString;
              apbd3.FKode := mtfkode.AsString;
              apbd3.Uraian:= mturaian.AsString;
              apbd3.Jumlah:= mtjumlah.AsFloat;
              if mt.Locate('kode', APBD3.PKode, []) then
              begin
                apbd2.PKode  := mtpkode.AsString;
                apbd2.Kode  := mtkode.AsString;
                apbd2.FKode := mtfkode.AsString;
                apbd2.Uraian:= mturaian.AsString;
                apbd2.Jumlah:= mtjumlah.AsFloat;
                if mt.Locate('kode', APBD2.PKode, []) then
                begin
                  apbd1.PKode  := mtpkode.AsString;
                  apbd1.Kode  := mtkode.AsString;
                  apbd1.FKode := mtfkode.AsString;
                  apbd1.Uraian:= mturaian.AsString;
                  apbd1.Jumlah:= mtjumlah.AsFloat;
                end;
              end;
            end;
          end
          else
          if AllowedLevel = 3 then
          begin
            apbd3.PKode  := mtpkode.AsString;
            apbd3.Kode  := mtkode.AsString;
            apbd3.FKode := mtfkode.AsString;
            apbd3.Uraian:= mturaian.AsString;
            apbd3.Jumlah:= mtjumlah.AsFloat;
            if mt.Locate('kode', APBD3.PKode, []) then
            begin
              apbd2.PKode  := mtpkode.AsString;
              apbd2.Kode  := mtkode.AsString;
              apbd2.FKode := mtfkode.AsString;
              apbd2.Uraian:= mturaian.AsString;
              apbd2.Jumlah:= mtjumlah.AsFloat;
              if mt.Locate('kode', APBD2.PKode, []) then
              begin
                apbd1.PKode  := mtpkode.AsString;
                apbd1.Kode  := mtkode.AsString;
                apbd1.FKode := mtfkode.AsString;
                apbd1.Uraian:= mturaian.AsString;
                apbd1.Jumlah:= mtjumlah.AsFloat;
              end;
            end;
          end
          else
          if AllowedLevel = 2 then
          begin
            apbd2.PKode  := mtpkode.AsString;
            apbd2.Kode  := mtkode.AsString;
            apbd2.FKode := mtfkode.AsString;
            apbd2.Uraian:= mturaian.AsString;
            apbd2.Jumlah:= mtjumlah.AsFloat;
            if mt.Locate('kode', APBD2.PKode, []) then
            begin
              apbd1.PKode  := mtpkode.AsString;
              apbd1.Kode  := mtkode.AsString;
              apbd1.FKode := mtfkode.AsString;
              apbd1.Uraian:= mturaian.AsString;
              apbd1.Jumlah:= mtjumlah.AsFloat;
            end;
          end
          else
          if AllowedLevel = 1 then
          begin
            apbd1.PKode  := mtpkode.AsString;
            apbd1.Kode  := mtkode.AsString;
            apbd1.FKode := mtfkode.AsString;
            apbd1.Uraian:= mturaian.AsString;
            apbd1.Jumlah:= mtjumlah.AsFloat;
          end;
        end;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TFRekTransaksiKas.Button2Click(Sender: TObject);
begin
  if mt.IsEmpty then
  begin
    Tag := mrCancel;
    close;
  end;

  if _allowedLevel<>mtlvl.AsInteger then
  begin
    warn('Pilih Rekening anak saja (berwarna latar hijau muda.');
    gep.SetFocus;
    exit;
  end;

  tag := mrOk;
  close;
end;

procedure TFRekTransaksiKas.Button3Click(Sender: TObject);
begin
  ModalResult := mrCancel;
  close;
end;

procedure TFRekTransaksiKas.FormCreate(Sender: TObject);
begin
  MyQuery1.Connection := GetGlobalConnection;
end;

procedure TFRekTransaksiKas.gepAdvDrawDataCell(Sender: TCustomDBGridEh; Cell,
  AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
  var Params: TColCellParamsEh; var Processed: Boolean);
begin
  if Sender.DataSource.DataSet.FieldByName('lvl').AsInteger = _allowedLevel then
    Params.Background := $00F1FEED { $00CFFFC6 } ;
end;

procedure TFRekTransaksiKas.gepDblClick(Sender: TObject);
begin
  Button2.Click;
end;

procedure TFRekTransaksiKas.gepKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
  begin
    Button2.Click;
    exit;
  end
  else
  if chr(key) in ['a'..'z','A'..'Z','0'..'9'] then
  begin
    SendCtrlF;
  end
  else
  if Key = VK_UP then
  begin
    if MyQuery1.Bof then
      SendCtrlF;
  end
  else
  if Key = VK_Down then
  begin
    if MyQuery1.Eof then
      SendCtrlF;
  end;
end;


end.
