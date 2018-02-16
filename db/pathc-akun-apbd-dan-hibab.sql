-- Function: get_saldo_dana(character varying, date, date, character varying)

-- DROP FUNCTION get_saldo_dana(character varying, date, date, character varying);

CREATE OR REPLACE FUNCTION get_saldo_dana(kdbranch character varying, a_tglmulai date, a_tglsampai date, a_pos character varying)
  RETURNS rupiah AS
$BODY$
	-- params:
	declare cabang	 	alias for $1;
					atgl1 		alias for $2;
					atgl2 		alias for $3;
					pos 			alias for $4;
	-- vars:
	declare 
					t_saldo numeric default 0;
					t_m			numeric default 0;
					t_k			numeric default 0;
					kdrek		varchar default '';
					persen_dskl numeric default 0;
					persen_csr	 numeric default 0;
					persen_hibah	 numeric default 0;
					v varchar;
begin
	/* Test:
	select get_saldo_dana('073','2017-01-01', current_date, '310...');
	*/
	-- ambil saldo hasil jurnal:
	if not pos like '310%' then
		return 0;
	elsif pos like '3101%' then
		-- Dana Zakat
		t_saldo := 0;
		select 
				coalesce(sum(d.kredit) - sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3101%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;		
		-- penerimaan		
		select 
				coalesce(sum(d.kredit) - sum(d.debet),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('41%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;		
		-- t_m := t_m * 87.5/100;
		t_saldo := t_saldo + t_m;					
		-- pendistribusian dan penggunaan:
		select 
				coalesce(sum(d.debet) - sum(d.kredit),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like '51%')
				/* and (not (d.kode_rek like ('510103%'))) */ and (j.checked='Y') and (j.approved='Y')
		into t_k;
		t_saldo := t_saldo - t_k;
		return t_saldo;
	elsif pos like '3102%' then
		-- Dana Infaq/Sedakah
		t_saldo := 0;
		select 
				coalesce(sum(d.kredit) - sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3102%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;
		select 
				coalesce(sum(d.kredit) - sum(d.debet),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (substr(d.kode_rek,1,2) in ('42')) and (j.checked='Y') and (j.approved='Y')
		into t_m;		
		t_saldo := t_saldo + t_m;					
		-- pendistribusian dan penggunaan:
		select 
				coalesce(sum(d.debet) - sum(d.kredit),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like '52%')
				/* and (not (d.kode_rek like ('520103%'))) */ and (j.checked='Y') and (j.approved='Y')
		into t_k;
		t_saldo := t_saldo - t_k;
		return t_saldo;
	elsif pos like '3103%' then
		-- Dana DSKL
		t_saldo := 0;
		-- v := get_option(cabang||'persen-amil-dskl');
		-- if v = '' then persen_dskl := 0.2; else persen_dskl := v::numeric; end if;
		select 
				coalesce(sum(d.kredit) - sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3103%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;
		-- penerimaan		
		select 
				coalesce(sum(d.kredit) - sum(d.debet),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('43%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;		
		-- t_m := t_m * (1-persen_dskl); -- potongan N% dana amil
		t_saldo := t_saldo + t_m;					
		-- pendistribusian dan penggunaan:
		select 
				coalesce(sum(d.debet) - sum(d.kredit),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like '53%') and (j.checked='Y') and (j.approved='Y')
		into t_k;
		t_saldo := t_saldo - t_k;
		return t_saldo;
	elsif pos like '3104%' then
		-- Dana Amil tidak termasuk distribusi hak amil UPZ!
		t_saldo := 0;	
		select 
				coalesce(sum(d.kredit) - sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3104%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;
		-- penerimaan
		/*
		v := get_option(cabang||'persen-amil-dskl');
		if v = '' then persen_dskl := 0.2; else persen_dskl := v::numeric; end if;
		v := get_option(cabang||'persen-amil-csr');
		if v = '' then persen_csr := 0.2;  else persen_csr := v::numeric; end if;
		v := get_option(cabang||'persen-amil-hibah');
		if v = '' then persen_hibah := 0.2; else persen_hibah := v::numeric; end if;
		*/
		--
		/*
		for kdrek in select kode from v_coa_2 where kode like '4%' and kode <> '49' and tingkat = 2 order by kode asc
		loop		
			select 
					coalesce(sum(d.kredit) - sum(d.debet),0)
				from acc_jurnal_u j
					inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
					where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
					and (d.kode_rek like (kdrek||'%')) and (j.checked='Y') and (j.approved='Y')
			into t_m;		
			if kdrek = '41' then
				-- zakat: 12.5%
				t_m := t_m * 12.5/100;
			elsif kdrek = '42' then
				-- infaq & sedekah: 20%
				t_m := t_m * 20/100;
			elsif kdrek = '43' then
				t_m := t_m * persen_dskl;
			elsif kdrek = '44' then
				t_m := t_m * persen_csr;
			elsif kdrek = '45' then
				t_m := t_m * persen_hibah;
			else
				t_m := 0;
			end if;
			t_saldo := t_saldo + t_m;			
		end loop;
		*/
		-- pendistribusian dan penggunaan:
		/* tidak dipakai, karena distribusi amil di sini adalah amil UPZ, tidak berkaitan dengan amil Baznas!
		-- 1. Distribusi Dana Zakat kepada Amil:	
		select 
				coalesce(sum(d.debet) - sum(d.kredit),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('510103%')) and (j.checked='Y') and (j.approved='Y')
		into t_k;
		t_saldo := t_saldo - t_k;
		*/
		-- 2. Penggunaan Dana Amil Selain Zakat:	
		select 
				coalesce(sum(d.debet) - sum(d.kredit),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('54%')) and (j.checked='Y') and (j.approved='Y')
		into t_k;
		t_saldo := t_saldo - t_k;
		return t_saldo;
	elsif pos like '3105%' then 
		-- Dana CSR:
		t_saldo := 0;
		-- v := get_option(cabang||'persen-amil-csr');
		-- if v = '' then persen_dskl := 0.2; else persen_dskl := v::numeric; end if;
		select 
				coalesce(sum(d.kredit) - sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3105%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;
		-- penerimaan		
		select 
				coalesce(sum(d.kredit) - sum(d.debet),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('44%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;		
		-- t_m := t_m * (1-persen_csr); -- potongan N% dana amil
		t_saldo := t_saldo + t_m;					
		-- pendistribusian dan penggunaan:
		select 
				coalesce(sum(d.debet) - sum(d.kredit),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like '55%') and (j.checked='Y') and (j.approved='Y')
		into t_k;
		t_saldo := t_saldo - t_k;
		return t_saldo;
	elsif pos like '3106%' then 
		-- Dana Investasi:
		t_saldo := 0;
		-- a. saldo investasi lancar:
		/*
		select 
				coalesce(sum(d.debet) - sum(d.kredit), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('1102%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;
		t_saldo := t_saldo + t_m;				
		-- b. saldo aset tetap	
		select 
				coalesce(sum(d.debet) - sum(d.kredit), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('1201%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;		
		-- depresiasi (pengurang):
		t_saldo := t_saldo + t_m;
		select 
				coalesce(sum(d.debet) - sum(d.kredit), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('1202%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;		
		t_saldo := t_saldo + t_m;
		-- b. saldo piutang:
		select 
				coalesce(sum(d.debet) - sum(d.kredit), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('13%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;
		t_saldo := t_saldo + t_m;
		*/
		select 
				coalesce(sum(d.kredit) - sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) /* and (j.tanggal>=atgl1) */ and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3106%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;
		t_saldo := t_m;
		return t_saldo;
	elsif pos like '3107%' then 
		-- Dana HIBAH:
		t_saldo := 0;
		-- v := get_option(cabang||'persen-amil-csr');
		-- if v = '' then persen_dskl := 0.2; else persen_dskl := v::numeric; end if;
		select 
				coalesce(sum(d.kredit) - sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3107%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;
		-- penerimaan		
		select 
				coalesce(sum(d.kredit) - sum(d.debet),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('45%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;		
		-- t_m := t_m * (1-persen_csr); -- potongan N% dana amil
		t_saldo := t_saldo + t_m;					
		-- pendistribusian dan penggunaan:
		select 
				coalesce(sum(d.debet) - sum(d.kredit),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like '56%') and (j.checked='Y') and (j.approved='Y')
		into t_k;
		t_saldo := t_saldo - t_k;
		return t_saldo;
	elsif pos like '3108%' then 
		-- Dana APBD
		t_saldo := 0;
		select 
				coalesce(sum(d.kredit) - sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3108%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;
		-- penerimaan		
		select 
				coalesce(sum(d.kredit) - sum(d.debet),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('46%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;		
		-- t_m := t_m * (1-persen_csr); -- potongan N% dana amil
		t_saldo := t_saldo + t_m;					
		-- pendistribusian dan penggunaan:
		select 
				coalesce(sum(d.debet) - sum(d.kredit),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like '57%') and (j.checked='Y') and (j.approved='Y')
		into t_k;
		t_saldo := t_saldo - t_k;
		return t_saldo;
	elsif pos like '3109%' then 
		-- Dana non Halal
		t_saldo := 0;
		select 
				coalesce(sum(d.kredit) - sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3109%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;
		-- penerimaan		
		select 
				coalesce(sum(d.kredit) - sum(d.debet),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('49%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;		
		-- t_m := t_m * (1-persen_csr); -- potongan N% dana amil
		t_saldo := t_saldo + t_m;					
		-- pendistribusian dan penggunaan:
		select 
				coalesce(sum(d.debet) - sum(d.kredit),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<=atgl2) 
				and (d.kode_rek like '59%') and (j.checked='Y') and (j.approved='Y')
		into t_k;
		t_saldo := t_saldo - t_k;
		return t_saldo;
	else
		return 0;
	end if;
end;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION get_saldo_dana(character varying, date, date, character varying) OWNER TO postgres;

-- Function: get_saldo_dana_kenaikan(character varying, date, date, character varying)

-- DROP FUNCTION get_saldo_dana_kenaikan(character varying, date, date, character varying);

CREATE OR REPLACE FUNCTION get_saldo_dana_kenaikan(kdbranch character varying, a_tglmulai date, a_tglsampai date, a_pos character varying)
  RETURNS rupiah AS
$BODY$
	-- params:
	declare cabang	 	alias for $1;
					atgl1 		alias for $2;
					atgl2 		alias for $3;
					pos 			alias for $4;
	-- vars:
	declare 
					t_saldo numeric default 0;
					t_m			numeric default 0;
					t_k			numeric default 0;
					kdrek		varchar default '';
					persen_dskl numeric default 0;
					persen_csr	 numeric default 0;
					persen_hibah	 numeric default 0;
					v varchar;
begin
	/* Test:
	select get_saldo_dana('073','2017-01-01', current_date, '310...');
	*/
	-- ambil saldo hasil jurnal:
	if not pos like '310%' then
		return 0;
	elsif pos like '3101%' then
		-- Dana Zakat
		t_saldo := 0;
		select 
				coalesce(sum(d.kredit), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3101%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;		
		-- penerimaan		
		select 
				coalesce(sum(d.kredit) - sum(d.debet),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('41%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;		
		-- t_m := t_m * 87.5/100;
		t_saldo := t_saldo + t_m;					
		return t_saldo;
	elsif pos like '3102%' then
		-- Dana Infaq/Sedakah
		t_saldo := 0;
		select 
				coalesce(sum(d.kredit), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3102%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;
		select 
				coalesce(sum(d.kredit) - sum(d.debet),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (substr(d.kode_rek,1,2) in ('42')) and (j.checked='Y') and (j.approved='Y')
		into t_m;		
		t_saldo := t_saldo + t_m;					
		return t_saldo;
	elsif pos like '3103%' then
		-- Dana DSKL
		t_saldo := 0;
		-- v := get_option(cabang||'persen-amil-dskl');
		-- if v = '' then persen_dskl := 0.2; else persen_dskl := v::numeric; end if;
		select 
				coalesce(sum(d.kredit), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3103%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;
		-- penerimaan		
		select 
				coalesce(sum(d.kredit) - sum(d.debet),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('43%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;		
		-- t_m := t_m * (1-persen_dskl); -- potongan N% dana amil
		t_saldo := t_saldo + t_m;					
		
		return t_saldo;
	elsif pos like '3104%' then
		-- Dana Amil tidak termasuk distribusi hal amil UPZ!
		t_saldo := 0;	
		select 
				coalesce(sum(d.kredit), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3104%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;
		return t_saldo;
	elsif pos like '3105%' then 
		-- Dana CSR:
		t_saldo := 0;
		-- v := get_option(cabang||'persen-amil-csr');
		-- if v = '' then persen_dskl := 0.2; else persen_dskl := v::numeric; end if;
		select 
				coalesce(sum(d.kredit) , 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3105%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;
		-- penerimaan		
		select 
				coalesce(sum(d.kredit) - sum(d.debet),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('44%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;		
		-- t_m := t_m * (1-persen_csr); -- potongan N% dana amil
		t_saldo := t_saldo + t_m;					
		
		return t_saldo;
	elsif pos like '3106%' then 
		-- Dana Investasi:
		t_saldo := 0;
		/*
		-- a. saldo investasi lancar:
		select 
				coalesce(sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('1102%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;
		t_saldo := t_saldo + t_m;				
		-- b. saldo aset tetap	
		select 
				coalesce(sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('1201%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;		
		-- depresiasi (pengurang):
		t_saldo := t_saldo + t_m;
		select 
				coalesce(sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('1202%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;		
		t_saldo := t_saldo + t_m;
		-- b. saldo piutang:
		select 
				coalesce(sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('13%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;
		t_saldo := t_saldo + t_m;
		*/
		select 
				coalesce(sum(d.kredit), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3106%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;
		return t_saldo;
	elsif pos like '3107%' then 
		-- Dana Hibah
		t_saldo := 0;
		select 
				coalesce(sum(d.kredit), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3107%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;
		-- penerimaan		
		select 
				coalesce(sum(d.kredit) - sum(d.debet),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('45%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;		
		-- t_m := t_m * (1-persen_csr); -- potongan N% dana amil
		t_saldo := t_saldo + t_m;					
		
		return t_saldo;
	elsif pos like '3108%' then 
		-- Dana APBD
		t_saldo := 0;
		select 
				coalesce(sum(d.kredit), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3108%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;
		-- penerimaan		
		select 
				coalesce(sum(d.kredit) - sum(d.debet),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('46%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;		
		-- t_m := t_m * (1-persen_csr); -- potongan N% dana amil
		t_saldo := t_saldo + t_m;					
		
		return t_saldo;
	elsif pos like '3109%' then 
		-- Dana non Halal
		t_saldo := 0;
		select 
				coalesce(sum(d.kredit), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3109%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;
		-- penerimaan		
		select 
				coalesce(sum(d.kredit) - sum(d.debet),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('49%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;		
		-- t_m := t_m * (1-persen_csr); -- potongan N% dana amil
		t_saldo := t_saldo + t_m;					
		
		return t_saldo;
	else
		return 0;
	end if;
end;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION get_saldo_dana_kenaikan(character varying, date, date, character varying) OWNER TO postgres;

-- Function: get_saldo_dana_penurunan(character varying, date, date, character varying)

-- DROP FUNCTION get_saldo_dana_penurunan(character varying, date, date, character varying);

CREATE OR REPLACE FUNCTION get_saldo_dana_penurunan(kdbranch character varying, a_tglmulai date, a_tglsampai date, a_pos character varying)
  RETURNS rupiah AS
$BODY$
	-- params:
	declare cabang	 	alias for $1;
					atgl1 		alias for $2;
					atgl2 		alias for $3;
					pos 			alias for $4;
	-- vars:
	declare 
					t_saldo numeric default 0;
					t_m			numeric default 0;
					t_k			numeric default 0;
					kdrek		varchar default '';
					persen_dskl numeric default 0;
					persen_csr	 numeric default 0;
					persen_hibah	 numeric default 0;
					v varchar;
begin
	/* Test:
	select get_saldo_dana('073','2017-01-01', current_date, '310...');
	*/
	-- ambil saldo hasil jurnal:
	if not pos like '310%' then
		return 0;
	elsif pos like '3101%' then
		-- Dana Zakat
		t_saldo := 0;
		select 
				coalesce(sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3101%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;		
		
		-- pendistribusian dan penggunaan:
		select 
				coalesce(sum(d.debet) - sum(d.kredit),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like '51%')
				/* and (not (d.kode_rek like ('510103%'))) */ and (j.checked='Y') and (j.approved='Y')
		into t_k;
		t_saldo := t_saldo + t_k;
		return t_saldo;
	elsif pos like '3102%' then
		-- Dana Infaq/Sedakah
		t_saldo := 0;
		select 
				coalesce(sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3102%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;
						
		-- pendistribusian dan penggunaan:
		select 
				coalesce(sum(d.debet) - sum(d.kredit),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like '52%')
				/* and (not (d.kode_rek like ('520103%'))) */ and (j.checked='Y') and (j.approved='Y')
		into t_k;
		t_saldo := t_saldo + t_k;
		return t_saldo;
	elsif pos like '3103%' then
		-- Dana DSKL
		t_saldo := 0;
		-- v := get_option(cabang||'persen-amil-dskl');
		-- if v = '' then persen_dskl := 0.2; else persen_dskl := v::numeric; end if;
		select 
				coalesce(sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3103%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;
			
		-- pendistribusian dan penggunaan:
		select 
				coalesce(sum(d.debet) - sum(d.kredit),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like '53%') and (j.checked='Y') and (j.approved='Y')
		into t_k;
		t_saldo := t_saldo + t_k;
		return t_saldo;
	elsif pos like '3104%' then
		-- Dana Amil tidak termasuk distribusi hal amil UPZ!
		t_saldo := 0;	
		select 
				coalesce(sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3104%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;	
		select 
				coalesce(sum(d.debet) - sum(d.kredit),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('54%')) and (j.checked='Y') and (j.approved='Y')
		into t_k;
		t_saldo := t_saldo + t_k;
		return t_saldo;
	elsif pos like '3105%' then 
		-- Dana CSR:
		t_saldo := 0;
		-- v := get_option(cabang||'persen-amil-csr');
		-- if v = '' then persen_dskl := 0.2; else persen_dskl := v::numeric; end if;
		select 
				coalesce(sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3105%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;		
		-- pendistribusian dan penggunaan:
		select 
				coalesce(sum(d.debet) - sum(d.kredit),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like '55%') and (j.checked='Y') and (j.approved='Y')
		into t_k;
		t_saldo := t_saldo + t_k;
		return t_saldo;
	elsif pos like '3106%' then 
		-- Dana Investasi:
		t_saldo := 0;
		-- a. saldo investasi lancar:
		/*
		select 
				coalesce(sum(d.kredit), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('1102%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;
		t_saldo := t_saldo + t_m;				
		-- b. saldo aset tetap	
		select 
				coalesce(sum(d.kredit), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2)  
				and (d.kode_rek like ('1201%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;		
		-- depresiasi (pengurang):
		t_saldo := t_saldo + t_m;
		select 
				coalesce(sum(d.kredit), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('1202%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;		
		t_saldo := t_saldo + t_m;
		-- b. saldo piutang:
		select 
				coalesce(sum(d.kredit), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('13%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;
		t_saldo := t_saldo + t_m;
		*/
		select 
				coalesce(sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) /* and (j.tanggal>=atgl1) */ and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3106%')) and (j.checked='Y') and (j.approved='Y')
		into t_m;
		t_saldo := t_m;
		return t_saldo;
	elsif pos like '3107%' then 
		-- Dana Hibah
		t_saldo := 0;
		select 
				coalesce(sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3107%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;
		
		-- pendistribusian dan penggunaan:
		select 
				coalesce(sum(d.debet) - sum(d.kredit),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like '56%') and (j.checked='Y') and (j.approved='Y')
		into t_k;
		t_saldo := t_saldo + t_k;
		return t_saldo;
	elsif pos like '3108%' then 
		-- Dana APBD
		t_saldo := 0;
		select 
				coalesce(sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3108%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;
		
		-- pendistribusian dan penggunaan:
		select 
				coalesce(sum(d.debet) - sum(d.kredit),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like '57%') and (j.checked='Y') and (j.approved='Y')
		into t_k;
		t_saldo := t_saldo + t_k;
		return t_saldo;
	elsif pos like '3109%' then 
		-- Dana non Halal
		t_saldo := 0;
		select 
				coalesce(sum(d.debet), 0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like ('3109%')) and (j.checked='Y') and (j.approved='Y')
		into t_saldo;
		
		-- pendistribusian dan penggunaan:
		select 
				coalesce(sum(d.debet) - sum(d.kredit),0)
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
				and (d.kode_rek like '59%') and (j.checked='Y') and (j.approved='Y')
		into t_k;
		t_saldo := t_saldo + t_k;
		return t_saldo;
	else
		return 0;
	end if;
end;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION get_saldo_dana_penurunan(character varying, date, date, character varying) OWNER TO postgres;

-- Function: gen_gl_2(character varying, date, date, character varying)

-- DROP FUNCTION gen_gl_2(character varying, date, date, character varying);

CREATE OR REPLACE FUNCTION gen_gl_2(IN kdbranch character varying, IN a_tglmulai date, IN a_tglsampai date, IN kdrek character varying)
  RETURNS TABLE(kode character varying, kode_jenis_jurnal character varying, branch_kode character varying, tanggal date, no_bukti character varying, uraian text, kode_detail character varying, kode_rek character varying, debet numeric, kredit numeric, saldo numeric, uraian_detail text) AS
$BODY$
	-- params:
	declare cabang	 	alias for $1;
					atgl1 		alias for $2;
					atgl2 		alias for $3;
					kdrek	    alias for $4;
	-- vars:
	declare 
					t_debet numeric default 0;
					t_kredit numeric default 0;
					t_saldo numeric default 0;
					r_tipe char;
					r_kode varchar;
					r_nama varchar;
					t_start date;
	--temp vars:
					xkode varchar;
					xjenis_jurnal varchar;
					xbranch_kode character varying;
					xtanggal timestamp without time zone;					
					xno_bukti varchar;
					xuraian text;
					xkode_d varchar;
					xkode_rek varchar;
					xdebet numeric default 0;
					xkredit numeric default 0;
					xuraian_d text;
					--
					persen_dskl 	numeric default 0;
					persen_csr	 	numeric default 0;
					persen_hibah	numeric default 0;
					v 						varchar;
begin
	if not (substr(kdrek,1,1) in ('1','2','3')) then
		t_start := (substr(atgl1::text,1,4)||'-01-01')::date;
	else
		t_start := '1799-12-31'::date;
	end if;

	/* Untuk rekening non-dana, lakukan seperti biasa. Tetapi untuk rekening dana, perlakukan khusus */
	-- a. Rekening normal
	if not kdrek like '310%' then
		select vc.kode, vc.tipe, vc.rekening from v_coa_2 vc where vc.kode = kdrek into r_kode, r_tipe, r_nama;
		-- Saldo sebelumnya: 
		select 
			sum(d.debet),
			sum(d.kredit)
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			where (j.branch_kode = cabang) and (j.tanggal<atgl1) and (j.tanggal>t_start)
			-- and (d.kode_rek = kdrek)
			and (d.kode_rek like (kdrek||'%')) and (j.checked='Y') and (j.approved='Y')
			group by d.kode_rek into t_debet, t_kredit;
		t_debet := coalesce(t_debet,0)::rupiah;
		t_kredit := coalesce(t_kredit,0)::rupiah;
		if r_tipe = 'D' then
			t_saldo := t_debet - t_kredit;
		else
			t_saldo := t_kredit - t_debet;
		end if;
		-- raise exception E'%',t_saldo;
		if t_saldo<>0 then
			return query( select
				'System-Gen'::varchar,
				'0000'::varchar,
				cabang,
				atgl1::date,
				'System'::varchar,
				'Saldo Sebelumnya'::text,
				'System'::varchar,
				kdrek,
				t_debet,
				t_kredit,
				t_saldo,
				r_nama::text
			);		
		end if;
		
		-- running balance
		t_debet  := 0;
		t_kredit := 0;
		for 
			xkode,
			xjenis_jurnal,
			xbranch_kode,
			xtanggal,		
			xno_bukti,
			xuraian,
			xkode_d,
			xkode_rek,
			xdebet,
			xkredit,
			xuraian_d 
		in select 
			j.kode,
			j.jenis_jurnal,
			j.branch_kode,
			j.tanggal,		
			j.no_bukti,
			j.uraian,		
			d.kode,
			d.kode_rek,
			d.debet,
			d.kredit,
			d.uraian
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			inner join sys_coa_5 c5 on c5.kode = d.kode_rek
			where (j.branch_kode = cabang)
			and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) and (j.checked='Y') and (j.approved='Y')
			-- and (d.kode_rek = kdrek)
			and (d.kode_rek like (kdrek||'%')) order by j.tanggal asc, j.kode asc
		loop
			if r_tipe = 'D' then
				t_saldo := t_saldo + xdebet - xkredit;
			else
				t_saldo := t_saldo + xkredit - xdebet;
			end if;
			-- raise exception E'% - % - % %',r_tipe, xdebet, xkredit, t_saldo;
			return query( select
				xkode,
				xjenis_jurnal,
				xbranch_kode,
				xtanggal::date,			
				xno_bukti,
				xuraian,
				xkode_d,
				xkode_rek,
				xdebet,
				xkredit,
				t_saldo,
				xuraian_d			
			);		
		end loop;
	-- b. rekening saldo dana:
	elsif kdrek like '310%' then		
		if kdrek like '3101%' then
			-- b.1. Dana Zakat:
			select vc.kode, vc.tipe, vc.rekening from v_coa_2 vc where vc.kode = substr(kdrek,1,4) into r_kode, r_tipe, r_nama;
			-- Saldo sebelumnya: 
			t_debet := 0;
			t_kredit := 0;
			select get_saldo_dana(cabang, tahun3()::date-1, atgl1-1, substr(kdrek,1,4)) into t_saldo;
			if t_saldo<>0 then
				return query( select
					'System-Gen'::varchar,
					'0000'::varchar,
					cabang,
					atgl1::date,
					'System'::varchar,
					'Saldo Sebelumnya'::text,
					'System'::varchar,
					kdrek,
					t_debet,
					t_kredit,
					t_saldo,
					r_nama::text
				);		
			end if;
			
			-- running balance
			t_debet  := 0;
			t_kredit := 0;
			for 
				xkode,
				xjenis_jurnal,
				xbranch_kode,
				xtanggal,		
				xno_bukti,
				xuraian,
				xkode_d,
				xkode_rek,
				xdebet,
				xkredit,
				xuraian_d 
			in select 
				j.kode,
				j.jenis_jurnal,
				j.branch_kode,
				j.tanggal,		
				j.no_bukti,
				j.uraian,		
				d.kode,
				d.kode_rek,
				d.debet,
				d.kredit,
				d.uraian
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				inner join sys_coa_5 c5 on c5.kode = d.kode_rek
				where (j.branch_kode = cabang)
				and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) and (j.checked='Y') and (j.approved='Y')
				-- and (d.kode_rek = kdrek)
				and (
					(d.kode_rek like (substr(kdrek,1,4)||'%'))
					or
					(d.kode_rek like ('41%'))
					or
					(d.kode_rek like ('51%'))
				)
				/*
				and (not (d.kode_rek like '510103%' ))
				*/ order by j.tanggal asc, j.kode asc
			loop
				if xkode_rek like '5%' then
					-- raise exception E'%:%',xdebet,xkredit;
					t_saldo := t_saldo - xdebet + xkredit;
				elsif xkode_rek like '4%' then
					t_saldo := t_saldo - xdebet + xkredit;
				else
					t_saldo := t_saldo + xkredit - xdebet;
				end if;

				return query( select
					xkode,
					xjenis_jurnal,
					xbranch_kode,
					xtanggal::date,			
					xno_bukti,
					xuraian,
					xkode_d,
					xkode_rek,
					xdebet,
					xkredit,
					t_saldo,
					xuraian_d			
				);		
			end loop;
		elsif kdrek like '3102%' then
			-- b.2. Dana Infaq/Sedekah:
			select vc.kode, vc.tipe, vc.rekening from v_coa_2 vc where vc.kode = substr(kdrek,1,4) into r_kode, r_tipe, r_nama;
			-- Saldo sebelumnya: 
			t_debet := 0;
			t_kredit := 0;
			select get_saldo_dana(cabang, tahun3()::date-1, atgl1-1, substr(kdrek,1,4)) into t_saldo;
			if t_saldo<>0 then
				return query( select
					'System-Gen'::varchar,
					'0000'::varchar,
					cabang,
					atgl1::date,
					'System'::varchar,
					'Saldo Sebelumnya'::text,
					'System'::varchar,
					kdrek,
					t_debet,
					t_kredit,
					t_saldo,
					r_nama::text
				);		
			end if;
			
			-- running balance
			t_debet  := 0;
			t_kredit := 0;
			for 
				xkode,
				xjenis_jurnal,
				xbranch_kode,
				xtanggal,		
				xno_bukti,
				xuraian,
				xkode_d,
				xkode_rek,
				xdebet,
				xkredit,
				xuraian_d 
			in select 
				j.kode,
				j.jenis_jurnal,
				j.branch_kode,
				j.tanggal,		
				j.no_bukti,
				j.uraian,		
				d.kode,
				d.kode_rek,
				d.debet,
				d.kredit,
				d.uraian
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				inner join sys_coa_5 c5 on c5.kode = d.kode_rek
				where (j.branch_kode = cabang)
				and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) and (j.checked='Y') and (j.approved='Y')
				-- and (d.kode_rek = kdrek)
				and (
					(d.kode_rek like (substr(kdrek,1,4)||'%'))
					or
					(d.kode_rek like ('42%')) -- Dana IS
					or
					(d.kode_rek like ('52%'))
				)
				order by j.tanggal asc, j.kode asc
			loop
				if xkode_rek like '5%' then
					t_saldo := t_saldo - xdebet + xkredit;
				elsif xkode_rek like '4%' then
					t_saldo := t_saldo - xdebet + xkredit;
				else
					t_saldo := t_saldo + xkredit - xdebet;
				end if;

				return query( select
					xkode,
					xjenis_jurnal,
					xbranch_kode,
					xtanggal::date,			
					xno_bukti,
					xuraian,
					xkode_d,
					xkode_rek,
					xdebet,
					xkredit,
					t_saldo,
					xuraian_d			
				);		
			end loop;
		elsif kdrek like '3103%' then
			-- b.3. DSKL:
			
			select vc.kode, vc.tipe, vc.rekening from v_coa_2 vc where vc.kode = substr(kdrek,1,4) into r_kode, r_tipe, r_nama;
			-- Saldo sebelumnya: 
			t_debet := 0;
			t_kredit := 0;
			select get_saldo_dana(cabang, tahun3()::date-1, atgl1-1, substr(kdrek,1,4)) into t_saldo;
			if t_saldo<>0 then
				return query( select
					'System-Gen'::varchar,
					'0000'::varchar,
					cabang,
					atgl1::date,
					'System'::varchar,
					'Saldo Sebelumnya'::text,
					'System'::varchar,
					kdrek,
					t_debet,
					t_kredit,
					t_saldo,
					r_nama::text
				);		
			end if;
			
			-- running balance
			t_debet  := 0;
			t_kredit := 0;
			for 
				xkode,
				xjenis_jurnal,
				xbranch_kode,
				xtanggal,		
				xno_bukti,
				xuraian,
				xkode_d,
				xkode_rek,
				xdebet,
				xkredit,
				xuraian_d 
			in select 
				j.kode,
				j.jenis_jurnal,
				j.branch_kode,
				j.tanggal,		
				j.no_bukti,
				j.uraian,		
				d.kode,
				d.kode_rek,
				d.debet,
				d.kredit,
				d.uraian
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				inner join sys_coa_5 c5 on c5.kode = d.kode_rek
				where (j.branch_kode = cabang)
				and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) and (j.checked='Y') and (j.approved='Y')
				-- and (d.kode_rek = kdrek)
				and (
					(d.kode_rek like (substr(kdrek,1,4)||'%'))
					or
					(d.kode_rek like ('43%'))
					or
					(d.kode_rek like ('53%'))
				)
				order by j.tanggal asc, j.kode asc
			loop
				if xkode_rek like '5%' then
					t_saldo := t_saldo - xdebet + xkredit;
				elsif xkode_rek like '4%' then
					t_saldo := t_saldo - xdebet + xkredit;
				else
					t_saldo := t_saldo + xkredit - xdebet;
				end if;

				return query( select
					xkode,
					xjenis_jurnal,
					xbranch_kode,
					xtanggal::date,			
					xno_bukti,
					xuraian,
					xkode_d,
					xkode_rek,
					xdebet,
					xkredit,
					t_saldo,
					xuraian_d			
				);		
			end loop;
		elsif kdrek like '3104%' then
			-- b.3. Dana Hak Amil:			
			select vc.kode, vc.tipe, vc.rekening from v_coa_2 vc where vc.kode = substr(kdrek,1,4) into r_kode, r_tipe, r_nama;
			-- Saldo sebelumnya: 
			t_debet := 0;
			t_kredit := 0;
			select get_saldo_dana(cabang, tahun3()::date-1, atgl1-1, substr(kdrek,1,4)) into t_saldo;
			if t_saldo<>0 then
				return query( select
					'System-Gen'::varchar,
					'0000'::varchar,
					cabang,
					atgl1::date,
					'System'::varchar,
					'Saldo Sebelumnya'::text,
					'System'::varchar,
					kdrek,
					t_debet,
					t_kredit,
					t_saldo,
					r_nama::text
				);		
			end if;
			
			-- running balance
			t_debet  := 0;
			t_kredit := 0;
			for 
				xkode,
				xjenis_jurnal,
				xbranch_kode,
				xtanggal,		
				xno_bukti,
				xuraian,
				xkode_d,
				xkode_rek,
				xdebet,
				xkredit,
				xuraian_d 
			in select 
				j.kode,
				j.jenis_jurnal,
				j.branch_kode,
				j.tanggal,		
				j.no_bukti,
				j.uraian,		
				d.kode,
				d.kode_rek,
				d.debet,
				d.kredit,
				d.uraian
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				inner join sys_coa_5 c5 on c5.kode = d.kode_rek
				where (j.branch_kode = cabang)
				and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) and (j.checked='Y') and (j.approved='Y')
				-- and (d.kode_rek = kdrek)
				and (
					(d.kode_rek like (substr(kdrek,1,4)||'%'))					
					or
					(d.kode_rek like ('54%'))
				)
				order by j.tanggal asc, j.kode asc
			loop
				if xkode_rek like '5%' then
					t_saldo := t_saldo - xdebet + xkredit;
				elsif xkode_rek like '4%' then
					t_saldo := t_saldo - xdebet + xkredit;
				else
					t_saldo := t_saldo + xkredit - xdebet;
				end if;

				return query( select
					xkode,
					xjenis_jurnal,
					xbranch_kode,
					xtanggal::date,			
					xno_bukti,
					xuraian,
					xkode_d,
					xkode_rek,
					xdebet,
					xkredit,
					t_saldo,
					xuraian_d			
				);		
			end loop;
		elsif kdrek like '3105%' then 
			-- b.5. CSR:
			
			select vc.kode, vc.tipe, vc.rekening from v_coa_2 vc where vc.kode = substr(kdrek,1,4) into r_kode, r_tipe, r_nama;
			-- Saldo sebelumnya: 
			t_debet := 0;
			t_kredit := 0;
			select get_saldo_dana(cabang, tahun3()::date-1, atgl1-1, substr(kdrek,1,4)) into t_saldo;
			if t_saldo<>0 then
				return query( select
					'System-Gen'::varchar,
					'0000'::varchar,
					cabang,
					atgl1::date,
					'System'::varchar,
					'Saldo Sebelumnya'::text,
					'System'::varchar,
					kdrek,
					t_debet,
					t_kredit,
					t_saldo,
					r_nama::text
				);		
			end if;
			
			-- running balance
			t_debet  := 0;
			t_kredit := 0;
			for 
				xkode,
				xjenis_jurnal,
				xbranch_kode,
				xtanggal,		
				xno_bukti,
				xuraian,
				xkode_d,
				xkode_rek,
				xdebet,
				xkredit,
				xuraian_d 
			in select 
				j.kode,
				j.jenis_jurnal,
				j.branch_kode,
				j.tanggal,		
				j.no_bukti,
				j.uraian,		
				d.kode,
				d.kode_rek,
				d.debet,
				d.kredit,
				d.uraian
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				inner join sys_coa_5 c5 on c5.kode = d.kode_rek
				where (j.branch_kode = cabang)
				and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) and (j.checked='Y') and (j.approved='Y')
				-- and (d.kode_rek = kdrek)
				and (
					(d.kode_rek like (substr(kdrek,1,4)||'%'))
					or
					(d.kode_rek like ('44%'))
					or
					(d.kode_rek like ('55%'))
				)
				order by j.tanggal asc, j.kode asc
			loop
				if xkode_rek like '5%' then
					t_saldo := t_saldo - xdebet + xkredit;
				elsif xkode_rek like '4%' then
					t_saldo := t_saldo - xdebet + xkredit;
				else
					t_saldo := t_saldo + xkredit - xdebet;
				end if;

				return query( select
					xkode,
					xjenis_jurnal,
					xbranch_kode,
					xtanggal::date,			
					xno_bukti,
					xuraian,
					xkode_d,
					xkode_rek,
					xdebet,
					xkredit,
					t_saldo,
					xuraian_d			
				);		
			end loop;
		elsif kdrek like '3106%' then
			-- b.6. Dana Investasi:
			/*
			if v = '' then persen_csr := 0.2; else persen_csr := v::numeric; end if;
			*/
			select vc.kode, vc.tipe, vc.rekening from v_coa_2 vc where vc.kode = substr(kdrek,1,4) into r_kode, r_tipe, r_nama;
			-- Saldo sebelumnya: 
			t_debet := 0;
			t_kredit := 0;
			/*
			1102 inv. lancar
			1103 piutang
			1201 aset tetap bruto
			1202 depresiasi aset tetap
			*/
			
			/*
			select get_saldo_rek_ringkas(cabang, '1102', tahun3()::date-1, atgl1) into t_saldo;			
			select get_saldo_rek_ringkas(cabang, '1201', tahun3()::date-1, atgl1) into t_debet;
			t_saldo := t_saldo + t_debet;
			select get_saldo_rek_ringkas(cabang, '1202', tahun3()::date-1, atgl1) into t_debet;
			t_saldo := t_saldo + t_debet;
			select get_saldo_rek_ringkas(cabang, '1301', tahun3()::date-1, atgl1) into t_debet;
			t_saldo := t_saldo + t_debet;
			select get_saldo_rek_ringkas(cabang, '1302', tahun3()::date-1, atgl1) into t_debet;
			t_saldo := t_saldo + t_debet;
			select get_saldo_rek_ringkas(cabang, '130301', tahun3()::date-1, atgl1) into t_debet;
			t_saldo := t_saldo + t_debet;
			*/

			select get_saldo_dana(cabang, tahun3()::date-1, atgl1-1, substr(kdrek,1,4)) into t_saldo;
			t_debet := 0;
			t_kredit := 0;
			if t_saldo<>0 then
				return query( select
					'System-Gen'::varchar,
					'0000'::varchar,
					cabang,
					atgl1::date,
					'System'::varchar,
					'Saldo Sebelumnya'::text,
					'System'::varchar,
					kdrek,
					t_debet,
					t_kredit,
					t_saldo,
					r_nama::text
				);		
			end if;
			
			-- running balance
			t_debet  := 0;
			t_kredit := 0;
			for 
				xkode,
				xjenis_jurnal,
				xbranch_kode,
				xtanggal,		
				xno_bukti,
				xuraian,
				xkode_d,
				xkode_rek,
				xdebet,
				xkredit,
				xuraian_d 
			in select 
				j.kode,
				j.jenis_jurnal,
				j.branch_kode,
				j.tanggal,		
				j.no_bukti,
				j.uraian,		
				d.kode,
				d.kode_rek,
				d.debet,
				d.kredit,
				d.uraian
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				inner join sys_coa_5 c5 on c5.kode = d.kode_rek
				where (j.branch_kode = cabang)
				and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) and (j.checked='Y') and (j.approved='Y')
				and (
					--substr(d.kode_rek,1,4) in ('1102', '1201', '1202', '1301','1302')
					-- or (d.kode_rek like '130301%')
					-- or
					(d.kode_rek like (substr(kdrek,1,4)||'%'))
				)
				order by j.tanggal asc, j.kode asc
			loop
				if xkode_rek like '1%' then
					t_saldo := t_saldo + xdebet - xkredit;
				else
					t_saldo := t_saldo + xkredit - xdebet;
				end if;
				
				return query( select
					xkode,
					xjenis_jurnal,
					xbranch_kode,
					xtanggal::date,			
					xno_bukti,
					xuraian,
					xkode_d,
					xkode_rek,
					xdebet,
					xkredit,
					t_saldo,
					xuraian_d			
				);		
			end loop;
		elsif kdrek like '3107%' then 
			-- b.7. Dana Hibah:
			select vc.kode, vc.tipe, vc.rekening from v_coa_2 vc where vc.kode = substr(kdrek,1,4) into r_kode, r_tipe, r_nama;
			-- Saldo sebelumnya: 
			t_debet := 0;
			t_kredit := 0;
			select get_saldo_dana(cabang, tahun3()::date-1, atgl1-1, substr(kdrek,1,4)) into t_saldo;
			if t_saldo<>0 then
				return query( select
					'System-Gen'::varchar,
					'0000'::varchar,
					cabang,
					atgl1::date,
					'System'::varchar,
					'Saldo Sebelumnya'::text,
					'System'::varchar,
					kdrek,
					t_debet,
					t_kredit,
					t_saldo,
					r_nama::text
				);		
			end if;
			
			-- running balance
			t_debet  := 0;
			t_kredit := 0;
			for 
				xkode,
				xjenis_jurnal,
				xbranch_kode,
				xtanggal,		
				xno_bukti,
				xuraian,
				xkode_d,
				xkode_rek,
				xdebet,
				xkredit,
				xuraian_d 
			in select 
				j.kode,
				j.jenis_jurnal,
				j.branch_kode,
				j.tanggal,		
				j.no_bukti,
				j.uraian,		
				d.kode,
				d.kode_rek,
				d.debet,
				d.kredit,
				d.uraian
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				inner join sys_coa_5 c5 on c5.kode = d.kode_rek
				where (j.branch_kode = cabang)
				and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) and (j.checked='Y') and (j.approved='Y')
				-- and (d.kode_rek = kdrek)
				and (
					(d.kode_rek like (substr(kdrek,1,4)||'%'))
					or
					(d.kode_rek like ('45%'))
					or
					(d.kode_rek like ('56%'))
				)
				order by j.tanggal asc, j.kode asc
			loop
				if xkode_rek like '5%' then
					t_saldo := t_saldo + xdebet - xkredit;
				else
					t_saldo := t_saldo + xkredit - xdebet;
				end if;
				return query( select
					xkode,
					xjenis_jurnal,
					xbranch_kode,
					xtanggal::date,			
					xno_bukti,
					xuraian,
					xkode_d,
					xkode_rek,
					xdebet,
					xkredit,
					t_saldo,
					xuraian_d			
				);		
			end loop;
		elsif kdrek like '3108%' then 
			-- b.7. Dana APBD:
			select vc.kode, vc.tipe, vc.rekening from v_coa_2 vc where vc.kode = substr(kdrek,1,4) into r_kode, r_tipe, r_nama;
			-- Saldo sebelumnya: 
			t_debet := 0;
			t_kredit := 0;
			select get_saldo_dana(cabang, tahun3()::date-1, atgl1-1, substr(kdrek,1,4)) into t_saldo;
			if t_saldo<>0 then
				return query( select
					'System-Gen'::varchar,
					'0000'::varchar,
					cabang,
					atgl1::date,
					'System'::varchar,
					'Saldo Sebelumnya'::text,
					'System'::varchar,
					kdrek,
					t_debet,
					t_kredit,
					t_saldo,
					r_nama::text
				);		
			end if;
			
			-- running balance
			t_debet  := 0;
			t_kredit := 0;
			for 
				xkode,
				xjenis_jurnal,
				xbranch_kode,
				xtanggal,		
				xno_bukti,
				xuraian,
				xkode_d,
				xkode_rek,
				xdebet,
				xkredit,
				xuraian_d 
			in select 
				j.kode,
				j.jenis_jurnal,
				j.branch_kode,
				j.tanggal,		
				j.no_bukti,
				j.uraian,		
				d.kode,
				d.kode_rek,
				d.debet,
				d.kredit,
				d.uraian
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				inner join sys_coa_5 c5 on c5.kode = d.kode_rek
				where (j.branch_kode = cabang)
				and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) and (j.checked='Y') and (j.approved='Y')
				-- and (d.kode_rek = kdrek)
				and (
					(d.kode_rek like (substr(kdrek,1,4)||'%'))
					or
					(d.kode_rek like ('46%'))
					or
					(d.kode_rek like ('57%'))
				)
				order by j.tanggal asc, j.kode asc
			loop
				if xkode_rek like '5%' then
					t_saldo := t_saldo + xdebet - xkredit;
				else
					t_saldo := t_saldo + xkredit - xdebet;
				end if;
				return query( select
					xkode,
					xjenis_jurnal,
					xbranch_kode,
					xtanggal::date,			
					xno_bukti,
					xuraian,
					xkode_d,
					xkode_rek,
					xdebet,
					xkredit,
					t_saldo,
					xuraian_d			
				);		
			end loop;
		elsif kdrek like '3109%' then 
			-- b.7. Dana Non Halal:
			select vc.kode, vc.tipe, vc.rekening from v_coa_2 vc where vc.kode = substr(kdrek,1,4) into r_kode, r_tipe, r_nama;
			-- Saldo sebelumnya: 
			t_debet := 0;
			t_kredit := 0;
			select get_saldo_dana(cabang, tahun3()::date-1, atgl1-1, substr(kdrek,1,4)) into t_saldo;
			if t_saldo<>0 then
				return query( select
					'System-Gen'::varchar,
					'0000'::varchar,
					cabang,
					atgl1::date,
					'System'::varchar,
					'Saldo Sebelumnya'::text,
					'System'::varchar,
					kdrek,
					t_debet,
					t_kredit,
					t_saldo,
					r_nama::text
				);		
			end if;
			
			-- running balance
			t_debet  := 0;
			t_kredit := 0;
			for 
				xkode,
				xjenis_jurnal,
				xbranch_kode,
				xtanggal,		
				xno_bukti,
				xuraian,
				xkode_d,
				xkode_rek,
				xdebet,
				xkredit,
				xuraian_d 
			in select 
				j.kode,
				j.jenis_jurnal,
				j.branch_kode,
				j.tanggal,		
				j.no_bukti,
				j.uraian,		
				d.kode,
				d.kode_rek,
				d.debet,
				d.kredit,
				d.uraian
			from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				inner join sys_coa_5 c5 on c5.kode = d.kode_rek
				where (j.branch_kode = cabang)
				and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) and (j.checked='Y') and (j.approved='Y')
				-- and (d.kode_rek = kdrek)
				and (
					(d.kode_rek like (substr(kdrek,1,4)||'%'))
					or
					(d.kode_rek like ('49%'))
					or
					(d.kode_rek like ('59%'))
				)
				order by j.tanggal asc, j.kode asc
			loop
				if xkode_rek like '5%' then
					t_saldo := t_saldo + xdebet - xkredit;
				else
					t_saldo := t_saldo + xkredit - xdebet;
				end if;
				return query( select
					xkode,
					xjenis_jurnal,
					xbranch_kode,
					xtanggal::date,			
					xno_bukti,
					xuraian,
					xkode_d,
					xkode_rek,
					xdebet,
					xkredit,
					t_saldo,
					xuraian_d			
				);		
			end loop;
		end if;		
	end if;
end;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION gen_gl_2(character varying, date, date, character varying) OWNER TO postgres;




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


	
	return query(
		select s_trans_name,
			''::varchar, ''::varchar, upper('jumlah infak/sedekah')::varchar, sum_t::rupiah, 2, 'F'::char 
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
			'42000000'::varchar, ''::varchar, 'Bagian Amil Dari Dana Infak/Sedekah'::varchar, bagian_amil::rupiah, 3, 'D'::char
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
	urut2 := urut2+1;
	select 
			coalesce(sum(d.kredit - d.debet),0)
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
			and (d.kode_rek like '3104%') and (j.checked='Y') and (j.approved='Y')
			and (j.jenis_trans in ('3107'))
		into bagian_amil; 
	sum_t := sum_t + bagian_amil;
	return query(
		select urut2::varchar,
			'42000000'::varchar, ''::varchar, 'Bagian Amil Dari Dana Hibah'::varchar, bagian_amil::rupiah, 3, 'D'::char
	);	
	urut2 := urut2+1;
	select 
			coalesce(sum(d.kredit - d.debet),0)
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
			and (d.kode_rek like '3104%') and (j.checked='Y') and (j.approved='Y')
			and (j.jenis_trans in ('3108'))
		into bagian_amil; 
	sum_t := sum_t + bagian_amil;
	if bagian_amil<>0 then
		return query(
			select urut2::varchar,
				'42000000'::varchar, ''::varchar, 'Bagian Amil Dari Dana APBD'::varchar, bagian_amil::rupiah, 3, 'D'::char
		);	
	end if;

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

	-- Dana Hibah
	return query(
		select 
			''::varchar, ''::varchar, ''::varchar, 'DANA HIBAH'::varchar, 0::rupiah, 9, 'T'::char
	);
	laba := 0;
	sum_t := 0;
	sum_x := 0;
	bagian_amil := 0;
	prefix := '45';
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
			and (j.jenis_trans in ('3107'))
		into bagian_amil; 
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, 'Bagian Amil atas penerimaan Dana Hibah'::varchar, bagian_amil::rupiah, 3, 'D'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	sum_t := sum_t - bagian_amil;
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, upper('Jumlah penerimaan Dana Hibah setelah bagian amil')::varchar, sum_t::rupiah, 2, 'F'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	laba := sum_t;
	
	prefix := '56';
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
			vc2.full_kode::varchar, vc2.vkode, upper('JUMLAH Penyaluran Dana Hibah')::varchar, sum_x::rupiah, 2, 'F'::char from v_coa_2 vc2 
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

	-- Dana APBD
	return query(
		select 
			''::varchar, ''::varchar, ''::varchar, 'DANA APBD PEMERINTAH KOTA PALOPO'::varchar, 0::rupiah, 9, 'T'::char
	);
	laba := 0;
	sum_t := 0;
	sum_x := 0;
	bagian_amil := 0;
	prefix := '46';
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
			and (j.jenis_trans in ('3108'))
		into bagian_amil; 
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, 'Bagian Amil atas penerimaan Dana APBD'::varchar, bagian_amil::rupiah, 3, 'D'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	sum_t := sum_t - bagian_amil;
	return query(
		select s_trans_name,
			vc2.full_kode::varchar, vc2.vkode, upper('Jumlah penerimaan Dana APBD setelah bagian amil')::varchar, sum_t::rupiah, 2, 'F'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);
	laba := sum_t;
	
	prefix := '57';
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
			vc2.full_kode::varchar, vc2.vkode, upper('JUMLAH Penyaluran Dana APBD')::varchar, sum_x::rupiah, 2, 'F'::char from v_coa_2 vc2 
			where vc2.kode= prefix
	);

	laba := laba - sum_x;
	return query( select s_trans_name, 'E4151000'::varchar, 'E4151'::varchar, ''::varchar, 0::rupiah, 2, 'H'::char);
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Surplus (defisit)'::varchar, laba::rupiah, 2, 'F'::char);
	-- saldo awal:
	saldo_t := get_saldo_dana(cabang, tahun3()::date-1, atgl1-1, '3108');
	laba := laba + saldo_t;
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Saldo Awal'::varchar, saldo_t::rupiah, 2, 'F'::char);
	saldo_t := coalesce((
		select 
			coalesce(sum(d.kredit - d.debet),0)
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
			and (d.kode_rek like ('3108%')) and (j.checked='Y') and (j.approved='Y') and (not (j.jenis_trans in ('UPZF', '3108')))
	), 0);
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Kenaikan (Penurunan) Akibat Pemindahbukuan'::varchar, saldo_t::rupiah, 2, 'F'::char);
	laba := laba + saldo_t;
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
	saldo_t := get_saldo_dana(cabang, tahun3()::date-1, atgl1-1, '3109');
	laba := laba + saldo_t;
	return query( select s_trans_name, 'S4151000'::varchar, 'S4151'::varchar, 'Saldo Awal'::varchar, saldo_t::rupiah, 2, 'F'::char);
	saldo_t := coalesce((
		select 
			coalesce(sum(d.kredit - d.debet),0)
		from acc_jurnal_u j
			inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
			where (j.branch_kode = cabang) and (j.tanggal>=atgl1) and (j.tanggal<=atgl2) 
			and (d.kode_rek like ('3109%')) and (j.checked='Y') and (j.approved='Y') and (not (j.jenis_trans in ('UPZF', '3109')))
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
