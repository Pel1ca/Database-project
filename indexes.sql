DROP INDEX IF EXISTS  boat_idx;
CREATE INDEX boat_idx ON boat USING
BTREE(boat_iso_code,year);

EXPLAIN ANALYSE SELECT boat.boat_name
FROM boat INNER JOIN
country ON boat.boat_iso_code=country.iso_code
WHERE year >= 2000
AND country.country_name = 'Portugal';

DROP INDEX IF EXISTS trip_idx;
CREATE INDEX trip_idx ON trip USING
BTREE(start_date);

EXPLAIN ANALYSE SELECT count(*)
FROM trip
INNER JOIN location ON
trip.end_latitude=location.latitude
AND trip.end_longitude=location.longitude
WHERE start_date BETWEEN '12/12/2021' AND '13/12/2021'
AND location.location_name LIKE '%Porto%';