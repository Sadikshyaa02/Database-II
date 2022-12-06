

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


ALTER TABLE accomodation_styles
ADD CONSTRAINT pk_accomodation_style PRIMARY KEY (accomodation_styles_id);

ALTER TABLE reviews
ADD CONSTRAINT pk_review PRIMARY KEY (id);

ALTER TABLE settings 
ADD CONSTRAINTS pk_settings
PRIMARY KEY (setting_id);

ALTER TABLE retreats
ADD CONSTRAINT pk_retreats
PRIMARY KEY (retreat_id);

ALTER TABLE retreat_settings
ADD CONSTRAINT pk_retreat_setting PRIMARY KEY (retreat_setting_id);

ALTER TABLE ACCOMODATIONS ADD CONSTRAINT PK_ACCOMODATIONS PRIMARY KEY (accomodation_id);

ALTER TABLE retreat_settings
ADD CONSTRAINT fk_r_retreats
FOREIGN KEY (retreat_id)
REFERENCES retreats(retreat_id);

ALTER TABLE retreat_settings
ADD CONSTRAINT fk_r_retreat_settings
FOREIGN KEY (setting_id)
REFERENCES settings(setting_id);


-- ALTER SCRIPTS


ALTER TABLE ACCOMODATIONS ADD CONSTRAINT FK_A_ACCOMODATION_STYLES FOREIGN KEY (ACCOMODATION_style_ID) REFERENCES ACCOMODATION_STYLES(accomodation_styles_id);

ALTER TABLE retreat_accomodations
ADD CONSTRAINT pk_retreat_accomodations
PRIMARY KEY (retreat_setting_id, accomodation_id);

ALTER TABLE retreat_accomodations
ADD CONSTRAINT fk_retreat_acco_settings 
FOREIGN KEY (retreat_setting_id) REFERENCES retreat_settings(retreat_setting_id);

ALTER TABLE retreat_accomodations
ADD CONSTRAINT fk_retreat_acco_accomo
FOREIGN KEY (accomodation_id ) REFERENCES accomodations(accomodation_id);

ALTER TABLE reviews
ADD CONSTRAINT fk_r_retreat_settings_c
FOREIGN KEY (retreat_setting_id) REFERENCES retreat_settings(retreat_setting_id);



--Inserting records into the table settings
INSERT INTO settings(setting_id,setting,address)
VALUES(setting_id.nextval,'WOODLAND', address_type('CHITWAN','NEPAL')
);

INSERT INTO settings(setting_id,setting,address)
VALUES(setting_id.nextval,'Coastal',address_type('POKHARA','NEPAL')
);

INSERT INTO settings(setting_id,setting,address)
VALUES(setting_id.nextval,'Lakeside',address_type('RARA','NEPAL')
);

INSERT INTO settings(setting_id,setting,address)
VALUES(setting_id.nextval,'Winter wonderland',address_type('MUSTANG','NEPAL')
);

INSERT INTO settings(setting_id,setting,address)
VALUES(setting_id.nextval,'Mountains',address_type('ANNAPURNA','NEPAL')
);

--Inserting records into the table accomodation_styles
INSERT INTO accomodation_styles VALUES (accomodation_style_seq.nextval, 'CHALETS');
INSERT INTO accomodation_styles VALUES (accomodation_style_seq.nextval, 'COTTAGES');
INSERT INTO accomodation_styles VALUES (accomodation_style_seq.nextval, 'TREE HOUSES');
INSERT INTO accomodation_styles VALUES (accomodation_style_seq.nextval, 'CABIN');
INSERT INTO accomodation_styles VALUES (accomodation_style_seq.nextval, 'BOUTIQUE HOTELS');

--Inserting records into the table settings
INSERT INTO ACCOMODATIONS VALUES (
	ACCOMODATIONS_SEQ.NEXTVAL,
	'FEEL LIKE HOME NEPAL',
	213,
	ROOM_TABLE_TYPE ( ROOM_TYPE(1, 'SINGLE', 2), ROOM_TYPE(2, 'DOUBLE', 4), ROOM_TYPE(3, 'STUDIO', 2), ROOM_TYPE(1, 'DELUXE', 4), ROOM_TYPE(1, 'SUITES', 10) ),
	1,
	FACILITY_VARRAY_TYPE ( FACILITY_TYPE('Y', 'Y', 'Y')
),
SERVICE_VARRAY_TYPE (
SERVICE_TYPE('Y', 'Y', 'Y', 'Y', 'Y')
)
);

INSERT INTO ACCOMODATIONS VALUES (
	ACCOMODATIONS_SEQ.NEXTVAL,
	'KATHMANDU MARRIOTT HOTEL',
	100,
	ROOM_TABLE_TYPE ( ROOM_TYPE(1, 'SINGLE', 2), ROOM_TYPE(2, 'DOUBLE', 4), ROOM_TYPE(3, 'STUDIO', 2), ROOM_TYPE(1, 'DELUXE', 4), ROOM_TYPE(1, 'SUITES', 10) ),
	2,
	FACILITY_VARRAY_TYPE ( FACILITY_TYPE('Y', 'Y', 'N')
),
SERVICE_VARRAY_TYPE(
SERVICE_TYPE('Y', 'Y', 'Y', 'Y', 'Y')
)
);

INSERT INTO ACCOMODATIONS VALUES (
	ACCOMODATIONS_SEQ.NEXTVAL,
	'KANTIPUR TEMPLE HOUSE',
	200,
	ROOM_TABLE_TYPE ( ROOM_TYPE(1, 'SINGLE', 2), ROOM_TYPE(2, 'DOUBLE', 4), ROOM_TYPE(3, 'STUDIO', 2), ROOM_TYPE(1, 'DELUXE', 4), ROOM_TYPE(1, 'SUITES', 10) ),
	3,
	FACILITY_VARRAY_TYPE ( FACILITY_TYPE('Y', 'N', 'Y')
),
SERVICE_VARRAY_TYPE(
SERVICE_TYPE('Y', 'Y', 'Y', 'Y', 'N')
)
);

