unit u_user_akses;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, Data.DB, MemDS, VirtualTable, EhLibVCL, GridsEh,
  DBAxisGridsEh, DBGridEh, DBAccess, Uni, u_utils, Vcl.DBCtrls, System.Actions,
  Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.Menus;

type
  TFUserAccessControl = class(TForm)
    Panel6: TPanel;
    Bevel5: TBevel;
    Button3: TButton;
    Button4: TButton;
    vtAccess: TVirtualTable;
    dsAccess: TDataSource;
    Panel1: TPanel;
    DBLookupComboBox1: TDBLookupComboBox;
    Label1: TLabel;
    Splitter1: TSplitter;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    geAkses: TDBGridEh;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    geUsers: TDBGridEh;
    qTipe: TUniQuery;
    dsTipe: TDataSource;
    dsUsers: TDataSource;
    qAkses: TUniQuery;
    qAkseskode: TStringField;
    qAksesaccess_item_name: TStringField;
    qAksesuraian: TStringField;
    qAksesjml: TLargeintField;
    qTipetipe: TStringField;
    qTipeuraian: TStringField;
    qUsers: TUniQuery;
    qUsersgroup_kode: TStringField;
    qUserskode: TStringField;
    qUsersuraian: TStringField;
    qUsersid: TLargeintField;
    vtAccesskode: TStringField;
    vtAccessHakAkses: TStringField;
    vtAccessUraian: TStringField;
    vtAccessIjin: TStringField;
    Button1: TButton;
    ActionManager1: TActionManager;
    acRefresh: TAction;
    PopupMenu1: TPopupMenu;
    UserBaru1: TMenuItem;
    EditUser1: TMenuItem;
    Hapus1: TMenuItem;
    N1: TMenuItem;
    PopupMenu2: TPopupMenu;
    IjinkanSemua1: TMenuItem;
    LarangSemua1: TMenuItem;
    N2: TMenuItem;
    Refresh1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure vtAccessAfterPost(DataSet: TDataSet);
    procedure Button3Click(Sender: TObject);
    procedure qUsersAfterScroll(DataSet: TDataSet);
    procedure qTipeAfterScroll(DataSet: TDataSet);
    procedure IjinkanSemua1Click(Sender: TObject);
    procedure LarangSemua1Click(Sender: TObject);
    procedure acRefreshExecute(Sender: TObject);
    procedure UserBaru1Click(Sender: TObject);
    procedure EditUser1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RefreshData(UserName: String);
    procedure SaveData;
  end;

var
  FUserAccessControl: TFUserAccessControl;

implementation

{$R *.dfm}

uses umain, u_display_text, u_edit_user;

procedure TFUserAccessControl.acRefreshExecute(Sender: TObject);
begin
  if not qUsers.IsEmpty then
  begin
    RefreshData(qUserskode.AsString);
  end;
end;

procedure TFUserAccessControl.Button3Click(Sender: TObject);
var
  q: TUniQuery;
  e: integer;
  s: string;
begin
  if vtAccess.IsEmpty then
    exit;
  q := Query;
  StartTrans;
  vtAccess.DisableControls;
  try
    // s := s+#13#10'select user_revoke_all_access('+_s(qUsersid.AsInteger)+')';
    q.SQL.Text := 'select user_revoke_all_access('+_s(qUsersid.AsInteger)+')';
    try q.Execute; except inc(e); end;
    vtAccess.First;
    while not vtAccess.Eof do
    begin
      if vtAccessIjin.AsString = 'Y' then
      begin
        if q.Active then
          q.Close;
        // s := s+#13#10'select user_add_access_list('+_s(qUsersid.AsInteger)+', '+_q(vtAccessHakAkses.AsString)+')';
        q.SQL.Text := 'select user_add_access_list('+_s(qUsersid.AsInteger)+', '+_q(vtAccessHakAkses.AsString)+')';
        try q.Execute; except inc(e); end;
      end;
      vtAccess.Next;
    end;
    // ShowText(s);
  finally
    q.Free;
    vtAccess.EnableControls;
    if e = 0 then
    begin
      CommitTrans;
      Inform('Sukses mengupdate hak akses.');
      Button3.Enabled := false;
      RefreshData(qUserskode.AsString);
    end
    else
    begin
      RollBackTrans;
      Deny('Gagal mengupdate hak akses!');
    end;
  end;
end;

procedure TFUserAccessControl.EditUser1Click(Sender: TObject);
var
  u: TUser;
  q: TUniQuery;
begin
  if qUsers.IsEmpty then
    exit;
  q := ExecSQL('SELECT u.*, g.group_name FROM usr_user u '+
    'inner join usr_group g on g.group_kode = u.group_kode '+
    'where u.user_name = '+QuotedStr(qUserskode.AsString));
  with q do
  begin
    u.Clear;
    if IsEmpty then
    begin
      Warn('User tidak ditemukan!');
    end
    else
    begin
      first;
      u.ID := FieldByName('id').AsInteger;
      u.GrupName  := FieldByName('group_name').AsString;
      u.UserName  := FieldByName('user_name').AsString;
      u.FullName  := FieldByName('full_name').AsString;
      u.Grup      := FieldByName('group_kode').AsString;
      u.AllowLogin:= FieldByName('allow_login').AsString = 'Y';
      if ShowEditUser(u) then
      begin
        try
          u_utils.ExecSQL(
            'update usr_user set '+
            _iif(u.Password<>'', 'user_password = md5('+_q(u.Password)+'), ','')+
            'full_name = '+_q(u.FullName)+', '+
            'group_kode = '+_q(u.Grup)+', '+
            'allow_login ='+_q(_iif(u.AllowLogin, 'Y','N'))+' where '+
            'user_name = '+_q(u.UserName)
          ).Free;
          Inform('User telah disimpan.');
        except
          Deny('Gagal mengupdate data user.');
        end;
      end;
    end;
    Free;
  end;
