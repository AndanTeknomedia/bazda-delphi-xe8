-- Function: gen_lr(character varying, date, date)

-- DROP FUNCTION gen_lr(character varying, date, date);

CREATE OR REPLACE FUNCTION gen_lr(IN kdbranch character varying, IN a_tglmulai date, IN a_tglsampai date)
  RETURNS TABLE(nomor character varying, kode_rek character varying, vkode character varying, nama_rek character varying, saldo_n rupiah, lvl integer, tipe character) AS
$BODY$
	-- params:
	declare cabang	 	alias for $1;
					atgl1 		alias for $2;
					atgl2 		alias for $3;
					lvl				integer default 3;
	-- vars:
	declare 
					saldo_t numeric default 0;
					saldo_x numeric default 0;
					saldo_xd numeric default 0;
					sum_t numeric default 0;
					sum_x numeric default 0;
					laba numeric default 0;
					sum_laba numeric default 0;
					prefix varchar default '';
					sv varchar default '';
					v numeric default 0;
					vdskl numeric default 0;
					vcsr numeric default 0;
					vhibah numeric default 0;
					bagian_amil rupiah default 0;
					
	--temp vars:
					s_trans_name varchar;
					s_tingkat integer;
					x_tingkat integer;
					s_kode varchar;
					x_kode varchar;
					s_pkode varchar;
					x_pkode varchar;
					s_full_kode varchar;
					x_full_kode varchar;
					s_rekening varchar;
					x_rekening varchar;
					s_tipe char;
					x_tipe char;
					s_vkode varchar;
					x_vkode varchar;					
					urut1 integer default 0;
					urut2 integer default 0;