INSERT INTO ACCOMODATIONS VALUES (
	ACCOMODATIONS_SEQ.NEXTVAL,
	'THE SOALTEE KATHMANDU',
	175,
	ROOM_TABLE_TYPE ( ROOM_TYPE(1, 'SINGLE', 2), ROOM_TYPE(2, 'DOUBLE', 4), ROOM_TYPE(3, 'STUDIO', 2), ROOM_TYPE(1, 'DELUXE', 4), ROOM_TYPE(1, 'SUITES', 10) ),
	4,
	FACILITY_VARRAY_TYPE ( FACILITY_TYPE('N', 'Y', 'Y')
),
SERVICE_VARRAY_TYPE(
SERVICE_TYPE('Y', 'Y', 'Y', 'N', 'Y')
)
);

INSERT INTO ACCOMODATIONS VALUES (
	ACCOMODATIONS_SEQ.NEXTVAL,
	'HYATT REGENCY KATHMANDU',
	178,
	ROOM_TABLE_TYPE ( ROOM_TYPE(1, 'SINGLE', 2), ROOM_TYPE(2, 'DOUBLE', 4), ROOM_TYPE(3, 'STUDIO', 2), ROOM_TYPE(1, 'DELUXE', 4), ROOM_TYPE(1, 'SUITES', 10) ),
	5,
	FACILITY_VARRAY_TYPE ( FACILITY_TYPE('Y', 'N', 'N')
),
SERVICE_VARRAY_TYPE(
SERVICE_TYPE('Y', 'Y', 'N', 'Y', 'Y')
)
);

INSERT INTO ACCOMODATIONS VALUES (
	ACCOMODATIONS_SEQ.NEXTVAL,
	'HOTEL SHANKAR',
	141,
	ROOM_TABLE_TYPE ( ROOM_TYPE(1, 'SINGLE', 2), ROOM_TYPE(2, 'DOUBLE', 4), ROOM_TYPE(3, 'STUDIO', 2), ROOM_TYPE(1, 'DELUXE', 4), ROOM_TYPE(1, 'SUITES', 10) ),
	5,
	FACILITY_VARRAY_TYPE ( FACILITY_TYPE('N', 'N', 'Y')
),
SERVICE_VARRAY_TYPE(
SERVICE_TYPE('N', 'Y', 'Y', 'Y', 'N')
)
);

INSERT INTO ACCOMODATIONS VALUES (
	ACCOMODATIONS_SEQ.NEXTVAL,
	'THAMEL BOUTIQUE HOTEL',
	197,
	ROOM_TABLE_TYPE ( ROOM_TYPE(1, 'SINGLE', 2), ROOM_TYPE(2, 'DOUBLE', 4), ROOM_TYPE(3, 'STUDIO', 2), ROOM_TYPE(1, 'DELUXE', 4), ROOM_TYPE(1, 'SUITES', 10) ),
	1,
	FACILITY_VARRAY_TYPE ( FACILITY_TYPE('Y', 'N', 'Y')
),
SERVICE_VARRAY_TYPE(
SERVICE_TYPE('Y', 'N', 'Y', 'Y', 'Y')
)
);

INSERT INTO ACCOMODATIONS VALUES (
	ACCOMODATIONS_SEQ.NEXTVAL,
	'BABAR MAHAL VILAS - THE BOUTIQUE HOTEL',
	90,
	ROOM_TABLE_TYPE ( ROOM_TYPE(1, 'SINGLE', 2), ROOM_TYPE(2, 'DOUBLE', 4), ROOM_TYPE(3, 'STUDIO', 2), ROOM_TYPE(1, 'DELUXE', 4), ROOM_TYPE(1, 'SUITES', 10) ),
	2,
	FACILITY_VARRAY_TYPE ( FACILITY_TYPE('N', 'Y', 'Y')
),
SERVICE_VARRAY_TYPE(
SERVICE_TYPE('Y', 'Y', 'Y', 'Y', 'Y')
)
);

INSERT INTO ACCOMODATIONS VALUES (
	ACCOMODATIONS_SEQ.NEXTVAL,
	'HOTEL JAMPA',
	80,
	ROOM_TABLE_TYPE ( ROOM_TYPE(1, 'SINGLE', 2), ROOM_TYPE(2, 'DOUBLE', 4), ROOM_TYPE(3, 'STUDIO', 2), ROOM_TYPE(1, 'DELUXE', 4), ROOM_TYPE(1, 'SUITES', 10) ),
	3,
	FACILITY_VARRAY_TYPE ( FACILITY_TYPE('Y', 'Y', 'N')
),
SERVICE_VARRAY_TYPE(
SERVICE_TYPE('N', 'Y', 'Y', 'Y', 'N')
)
);

INSERT INTO ACCOMODATIONS VALUES (
	ACCOMODATIONS_SEQ.NEXTVAL,
	'HOTEL SHAMBALA',
	99,
	ROOM_TABLE_TYPE ( ROOM_TYPE(1, 'SINGLE', 2), ROOM_TYPE(2, 'DOUBLE', 4), ROOM_TYPE(3, 'STUDIO', 2), ROOM_TYPE(1, 'DELUXE', 4), ROOM_TYPE(1, 'SUITES', 10) ),
	4,
	FACILITY_VARRAY_TYPE ( FACILITY_TYPE('Y', 'N', 'N')
),
SERVICE_VARRAY_TYPE(
SERVICE_TYPE('Y', 'N', 'Y', 'N', 'Y')
)
);


--Inserting records into the table retreats
INSERT INTO retreats (retreat_id,retreat, description)
VALUES (retreat_id.nextval,'SAMAYA RETREAT', 'RETREAT CENTER WHERE YOU CAN ENHANCE YOUR CHANGED LIVELIHOOD');
INSERT INTO retreats (retreat_id,retreat, description)
VALUES (retreat_id.nextval,'MIDNIGHTS RETREAT', 'LETS START A MUSICAL ERA AND GO FAR AWAY FROM CHAOS LIFESTYLE');
INSERT INTO retreats (retreat_id,retreat, description)
VALUES (retreat_id.nextval,'RETREAT AT NORLING', 'RETREAT CENTER IN NEPAL WITH UNIQUE EXPERIENCE');
INSERT INTO retreats (retreat_id,retreat, description)
VALUES (retreat_id.nextval,'NEPAL YOGA RETREAT', 'A CENTER WHERE YOU WILL FIND SANATAN YOGA, MANTRA CHANTING, YOGA PHILOSOPHY EXPLAINED AND GUIDED MEDITATION');
INSERT INTO retreats (retreat_id,retreat, description)
VALUES (retreat_id.nextval,'NEPAL WELLNESS RETREAT', ' THIS IS THE ONE PLACE IN THE WORLD WHERE YOU DO NOT NEED TO SET STANDARDS AND CRITERIA, JUST BE FREE, BE TRUE AND BE YOURSELF.');


