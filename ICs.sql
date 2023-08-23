/*(IC-1) Two reservations for the same boat can not have their corresponding date intervals intersecting.*/
/*1 trigger*/
CREATE OR REPLACE FUNCTION date_overlaps()
RETURNS TRIGGER AS
$$
DECLARE
     rec RECORD;
BEGIN
    SELECT * INTO rec
    FROM reservation
    WHERE NEW.cni = reservation.cni AND
          NEW.iso_code_boat = reservation.iso_code_boat AND
          NEW.id_sailor = reservation.id_sailor AND
          NEW.iso_code_sailor = reservation.iso_code_sailor AND
          reservation.start_date < NEW.end_date AND
          reservation.end_date > NEW.start_date;
    IF FOUND THEN
        RAISE EXCEPTION'(IC1): The boat % has already been reserved for those dates', NEW.iso_code_boat;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS overlaps_trigger ON reservation;

CREATE TRIGGER overlaps_trigger
BEFORE INSERT OR UPDATE ON reservation
FOR EACH ROW EXECUTE PROCEDURE date_overlaps();


/*(IC-2) Any location must be specialized in one of three - disjoint - entities: marina, wharf, or port.*/
/*4 triggers*/
--for mandatory
CREATE OR REPLACE FUNCTION location_mandatory_specialization()
RETURNS TRIGGER AS
$$
BEGIN
    IF (NEW.latitude , NEW.longitude) NOT IN (
        (SELECT marina.latitude , marina.longitude FROM marina) UNION
        (SELECT wharf.latitude , wharf.longitude FROM wharf) UNION
        (SELECT port.latitude , port.longitude FROM port)
    ) THEN
        RAISE EXCEPTION '(IC2):The location % has to be specialized into a port, marina or wharf.', NEW.location_name;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS location_mandatory_specialization_trigger ON location;

CREATE CONSTRAINT TRIGGER location_mandatory_specialization_trigger
AFTER INSERT ON location DEFERRABLE
FOR EACH ROW EXECUTE PROCEDURE location_mandatory_specialization();

--for disjoint wharf
CREATE OR REPLACE FUNCTION disjoint_wharf()
RETURNS TRIGGER AS
$$
DECLARE
     rec RECORD;
BEGIN
    SELECT * INTO rec FROM port WHERE NEW.latitude = port.latitude AND NEW.longitude = port.longitude;

    IF FOUND THEN
        RAISE EXCEPTION'(IC2):The location at (%,%) is specialized already into a port', NEW.latitude, NEW.longitude;
    END IF;
    SELECT * INTO rec FROM marina WHERE NEW.latitude = marina.latitude AND NEW.longitude = marina.longitude;

    IF FOUND THEN
        RAISE EXCEPTION'(IC2):The location at (%,%) is specialized already into a marina', NEW.latitude, NEW.longitude;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS location_disjoint_trigger_wharf ON wharf;

CREATE TRIGGER location_disjoint_trigger_wharf
BEFORE INSERT OR UPDATE ON wharf
FOR EACH ROW EXECUTE PROCEDURE disjoint_wharf();

--for disjoint marina
CREATE OR REPLACE FUNCTION disjoint_marina()
RETURNS TRIGGER AS
$$
DECLARE
     rec RECORD;
BEGIN
    SELECT * INTO rec FROM wharf WHERE NEW.latitude = wharf.latitude AND NEW.longitude = wharf.longitude;

    IF FOUND THEN
        RAISE EXCEPTION'(IC2):The location at (%,%) is specialized already into a wharf', NEW.latitude, NEW.longitude;
    END IF;
    SELECT * INTO rec FROM port WHERE NEW.latitude = port.latitude AND NEW.longitude = port.longitude;

    IF FOUND THEN
        RAISE EXCEPTION'(IC2):The location at (%,%) is specialized already into a port', NEW.latitude, NEW.longitude;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS location_disjoint_trigger_marina ON marina;

CREATE TRIGGER location_disjoint_trigger_marina
BEFORE INSERT OR UPDATE ON marina
FOR EACH ROW EXECUTE PROCEDURE disjoint_marina();

--for disjoint port
CREATE OR REPLACE FUNCTION disjoint_port()
RETURNS TRIGGER AS
$$
DECLARE
     rec RECORD;
BEGIN
    SELECT * INTO rec FROM wharf WHERE NEW.latitude = wharf.latitude AND NEW.longitude = wharf.longitude;

    IF FOUND THEN
        RAISE EXCEPTION'(IC2):The location at (%,%) is specialized already into a wharf', NEW.latitude, NEW.longitude;
    END IF;
    SELECT * INTO rec FROM marina WHERE NEW.latitude = marina.latitude AND NEW.longitude = marina.longitude;

    IF FOUND THEN
        RAISE EXCEPTION'(IC2):The location at (%,%) is specialized already into a marina', NEW.latitude, NEW.longitude;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS location_disjoint_trigger_port ON port;

CREATE TRIGGER location_disjoint_trigger_port
BEFORE INSERT OR UPDATE ON port
FOR EACH ROW EXECUTE PROCEDURE disjoint_port();


/*(IC-3) A country where a boat is registered must correspond - at least - to one location.*/
/*1 trigger*/
CREATE OR REPLACE FUNCTION boat_country_has_location()
RETURNS TRIGGER AS
$$
DECLARE
     rec RECORD;
BEGIN
    SELECT * INTO rec FROM location WHERE

            NEW.boat_iso_code = location.iso_code;


    IF NOT FOUND THEN
        RAISE EXCEPTION'(IC3): There are no registered locations in this country';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS boat_country_has_location_trigger ON boat;

CREATE TRIGGER boat_country_has_location_trigger
BEFORE INSERT OR UPDATE ON boat
FOR EACH ROW EXECUTE PROCEDURE boat_country_has_location();