DROP VIEW IF EXISTS trips_view;
DROP VIEW IF EXISTS trip_origin;
DROP VIEW IF EXISTS trip_dest;


CREATE	VIEW trip_origin AS
SELECT l.iso_code AS country_iso_origin,
       country_name AS country_name_origin,
       location_name AS loc_name_origin,
       cni AS cni_boat,
       iso_code_boat AS country_iso_boat,
       start_date AS trip_start_date,
       date,
       id_sailor,
       iso_code_sailor,
       end_date
FROM location l
INNER JOIN trip t ON t.start_latitude = l.latitude AND t.start_longitude = l.longitude
INNER JOIN country c ON l.iso_code = c.iso_code;

CREATE	VIEW trip_dest
AS
SELECT l.iso_code AS country_iso_dest,
       country_name AS country_name_dest,
       location_name AS loc_name_dest,
       cni AS cni_boat,
       iso_code_boat AS country_iso_boat,
       start_date AS trip_start_date,
       date,
       id_sailor,
       iso_code_sailor,
       end_date
FROM location l
INNER JOIN trip t ON t.end_latitude = l.latitude AND t.end_longitude = l.longitude
INNER JOIN country c ON l.iso_code = c.iso_code;

CREATE	VIEW trips_view
AS
SELECT o.country_iso_origin,
       o.country_name_origin,
       d.country_iso_dest,
       d.country_name_dest,
       o.loc_name_origin,
       d.loc_name_dest,
       d.cni_boat,
       d.country_iso_boat,
       country_name AS country_name_boat,
       d.trip_start_date
FROM trip_origin o
JOIN trip_dest d ON (o.date=d.date AND
                      o.cni_boat = d.cni_boat AND
                      o.country_iso_boat = d.country_iso_boat AND
                      o.id_sailor = d.id_sailor AND
                      o.iso_code_sailor = d.iso_code_sailor AND
                      o.trip_start_date = d.trip_start_date AND
                      o.end_date = d.end_date)
JOIN country c ON o.country_iso_boat = c.iso_code;