--Inserting records into the table retreat_settings
INSERT INTO retreat_settings (retreat_setting_id, retreat_id, setting_id)
VALUES (retreat_setting_id.nextval,3,5 );

INSERT INTO retreat_settings (retreat_setting_id, retreat_id, setting_id)
VALUES ( retreat_setting_id.nextval,1,4 );


INSERT INTO retreat_settings (retreat_setting_id, retreat_id, setting_id)
VALUES ( retreat_setting_id.nextval,2,1 );

INSERT INTO retreat_settings (retreat_setting_id, retreat_id, setting_id)
VALUES (retreat_setting_id.nextval ,5,2 );

INSERT INTO retreat_settings (retreat_setting_id, retreat_id, setting_id)
VALUES ( retreat_setting_id.nextval,4,3 );

--Inserting records into the table reviews
INSERT INTO reviews (id, retreat_setting_id, rating, stars, reviewer, review) VALUES (review_seq.nextval, 2, 4, 50, 6,
review_table_type(
review_type('ENJOY STAY')
) 
);
INSERT INTO reviews (id, retreat_setting_id, rating, stars, reviewer, review) VALUES (review_seq.nextval, 5, 4.2, 66, 15,
review_table_type(
review_type('GOOD SERVICE')
)
);
INSERT INTO reviews (id, retreat_setting_id, rating, stars, reviewer, review) VALUES (review_seq.nextval, 1, 3.9, 48, 13,
review_table_type(
review_type('DECENT')
)
);
INSERT INTO reviews (id, retreat_setting_id, rating, stars, reviewer, review) VALUES (review_seq.nextval, 3, 3.5, 40, 15,
review_table_type(
review_type('BETTER SERVICE NEEDED')
)
);
INSERT INTO reviews (id, retreat_setting_id, rating, stars, reviewer, review) VALUES (review_seq.nextval, 4, 4.5, 100, 23,
review_table_type(
review_type('WORTH EVERY PENNY')
)
);

--Inserting records into the table retreat_accomodations
INSERT INTO retreat_accomodations VALUES (2,3);
INSERT INTO retreat_accomodations VALUES (4,1);
INSERT INTO retreat_accomodations VALUES (3,4);
INSERT INTO retreat_accomodations VALUES (6,5);
INSERT INTO retreat_accomodations VALUES (5,2);

--Inserting records into the object table addresses
INSERT INTO addresses VALUES ('LONDON', 'ENGLAND');
INSERT INTO addresses VALUES ('MADRID', 'SPAIN');
INSERT INTO addresses VALUES ('ROME', 'ITALY');
INSERT INTO addresses VALUES ('BERLIN', 'GERMANY');
INSERT INTO addresses VALUES ('PARIS', 'FRANCE');



--Creating a procedure to list all the style from table accomodation_styles
CREATE OR REPLACE PROCEDURE proc_show_accomodation_style
IS a_style accomodation_styles.style%TYPE;

BEGIN
FOR loopIt IN (SELECT style INTO a_style FROM accomodation_styles)

LOOP

a_style := loopIt.style;
DBMS_OUTPUT.PUT_LINE(a_style);

END LOOP;

END proc_show_accomodation_style;
/

SHOW ERRORS;

EXECUTE proc_show_accomodation_style;


--Creating a procdure to insert a record into the table accomodation_styles
CREATE OR REPLACE PROCEDURE proc_insert_style
IS vc_style accomodation_styles.style%TYPE := 'GREENLAND';

BEGIN

INSERT INTO accomodation_styles
VALUES (accomodation_style_seq.nextval, vc_style);

END proc_insert_style;
/

SHOW ERRORS;

EXECUTE proc_insert_style;



--Creating a procedure to display retreat and settings from review table
CREATE OR REPLACE PROCEDURE proc_show_retreat_setting (in_retreat_setting_id
IN reviews.retreat_setting_id%TYPE) IS
vn_id NUMBER(6) := 0;
vn_retreat_id NUMBER(6) := 0;
vn_setting_id NUMBER(6) := 0;
vc_retreat VARCHAR2(100):= '';
vc_setting VARCHAR2(100) := '';

BEGIN

SELECT retreat_setting_id INTO vn_id FROM reviews WHERE id = in_retreat_setting_id;

SELECT retreat_id INTO vn_retreat_id FROM retreat_settings WHERE retreat_setting_id = vn_id;

SELECT setting_id INTO vn_setting_id FROM retreat_settings WHERE retreat_setting_id = vn_id;

SELECT retreat INTO vc_retreat FROM retreats WHERE retreat_id = vn_retreat_id;

SELECT setting INTO vc_setting FROM settings WHERE setting_id = vn_setting_id;

DBMS_OUTPUT.PUT_LINE('Retreat : ' || vc_retreat);
DBMS_OUTPUT.PUT_LINE('Setting : ' || vc_setting);

END proc_show_retreat_setting;
/

SHOW ERRORS;

EXECUTE proc_show_retreat_setting(5);




--Creating a function to get the id with the highest review
CREATE OR REPLACE FUNCTION func_display_review 
RETURN NUMBER IS 
vn_review_id NUMBER(5);

BEGIN 

SELECT id INTO vn_review_id FROM reviews WHERE rating = (SELECT MAX(rating) FROM reviews);

RETURN vn_review_id;

END func_display_review;
/

SHOW ERRORS;


--Creating a procedure to run above function and display review
CREATE OR REPLACE PROCEDURE run_func_display_review IS
vn_review_id NUMBER(5);
vc_review VARCHAR2(100);

BEGIN

vn_review_id := func_display_review();

SELECT r.reviews INTO vc_review FROM reviews re, TABLE(re.review) r WHERE id=vn_review_id;

DBMS_OUTPUT.PUT_LINE(vc_review);


END run_func_display_review;
/

SHOW ERRORS;

EXECUTE run_func_display_review;



--Creating a function to delete a record from table reviews
CREATE OR REPLACE FUNCTION func_delete_review (vc_review_id IN NUMBER)
RETURN NUMBER IS

BEGIN

DELETE FROM reviews WHERE id = vc_review_id;

