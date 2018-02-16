program SiBaz;



uses
  Windows,
  SysUtils,
  classes,
  Forms,
  umain in 'umain.pas' {FMain},
  ui_utils in 'ui_utils.pas',
  DataFile in 'libs\DataFile.pas',
  MahExcel in 'libs\MahExcel.pas',
  u_ask_util in 'libs\u_ask_util.pas' {FaskUtil},
  u_backup_settings in 'libs\u_backup_settings.pas' {FBackupSettings},
  u_blob_uploader in 'libs\u_blob_uploader.pas',
  u_dbgrideh_dac_helper in 'libs\u_dbgrideh_dac_helper.pas',
  u_display_text in 'libs\u_display_text.pas' {FDisplayText},
  u_fopsi in 'libs\u_fopsi.pas' {FPilihOpsi},
  u_frutils in 'libs\u_frutils.pas',
  u_input_date in 'libs\u_input_date.pas' {FInputDate},
  u_input_float_price_paid_change in 'libs\u_input_float_price_paid_change.pas' {Form1},
  u_input_tanggal in 'libs\u_input_tanggal.pas' {FInputTanggal},
  u_input_text in 'libs\u_input_text.pas' {FInputTeks},
  u_input_ttd in 'libs\u_input_ttd.pas' {FInputTTD},
  u_select_kode_name in 'libs\u_select_kode_name.pas' {FSelectKodeName},
  u_select_master_detail in 'libs\u_select_master_detail.pas' {FSelectMasterDetail},
  u_show_plain_text in 'libs\u_show_plain_text.pas' {FShowPlainText},
  u_sys_vars in 'libs\u_sys_vars.pas' {FSysVars},
  asn1util in 'libs\synapse\asn1util.pas',
  blcksock in 'libs\synapse\blcksock.pas',
  clamsend in 'libs\synapse\clamsend.pas',
  dnssend in 'libs\synapse\dnssend.pas',
  ftpsend in 'libs\synapse\ftpsend.pas',
  ftptsend in 'libs\synapse\ftptsend.pas',
  httpsend in 'libs\synapse\httpsend.pas',
  imapsend in 'libs\synapse\imapsend.pas',
  ldapsend in 'libs\synapse\ldapsend.pas',
  mimeinln in 'libs\synapse\mimeinln.pas',
  mimemess in 'libs\synapse\mimemess.pas',
  mimepart in 'libs\synapse\mimepart.pas',
  nntpsend in 'libs\synapse\nntpsend.pas',
  pingsend in 'libs\synapse\pingsend.pas',
  pop3send in 'libs\synapse\pop3send.pas',
  slogsend in 'libs\synapse\slogsend.pas',
  smtpsend in 'libs\synapse\smtpsend.pas',
  snmpsend in 'libs\synapse\snmpsend.pas',
  sntpsend in 'libs\synapse\sntpsend.pas',
  synachar in 'libs\synapse\synachar.pas',
  synacode in 'libs\synapse\synacode.pas',
  synacrypt in 'libs\synapse\synacrypt.pas',
  synadbg in 'libs\synapse\synadbg.pas',
  synafpc in 'libs\synapse\synafpc.pas',
  synaicnv in 'libs\synapse\synaicnv.pas',
  synaip in 'libs\synapse\synaip.pas',
  synamisc in 'libs\synapse\synamisc.pas',
  synaser in 'libs\synapse\synaser.pas',
  synautil in 'libs\synapse\synautil.pas',
  synsock in 'libs\synapse\synsock.pas',
  tlntsend in 'libs\synapse\tlntsend.pas',
  u_utils in 'libs\u_utils.pas',
  u_gl in 'u_gl.pas' {FGL},
  u_daftar_jurnal in 'u_daftar_jurnal.pas' {FDaftarJurnal},
  u_print_bs_lr_cf_ec in 'u_print_bs_lr_cf_ec.pas' {FPrintBsLrCfEc},
  u_login in 'u_login.pas' {FLogin},
  u_pembuat_dokumen in 'u_pembuat_dokumen.pas' {FPembuatDokumen},
  u_input_ttd_2 in 'libs\u_input_ttd_2.pas' {FInputTTD2},
  u_pilih_opsi in 'libs\u_pilih_opsi.pas' {FPilihBulan},
  Vcl.Themes,
  Vcl.Styles,
  u_input_email_settings in 'libs\u_input_email_settings.pas' {FInputEmailSettings},
  u_progress in 'u_progress.pas' {FProgress},
  u_jurnal in 'u_jurnal.pas' {FJurnal},
  u_login_otf in 'u_login_otf.pas' {FLoginOTF},
  u_jurnal_kas in 'u_jurnal_kas.pas' {FJurnalKas},
  u_jurnal_bank in 'u_jurnal_bank.pas' {FJurnalBank},
  u_coa in 'u_coa.pas' {FCoa},
  u_add_rek in 'u_add_rek.pas' {FAddRek},
  u_input_integer in 'libs\u_input_integer.pas' {FInputInteger},
  uSetLocale in 'uSetLocale.pas' {FSetLocale},
  u_koneksi in 'u_koneksi.pas' {FKoneksi},
  u_salur_non_zis in 'u_salur_non_zis.pas' {FSalurNonZis},
  u_salur_zis in 'u_salur_zis.pas' {FSalurZis},
  u_get_jenis_distribusi_dana in 'u_get_jenis_distribusi_dana.pas' {FJenisDistribusiDana},
  u_user_akses in 'libs\u_user_akses.pas' {FUserAccessControl},
  u_edit_user in 'libs\u_edit_user.pas' {FEditUser},
  u_new_muzaki in 'u_new_muzaki.pas' {FNewMuzaki},
  u_new_mustahik in 'u_new_mustahik.pas' {FNewMustahik},
  u_terima_upz_zis in 'u_terima_upz_zis.pas' {FTerimaUPZNonFitrah},
  u_terima_upz_fitrah in 'u_terima_upz_fitrah.pas' {FTerimaUPZFitrah},
  u_setting_persentase_bagian_amil in 'u_setting_persentase_bagian_amil.pas' {FSettingPersentaseBagianAmil},
  u_terima_zis in 'u_terima_zis.pas' {FTerimaZIS},
  u_neraca_saldo in 'u_neraca_saldo.pas' {FNeracaSaldo},
  u_muzaki in 'u_muzaki.pas' {FMuzaki},
  uexch in 'libs\uexch.pas' {FExceptionH},
  u_mustahik in 'u_mustahik.pas' {FMustahik},
  u_upz in 'u_upz.pas' {FUPZ},
  u_new_mustahik_ex in 'u_new_mustahik_ex.pas' {FNewMustahikEx},
  u_new_muzaki_ex in 'u_new_muzaki_ex.pas' {FNewMuzakiEx},
  u_jurnal_pb_kas_bank in 'u_jurnal_pb_kas_bank.pas' {FJurnalPinbukKasBank};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Sistem Akuntansi - Jamkrida Sulsel';
  Application.CreateForm(TFMain, FMain);
  Application.Run;

end.
