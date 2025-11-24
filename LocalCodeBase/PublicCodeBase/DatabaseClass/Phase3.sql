CREATE DATABASE ClinicDB;

CREATE TABLE staff
(
	staffid 	INT NOT NULL,
	role	VARCHAR(25)	NOT NULL,
	staffname	VARCHAR(25)	NOT NULL,
	supervisorid	INT,
	PRIMARY KEY (staffid),
	FOREIGN KEY (supervisorid) REFERENCES staff(staffid) );
	
CREATE TABLE doctor
(
	doctorid	INT	NOT NULL,
	licensenumber	VARCHAR(50)	UNIQUE NOT NULL,
	specialty	VARCHAR(255)	NOT NULL,
	workPhone	VARCHAR(20)	NOT NULL,
	dworkemail	VARCHAR(50)	NOT NULL,
	dfirstname	VARCHAR(25)	NOT NULL,
	dlastname	VARCHAR(50)	NOT NULL,
	staffid	INT	NOT NULL,
	PRIMARY KEY (doctorid),
	FOREIGN KEY (staffid) REFERENCES staff(staffid) );
	
CREATE TABLE insurance
(
	policynumber	VARCHAR(50)	NOT NULL,
	providername	VARCHAR(50)	NOT NULL,
	coveragetype	VARCHAR(50)	NOT NULL,
	expirationdate	DATE	NOT NULL,
	PRIMARY KEY (policynumber) );
	
CREATE TABLE patient
(
	patientid	VARCHAR(50)	NOT NULL,
	pfirstname	VARCHAR(25)	NOT NULL,
	pmiddlename	VARCHAR(25),	
	plastname	VARCHAR(50)	NOT NULL,
	gender	CHAR(1)	NOT NULL,
	zip	INT	NOT NULL,
	state	CHAR(2)	NOT NULL,
	city	VARCHAR(20)	NOT NULL,
	street	VARCHAR(25)	NOT NULL,
	dateofbirth	DATE	NOT NULL,
	policynumber	VARCHAR(50)	NOT NULL,
	PRIMARY KEY (patientid),
	FOREIGN KEY (policynumber) REFERENCES insurance(policynumber) );
	
CREATE TABLE billing
(
	invoicenumber	INT	NOT NULL,
	dateissued	DATE	NOT NULL,
	paymentstatus	VARCHAR(25)	NOT NULL,
	amountdue	DECIMAL(10,2)	NOT NULL,
	patientid	VARCHAR(50)	NOT NULL,
	PRIMARY KEY (invoicenumber),
	FOREIGN KEY (patientid) REFERENCES patient(patientid) );
	
CREATE TABLE appointment
(
	appointmentid	VARCHAR(50)	NOT NULL,
	appointmentdate	DATE	NOT NULL,
	appointmenttime	CHAR(5)	NOT NULL,
	status	VARCHAR(255)	NOT NULL,
	reasonforvisit	VARCHAR(255)	NOT NULL,
	patientid	VARCHAR(50)	NOT NULL,
	doctorid	INT	NOT NULL,
	PRIMARY KEY (appointmentid),
	FOREIGN KEY (patientid) REFERENCES patient(patientid),
	FOREIGN KEY (doctorid) REFERENCES doctor(doctorid) );

CREATE TABLE treatment
(
	treatmentid	INT	NOT NULL,
	treatmentdescription	VARCHAR(255)	NOT NULL,
	cost	DECIMAL(10,2)  	NOT NULL,
    appointmentid	VARCHAR(50)	NOT NULL,
	PRIMARY KEY (treatmentid),
	FOREIGN KEY (appointmentid) REFERENCES appointment(appointmentid) );
	
CREATE TABLE prescription
(
	prescriptionid	INT	NOT NULL,
    doctorid	INT	NOT NULL,
    patientid	VARCHAR(50)	NOT NULL,
    appointmentid	VARCHAR(50)	NOT NULL,
	medicinename	VARCHAR(50)	NOT NULL,
	startdate	DATE	NOT NULL,
	enddate	DATE	NOT NULL,
	dosage	VARCHAR(50)	NOT NULL,
	PRIMARY KEY (prescriptionid),
	FOREIGN KEY (doctorid) REFERENCES doctor(doctorid),
	FOREIGN KEY (patientid) REFERENCES patient(patientid),
	FOREIGN KEY (appointmentid) REFERENCES appointment(appointmentid) );
	
CREATE TABLE conducts
(
	doctorid	INT	NOT NULL,
	appointmentid	VARCHAR(50)	NOT NULL,
    PRIMARY KEY (doctorid, appointmentid),
	FOREIGN KEY (doctorid) REFERENCES doctor(doctorid),
	FOREIGN KEY (appointmentid) REFERENCES appointment(appointmentid) );
	
CREATE TABLE treats
(
	doctorid	INT	NOT NULL,
	patientid	VARCHAR(50)	NOT NULL,
    PRIMARY KEY (doctorid, patientid),
	FOREIGN KEY (doctorid) REFERENCES doctor(doctorid),
	FOREIGN KEY (patientid) REFERENCES patient(patientid) );
	
CREATE TABLE patientallergy
(
	patientid	VARCHAR(50)	NOT NULL,
	allergy	VARCHAR(255)	NOT NULL,
    PRIMARY KEY (patientid, allergy),
	FOREIGN KEY (patientid) REFERENCES patient(patientid) );

CREATE TABLE patientphone
(
	patientid	VARCHAR(50)	NOT NULL,
	phone	VARCHAR(20)	NOT NULL,
    PRIMARY KEY (patientid, phone),
	FOREIGN KEY (patientid) REFERENCES patient(patientid) );
	
CREATE TABLE patientemail
(
	patientid	VARCHAR(50),
	email	VARCHAR(50),
    PRIMARY KEY (patientid, email),
	FOREIGN KEY (patientid) REFERENCES patient(patientid) );
