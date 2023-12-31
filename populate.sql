-- POPULATE DATABASE


-- POPULATE COUNTRY
--(flag,name,iso)
INSERT INTO country VALUES('https://www.worldometers.info/img/flags/po-flag.gif','Portugal','PT');
INSERT INTO country VALUES('https://www.worldometers.info/img/flags/sf-flag.gif','South Africa','ZF');
INSERT INTO country VALUES('https://www.worldometers.info/img/flags/rs-flag.gif','Russia','RS');
INSERT INTO country VALUES('https://www.worldometers.info/img/flags/uk-flag.gif','United Kingdom','UK');
INSERT INTO country VALUES('https://www.worldometers.info/img/flags/us-flag.gif','United States','US');
INSERT INTO country VALUES('https://www.worldometers.info/img/flags/it-flag.gif','Italy','IT');


--POPULATE LOCATION AND SPECIALIZATIONS (HAVE TO BE ALL INSIDE TRANSACTION SO THE TRIGGERS WORK)
START TRANSACTION;
SET CONSTRAINTS ALL DEFERRED;

--POPULATE LOCATION
--(nome,latitude,longitude,iso)
INSERT INTO location VALUES ('Porto Leixoes',41.183455,-8.7031843,'PT');
INSERT INTO location VALUES ('Marina de Vilamoura',37.077774,-8.1220201,'PT');
INSERT INTO location VALUES ('Mossel Bay',-34.177435,22.146771,'ZF');
INSERT INTO location VALUES ('Long Wharf Boston',42.360183,-71.049666,'US');
INSERT INTO location VALUES ('Porto Cervo',41.136240,9.5271152,'IT');
INSERT INTO location VALUES ('Porto CervoRS',41.136240,8.5271152,'RS');
INSERT INTO location VALUES ('Ria de Aveiro',40.651960,-8.678066,'PT');

-- POPULATE MARINA
--(latitude,longitude)
INSERT INTO marina VALUES (37.077774,-8.1220201);
INSERT INTO marina VALUES (41.136240,9.5271152);
INSERT INTO marina VALUES (41.136240,8.5271152);

-- POPULATE WHARF
--(latitude,longitude)
INSERT INTO wharf VALUES(42.360183,-71.049666);
INSERT INTO wharf VALUES(-34.177435,22.146771);
INSERT INTO wharf VALUES(40.651960,-8.678066);

-- POPULATE PORT
--(latitude,longitude)
INSERT INTO port VALUES(41.183455,-8.7031843);

COMMIT;


-- POPULATE PERSON
--(id,name,iso)
INSERT INTO person VALUES ('971594034','Joao Rendeiro','PT');
INSERT INTO person VALUES ('444244189','Miguel Chafarrica','PT');
INSERT INTO person VALUES ('364617091','Johnny Coxo','PT');
INSERT INTO person VALUES ('598414351','Raiumundo Jose','ZF');
INSERT INTO person VALUES ('185277083','Vladimyr Putin','RS');
INSERT INTO person VALUES ('642510174','Megan Fox','UK');
INSERT INTO person VALUES ('597101044','Donald Trump','US');
INSERT INTO person VALUES ('274215816','Mateo Salvini','IT');

-- POPULATE SAILOR
--(id,iso)
INSERT INTO sailor VALUES ('444244189','PT');
INSERT INTO sailor VALUES ('598414351','ZF');
INSERT INTO sailor VALUES ('642510174','UK');
INSERT INTO sailor VALUES ('274215816','IT');
INSERT INTO sailor VALUES ('364617091','PT');

-- POPULATE OWNER
--(id,iso,birthdate)
INSERT INTO owner VALUES ('444244189','PT','1952-05-22');
INSERT INTO owner VALUES ('598414351','ZF','1955-11-19');
INSERT INTO owner VALUES ('185277083','RS','1952-10-07');
INSERT INTO owner VALUES ('597101044','US','1946-06-14');

