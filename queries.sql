/*1. Who is the owner with the most boats per country? (Em cada país quem é o owner com mais barcos)*/

SELECT DISTINCT ON (boat_iso_code) boat_iso_code,COUNT(id_owner) as boats, person_name
 FROM boat b
  JOIN owner o ON b.id_owner=o.owner_id
  JOIN person p ON p.person_id =o.owner_id
GROUP BY boat_iso_code,person_name
ORDER BY boat_iso_code, COUNT(id_owner) DESC


/*2. List all the owners that have at least two boats in distinct countries. (Lista de owners com que têm pelo menos 2 barcos em países diferentes)*/

SELECT (SELECT person_name
	FROM person AS p
	WHERE o.owner_id = p.person_id
	), o.owner_id,COUNT(DISTINCT b.cni) AS number_of_boats
FROM owner o INNER JOIN boat b ON o.owner_id = b.id_owner
GROUP BY o.owner_id
HAVING COUNT(DISTINCT b.boat_iso_code) > 1;



/*3. Who are the sailors that have sailed to every location in 'Portugal'? (sailors que já passaram por todos os sitios em portugal)*/


SELECT person_name, COUNT(distinct l.latitude) AS number_of_times_visited_all_portugal
FROM person p JOIN sailor s
ON p.person_id = s.sailor_id
JOIN trip t ON t.id_sailor = s.sailor_id
JOIN location l
ON (((t.start_latitude = l.latitude AND t.start_longitude = l.longitude) OR (t.end_latitude = l.latitude AND t.end_longitude = l.longitude)) AND l.iso_code='PT')
GROUP BY person_name
HAVING COUNT(distinct l.latitude) = (
	SELECT COUNT(*)
	FROM location
	WHERE iso_code = 'PT');



/*4. List the sailors with the most trips along with their reservations ( SAILOR com mais trips assim como quantas reservas efetou para fazer estas viagens)*/


SELECT p.person_name,COUNT(t.id_sailor) AS trips, t.id_sailor,
	(SELECT COUNT(*)
	FROM reservation r
	WHERE r.id_sailor=t.id_sailor) AS reservations
FROM person p JOIN trip t ON p.person_id = t.id_sailor
GROUP BY (person_name,t.id_sailor)
HAVING COUNT (t.id_sailor)>=ALL(
 	SELECT COUNT(id_sailor)
	FROM person p JOIN trip t ON p.person_id = t.id_sailor
	GROUP BY person_name)


/*5. List the sailors with the longest duration of trips (sum of trip durations) for the same
single reservation; display also the sum of the trip durations.*/


SELECT sum(duration) AS sumoftripdurations, t.id_sailor,
	( SELECT person_name
	  FROM person p
	  WHERE p.person_id=t.id_sailor)
    FROM trip t JOIN reservation r ON r.id_sailor=t.id_sailor
    WHERE(t.start_date >= r.start_date AND t.end_date <= r.end_date)
    GROUP BY t.id_sailor,r.start_date,r.end_date
 HAVING SUM(duration) >= ALL (
    SELECT sum(duration)
    FROM trip t JOIN reservation r ON r.id_sailor=t.id_sailor
    WHERE(t.start_date >= r.start_date AND t.end_date <= r.end_date)
    GROUP BY t.id_sailor,r.start_date,r.end_date);