begin
	/*

	ADA SELISIH PENERIMAAN DANA INFAK DARI PENERIMAAN HIBAH!

	
	Jenis Transaksi:
		JU00				Jurnal Umum
		JBM0/JBK0		Jurnal Bank Masuk/Keluar
		JKM0/JKK0		Jurnal Kas Masuk/Keluar
		JIZF				UPZ - Penerimaan Zakat Fitrah
		JIZS				UPZ - Penerimaan Zakat Mal, Infak dan Sedekah
			Cek jenis dana sesuai rekening di field jenis_trans
		JIBZ				Baznas - Penerimaan Zakat, Infak dan Sedekah
			Cek jenis dana sesuai rekening di field jenis_trans
		
	
	*/
	sum_laba := 0;
	-- if tgl_awal_bulan_lalu
	prefix := '';
	s_trans_name := '';
	-- Dana Zakat
	return query(
		select 
			''::varchar, ''::varchar, ''::varchar, 'DANA ZAKAT'::varchar, 0::rupiah, 9, 'T'::char
	);
	sum_t := 0;
	sum_x := 0;
	laba := 0;
	bagian_amil := 0;
	prefix := '41';
	urut1 := 1;
	urut2 := 0;
	return query(
		select 
			get_angka_rum(urut1,'A'), vc2.full_kode::varchar, vc2.vkode, upper(vc2.rekening)::varchar, 0::rupiah, 2, 'H'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	for	s_tingkat, s_kode, s_pkode, s_full_kode, s_rekening, s_tipe, s_vkode in select
		vc2.tingkat, vc2.kode, vc2.pkode, vc2.full_kode, vc2.rekening, vc2.tipe, vc2.vkode from v_coa_2 vc2 
		where (vc2.tingkat <= lvl) and (substr(vc2.pkode,1,2)= prefix )
		order by vc2.kode asc
	loop
		-- saldo:
		saldo_t := 0;
		
		saldo_t := coalesce((
			select 
				sum(d.kredit - d.debet)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like (s_kode||'%')) and (j.checked='Y') and (j.approved='Y')
		), 0);
		urut2 := urut2+1;
		return query(
			select urut2::varchar,
				s_full_kode, s_vkode, s_rekening, saldo_t::rupiah, s_tingkat, 'D'::char
		);
		sum_t := sum_t + saldo_t;
	end loop;
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, upper('JUMLAH '||vc2.rekening)::varchar, sum_t::rupiah, 2, 'F'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	select 
			coalesce(sum(d.kredit - d.debet),0)
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
			and (d.kode_rek like '3104%') and (j.checked='Y') and (j.approved='Y')
			and (j.jenis_trans in ('UPZF', '3101'))
		into bagian_amil; 
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, 'Bagian Amil atas penerimaan dana zakat'::varchar, bagian_amil, 3, 'D'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	sum_t := sum_t - bagian_amil;
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, upper('Jumlah penerimaan dana zakat setelah bagian amil')::varchar, sum_t::rupiah, 2, 'F'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	laba := sum_t;

	
	prefix := '51';
	urut1 := urut1+1;
	urut2 := 0;
	return query(
		select get_angka_rum(urut1,'A'),
			vc2.full_kode::varchar, vc2.vkode, upper(vc2.rekening)::varchar, 0::rupiah, 2, 'H'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	for	s_tingkat, s_kode, s_pkode, s_full_kode, s_rekening, s_tipe, s_vkode in select
		vc2.tingkat, vc2.kode, vc2.pkode, vc2.full_kode, vc2.rekening, vc2.tipe, vc2.vkode from v_coa_2 vc2 
		where (vc2.tingkat <= lvl) and (substr(vc2.pkode,1,2)= prefix )
		order by vc2.kode asc
	loop
		saldo_x := 0;
		urut2 := urut2+1;
		return query(
			select urut2::varchar,
				s_full_kode, s_vkode, s_rekening, 0::rupiah, 3, 'H'::char
		);
		for	x_tingkat, x_kode, x_pkode, x_full_kode, x_rekening, x_tipe, x_vkode in select
		vc2.tingkat, vc2.kode, vc2.pkode, vc2.full_kode, vc2.rekening, vc2.tipe, vc2.vkode from v_coa_2 vc2 
		where (vc2.pkode = s_kode)
		order by vc2.kode asc
		loop
			saldo_xd := coalesce((
				select 
					coalesce(sum(d.debet - d.kredit),0)
				from acc_jurnal_u j
					inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
					where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
					and (d.kode_rek like (x_kode||'%')) 					
					and (j.checked='Y') and (j.approved='Y')
			), 0);			
			return query(
				select urut2::varchar,
					x_full_kode, x_vkode, x_rekening, saldo_xd::rupiah, x_tingkat, 'D'::char
			);			
			saldo_x := saldo_x + saldo_xd;
		end loop;
		sum_x := sum_x + saldo_x;
	end loop;
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, upper('JUMLAH Penyaluran Dana Zakat')::varchar, sum_x::rupiah, 2, 'F'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);

	laba := laba - sum_x;
	-- raise exception E'%',sum_x;
	return query( select s_trans_name, 'E4151000'::varchar, 'E4151'::varchar, ''::varchar, 0::rupiah, 2, 'H'::char);
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Surplus (defisit)'::varchar, laba::rupiah, 2, 'F'::char);
	-- saldo awal:
	saldo_t := get_saldo_dana(cabang, tahun3()::date-1, atgl1-1, '3101');
	laba := laba + saldo_t;
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Saldo Awal'::varchar, saldo_t::rupiah, 2, 'F'::char);
	saldo_t := coalesce((
		select 
			coalesce(sum(d.kredit - d.debet),0)
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
			and (d.kode_rek like ('3101%')) and (j.checked='Y') and (j.approved='Y') and (not (j.jenis_trans in ('UPZF', '3101')))
	), 0);
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Kenaikan (Penurunan) Akibat Pemindahbukuan'::varchar, saldo_t::rupiah, 2, 'F'::char);
	laba := laba + saldo_t;
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Saldo Akhir'::varchar, laba::rupiah, 2, 'F'::char);
	return query( select s_trans_name, 'E4151000'::varchar, 'E4151'::varchar, ''::varchar, 0::rupiah, 2, 'H'::char);

	sum_laba := sum_laba + laba;
	
	-- Dana Infaq/Sedekah
	return query(
		select 
			''::varchar, ''::varchar, ''::varchar, 'DANA INFAK/SEDEKAH'::varchar, 0::rupiah, 9, 'T'::char
	);
	laba := 0;
	sum_t := 0;
	sum_x := 0;
	bagian_amil := 0;
	
	prefix := '42';
	urut1 := 1;
	urut2 := 0;
	return query(
		select 
			get_angka_rum(urut1,'A'), vc2.full_kode::varchar, vc2.vkode, upper(vc2.rekening)::varchar, 0::rupiah, 2, 'H'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	for	s_tingkat, s_kode, s_pkode, s_full_kode, s_rekening, s_tipe, s_vkode in select
		vc2.tingkat, vc2.kode, vc2.pkode, vc2.full_kode, vc2.rekening, vc2.tipe, vc2.vkode from v_coa_2 vc2 
		where (vc2.tingkat <= lvl) and (substr(vc2.pkode,1,2)= prefix )
		order by vc2.kode asc
	loop
		-- saldo:
		saldo_t := 0;
		
		saldo_t := coalesce((
			select 
				sum(d.kredit - d.debet)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like (s_kode||'%')) and (j.checked='Y') and (j.approved='Y')
		), 0);
		urut2 := urut2+1;
		return query(
			select urut2::varchar,
				s_full_kode, s_vkode, s_rekening, saldo_t::rupiah, s_tingkat, 'D'::char
		);
		sum_t := sum_t + saldo_t;
	end loop;

	
	prefix := '45';
	urut1 := urut1 + 1;
	urut2 := 0;
	return query(
		select 
			get_angka_rum(urut1,'A'), vc2.full_kode::varchar, vc2.vkode, upper(vc2.rekening)::varchar, 0::rupiah, 2, 'H'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	for	s_tingkat, s_kode, s_pkode, s_full_kode, s_rekening, s_tipe, s_vkode in select
		vc2.tingkat, vc2.kode, vc2.pkode, vc2.full_kode, vc2.rekening, vc2.tipe, vc2.vkode from v_coa_2 vc2 
		where (vc2.tingkat <= lvl) and (substr(vc2.pkode,1,2)= prefix )
		order by vc2.kode asc
	loop
		-- saldo:
		saldo_t := 0;
		
		saldo_t := coalesce((
			select 
				sum(d.kredit - d.debet)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like (s_kode||'%')) and (j.checked='Y') and (j.approved='Y')
		), 0);
		urut2 := urut2+1;
		return query(
			select urut2::varchar,
				s_full_kode, s_vkode, s_rekening, saldo_t::rupiah, s_tingkat, 'D'::char
		);
		sum_t := sum_t + saldo_t;
	end loop;

	
	return query(
		select s_trans_name,
			''::varchar, ''::varchar, upper('jumlah infak/sedekah dan hibah')::varchar, sum_t::rupiah, 2, 'F'::char 
	);
	select 
			coalesce(sum(d.kredit - d.debet),0)
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
			and (d.kode_rek like '3104%') and (j.checked='Y') and (j.approved='Y')
			and (j.jenis_trans in ('3102'))
		into bagian_amil; 
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, 'Bagian Amil atas penerimaan Infak/Sedekah dan Hibah'::varchar, bagian_amil::rupiah, 3, 'D'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	sum_t := sum_t - bagian_amil;
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, upper('penerimaan Infak/Sedekah dan hibah setelah bagian amil')::varchar, sum_t::rupiah, 2, 'F'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);

	laba := laba + sum_t;
	
	prefix := '52';
	urut1 := urut1+1;
	urut2 := 0;
	return query(
		select get_angka_rum(urut1,'A'),
			vc2.full_kode::varchar, vc2.vkode, upper(vc2.rekening)::varchar, 0::rupiah, 2, 'H'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	for	s_tingkat, s_kode, s_pkode, s_full_kode, s_rekening, s_tipe, s_vkode in select
		vc2.tingkat, vc2.kode, vc2.pkode, vc2.full_kode, vc2.rekening, vc2.tipe, vc2.vkode from v_coa_2 vc2 
		where (vc2.tingkat <= lvl) and (substr(vc2.pkode,1,2)= prefix )
		order by vc2.kode asc
	loop
		saldo_x := 0;
		urut2 := urut2+1;
		return query(
			select urut2::varchar,
				s_full_kode, s_vkode, s_rekening, 0::rupiah, 3, 'H'::char
		);
		for	x_tingkat, x_kode, x_pkode, x_full_kode, x_rekening, x_tipe, x_vkode in select
		vc2.tingkat, vc2.kode, vc2.pkode, vc2.full_kode, vc2.rekening, vc2.tipe, vc2.vkode from v_coa_2 vc2 
		where (vc2.pkode = s_kode) 
		order by vc2.kode asc
		loop
			saldo_xd := coalesce((
				select 
					coalesce(sum(d.debet - d.kredit),0)
				from acc_jurnal_u j
					inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
					where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
					and (d.kode_rek like (x_kode||'%')) 					
					and (j.checked='Y') and (j.approved='Y')
			), 0);			
			return query(
				select urut2::varchar,
					x_full_kode, x_vkode, x_rekening, saldo_xd::rupiah, x_tingkat, 'D'::char
			);			
			saldo_x := saldo_x + saldo_xd;
		end loop;
		sum_x := sum_x + saldo_x;
	end loop;
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, upper('JUMLAH Penyaluran Dana Infak/Sedekah')::varchar, sum_x::rupiah, 2, 'F'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);

	laba := laba - sum_x;
	return query( select s_trans_name, 'E4151000'::varchar, 'E4151'::varchar, ''::varchar, 0::rupiah, 2, 'H'::char);
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Surplus (defisit)'::varchar, laba::rupiah, 2, 'F'::char);
	-- saldo awal:
	saldo_t := get_saldo_dana(cabang, tahun3()::date-1, atgl1-1, '3102');
	laba := laba + saldo_t;
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Saldo Awal'::varchar, saldo_t::rupiah, 2, 'F'::char);
	saldo_t := coalesce((
		select 
			coalesce(sum(d.kredit - d.debet),0)
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
			and (d.kode_rek like ('3102%')) and (j.checked='Y') and (j.approved='Y') and (not (j.jenis_trans in ('UPZF', '3102')))
	), 0);
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Kenaikan (Penurunan) Akibat Pemindahbukuan'::varchar, saldo_t::rupiah, 2, 'F'::char);
	laba := laba + saldo_t;
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Saldo Akhir'::varchar, laba::rupiah, 2, 'F'::char);
	return query( select s_trans_name, 'E4151000'::varchar, 'E4151'::varchar, ''::varchar, 0::rupiah, 2, 'H'::char);

	sum_laba := sum_laba + laba;
	-- Dana DSKL
	
	return query(
		select 
			''::varchar, ''::varchar, ''::varchar, 'DANA SOSIAL KEAGAMAAN LAINNYA (DSKL)'::varchar, 0::rupiah, 9, 'T'::char
	);
	laba := 0;
	sum_t := 0;
	sum_x := 0;
	bagian_amil := 0;
	prefix := '43';
	urut1 := 1;
	urut2 := 0;
	return query(
		select 
			get_angka_rum(urut1,'A'), vc2.full_kode::varchar, vc2.vkode, upper(vc2.rekening)::varchar, 0::rupiah, 2, 'H'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	for	s_tingkat, s_kode, s_pkode, s_full_kode, s_rekening, s_tipe, s_vkode in select
		vc2.tingkat, vc2.kode, vc2.pkode, vc2.full_kode, vc2.rekening, vc2.tipe, vc2.vkode from v_coa_2 vc2 
		where (vc2.tingkat <= lvl) and (substr(vc2.pkode,1,2)= prefix )
		order by vc2.kode asc
	loop
		-- saldo:
		saldo_t := coalesce((
			select 
				coalesce(sum(d.kredit - d.debet),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like (s_kode||'%')) and (j.checked='Y') and (j.approved='Y')
		), 0);
		urut2 := urut2+1;
		return query(
			select urut2::varchar,
				s_full_kode, s_vkode, s_rekening, saldo_t::rupiah, s_tingkat, 'D'::char
		);
		sum_t := sum_t + saldo_t;
	end loop;
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, upper('JUMLAH '||vc2.rekening)::varchar, sum_t::rupiah, 2, 'F'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	select 
			coalesce(sum(d.kredit - d.debet),0)
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
			and (d.kode_rek like '3104%') and (j.checked='Y') and (j.approved='Y')
			and (j.jenis_trans in ('3103'))
		into bagian_amil; 
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, 'Bagian Amil atas penerimaan DSKL'::varchar, bagian_amil::rupiah, 3, 'D'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	sum_t := sum_t - bagian_amil;
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, upper('Jumlah penerimaan DSKL setelah bagian amil')::varchar, sum_t::rupiah, 2, 'F'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	laba := sum_t;
	
	prefix := '53';
	urut1 := urut1+1;
	urut2 := 0;
	return query(
		select get_angka_rum(urut1,'A'),
			vc2.full_kode::varchar, vc2.vkode, upper(vc2.rekening)::varchar, 0::rupiah, 2, 'H'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	for	s_tingkat, s_kode, s_pkode, s_full_kode, s_rekening, s_tipe, s_vkode in select
		vc2.tingkat, vc2.kode, vc2.pkode, vc2.full_kode, vc2.rekening, vc2.tipe, vc2.vkode from v_coa_2 vc2 
		where (vc2.tingkat <= lvl) and (substr(vc2.pkode,1,2)= prefix )
		order by vc2.kode asc
	loop
		saldo_x := 0;
		urut2 := urut2+1;
		return query(
			select urut2::varchar,
				s_full_kode, s_vkode, s_rekening, 0::rupiah, 3, 'H'::char
		);
		for	x_tingkat, x_kode, x_pkode, x_full_kode, x_rekening, x_tipe, x_vkode in select
		vc2.tingkat, vc2.kode, vc2.pkode, vc2.full_kode, vc2.rekening, vc2.tipe, vc2.vkode from v_coa_2 vc2 
		where (vc2.pkode = s_kode) 
		order by vc2.kode asc
		loop
			saldo_xd := coalesce((
				select 
					coalesce(sum(d.debet - d.kredit),0)
				from acc_jurnal_u j
					inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
					where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
					and (d.kode_rek like (x_kode||'%')) 					
					and (j.checked='Y') and (j.approved='Y')
			), 0);			
			return query(
				select urut2::varchar,
					x_full_kode, x_vkode, x_rekening, saldo_xd::rupiah, x_tingkat, 'D'::char
			);			
			saldo_x := saldo_x + saldo_xd;
		end loop;
		sum_x := sum_x + saldo_x;
	end loop;
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, upper('JUMLAH Penyaluran DSKL')::varchar, sum_x::rupiah, 2, 'F'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);

	laba := laba - sum_x;
	return query( select s_trans_name, 'E4151000'::varchar, 'E4151'::varchar, ''::varchar, 0::rupiah, 2, 'H'::char);
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Surplus (defisit)'::varchar, laba::rupiah, 2, 'F'::char);
	-- saldo awal:
	saldo_t := get_saldo_dana(cabang, tahun3()::date-1, atgl1-1, '3103');
	laba := laba + saldo_t;
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Saldo Awal'::varchar, saldo_t::rupiah, 2, 'F'::char);
	saldo_t := coalesce((
		select 
			coalesce(sum(d.kredit - d.debet),0)
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
			and (d.kode_rek like ('3103%')) and (j.checked='Y') and (j.approved='Y') and (not (j.jenis_trans in ('UPZF', '3103')))
	), 0);
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Kenaikan (Penurunan) Akibat Pemindahbukuan'::varchar, saldo_t::rupiah, 2, 'F'::char);
	laba := laba + saldo_t;
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Saldo Akhir'::varchar, laba::rupiah, 2, 'F'::char);
	return query( select s_trans_name, 'E4151000'::varchar, 'E4151'::varchar, ''::varchar, 0::rupiah, 2, 'H'::char);
	sum_laba := sum_laba + laba;
	
	-- Dana Hak Amil:
	
	return query(
		select 
			''::varchar, ''::varchar, ''::varchar, 'DANA AMIL'::varchar, 0::rupiah, 9, 'T'::char
	);
	laba := 0;
	sum_t := 0;
	sum_x := 0;
	bagian_amil := 0;
	urut1 := 1;
	urut2 := 0;
	return query(
		select 
			get_angka_rum(urut1,'A'), ''::varchar, ''::varchar, upper('Penerimaan dana amil')::varchar, 0::rupiah, 2, 'H'::char
	);
	urut2 := urut2+1;
	select 
			coalesce(sum(d.kredit - d.debet),0)
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
			and (d.kode_rek like '3104%') and (j.checked='Y') and (j.approved='Y')
			and (j.jenis_trans in ('UPZF', '3101'))
		into bagian_amil; 
	sum_t := sum_t + bagian_amil;
	return query(
		select urut2::varchar,
			'41000000'::varchar, ''::varchar, 'Bagian Amil Dari Dana Zakat'::varchar, bagian_amil::rupiah, 3, 'D'::char
	);	
	urut2 := urut2+1;
	select 
			coalesce(sum(d.kredit - d.debet),0)
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
			and (d.kode_rek like '3104%') and (j.checked='Y') and (j.approved='Y')
			and (j.jenis_trans in ('3102'))
		into bagian_amil; 
	sum_t := sum_t + bagian_amil;
	return query(
		select urut2::varchar,
			'42000000'::varchar, ''::varchar, 'Bagian Amil Dari Dana Infak/Sedekah/Hibah'::varchar, bagian_amil::rupiah, 3, 'D'::char
	);	
	urut2 := urut2+1;
	select 
			coalesce(sum(d.kredit - d.debet),0)
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
			and (d.kode_rek like '3104%') and (j.checked='Y') and (j.approved='Y')
			and (j.jenis_trans in ('3103'))
		into bagian_amil; 
	sum_t := sum_t + bagian_amil;
	
	return query(
		select urut2::varchar,
			'43000000'::varchar, ''::varchar, 'Bagian Amil Dari Dana Sosial Keagamaan Lainnya'::varchar, bagian_amil::rupiah, 3, 'D'::char
	);
	urut2 := urut2+1;
	select 
			coalesce(sum(d.kredit - d.debet),0)
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
			and (d.kode_rek like '3104%') and (j.checked='Y') and (j.approved='Y')
			and (j.jenis_trans in ('3105'))
		into bagian_amil; 
	sum_t := sum_t + bagian_amil;
	return query(
		select urut2::varchar,
			'44000000'::varchar, ''::varchar, 'Bagian Amil Dari Dana Corporate Social Responsibility'::varchar, bagian_amil::rupiah, 3, 'D'::char
	);

	return query(
		select s_trans_name,
			''::varchar, ''::varchar, upper('JUMLAH Penerimaan Dana Amil')::varchar, sum_t::rupiah, 2, 'F'::char
	);
	
	prefix := '54';
	urut1 := urut1+1;
	urut2 := 0;
	return query(
		select get_angka_rum(urut1,'A'),
			vc2.full_kode::varchar, vc2.vkode, upper(vc2.rekening)::varchar, 0::rupiah, 2, 'H'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	for	s_tingkat, s_kode, s_pkode, s_full_kode, s_rekening, s_tipe, s_vkode in select
		vc2.tingkat, vc2.kode, vc2.pkode, vc2.full_kode, vc2.rekening, vc2.tipe, vc2.vkode from v_coa_2 vc2 
		where (vc2.tingkat <= lvl) and (substr(vc2.pkode,1,2)= prefix )
		order by vc2.kode asc
	loop
		saldo_x := 0;
		urut2 := urut2+1;
		return query(
			select urut2::varchar,
				s_full_kode, s_vkode, s_rekening, 0::rupiah, 3, 'H'::char
		);
		for	x_tingkat, x_kode, x_pkode, x_full_kode, x_rekening, x_tipe, x_vkode in select
		vc2.tingkat, vc2.kode, vc2.pkode, vc2.full_kode, vc2.rekening, vc2.tipe, vc2.vkode from v_coa_2 vc2 
		where (vc2.pkode = s_kode) 
		order by vc2.kode asc
		loop
			saldo_xd := coalesce((
				select 
					coalesce(sum(d.debet - d.kredit),0)
				from acc_jurnal_u j
					inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
					where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
					and (d.kode_rek like (x_kode||'%')) 					
					and (j.checked='Y') and (j.approved='Y')
			), 0);			
			return query(
				select urut2::varchar,
					x_full_kode, x_vkode, x_rekening, saldo_xd::rupiah, x_tingkat, 'D'::char
			);			
			saldo_x := saldo_x + saldo_xd;
		end loop;
		sum_x := sum_x + saldo_x;
	end loop;
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, upper('JUMLAH Penyaluran Dana Amil')::varchar, sum_x::rupiah, 2, 'F'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);

	laba := sum_t - sum_x;
	return query( select s_trans_name, 'E4151000'::varchar, 'E4151'::varchar, ''::varchar, 0::rupiah, 2, 'H'::char);
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Surplus (defisit)'::varchar, laba::rupiah, 2, 'F'::char);
	-- saldo awal:
	saldo_t := get_saldo_dana(cabang, tahun3()::date-1, atgl1-1, '3104');
	laba := laba + saldo_t;
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Saldo Awal'::varchar, saldo_t::rupiah, 2, 'F'::char);	
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Saldo Akhir'::varchar, laba::rupiah, 2, 'F'::char);
	return query( select s_trans_name, 'E4151000'::varchar, 'E4151'::varchar, ''::varchar, 0::rupiah, 2, 'H'::char);

	sum_laba := sum_laba + laba;
	
	-- Dana CSR
	return query(
		select 
			''::varchar, ''::varchar, ''::varchar, 'DANA CORPORATE SOCIAL RESPONSIBILITY (CSR)'::varchar, 0::rupiah, 9, 'T'::char
	);
	laba := 0;
	sum_t := 0;
	sum_x := 0;
	bagian_amil := 0;
	prefix := '44';
	urut1 := 1;
	urut2 := 0;
	return query(
		select 
			get_angka_rum(urut1,'A'), vc2.full_kode::varchar, vc2.vkode, upper(vc2.rekening)::varchar, 0::rupiah, 2, 'H'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	for	s_tingkat, s_kode, s_pkode, s_full_kode, s_rekening, s_tipe, s_vkode in select
		vc2.tingkat, vc2.kode, vc2.pkode, vc2.full_kode, vc2.rekening, vc2.tipe, vc2.vkode from v_coa_2 vc2 
		where (vc2.tingkat <= lvl) and (substr(vc2.pkode,1,2)= prefix )
		order by vc2.kode asc
	loop
		-- saldo:
		saldo_t := coalesce((
			select 
				coalesce(sum(d.kredit - d.debet),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like (s_kode||'%')) and (j.checked='Y') and (j.approved='Y')
		), 0);
		urut2 := urut2+1;
		return query(
			select urut2::varchar,
				s_full_kode, s_vkode, s_rekening, saldo_t::rupiah, s_tingkat, 'D'::char
		);
		sum_t := sum_t + saldo_t;
	end loop;
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, upper('JUMLAH '||vc2.rekening)::varchar, sum_t::rupiah, 2, 'F'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	select 
			coalesce(sum(d.kredit - d.debet),0)
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
			and (d.kode_rek like '3104%') and (j.checked='Y') and (j.approved='Y')
			and (j.jenis_trans in ('3105'))
		into bagian_amil; 
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, 'Bagian Amil atas penerimaan Dana CSR'::varchar, bagian_amil::rupiah, 3, 'D'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	sum_t := sum_t - bagian_amil;
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, upper('Jumlah penerimaan Dana CSR setelah bagian amil')::varchar, sum_t::rupiah, 2, 'F'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	laba := sum_t;
	
	prefix := '55';
	urut1 := urut1+1;
	urut2 := 0;
	return query(
		select get_angka_rum(urut1,'A'),
			vc2.full_kode::varchar, vc2.vkode, upper(vc2.rekening)::varchar, 0::rupiah, 2, 'H'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	for	s_tingkat, s_kode, s_pkode, s_full_kode, s_rekening, s_tipe, s_vkode in select
		vc2.tingkat, vc2.kode, vc2.pkode, vc2.full_kode, vc2.rekening, vc2.tipe, vc2.vkode from v_coa_2 vc2 
		where (vc2.tingkat <= lvl) and (substr(vc2.pkode,1,2)= prefix )
		order by vc2.kode asc
	loop
		saldo_x := 0;
		urut2 := urut2+1;
		return query(
			select urut2::varchar,
				s_full_kode, s_vkode, s_rekening, 0::rupiah, 3, 'H'::char
		);
		for	x_tingkat, x_kode, x_pkode, x_full_kode, x_rekening, x_tipe, x_vkode in select
		vc2.tingkat, vc2.kode, vc2.pkode, vc2.full_kode, vc2.rekening, vc2.tipe, vc2.vkode from v_coa_2 vc2 
		where (vc2.pkode = s_kode) 
		order by vc2.kode asc
		loop
			saldo_xd := coalesce((
				select 
					coalesce(sum(d.debet - d.kredit),0)
				from acc_jurnal_u j
					inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
					where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
					and (d.kode_rek like (x_kode||'%')) 					
					and (j.checked='Y') and (j.approved='Y')
			), 0);			
			return query(
				select urut2::varchar,
					x_full_kode, x_vkode, x_rekening, saldo_xd::rupiah, x_tingkat, 'D'::char
			);			
			saldo_x := saldo_x + saldo_xd;
		end loop;
		sum_x := sum_x + saldo_x;
	end loop;
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, upper('JUMLAH Penyaluran Dana CSR')::varchar, sum_x::rupiah, 2, 'F'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);

	laba := laba - sum_x;
	return query( select s_trans_name, 'E4151000'::varchar, 'E4151'::varchar, ''::varchar, 0::rupiah, 2, 'H'::char);
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Surplus (defisit)'::varchar, laba::rupiah, 2, 'F'::char);
	-- saldo awal:
	saldo_t := get_saldo_dana(cabang, tahun3()::date-1, atgl1-1, '3105');
	laba := laba + saldo_t;
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Saldo Awal'::varchar, saldo_t::rupiah, 2, 'F'::char);
	saldo_t := coalesce((
		select 
			coalesce(sum(d.kredit - d.debet),0)
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
			and (d.kode_rek like ('3105%')) and (j.checked='Y') and (j.approved='Y') and (not (j.jenis_trans in ('UPZF', '3105')))
	), 0);
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Kenaikan (Penurunan) Akibat Pemindahbukuan'::varchar, saldo_t::rupiah, 2, 'F'::char);
	laba := laba + saldo_t;
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Saldo Akhir'::varchar, laba::rupiah, 2, 'F'::char);
	return query( select s_trans_name, 'E4151000'::varchar, 'E4151'::varchar, ''::varchar, 0::rupiah, 2, 'H'::char);
	
	sum_laba := sum_laba + laba;
	
	-- DANA INVESTASI:
	return query(
		select 
			''::varchar, ''::varchar, ''::varchar, 'DANA INVESTASI'::varchar, 0::rupiah, 9, 'T'::char
	);
	laba := 0;
	sum_t := 0;
	sum_x := 0;
	bagian_amil := 0;
	prefix := '3106';
	urut1 := 1;
	urut2 := 0;
	return query(
		select 
			get_angka_rum(urut1,'A'), ''::varchar, ''::varchar, upper('Penempatan Dana Investasi')::varchar, 0::rupiah, 2, 'H'::char 
	);
	select 
			coalesce(sum(d.kredit), 0)
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
			and (d.kode_rek like (prefix||'%')) and (j.checked='Y') and (j.approved='Y')
	into saldo_t;
	urut2 := urut2+1;
	return query(
		select urut2::varchar,
			''::varchar, ''::varchar, 'Penempatan Dana Investasi'::varchar, saldo_t::rupiah, 3, 'D'::char
	);	
	sum_t := sum_t + saldo_t;
	return query(
		select s_trans_name,
			''::varchar, ''::varchar, upper('JUMLAH penempatan dana investasi')::varchar, sum_t::rupiah, 2, 'F'::char 
	);	
	laba := sum_t;
	-- raise exception E'%',laba;
	urut1 := urut1+1;
	return query(
		select 
			get_angka_rum(urut1,'A'), ''::varchar, ''::varchar, upper('penghapusan Dana Investasi')::varchar, 0::rupiah, 2, 'H'::char 
	);
	select 
			coalesce(sum(d.debet), 0)
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
			and (d.kode_rek like (prefix||'%')) and (j.checked='Y') and (j.approved='Y')
	into saldo_x;
	urut2 := 1;
	return query(
		select urut2::varchar,
			''::varchar, ''::varchar, 'Penghapusan Dana Investasi'::varchar, saldo_x::rupiah, 3, 'D'::char
	);	
	sum_x := sum_x + saldo_x;
	return query(
		select s_trans_name,
			''::varchar, ''::varchar, upper('JUMLAH Penghapusan Dana Investasi')::varchar, sum_x::rupiah, 2, 'F'::char 
	);

	laba := laba - sum_x;
	return query( select s_trans_name, 'E4151000'::varchar, 'E4151'::varchar, ''::varchar, 0::rupiah, 2, 'H'::char);
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Surplus (defisit)'::varchar, laba::rupiah, 2, 'F'::char);
	-- saldo awal:
	saldo_t := get_saldo_dana(cabang, tahun3()::date-1, atgl1-1, prefix);
	laba := laba + saldo_t;
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Saldo Awal'::varchar, saldo_t::rupiah, 2, 'F'::char);	
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Saldo Akhir'::varchar, laba::rupiah, 2, 'F'::char);
	return query( select s_trans_name, 'E4151000'::varchar, 'E4151'::varchar, ''::varchar, 0::rupiah, 2, 'H'::char);

	sum_laba := sum_laba + laba;
	
	
	-- Dana Non Halal
	return query(
		select 
			''::varchar, ''::varchar, ''::varchar, 'DANA NON HALAL'::varchar, 0::rupiah, 9, 'T'::char
	);
	laba := 0;
	sum_t := 0;
	sum_x := 0;
	bagian_amil := 0;
	prefix := '49';
	urut1 := 1;
	urut2 := 0;
	return query(
		select 
			get_angka_rum(urut1,'A'), vc2.full_kode::varchar, vc2.vkode, upper(vc2.rekening)::varchar, 0::rupiah, 2, 'H'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	for	s_tingkat, s_kode, s_pkode, s_full_kode, s_rekening, s_tipe, s_vkode in select
		vc2.tingkat, vc2.kode, vc2.pkode, vc2.full_kode, vc2.rekening, vc2.tipe, vc2.vkode from v_coa_2 vc2 
		where (vc2.tingkat <= lvl) and (substr(vc2.pkode,1,2)= prefix )
		order by vc2.kode asc
	loop
		-- saldo:
		saldo_t := coalesce((
			select 
				coalesce(sum(d.kredit - d.debet),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like (s_kode||'%')) and (j.checked='Y') and (j.approved='Y')
 		), 0);
		urut2 := urut2+1;
		return query(
			select urut2::varchar,
				s_full_kode, s_vkode, s_rekening, saldo_t::rupiah, s_tingkat, 'D'::char
		);
		sum_t := sum_t + saldo_t;
	end loop;
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, upper('JUMLAH '||vc2.rekening)::varchar, sum_t::rupiah, 2, 'F'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	laba := sum_t;
	
	prefix := '59';
	urut1 := urut1+1;
	urut2 := 0;
	return query(
		select get_angka_rum(urut1,'A'),
			vc2.full_kode::varchar, vc2.vkode, upper(vc2.rekening)::varchar, 0::rupiah, 2, 'H'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	for	s_tingkat, s_kode, s_pkode, s_full_kode, s_rekening, s_tipe, s_vkode in select
		vc2.tingkat, vc2.kode, vc2.pkode, vc2.full_kode, vc2.rekening, vc2.tipe, vc2.vkode from v_coa_2 vc2 
		where (vc2.tingkat <= lvl) and (substr(vc2.pkode,1,2)= prefix )
		order by vc2.kode asc
	loop
		saldo_x := 0;
		urut2 := urut2+1;
		return query(
			select urut2::varchar,
				s_full_kode, s_vkode, s_rekening, 0::rupiah, 3, 'H'::char
		);
		for	x_tingkat, x_kode, x_pkode, x_full_kode, x_rekening, x_tipe, x_vkode in select
		vc2.tingkat, vc2.kode, vc2.pkode, vc2.full_kode, vc2.rekening, vc2.tipe, vc2.vkode from v_coa_2 vc2 
		where (vc2.pkode = s_kode) 
		order by vc2.kode asc
		loop
			saldo_xd := coalesce((
				select 
					coalesce(sum(d.debet - d.kredit),0)
				from acc_jurnal_u j
					inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
					where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
					and (d.kode_rek like (x_kode||'%')) 					
					and (j.checked='Y') and (j.approved='Y')
			), 0);			
			return query(
				select urut2::varchar,
					x_full_kode, x_vkode, x_rekening, saldo_xd::rupiah, x_tingkat, 'D'::char
			);			
			saldo_x := saldo_x + saldo_xd;
		end loop;
		sum_x := sum_x + saldo_x;
	end loop;
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, upper('JUMLAH Penyaluran Dana Non Halal')::varchar, sum_x::rupiah, 2, 'F'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);

	laba := laba - sum_x;
	return query( select s_trans_name, 'E4151000'::varchar, 'E4151'::varchar, ''::varchar, 0::rupiah, 2, 'H'::char);
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Surplus (defisit)'::varchar, laba::rupiah, 2, 'F'::char);
	-- saldo awal:
	saldo_t := get_saldo_dana(cabang, tahun3()::date-1, atgl1-1, '3107');
	laba := laba + saldo_t;
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Saldo Awal'::varchar, saldo_t::rupiah, 2, 'F'::char);
	saldo_t := coalesce((
		select 
			coalesce(sum(d.kredit - d.debet),0)
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
			and (d.kode_rek like ('3107%')) and (j.checked='Y') and (j.approved='Y') and (not (j.jenis_trans in ('UPZF', '3107')))
	), 0);
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Kenaikan (Penurunan) Akibat Pemindahbukuan'::varchar, saldo_t::rupiah, 2, 'F'::char);
	laba := laba + saldo_t;
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Saldo Akhir'::varchar, laba::rupiah, 2, 'F'::char);
	return query( select s_trans_name, 'E4151000'::varchar, 'E4151'::varchar, ''::varchar, 0::rupiah, 2, 'H'::char);

	sum_laba := sum_laba + laba;
	return query( select s_trans_name, 'E4151000'::varchar, 'E4151'::varchar, ''::varchar, 0::rupiah, 2, 'H'::char);
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, upper('Jumlah Akhir Saldo Dana')::varchar, sum_laba::rupiah, 2, 'F'::char);
	return query( select s_trans_name, 'E4151000'::varchar, 'E4151'::varchar, ''::varchar, 0::rupiah, 2, 'H'::char);
end;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION gen_lr(character varying, date, date) OWNER TO postgres;
