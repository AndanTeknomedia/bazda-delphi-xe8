-- Function: get_data_muzaki(character varying, date, date, character varying, character varying)

-- DROP FUNCTION get_data_upz(character varying, date, date, varchar, character varying, character varying);

CREATE OR REPLACE FUNCTION get_data_upz(IN kdbranch character varying, IN atgl1 date, IN atgl2 date, in tipe_upz varchar default '*', IN akecamatan character varying DEFAULT '*'::character varying, IN akelurahan character varying DEFAULT '*'::character varying)
  RETURNS TABLE(npwz character varying, tipe character varying, nama character varying, alamat_user text, alamat_system character varying, data text) AS
$BODY$
	-- params:
	declare 
		cabang	 	alias for $1;
		tgl1 			alias for $2;
		tgl2 			alias for $3;
		atipe			alias for $4;
		kec 			alias for $5;
		kel				alias for $6;
					
	-- vars:
	declare 
		kode_tipemzk		varchar;
		uraian_tipemzk	varchar;
		reks_terima			varchar[];
		reks_salur			varchar[];
		json						text default '';
		tmp							text default '';
		i								integer;
		j								integer;
		a_npwz					varchar;
		a_tipe					varchar;
		a_nama 					varchar;
		a_alamat_user 	text;
		a_alamat_system varchar;
		s_awal_t				rupiah default 0;
		s_awal_s				rupiah default 0;
		s_tmp						rupiah default 0;
		s_total_t				rupiah default 0;
		s_total_s				rupiah default 0;
		s_akhir					rupiah default 0;