RETURN 1;

end func_DELETE_review;
/

SHOW ERRORS;


--Creating a procedure to run function above
CREATE OR REPLACE PROCEDURE run_func_delete_review IS
num NUMBER(1);

BEGIN 

NUM := func_delete_review(5);

END run_func_delete_review;
/

SHOW ERRORS;

EXECUTE run_func_delete_review;


--Creating a function to update the style in accomodation_styles table
CREATE OR REPLACE FUNCTION func_update_accomodation_style (vc_accomodation_styles_id IN NUMBER, vc_style IN VARCHAR2)
RETURN NUMBER IS

BEGIN

UPDATE accomodation_styles SET style = vc_style WHERE accomodation_styles_id = vc_accomodation_styles_id;

RETURN 1;

end func_update_accomodation_style;
/

SHOW ERRORS;


--Creating a function to run the function above
CREATE OR REPLACE PROCEDURE run_func_update_accomodation_style IS
num NUMBER(1);

BEGIN 

NUM := func_update_accomodation_style(5, 'Highland');

END run_func_update_accomodation_style;
/

SHOW ERRORS;

EXECUTE run_func_update_accomodation_style;


--Creating a trigger which will be triggered when stars in reviews table will change
CREATE OR REPLACE TRIGGER trig_calculate_rating
AFTER INSERT OR UPDATE OF stars ON reviews
FOR EACH ROW

WHEN(NEW.STARS != OLD.STARS)

DECLARE
vn_rating NUMBER(5,1);

BEGIN
vn_rating := :NEW.stars / :OLD.reviewer;

DBMS_OUTPUT.PUT_LINE('New rating will be : ' || vn_rating);

END trig_calculate_rating;
/

SHOW ERRORS;


--Creating a trigger to notify what action is taking place
CREATE OR REPLACE TRIGGER trig_notify_action
BEFORE INSERT OR DELETE OR UPDATE OF style ON accomodation_styles
FOR EACH ROW

BEGIN

IF(INSERTING) THEN
DBMS_OUTPUT.PUT_LINE('Inserting data ...');

END IF;

IF(UPDATING) THEN
DBMS_OUTPUT.PUT_LINE('Updating data ...');

END IF;

IF(DELETING) THEN
DBMS_OUTPUT.PUT_LINE('Deleting data ...');

END IF;

END trig_notify_action;
/

SHOW ERRORS;



--Creating a procedure to run a implicit cursor within
CREATE OR REPLACE PROCEDURE proc_add_stars IS
vn_stars NUMBER(5);

BEGIN

UPDATE reviews SET stars = stars + 10;

IF sql%NOTFOUND THEN
DBMS_OUTPUT.PUT_LINE('Stars added to none');

END IF;

IF sql%FOUND THEN
vn_stars := sql%ROWCOUNT;
DBMS_OUTPUT.PUT_LINE('Stars added to ' || vn_stars || ' records.');

END IF;

END proc_add_stars;
/

SHOW ERRORS;

EXECUTE proc_add_stars;


--Creating a procedure and cursor to display all the retreat setting with rating above 4
CREATE OR REPLACE PROCEDURE proc_show_high_rated(vn_rating IN reviews.rating%TYPE) IS
vc_retreat VARCHAR2(100);
vc_setting VARCHAR2(100);

CURSOR cur_reviews IS
SELECT id, retreat_setting_id, reviewer, stars, rating, review 
FROM reviews;

BEGIN

FOR rec_cur_reviews IN cur_reviews LOOP

IF rec_cur_reviews.rating >= vn_rating THEN

SELECT retreat INTO vc_retreat FROM retreats WHERE retreat_id = 
(SELECT retreat_id FROM retreat_settings WHERE retreat_setting_id = rec_cur_reviews.retreat_setting_id);

SELECT setting INTO vc_setting FROM settings WHERE setting_id = 
(SELECT setting_id FROM retreat_settings WHERE retreat_setting_id = rec_cur_reviews.retreat_setting_id);

DBMS_OUTPUT.PUT_LINE('Rated 4+ stars : ' || vc_retreat || ' and ' || vc_setting);

END IF;

END LOOP;

EXCEPTION

WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('Somethig went wrong...');

END proc_show_high_rated;
/

SHOW ERRORS;


EXECUTE proc_show_high_rated(4);


-- TO GET THE LIST ORDERED LIST OF ACCOMMODATIONS WHICH HAS BEST ACCOMMODATION FACILITIES
-- 4 FUNCTION
-- 1 PROCEDURE
-- 1 VIEW

-- CREATING A FUNCTION
CREATE OR REPLACE FUNCTION FUNC_BEST_ACCOM(IN_FACILITY FACILITY_TYPE) RETURN NUMBER IS
VN_TOTAL NUMBER;
VN_GYM NUMBER := 0;
VN_SPA NUMBER := 0;
VN_POOL NUMBER := 0;
BEGIN
    IF (IN_FACILITY.GYM = 'Y') THEN
        VN_GYM := 1;
    END IF;
    IF (IN_FACILITY.POOL = 'Y') THEN
        VN_POOL := 1;
    END IF;
    IF (IN_FACILITY.SPA = 'Y') THEN
        VN_SPA := 1;
    END IF;

    RETURN VN_TOTAL;
END;
/

-- CREATING A FUNCTION
CREATE OR REPLACE FUNCTION FUNC_C_N(IN_VALUE CHAR) RETURN NUMBER IS
    VN_NUMBER NUMBER := 0;
BEGIN
    IF (IN_VALUE = 'Y') THEN
        VN_NUMBER := 1;
end if;

    RETURN VN_NUMBER;

end;
/

-- CREATING A FUNCTION

CREATE OR REPLACE FUNCTION FUNC_SUM_THREE(IN_A NUMBER, IN_B NUMBER, IN_C NUMBER) RETURN NUMBER IS
    BEGIN
        RETURN IN_A + IN_B + IN_C;
    end;
/

-- CREATING A FUNCTION
CREATE OR REPLACE FUNCTION FUNC_SUM_FIVE(IN_A NUMBER, IN_B NUMBER, IN_C NUMBER, IN_D NUMBER, IN_E NUMBER) RETURN NUMBER IS
    BEGIN
        RETURN IN_A + IN_B + IN_C + IN_D + IN_E;
    end;
/

