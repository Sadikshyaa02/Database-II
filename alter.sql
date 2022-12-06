

-- ALTER SCRIPTS

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

