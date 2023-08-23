/*6.1*/
SELECT EXTRACT(YEAR FROM trip_start_date) AS year,
       NULL AS month,
       TO_DATE(NULL, 'YYYY-MM-DD') AS date,
       COUNT(*) AS numb_of_trips
FROM trips_view t
GROUP BY  year
UNION
SELECT NULL,
       EXTRACT(MONTH FROM trip_start_date) AS month,
       TO_DATE(NULL, 'YYYY-MM-DD') AS date,
       COUNT(*)
FROM trips_view t
GROUP BY month
UNION
SELECT NULL AS year,
       NULL AS month,
       trip_start_date AS date,
       COUNT(*)
FROM trips_view t
GROUP BY  date
ORDER BY year,month,date;

/*6.2*/
SELECT country_name_origin,loc_name_origin,COUNT(*) AS numb_of_trips
FROM trips_view t
GROUP BY CUBE (country_name_origin,loc_name_origin)
ORDER BY country_name_origin,loc_name_origin;