-- CREATING A VIEW
CREATE OR REPLACE VIEW VIEW_ACCOM_BY_FACILITY AS SELECT  FUNC_SUM_THREE(FUNC_C_N(F.GYM), FUNC_C_N(F.POOL), FUNC_C_N(F.SPA)) AS SUM, A.NAME
FROM ACCOMODATIONS A,
TABLE (A.ACCOMODATION_FACILITIES) F ORDER BY SUM DESC;


-- CREATING A PROCEDURE
DROP PROCEDURE PROC_PRINT_ACCOM_BY_FACILITY;
CREATE OR REPLACE PROCEDURE PROC_PRINT_ACCOM_BY_FACILITY IS
VV_NAME ACCOMODATIONS.NAME%TYPE;
BEGIN
    FOR C IN (select name from VIEW_ACCOM_BY_FACILITY)
        LOOP
            VV_NAME := C.NAME;
            DBMS_OUTPUT.PUT_LINE(VV_NAME);
    end loop;
end PROC_PRINT_ACCOM_BY_FACILITY;
/

-- CALL A PROCEDURE
CALL PROC_PRINT_ACCOM_BY_FACILITY();


-- TO GET THE LIST OF THE BEST ACCOMODATION BY CUSTOMER SERVICE
-- 1 VIEW
-- 1 PROC
-- CREATING A VIEW
CREATE OR REPLACE VIEW VIEW_ACCOM_BY_CUSTOMER_SERVICE AS SELECT  FUNC_SUM_FIVE(FUNC_C_N(F.T24_7), FUNC_C_N(F.FREE_WIFI), FUNC_C_N(F.AIRPORT_TRANSFER), FUNC_C_N(F.EBIKE_RENTAL), FUNC_C_N(F.EXCURSIONS)) AS SUM, A.NAME
FROM ACCOMODATIONS A,
TABLE (A.CUSTOMER_SERVICE) F ORDER BY SUM DESC;

-- CREATING A PROCEDURE
CREATE OR REPLACE PROCEDURE PROC_PRINT_ACCOM_BY_SERVICE IS
VV_NAME ACCOMODATIONS.NAME%TYPE;
BEGIN
    FOR C IN (select name from VIEW_ACCOM_BY_CUSTOMER_SERVICE)
        LOOP
            VV_NAME := C.NAME;
            DBMS_OUTPUT.PUT_LINE(VV_NAME);
    end loop;
end PROC_PRINT_ACCOM_BY_SERVICE;
/

CALL PROC_PRINT_ACCOM_BY_SERVICE();


-- TO GET THE BEST ACCOMMODATION BY ALL FEATURE
-- 1 FUNC
-- 1 VIEW
-- 1 PROC
-- CREATING A FUNCTION
CREATE OR REPLACE FUNCTION FUNC_SUM_TWO(IN_A NUMBER, IN_B NUMBER) RETURN NUMBER IS
    BEGIN
        RETURN IN_A + IN_B;
    end;
/

--ERROR
--ERROR
--ERROR
--ERROR
--ERROR
--ERROR
-- CREATING A VIEW
CREATE VIEW VIEW_BEST_ACCOM AS
    SELECT FUNC_SUM_TWO(FUNC_SUM_FIVE(FUNC_C_N(S.T24_7), FUNC_C_N(S.FREE_WIFI), FUNC_C_N(S.AIRPORT_TRANSFER), FUNC_C_N(S.EBIKE_RENTAL), FUNC_C_N(S.EXCURSIONS)), FUNC_SUM_THREE(FUNC_C_N(F.GYM), FUNC_C_N(F.POOL), FUNC_C_N(F.SPA))) AS SUM ,
           A.NAME, A.ACCOMODATION_STYLE_ID
    FROM ACCOMODATIONS A , TABLE ( A.CUSTOMER_SERVICE ) S, TABLE ( A.ACCOMODATION_FACILITIES ) F

    ORDER BY SUM DESC;


--ERROR
--ERROR
--ERROR
--ERROR
--ERROR
--ERROR
-- CREATING A PROCEDURE
CREATE OR REPLACE PROCEDURE PROC_PRINT_BEST_ACCOM IS
VV_NAME ACCOMODATIONS.NAME%TYPE;
BEGIN
    FOR C IN (select name from VIEW_BEST_ACCOM)
        LOOP
            VV_NAME := C.NAME;
            DBMS_OUTPUT.PUT_LINE(VV_NAME);
    end loop;
end PROC_PRINT_BEST_ACCOM;
/

-- CALLING A PROCEDURE
CALL PROC_PRINT_BEST_ACCOM();


-- TO GET BEST ACCOMMODATION BY ACCOMMODATION STYLE
-- 1 VIEW
-- 1 PROC


--ERROR
--ERROR
--ERROR
--ERROR
--ERROR
--ERROR
-- CREATING A VIEW
CREATE OR REPLACE VIEW VIEW_BEST_ACCOM_BY_STYLE AS
    SELECT V.NAME, A.STYLE
    FROM VIEW_BEST_ACCOM V
    INNER JOIN ACCOMODATION_STYLES A on V.ACCOMODATION_STYLE_ID = A.ACCOMODATION_STYLES_ID;

-- SELECT * FROM VIEW_BEST_ACCOM_BY_STYLE WHERE STYLE LIKE 'T%';


--ERROR
--ERROR
--ERROR
--ERROR
--ERROR
--ERROR
-- CREATING A PROCEDURE
CREATE OR REPLACE PROCEDURE PROC_PRINT_BEST_ACCOM_BY_STYLE(IN_STYLE VARCHAR2) IS
VV_NAME ACCOMODATIONS.NAME%TYPE;
VV_STYLE VARCHAR2(30) := CONCAT(IN_STYLE, '%');
BEGIN
    FOR C IN (SELECT NAME, STYLE FROM VIEW_BEST_ACCOM_BY_STYLE WHERE STYLE LIKE VV_STYLE)
        LOOP
            VV_NAME := C.NAME;
            DBMS_OUTPUT.PUT_LINE(VV_NAME || ' ' ||C.STYLE);
    end loop;
end PROC_PRINT_BEST_ACCOM_BY_STYLE;
/

CALL PROC_PRINT_BEST_ACCOM_BY_STYLE('T');