end;

procedure TFUserAccessControl.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFUserAccessControl.FormCreate(Sender: TObject);
begin
  if not qTipe.Active then
    qTipe.Open;
  if not qUsers.Active then
    qUsers.Open
  else
    qUsers.Refresh;
  if not qTipe.IsEmpty then
  begin
    qTipe.First;
    DBLookupComboBox1.KeyValue := qTipetipe.AsString;
  end;
  if not qUsers.IsEmpty then
  begin
    qUsers.First;
    RefreshData(qUserskode.AsString);
  end;
end;

procedure TFUserAccessControl.IjinkanSemua1Click(Sender: TObject);
var
  t,
  kd: string;
begin
  if vtAccess.IsEmpty then exit;
  kd := vtAccesskode.AsString;
  vtAccess.DisableControls;
  try
    vtAccess.First;
    while not vtAccess.Eof do
    begin
      t := vtAccesskode.AsString;
      vtAccess.Edit;
      vtAccessIjin.AsString := 'Y';
      vtAccess.Post;
      // vtAccess.Locate('kode', t, []);
      vtAccess.Next;
    end;
  finally
    vtAccess.Locate('kode', kd, []);
    vtAccess.EnableControls;
  end;
end;

procedure TFUserAccessControl.LarangSemua1Click(Sender: TObject);
var
  t,
  kd: string;
begin
  if vtAccess.IsEmpty then exit;
  kd := vtAccesskode.AsString;
  vtAccess.DisableControls;
  try
    vtAccess.First;
    while not vtAccess.Eof do
    begin
      t := vtAccesskode.AsString;
      vtAccess.Edit;
      vtAccessIjin.AsString := 'N';
      vtAccess.Post;
      // vtAccess.Locate('kode', t, []);
      vtAccess.Next;
    end;
  finally
    vtAccess.Locate('kode', kd, []);
    vtAccess.EnableControls;
  end;
end;

procedure TFUserAccessControl.qTipeAfterScroll(DataSet: TDataSet);
begin
  qUsersAfterScroll(qUsers);
end;

procedure TFUserAccessControl.qUsersAfterScroll(DataSet: TDataSet);
begin
  RefreshData(qUserskode.AsString);
end;

procedure TFUserAccessControl.RefreshData;
begin
  if not vtAccess.Active then
    vtAccess.Open;
  vtAccess.DisableControls;
  try
    if not vtAccess.IsEmpty then
    begin
      vtAccess.First;
      while not vtAccess.IsEmpty do
        vtAccess.Delete;
    end;
  finally
    vtAccess.EnableControls;
  end;
  Button3.Enabled := false;
  if qUsers.IsEmpty then
    exit;
  if qAkses.Active then
    qAkses.Close;
  vtAccess.AfterPost:= nil;
  qAkses.ParamByName('uid').AsInteger := qUsersid.AsInteger;
  qAkses.Open;
  vtAccess.DisableControls;
  try
    if not qAkses.IsEmpty then
    begin
      qAkses.First;
      while not qAkses.Eof do
      begin
        vtAccess.AppendRecord([
          qAkseskode.AsString,
          qAksesaccess_item_name.AsString,
          qAksesuraian.AsString,
          _IIF(qAksesjml.AsInteger>0, 'Y','N')
        ]);
        qAkses.Next;
      end;
    end;
  finally
    vtAccess.AfterPost := vtAccessAfterPost;
    vtAccess.EnableControls;
  end;
end;

procedure TFUserAccessControl.SaveData;
begin
  //
end;

procedure TFUserAccessControl.UserBaru1Click(Sender: TObject);
var
  u: TUser;
  sql,
  kd: string;
begin
  u.Clear;
  if ShowAddUser(u) then
  begin

    try
      sql :=
        'insert into usr_user (user_name, email, user_password, full_name, group_kode, allow_login) '+
        ' values ( '+
        _q(u.UserName)+', '+
        _q(u.UserName+'@'+CurrentUser.KodeCabang+'.simbaz.atm.id')+', '+
        'md5('+_q(u.Password)+'), '+
        _q(u.FullName)+', '+
        _q(u.Grup)+', '+
        _q(_iif(u.AllowLogin, 'Y','N'))+') returning user_name';
      // ShowText(sql);
      kd := ExecSQLAndFetchOneValueAsString(sql);
      if kd<>'' then
      begin
        if qTipe.Locate('tipe', u.Grup, [loCaseInsensitive]) then
        begin
          if qUsers.Locate('kode', kd , []) then
            RefreshData(kd);
        end;
        Inform('User telah disimpan.');
      end
      else
        Deny('Gagal membuat user baru.');
    except
      Deny('Gagal membuat user baru.');
    end;
  end;
end;

procedure TFUserAccessControl.vtAccessAfterPost(DataSet: TDataSet);
begin
  Button3.Enabled := true;
end;

end.
