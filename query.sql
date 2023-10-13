-- Add column „Stadt“ and „Adresse“
	alter table bln_kita 
	add stadt varchar, add adresse varchar


-- Set value to column
	update bln_kita 
	set stadt = 'Berlin'
	
	update bln_kita 
	set adresse = concat(einrichtungsadresse, ', ', plz, ', ', stadt),

-- Import bln_kita_geo to Postgres
CREATE TABLE u577979.bln_kita_geo (
	betreuungsbezirk_nr int4 NULL,
	betreuungsbezirk varchar NULL,
	einrichtungsnummer int4 NULL,
	einrichtungsname varchar NULL,
	einrichtungsadresse varchar NULL,
	plz int4 NULL,
	telefon varchar NULL,
	anzahl_plätze int4 NULL,
	einrichtungsart varchar NULL,
	trägernummer int4 NULL,
	trägername varchar NULL,
	trägerart varchar NULL,
	stadt varchar NULL,
	adresse varchar NULL,
	latitude float8 NULL,
	longitude float8 NULL,
	geometry geometry null,
	"index" int4 NULL
);

-- Set value to column
UPDATE u577979.bln_kita_geo 
SET geometry = ST_GeomFromText('POINT(' || longitude || ' ' || latitude || ')',4326);


with base1 as (
	select
	    bkg.einrichtungsname as kita_name,
		gotf."name" as haltestelle,
		st_distance(bkg.geometry, gotf.geometry) as min_distance
	from ugeobln.gis_osm_transport_free_1 gotf, u577979.bln_kita_geo bkg 
	),
	base2 as (
	select * from
    (select *,
        row_number() over(partition by kita_name order by min_distance asc ) as RowNum
     from base1
    ) A
    where RowNum = 1
	), 
	base3 as (
		select kita_name, betreuungsbezirk as bezirk, bkg.adresse, telefon, anzahl_plätze, 
	       case when anzahl_plätze <= 100 then 'sehr klein'
                when anzahl_plätze > 100 and anzahl_plätze  <= 200 then 'klein'
                when anzahl_plätze > 200 and anzahl_plätze  <= 300 then 'mittel'
           else 'groß'
           end as gruppe_plätze,
	       einrichtungsart as kita_art, trägername, 
	       trägerart, bkg.latitude, bkg.longitude , bkg.geometry as geom, min_distance, haltestelle
	from base2
	join u577979.bln_kita_geo bkg 
	on base2.kita_name = bkg.einrichtungsname
	)

    SELECT ST_ClusterKMeans(geom, 3) over (PARTITION BY gruppe_plätze) AS cid, kita_name, gruppe_plätze, anzahl_plätze
    FROM base3 ;