-- 2 TRIGGERS 2 CURSORS
-- TRIGGER TO DISPLAY THE NAME OF THE ACCOMMODATION BEFORE DELETING.
CREATE OR REPLACE TRIGGER trig_delete_accommodations
	BEFORE DELETE ON ACCOMODATIONS
	FOR EACH ROW
BEGIN
	DBMS_OUTPUT.PUT_LINE('You are deleting... ' ||:OLD.NAME);
EXCEPTION
WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No name found accommodation.');
when others THEN
    DBMS_OUTPUT.PUT_LINE('ERROR!');


END trig_delete_accommodations;
/



-- TO DISPLAY THE ACCOMMODATION STYLE BEFORE INSERTING THE ACCOMMODATION DATA
-- CREATE A TRIGGER
CREATE OR REPLACE TRIGGER trig_insert_accommodations
	BEFORE INSERT OR UPDATE ON ACCOMODATIONS
	FOR EACH ROW
DECLARE
    VC_STYLE VARCHAR2(30);
BEGIN
    SELECT STYLE INTO VC_STYLE FROM ACCOMODATION_STYLES WHERE ACCOMODATION_STYLES.ACCOMODATION_STYLES_ID = :NEW.ACCOMODATION_STYLE_ID;
	DBMS_OUTPUT.PUT_LINE('You are inserting accommodation for... ' || VC_STYLE);
EXCEPTION
WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No name found accommodation.');
WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('ERROR!');


END trig_insert_accommodations;
/

INSERT INTO ACCOMODATIONS(ACCOMODATION_ID, NAME, ACCOMODATION_STYLE_ID) VALUES (ACCOMODATIONS_SEQ.nextval,'THE ROHAN HOTEL', 1);



-- TO DELETE THE ACCOMMODATION BY GIVEN NAME
-- CREATE A PROCEDURE WITH CURSOR
CREATE OR REPLACE PROCEDURE proc_delete_accom (in_name ACCOMODATIONS.NAME%type) IS

vc_name ACCOMODATIONS.NAME%type;
vb_found BOOLEAN := FALSE;
CURSOR cur_accomodations is  select NAME from ACCOMODATIONS;
BEGIN
    for rec_cur_sites in cur_accomodations LOOP
        if rec_cur_sites.NAME = in_name THEN
            DELETE from ACCOMODATIONS where NAME = in_name;
            DBMS_OUTPUT.put_line(in_name || ' is deleted.');
            vb_found := TRUE;
        end IF;
    end LOOP;
    if vb_found = FALSE THEN
        DBMS_OUTPUT.put_line('No such location found.');
    end if;
EXCEPTION
    when others THEN
    dbms_output.put_line(SQLERRM);
end proc_delete_accom;
/

-- TO FIND THE ACCOMMODATIONS WHICH HAS MORE ROOMS THAN GIVEN PARAMETER
-- CREATE A PROCEDURE WITH A CURSOR
CREATE OR REPLACE PROCEDURE PROC_FIND_ACCOM (IN_NO_OF_ROOMS ACCOMODATIONS.NO_OF_ROOMS%type) IS
CURSOR CUR_ACCOMMODATIONS IS  SELECT NAME,NO_OF_ROOMS   FROM ACCOMODATIONS WHERE ACCOMODATIONS.NO_OF_ROOMS >= IN_NO_OF_ROOMS;
REC_CUR_ACCOMMODATIONS CUR_ACCOMMODATIONS%ROWTYPE;
BEGIN
OPEN CUR_ACCOMMODATIONS;
IF (CUR_ACCOMMODATIONS%ROWCOUNT != 0) THEN
DBMS_OUTPUT.PUT_LINE('There are '|| CUR_ACCOMMODATIONS%ROWCOUNT ||' ACCOMMODATIONS FOUND.');
END IF;
FETCH   CUR_ACCOMMODATIONS   INTO    REC_CUR_ACCOMMODATIONS;
IF CUR_ACCOMMODATIONS%NOTFOUND = TRUE THEN
DBMS_OUTPUT.PUT_LINE('No such ACCOMMODATIONS found');
end if;
WHILE CUR_ACCOMMODATIONS%FOUND  LOOP
		DBMS_OUTPUT.PUT_LINE('Accommodations name :' || REC_CUR_ACCOMMODATIONS.NAME);
		DBMS_OUTPUT.PUT_LINE('No of rooms :' || REC_CUR_ACCOMMODATIONS.NO_OF_ROOMS);
	FETCH   CUR_ACCOMMODATIONS   INTO    REC_CUR_ACCOMMODATIONS;
END LOOP;
CLOSE CUR_ACCOMMODATIONS;
end PROC_FIND_ACCOM;
/

-- CALLING A PROCEDURE
CALL PROC_FIND_ACCOM(110);

--functions--

--function for counting the retreats--
CREATE OR REPLACE FUNCTION func_count_retreat RETURN NUMBER IS
vn_count NUMBER(5);
BEGIN 
	SELECT COUNT(retreat_id)
	INTO vn_count
	FROM retreats;
RETURN vn_count;
END func_count_retreat;
/
SHOW ERRORS;


--function for counting the retreats--
CREATE OR REPLACE FUNCTION func_count_retreat_setting RETURN NUMBER IS
vn_count NUMBER(5);
BEGIN 
	SELECT COUNT(retreat_setting_id)
	INTO vn_count
	FROM retreat_settings;
RETURN vn_count;
END func_count_retreat_setting;
/
SHOW ERRORS;


--procedure--


--procedure for adding retreat

CREATE OR REPLACE PROCEDURE proc_add_retreat 
IS r_id retreats.retreat_id%TYPE;
BEGIN
SELECT retreat_id
INTO r_id
FROM retreats;
EXCEPTION
WHEN too_many_rows THEN 
dbms_output.put_line('problem while fettching more than one');
END proc_add_retreat;
/
SHOW ERRORS;
EXECUTE proc_add_retreat ;

--procedure for counting retreats
CREATE OR REPLACE PROCEDURE proc_count_retreat AS
	vn_count NUMBER(5):= func_count_retreat;
BEGIN
	IF vn_count>0 THEN
		DBMS_OUTPUT.PUT_LINE('There are '|| vn_count || ' retreats.');
	ELSE 
		DBMS_OUTPUT.PUT_LINE('There is not any retreats.');
	END IF;
END proc_count_retreat;
/
SHOW ERRORS;
EXECUTE proc_count_retreat;


--procedure for adding retreat_settings

