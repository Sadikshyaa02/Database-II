

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