-- POPULATE BOAT
--(name,year,cni,boat_iso,id_owner,iso_owner)
INSERT INTO boat VALUES ('Cavaleiro do Crime','2009','60RP39','PT','444244189','PT');
INSERT INTO boat VALUES ('Cavaleiro da Sorte','2021','62NG31','PT','598414351','ZF');
INSERT INTO boat VALUES ('Diabo dos Mares','2013','2340SH','PT','444244189','PT');
INSERT INTO boat VALUES ('ALMIGHTY','2012','AH86KR','RS','185277083','RS');
INSERT INTO boat VALUES ('BIDDEN','2017','UD92WE','US','597101044','US');
INSERT INTO boat VALUES ('EPSTEIN','2018','1152BM','IT','597101044','US');
INSERT INTO boat VALUES ('SUGAR','2012','12EQ74','US','597101044','US');
INSERT INTO boat VALUES ('SALT','2007','IH42MS','US','185277083','RS');

-- POPULATE BOAT_VHF
--(mmsi,cni,iso)
INSERT INTO boat_vhf VALUES (908911395,'60RP39','PT');
INSERT INTO boat_vhf VALUES (600152648,'AH86KR','RS');

-- POPULATE SCHEDULE
--(start,end)
INSERT INTO schedule VALUES('2021-12-01','2021-12-05');
INSERT INTO schedule VALUES('2021-12-02','2021-12-25');
INSERT INTO schedule VALUES('2021-12-10','2021-12-15');
INSERT INTO schedule VALUES('2021-12-12','2021-12-25');
INSERT INTO schedule VALUES('2021-12-26','2021-12-28');
INSERT INTO schedule VALUES('2021-12-28','2021-12-31');
INSERT INTO schedule VALUES('2020-12-12','2020-12-14');
INSERT INTO schedule VALUES('2020-11-10','2020-11-11');
INSERT INTO schedule VALUES('2020-10-08','2020-10-09');
INSERT INTO schedule VALUES('2019-09-12','2019-09-14');
INSERT INTO schedule VALUES('2019-08-10','2019-08-11');
INSERT INTO schedule VALUES('2019-07-08','2019-07-09');
INSERT INTO schedule VALUES('2019-06-06','2019-06-07');
INSERT INTO schedule VALUES('2019-06-04','2019-06-05');
INSERT INTO schedule VALUES('2019-06-07','2019-06-09');
INSERT INTO schedule VALUES('2019-05-06','2019-05-08');
INSERT INTO schedule VALUES('2018-11-12','2018-11-14');
INSERT INTO schedule VALUES('2018-10-11','2018-10-13');

-- POPULATE RESERVATION
--(cni,iso_boat,id_sailor;iso_sailor,start,end)
INSERT INTO reservation VALUES('60RP39','PT','444244189','PT','2021-12-01','2021-12-05');
INSERT INTO reservation VALUES('60RP39','PT','444244189','PT','2021-12-12','2021-12-25');
INSERT INTO reservation VALUES('60RP39','PT','444244189','PT','2021-12-28','2021-12-31');
INSERT INTO reservation VALUES('2340SH','PT','598414351','ZF','2021-12-12','2021-12-25');
INSERT INTO reservation VALUES('AH86KR','RS','642510174','UK','2021-12-28','2021-12-31');
INSERT INTO reservation VALUES('AH86KR','RS','642510174','UK','2021-12-12','2021-12-25');
INSERT INTO reservation VALUES('UD92WE','US','274215816','IT','2021-12-26','2021-12-28');
INSERT INTO reservation VALUES('1152BM','IT','364617091','PT','2021-12-28','2021-12-31');
INSERT INTO reservation VALUES('AH86KR','RS','642510174','UK','2020-12-12','2020-12-14');
INSERT INTO reservation VALUES('AH86KR','RS','642510174','UK','2020-11-10','2020-11-11');
INSERT INTO reservation VALUES('AH86KR','RS','642510174','UK','2020-10-08','2020-10-09');
INSERT INTO reservation VALUES('AH86KR','RS','642510174','UK','2019-09-12','2019-09-14');
INSERT INTO reservation VALUES('AH86KR','RS','642510174','UK','2019-08-10','2019-08-11');
INSERT INTO reservation VALUES('AH86KR','RS','642510174','UK','2019-07-08','2019-07-09');
INSERT INTO reservation VALUES('AH86KR','RS','642510174','UK','2019-06-06','2019-06-07');
INSERT INTO reservation VALUES('AH86KR','RS','642510174','UK','2019-06-04','2019-06-05');
INSERT INTO reservation VALUES('AH86KR','RS','642510174','UK','2019-06-07','2019-06-09');
INSERT INTO reservation VALUES('AH86KR','RS','642510174','UK','2019-05-06','2019-05-08');
INSERT INTO reservation VALUES('AH86KR','RS','642510174','UK','2018-11-12','2018-11-14');
INSERT INTO reservation VALUES('AH86KR','RS','642510174','UK','2018-10-11','2018-10-13');