CREATE OR REPLACE PROCEDURE proc_add_retreat_setting 
IS z_id retreat_settings.retreat_setting_id%TYPE;
BEGIN
SELECT retreat_setting_id
INTO z_id
FROM retreat_settings;
EXCEPTION
WHEN too_many_rows THEN 
dbms_output.put_line('problem while fetching more than one');
END proc_add_retreat_setting;
/
SHOW ERRORS;
EXECUTE proc_add_retreat_setting;


--procedure for counting retreat_settings
CREATE OR REPLACE PROCEDURE proc_count_retreat_settings AS
	vn_count NUMBER(5):= func_count_retreat_setting;
BEGIN
	IF vn_count>0 THEN
		DBMS_OUTPUT.PUT_LINE('There are '|| vn_count || ' retreat_settings.');
	ELSE 
		DBMS_OUTPUT.PUT_LINE('There is not any retreat_settings.');
	END IF;
END proc_count_retreat_settings;
/
SHOW ERRORS;
EXECUTE proc_count_retreat_settings;

--trigger--


--This trigger displays a message saying you deleted this staff when a staff is deleted

CREATE OR REPLACE TRIGGER trig_del_description
AFTER DELETE ON retreats
FOR EACH row
BEGIN
	DBMS_OUTPUT.PUT_LINE('YOU DELETED THE DESCRIPTION '||:OLD.retreat_id);
END trig_del_description;
/
SHOW ERRORS;







--This trigger displays message when following work is done 
--insert, update and delete work is done and message is displayed
CREATE OR REPLACE TRIGGER trig_retreat
AFTER INSERT OR UPDATE OR DELETE ON retreats
FOR EACH row
BEGIN
	IF INSERTING THEN
		DBMS_OUTPUT.PUT_LINE('INSERTED IN RETREAT TABLE. RETREAT_ID: '|| :NEW.retreat_id);
		END IF;
	IF UPDATING THEN
		DBMS_OUTPUT.PUT_LINE(' UPDATED IN RETREAT TABLE. RETREAT_ID: '|| :OLD.retreat_id);
		END IF;
	IF DELETING THEN
		DBMS_OUTPUT.PUT_LINE('DELETED A RECORD. RETREAT_ID: '|| :OLD.retreat_id);
		END IF;
END trig_retreat;
/
SHOW ERRORS;


--cursor--



--cursor to delete description of retreat table
CREATE OR REPLACE PROCEDURE proc_del_description_cursor(in_description VARCHAR2) IS
BEGIN
	DELETE FROM retreats WHERE description = in_description;
	IF SQL%FOUND THEN
		DBMS_OUTPUT.PUT_LINE('RETREATS WITH DESCRIPTION "'||in_description || '" DELETED SUCCESSFULLY!');
	ELSE
		DBMS_OUTPUT.PUT_LINE('NO SUCH RETREATS IS FOUND!');
	END IF;
END proc_del_description_cursor;
/
SHOW ERRORS;
EXECUTE proc_del_description_cursor('dsfksdl');

-----------a function to count retreat accomodation---------------------
CREATE OR REPLACE FUNCTION func_count_retreat_accos (in_accomodation_id NUMBER)RETURN NUMBER IS 
vn_count NUMBER(2);
BEGIN 
   SELECT COUNT(retreat_setting_id) AS 
   INTO vn_count
   FROM retreat_accomodations
   WHERE accomodation_id = in_accomodation_id;
RETURN vn_count;
END func_count_retreat_accos;
/
SHOW ERRORS;

------------a function to count settings--------------------------
CREATE OR REPLACE FUNCTION func_count_settings RETURN NUMBER IS 
vn_count NUMBER(2);
BEGIN 
SELECT COUNT(setting_id)
INTO vn_count
FROM settings;
RETURN vn_count;
END func_count_settings;
/
SHOW ERRORS;

-------------trigger for object table --------------------------------
-------------trigger for avoiding the duplication to be entered in addresses-------------
CREATE OR REPLACE TRIGGER trigg_check_address
BEFORE 
INSERT ON addresses
FOR EACH ROW
DECLARE
	vn_count_country NUMBER(2);
BEGIN
	SELECT COUNT(district) INTO vn_count_country FROM addresses 
	WHERE district = :NEW.district AND country = :NEW.country;
	IF vn_count_country>0 THEN
		RAISE_APPLICATION_ERROR (-2000, 'ERROR! ERROR!! ERROR!!! THE PROVIDED ADDRESS ALREADY EXISTS');
	END IF;
END trigg_check_address;
/
SHOW ERRORS;

-------------trigger for deleting from settings-----------------------------
CREATE OR REPLACE TRIGGER trig_setting_del
AFTER DELETE ON settings
FOR EACH row
BEGIN
DBMS_OUTPUT.PUT_LINE('DELETED' || :OLD.setting);
END trig_setting_del;
/
SHOW ERRORS;

-------------Procedure to run function to count the retreat accomodation----------
CREATE OR REPLACE PROCEDURE run_func_count_retreat_accos IS 
vn_count NUMBER(2);
BEGIN 
vn_count := func_count_retreat_accos(2);
END run_func_count_retreat_accos;
/
SHOW ERRORS;
EXECUTE run_func_count_retreat_accos;

--------------Procedure to run function to count setting----------------------------
CREATE OR REPLACE PROCEDURE run_func_count_settings IS 
vn_count NUMBER(2);
BEGIN 
vn_count := func_count_settings;
DBMS_OUTPUT.PUT_LINE(vn_count);
END run_func_count_settings;
/
SHOW ERRORS;
EXECUTE run_func_count_settings;

---------------A procedure to insert into setting------------------------------------
CREATE OR REPLACE PROCEDURE proc_insert_set 
IS 
vn_setting_id settings.setting_id%TYPE := 3
;
BEGIN
DELETE FROM settings WHERE setting_id = vn_setting_id;
END proc_insert_set;
/
SHOW ERRORS;
EXECUTE proc_insert_set; 

-----------------A procedure for selecting settings----------------------------------
CREATE OR REPLACE PROCEDURE proc_select_settings 
IS s_id settings.setting_id%TYPE;
BEGIN
SELECT setting_id
INTO s_id
FROM settings;
EXCEPTION
WHEN too_many_rows THEN 
DBMS_OUTPUT.PUT_LINE('problem while fettching more than one');
END proc_select_settings;
/
SHOW ERRORS;
EXECUTE proc_select_settings;

