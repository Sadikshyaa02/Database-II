--Create Scripts
CREATE TABLE retreats (
retreat_id     NUMBER (5) NOT NULL,
retreat        VARCHAR2(100),
description    VARCHAR2(200)
);


CREATE TABLE retreat_settings (
retreat_setting_id NUMBER(5),
retreat_id             NUMBER(5),
setting_id             NUMBER(5)
);


CREATE SEQUENCE retreat_id
INCREMENT BY 1
START WITH 1
MINVALUE 0
MAXVALUE 9999999;


CREATE SEQUENCE retreat_setting_id
INCREMENT BY 1
START WITH 1
MINVALUE 0
MAXVALUE 9999999;

-- CREATE SCRIPT

CREATE OR REPLACE TYPE SERVICE_TYPE AS
	OBJECT (
		t24_7 CHAR(1),
		free_wifi CHAR(1),
		airport_transfer CHAR(1),
		ebike_rental CHAR(1),
		excursions CHAR(1)
	);
/

CREATE OR REPLACE TYPE SERVICE_VARRAY_TYPE AS
	VARRAY(
		3
	) OF SERVICE_TYPE;
/

CREATE OR REPLACE TYPE FACILITY_TYPE AS
	OBJECT (
		gym CHAR(1),
		pool CHAR(1),
		spa CHAR(1)
	);
/

CREATE OR REPLACE TYPE FACILITY_VARRAY_TYPE AS
	VARRAY(
		3
	) OF FACILITY_TYPE;
/

-- CREATING NESTED TABLE
CREATE OR REPLACE TYPE ROOM_TYPE AS
	OBJECT (
		id NUMBER(5),
		class VARCHAR2(10),
		capacity NUMBER(5)
	);
/

CREATE OR REPLACE TYPE ROOM_TABLE_TYPE AS
	TABLE OF ROOM_TYPE;
/

CREATE TABLE accomodations (
	accomodation_id NUMBER(5),
	name VARCHAR2(255),
	no_of_rooms NUMBER(8),
	room_details ROOM_TABLE_TYPE,
	accomodation_style_id NUMBER(5),
	accomodation_facilities FACILITY_VARRAY_TYPE,
	customer_service SERVICE_VARRAY_TYPE
) NESTED TABLE ROOM_DETAILS STORE AS NESTED_ROOM_TABLE_TYPE;

CREATE SEQUENCE ACCOMODATIONS_SEQ 
INCREMENT BY   1
 START WITH 1
 NOCACHE
 NOCYCLE;

CREATE OR REPLACE TYPE address_type AS OBJECT(
district       VARCHAR2(100),
country        VARCHAR2(50)
);
/
CREATE TABLE addresses OF address_type;

CREATE TABLE settings(
setting_id      NUMBER(6) NOT NULL,
setting         VARCHAR2(100),
address         address_type
);

CREATE SEQUENCE setting_id
INCREMENT BY 1
START WITH 1
MINVALUE 0
MAXVALUE 9999999;

CREATE TABLE retreat_accomodations(
accomodation_id             NUMBER(10) NOT NULL,
retreat_setting_id NUMBER(5)			
);

CREATE OR REPLACE TYPE review_type AS OBJECT(
reviews VARCHAR2(1000)
);
/

CREATE TYPE review_table_type AS TABLE OF review_type;
/

CREATE TABLE reviews(
id NUMBER(5),
retreat_setting_id NUMBER(10),
reviewer NUMBER(5),
stars NUMBER(10),
rating NUMBER(2,1),
review review_table_type)
NESTED TABLE review STORE AS nested_review_table_type
;

CREATE SEQUENCE review_seq
 INCREMENT BY   1
 START WITH     1
 NOCACHE
 NOCYCLE;

 CREATE SEQUENCE accomodation_style_seq
 INCREMENT BY   1
 START WITH 1
 NOCACHE
 NOCYCLE;

CREATE TABLE accomodation_styles(
accomodation_styles_id NUMBER(5),
style VARCHAR2(100)
);