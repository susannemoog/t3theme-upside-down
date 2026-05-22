CREATE TABLE tt_content (
    tx_themeupsidedown_character_faction       varchar(255)          DEFAULT '' NOT NULL,
    tx_themeupsidedown_character_status        varchar(50)           DEFAULT '' NOT NULL,
    tx_themeupsidedown_location_coords         varchar(255)          DEFAULT '' NOT NULL,
    tx_themeupsidedown_location_threat         varchar(50)           DEFAULT '' NOT NULL,
    tx_themeupsidedown_location_featured       tinyint(1) unsigned   DEFAULT '0' NOT NULL,
    tx_themeupsidedown_incident_id             varchar(50)           DEFAULT '' NOT NULL,
    tx_themeupsidedown_incident_date           varchar(50)           DEFAULT '' NOT NULL,
    tx_themeupsidedown_incident_classification varchar(255)          DEFAULT '' NOT NULL,
    tx_themeupsidedown_testimonial_citation    varchar(255)          DEFAULT '' NOT NULL,
    tx_themeupsidedown_testimonial_location    varchar(255)          DEFAULT '' NOT NULL,
    tx_themeupsidedown_testimonial_clearance   varchar(100)          DEFAULT '' NOT NULL
);