------------------A procedure for inserting into addresses---------------------------

CREATE OR REPLACE PROCEDURE proc_insert_add(in_district IN VARCHAR2:=NULL, in_country IN VARCHAR2:=NULL)IS
BEGIN
INSERT INTO addresses(district,country)
VALUES(in_district,in_country);
DBMS_OUTPUT.PUT_LINE('INSERTED INTO ROW SUCCESSFULLY');
END proc_insert_add;
/
SHOW ERRORS;
EXECUTE proc_insert_add;

-------------------A procedure for selecting addresses using cursor from addresses-----
CREATE OR REPLACE PROCEDURE proc_select_cur_add(in_district IN VARCHAR2) IS
vc_district VARCHAR2(50);

BEGIN
	SELECT district INTO vc_district FROM addresses 
	WHERE district = in_district;
	IF SQL%FOUND THEN
		DBMS_OUTPUT.PUT_LINE('DISTRICT "'||in_district || '" IS SELECTED SUCCESSFULLY!');
	ELSE
		DBMS_OUTPUT.PUT_LINE('THERE IS NO SUCH ADDRESS');
	END IF;
END proc_select_cur_add;
/
SHOW ERRORS;
EXECUTE proc_select_cur_add('PARIS');


--Dropping procedure proc_show_high_rated
DROP PROCEDURE proc_show_high_rated;

--Dropping procedure proc_add_stars
DROP PROCEDURE proc_add_stars;

--Dropping procedure run_func_update_accomodation_style
DROP PROCEDURE run_func_update_accomodation_style;

--Dropping procedure run_func_delete_review
DROP PROCEDURE run_func_delete_review;

--Dropping procedure run_func_display_review
DROP PROCEDURE run_func_display_review;

--Dropping procedure proc_show_retreat_setting
DROP PROCEDURE proc_show_retreat_setting;

--Dropping procedure proc_show_accomodation_style
DROP PROCEDURE proc_show_accomodation_style;

--Dropping procedure proc_insert_style
DROP PROCEDURE proc_insert_style;

--Dropping trigger trig_notify_action
DROP TRIGGER trig_notify_action;

--Dropping trigger trig_calculate_rating
DROP TRIGGER trig_calculate_rating;

--Dropping function func_display_review
DROP FUNCTION func_display_review;

--Dropping function func_delete_review
DROP FUNCTION func_delete_review;

--Dropping function func_update_accomodation_style
DROP FUNCTION func_update_accomodation_style;

-- Dropping procedure
DROP FUNCTION FUNC_BEST_ACCOM;
-- Dropping procedure
DROP PROCEDURE PROC_FIND_ACCOM;
-- Dropping procedure
DROP PROCEDURE PROC_DELETE_ACCOM;

-- dropping trigger
DROP TRIGGER TRIG_INSERT_ACCOMMODATIONS;
-- dropping trigger
DROP TRIGGER TRIG_DELETE_ACCOMMODATIONS;
-- dropping procedure
DROP PROCEDURE PROC_PRINT_BEST_ACCOM_BY_STYLE;
-- dropping procedure
DROP PROCEDURE PROC_PRINT_BEST_ACCOM;
-- dropping procedure
DROP PROCEDURE PROC_PRINT_ACCOM_BY_SERVICE;
-- dropping view
DROP VIEW VIEW_BEST_ACCOM_BY_STYLE;
-- dropping view
DROP VIEW VIEW_BEST_ACCOM;
-- dropping view
DROP VIEW VIEW_ACCOM_BY_FACILITY;
-- dropping view
DROP VIEW VIEW_ACCOM_BY_CUSTOMER_SERVICE;
-- dropping function
DROP FUNCTION FUNC_SUM_THREE;
-- dropping function
DROP FUNCTION FUNC_SUM_FIVE;
-- dropping function
DROP FUNCTION FUNC_SUM_TWO;
-- dropping function
DROP FUNCTION FUNC_C_N;

 --dropquery for count retreat functions
DROP FUNCTION func_count_retreat;

--drop query for count retreat_setting functions
DROP FUNCTION func_count_retreat_setting;

--drop query for adding retreats procedure
 DROP PROCEDURE proc_add_retreat ;

--drop query for counting retreats procedure
 DROP PROCEDURE proc_count_retreat;

--drop query for adding retreat_setting procedure
 DROP PROCEDURE proc_add_retreat_setting ;


--drop query for counting retreat_setting procedure
 DROP PROCEDURE proc_count_retreat_settings;


--drop query for deleting description trigger
DROP TRIGGER trig_del_description;

--drop query for retreat trigger
DROP TRIGGER trig_retreat;


--drop query for deleting description cursor
DROP PROCEDURE proc_del_description_cursor;



-------To drop procedure of adrresses and settings -----------
DROP PROCEDURE proc_insert_add;
DROP PROCEDURE proc_select_settings;
DROP PROCEDURE proc_insert_set;
DROP PROCEDURE proc_select_cur_add;
-------To drop procedure run function  of settings and retreat accomodation------
DROP PROCEDURE run_func_count_settings;
DROP PROCEDURE run_func_count_retreat_accos;
------To drop function of settings and retreat accomodation------
DROP FUNCTION func_count_retreat_accos;
DROP FUNCTION func_count_settings;

DROP TABLE reviews;
DROP TABLE retreat_accomodations;
DROP TABLE retreat_settings;
DROP TABLE ACCOMODATIONS;
DROP TABLE retreats;
DROP TABLE settings;
DROP TABLE accomodation_styles;
DROP TABLE addresses;

-- DROP SCRIPT

DROP TYPE SERVICE_VARRAY_TYPE ;
DROP TYPE FACILITY_VARRAY_TYPE;
DROP TYPE ROOM_TABLE_TYPE;
DROP TYPE SERVICE_TYPE;
DROP TYPE FACILITY_TYPE;
DROP TYPE ROOM_TYPE;
DROP SEQUENCE ACCOMODATIONS_SEQ;

DROP TYPE address_type;


DROP TYPE review_table_type;

DROP TYPE review_type;


DROP SEQUENCE review_seq;

DROP SEQUENCE accomodation_style_seq;

DROP SEQUENCE retreat_id;

DROP SEQUENCE retreat_setting_id;

DROP SEQUENCE setting_id;