-- POPULATE TRIP
--(date,duration,cni,iso_boat,id_sailor,iso_sailor,start,end,start_latitude,start_longitude,end_latitude,end_longitude)
INSERT INTO trip VALUES('2021-12-12',13,'60RP39','PT','444244189','PT','2021-12-12','2021-12-25',41.136240,9.5271152,37.077774,-8.1220201);
INSERT INTO trip VALUES('2021-12-17',13,'60RP39','PT','444244189','PT','2021-12-12','2021-12-25',37.077774,-8.1220201,41.183455,-8.7031843);
INSERT INTO trip VALUES('2021-12-21',13,'60RP39','PT','444244189','PT','2021-12-12','2021-12-25',41.183455,-8.7031843,42.360183,-71.049666);
INSERT INTO trip VALUES('2021-12-12',13,'2340SH','PT','598414351','ZF','2021-12-12','2021-12-25',-34.177435,22.146771,37.077774,-8.1220201);
INSERT INTO trip VALUES('2021-12-21',13,'2340SH','PT','598414351','ZF','2021-12-12','2021-12-25',37.077774,-8.1220201,42.360183,-71.049666);
INSERT INTO trip VALUES('2021-12-28',3,'AH86KR','RS','642510174','UK','2021-12-28','2021-12-31',37.077774,-8.1220201,41.136240,9.5271152);
INSERT INTO trip VALUES('2021-12-28',3,'60RP39','PT','444244189','PT','2021-12-28','2021-12-31',41.136240,9.5271152,40.651960,-8.678066);
INSERT INTO trip VALUES('2021-12-12',13,'AH86KR','RS','642510174','UK','2021-12-12','2021-12-25',37.077774,-8.1220201,40.651960,-8.678066);
INSERT INTO trip VALUES('2020-12-12',2,'AH86KR','RS','642510174','UK','2020-12-12','2020-12-14',37.077774,-8.1220201,40.651960,-8.678066);
INSERT INTO trip VALUES('2020-12-11',1,'AH86KR','RS','642510174','UK','2020-11-10','2020-11-11',37.077774,-8.1220201,40.651960,-8.678066);
INSERT INTO trip VALUES('2020-12-10',1,'AH86KR','RS','642510174','UK','2020-10-08','2020-10-09',37.077774,-8.1220201,40.651960,-8.678066);
INSERT INTO trip VALUES('2019-12-12',2,'AH86KR','RS','642510174','UK','2019-09-12','2019-09-14',37.077774,-8.1220201,40.651960,-8.678066);
INSERT INTO trip VALUES('2019-12-11',1,'AH86KR','RS','642510174','UK','2019-08-10','2019-08-11',37.077774,-8.1220201,40.651960,-8.678066);
INSERT INTO trip VALUES('2019-12-10',1,'AH86KR','RS','642510174','UK','2019-07-08','2019-07-09',37.077774,-8.1220201,40.651960,-8.678066);
INSERT INTO trip VALUES('2019-12-09',1,'AH86KR','RS','642510174','UK','2019-06-06','2019-06-07',37.077774,-8.1220201,40.651960,-8.678066);
INSERT INTO trip VALUES('2019-12-08',1,'AH86KR','RS','642510174','UK','2019-06-04','2019-06-05',37.077774,-8.1220201,40.651960,-8.678066);
INSERT INTO trip VALUES('2019-12-07',2,'AH86KR','RS','642510174','UK','2019-06-07','2019-06-09',37.077774,-8.1220201,40.651960,-8.678066);
INSERT INTO trip VALUES('2019-12-06',2,'AH86KR','RS','642510174','UK','2019-05-06','2019-05-08',37.077774,-8.1220201,40.651960,-8.678066);
INSERT INTO trip VALUES('2018-12-12',2,'AH86KR','RS','642510174','UK','2018-11-12','2018-11-14',37.077774,-8.1220201,40.651960,-8.678066);
INSERT INTO trip VALUES('2018-12-11',2,'AH86KR','RS','642510174','UK','2018-10-11','2018-10-13',37.077774,-8.1220201,40.651960,-8.678066);