begin
	-- raise exception E'%:%',kec,kel;
	/*
	SAMPLE:
	--
	select * from 
	get_data_upz('073', '2017-01-01', '2017-12-31', '02')
	--
	*/
	-- ambil daftar rekening:
	select array(
		select (full_kode||'Penerimaan|'||replace(replace(rekening,'Penerimaan Zakat Mal - ','ZM - '),'Penerimaan ',''))
		from v_coa_2 where (tingkat = 5) and (kode like '4%') and (substr(kode,1,2) <> '49') order by kode asc
	) into reks_terima;
	
	select array(
		select (full_kode||
			(case substr(kode,1,2) when '51' then
				'Distribusi Zakat Kepada|'||replace(
						replace(rekening,'Distribusi ',''),
						'Zakat Kepada ',''
					)
			else
				'Distribusi Infak/Sedekah Kepada|'||replace(
						replace(rekening,'Distribusi ',''),
						'Infak/Sedekah Kepada ',''
					)
			end)
		)
		from v_coa_2 where (tingkat = 5) and (substr(kode,1,2) in ('51','52')) order by kode asc
	) into reks_salur;
	
	-- record pertama diisi kode, rekening dan nilai:
	json := '{tipe: "meta", data:[';	
	json := json || '{k: "AWAL0000", r: "Saldo Awal|Penerimaan", v: 0.00, c:10},';
	json := json || '{k: "AWAL0000", r: "Saldo Awal|Penyaluran", v: 0.00, c:20},';
	for i in array_lower(reks_terima,1) .. array_upper(reks_terima,1) loop			
		tmp := reks_terima[i];
		json := json || '{k: "'||substr(tmp,1,8)||'", r: "'||substr(tmp,9,100)||'", v: 0.00,c:0},';
	end loop;
	json := json || '{k: "TP000000", r: "Total Penerimaan", v: 0.00, c:10},';
	for i in array_lower(reks_salur,1) .. array_upper(reks_salur,1) loop			
		tmp := reks_salur[i];
		json := json || '{k: "'||substr(tmp,1,8)||'", r: "'||substr(tmp,9,100)||'", v: 0.00,c:0},';
	end loop;
	json := json || '{k: "TP000000", r: "Total Penyaluran", v: 0.00, c:20},';
	json := json || '{k: "AKHIR000", r: "Saldo Akhir", v: 0.00, c:30}';
	json := json||']}';
	return query(
		select ''::varchar, atipe::varchar, ''::varchar, ''::text, ''::varchar, json
	);	
	-- looping jenis muzaki:
	i := 0;
	j := 0;
	for kode_tipemzk, uraian_tipemzk in select jm.kode, jm.uraian from baz_jenis_muzakki jm 
	where (
	case atipe when '*' then (not jm.kode in ('00','01')) else (jm.kode = atipe) end) order by jm.kode asc
	loop
		i := i+1;
		j := j+1;
		json := '{tipe: "head", data:[{v: 0},{v: 0},';
		for i in array_lower(reks_terima,1) .. array_upper(reks_terima,1) loop json := json || '{v: 0},'; end loop;
		json := json || '{v: 0},';
		for i in array_lower(reks_salur,1) .. array_upper(reks_salur,1) loop json := json || '{v: 0},'; end loop;
		json := json || '{v: 0},{v: 0}]}';
		return query(
			select i::varchar, kode_tipemzk::varchar, (j||'. '||uraian_tipemzk)::varchar, ''::text, ''::varchar, json
		);	
		-- loop muzaki sesuai jenisnya:
		for a_npwz, a_tipe, a_nama, a_alamat_user, a_alamat_system in 	
		select z.npwz, j.uraian, z.nama, z.alamat, (k.nama||', '||k.kecamatan)::varchar from 
			baz_muzakki z 
			inner join v_kelurahan k on k.kode = z.kelurahan
			inner join baz_jenis_muzakki j on j.kode = z.tipe
			where
			-- where clausa here...
			(z.tipe = kode_tipemzk)		
			-- filter kecamatan
			and (case when substr(kec,1,1) <> '*' then (substr(k.kode,1,6) = kec) else (1=1) end)
			-- filter kelurahan
			and (case when substr(kel,1,1) <> '*' then (substr(k.kode,7,4) = substr(kel,7,4)) else (1=1) end)
			order by z.nama asc
		loop
			json := '{tipe: "detail", data:[';		
			s_awal_t := 0;	
			s_awal_s := 0;	
			s_tmp := 0;	
			s_total_t := 0;	
			s_total_s := 0;	
			s_akhir := 0;	
			-- saldo awal
			select coalesce(sum(d.kredit) - sum(d.debet), 0)
				from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<tgl1) and (j.npwz = a_npwz)
				and (d.kode_rek like '4%') and (substr(d.kode_rek,1,2) <> '49')  and (j.checked='Y') and (j.approved='Y')
			into s_awal_t;	
			s_akhir := s_awal_t;	
			json := json || '{v: '||s_awal_t::text||'},';
			select coalesce(sum(d.debet) - sum(d.kredit), 0)
				from acc_jurnal_u j
				inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
				where (j.branch_kode = cabang) and (j.tanggal<tgl1) and (j.npwz = a_npwz)
				and (substr(d.kode_rek,1,2) in ('51','52')) and (j.checked='Y') and (j.approved='Y')
			into s_awal_s;		
			s_akhir := s_akhir - s_awal_s;
			json := json || '{v: '||s_awal_s::text||'},';
			-- peneriman
		
			for i in array_lower(reks_terima,1) .. array_upper(reks_terima,1) loop			
				tmp := reks_terima[i];
				select coalesce(sum(d.kredit) - sum(d.debet), 0)
					from acc_jurnal_u j
					inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
					where (j.branch_kode = cabang) and (j.tanggal>=tgl1) and (j.tanggal<=tgl2) and (j.npwz = a_npwz)
					and (d.kode_rek  = substr(tmp,1,8))  and (j.checked='Y') and (j.approved='Y')
				into s_tmp;
				s_total_t := s_total_t + s_tmp;
				json := json || '{v: '||s_tmp::text||'},';
			end loop;
			json := json || '{v: '||s_total_t::text||'},';
			s_akhir := s_akhir + s_total_t;
			--penyaluran
			for i in array_lower(reks_salur,1) .. array_upper(reks_salur,1) loop			
				tmp := reks_salur[i];
				select coalesce(sum(d.debet) - sum(d.kredit), 0)
					from acc_jurnal_u j
					inner join acc_jurnal_u_detail d on d.ref_jurnal = j.kode
					where (j.branch_kode = cabang) and (j.tanggal>=tgl1) and (j.tanggal<=tgl2) and (j.npwz = a_npwz)
					and (d.kode_rek  = substr(tmp,1,8))  and (j.checked='Y') and (j.approved='Y')
				into s_tmp;
				s_total_s := s_total_s + s_tmp;
				json := json || '{v: '||s_tmp::text||'},';
			end loop;
			json := json || '{v: '||s_total_s::text||'},';
			s_akhir := s_akhir - s_total_s;	
			json := json || '{v: '||s_akhir::text||'}';
			json := json||']}';
			return query(
				select a_npwz, a_tipe, a_nama, a_alamat_user, a_alamat_system, json
			);
			i := i+1;
		end loop;
	end loop;	
end;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
