INSERT INTO staff (staffid, role, staffname, supervisorid) VALUES
(1, 'Administrator', 'Alice Johnson', NULL),
(2, 'Receptionist', 'Cathy Brown', 1),
(3, 'Nurse', 'Bobbie Smith', 1),
(4, 'Technician', 'David Wilson', 1),
(5, 'Doctor', 'Eve Davis', 1),
(6, 'Doctor', 'Frank Miller', 1),
(7, 'Doctor', 'Grace Lee', 1),
(8, 'Nurse', 'Hannah Taylor', 3),
(9, 'Nurse', 'Ian Clark', 3),
(10, 'Pharmacist', 'Jack Lewis', 1),
(11, 'Doctor', 'Alice Smith', 1);

INSERT INTO doctor (doctorid, licensenumber, specialty, workPhone, dworkemail, dfirstname, dlastname, staffid) VALUES
(1001, 'D0012345', 'Family Medicine', '310-555-1234', 'asmith101@clinic13.com', 'Alice', 'Smith', 11),
(1002, 'H8765432', 'Neurology', '206-555-5678', 'sjohnson102@brainmedicine.com', 'Bob', 'Johnson', NULL),
(1003, 'X1234567', 'Dermatology', '808-555-6796', 'cjones103@skindocs.med', 'Carol', 'Jones', NULL),
(1004, 'T7654321', 'Pediatrics', '206-555-1221', 'glee@childmedicine.med', 'Grace', 'Lee', 7),
(1005, 'M5432109', 'Internal Medicine', '206-555-3366', 'fmiller@gutsandmore.med', 'Frank', 'Miller', 6),
(1006, 'L0987654', 'Cardiology', '206-555-5221', 'evedavis@cardiomed.com', 'Eve', 'Davis', 5),
(1007, 'P1122334', 'Orthopedics', '808-555-5124', 'dkim@futureortho.com', 'David', 'Kim', NULL),
(1008, 'Q2233445', 'Psychiatry', '510-555-7445', 'emartinez@pyshicsrus.com', 'Eva', 'Martinez', NULL),
(1009, 'R3344556', 'Oncology', '310-555-9988', 'ianderson@newmilleniamed.com', 'Ian', 'Anderson', NULL),
(1010, 'S4455667', 'Gynecology', '206-555-7766', 'htaylor@roots.org', 'Hannah', 'Taylor', NULL);

INSERT INTO insurance (policynumber, providername, coveragetype, expirationdate) VALUES
('P123456789', 'HealthFirst', 'Comprehensive', '2025-12-31'),
('P987654321', 'MediCare Plus', 'Basic', '2024-06-30'),
('P456789123', 'WellCare', 'Premium', '2026-03-15'),
('P654321987', 'SecureHealth', 'Standard', '2025-09-20'),
('P789123456', 'FamilyHealth', 'Comprehensive', '2024-11-11'),
('P321987654', 'GlobalCare', 'Premium', '2026-01-01'),
('P876543210', 'Allianz', 'Basic', '2025-05-05'),
('P234567890', 'MediCare', 'Standard', '2024-08-08'),
('P765432109', 'HealthCare', 'Comprehensive', '2025-10-10'),
('P109876543', 'Tricare', 'Prime', '2026-02-02'),
('P123456788', 'HealthFirst', 'Comprehensive', '2025-12-31');

INSERT INTO patient (patientid, pfirstname, pmiddlename, plastname, gender, zip, state, city, street, dateofbirth, policynumber) VALUES
('PT1001', 'John', 'A.', 'Doe', 'M', 98101, 'WA', 'Seattle', '123 Green St', '1980-05-15', 'P123456789'),
('PT1002', 'Jane', 'B.', 'Smith', 'F', 90210, 'CA', 'Beverly Hills', '1436 Sunset Blvd', '1990-07-22', 'P987654321'),
('PT1003', 'Emily', NULL, 'Johnson', 'F', 60614, 'IL', 'Chicago', '7809 Windy St', '1975-03-30', 'P456789123'),
('PT1004', 'Michael', 'C.', 'Brown', 'M', 10001, 'NY', 'New York', '32 Fingerlakes Rd', '1985-11-05', 'P654321987'),
('PT1005', 'Sarah', NULL, 'Davis', 'F', 73301, 'TX', 'Austin', '1 Anthill Rd', '1992-09-12', 'P789123456'),
('PT1006', 'David', 'D.', 'Wilson', 'M', 33101, 'FL', 'Miami', '1987 Hurricane St', '1978-12-25', 'P321987654'),
('PT1007', 'Laura', NULL, 'Garcia', 'F', 85001, 'AZ', 'Phoenix', '147 Sand St', '1983-04-18', 'P876543210'),
('PT1008', 'James', 'E.', 'Martinez-Hernandez', 'M', 75201, 'TX', 'Dallas', '28 JR Blvd', '1995-06-09', 'P234567890'),
('PT1009', 'Olivia', NULL, 'Rodriguez', 'F', 94101, 'CA', 'San Francisco', '369 Lumbard St', '1988-10-30', 'P765432109'),
('PT1010', 'Daniel', 'F.', 'Hernandez', 'M', 48201, 'MI', 'Detroit', '15259 Ford Rd', '1972-02-14', 'P109876543'),
('PT1011', 'Sophia', 'G.', 'Lopez', 'F', 30301, 'GA', 'Atlanta', '753 Hotlanta St', '1993-08-27', 'P123456788');

INSERT INTO billing (invoicenumber, dateissued, paymentstatus, amountdue, patientid) VALUES
(5001, '2024-01-15', 'Paid', 250.00, 'PT1001'),
(5002, '2024-02-20', 'Unpaid', 150.50, 'PT1002'),
(5003, '2024-03-10', 'Paid', 300.75, 'PT1003'),
(5004, '2024-04-05', 'Unpaid', 400.00, 'PT1004'),
(5005, '2024-05-12', 'Paid', 120.25, 'PT1005'),
(5006, '2024-06-18', 'Unpaid', 220.40, 'PT1006'),
(5007, '2024-07-22', 'Paid', 330.60, 'PT1007'),
(5008, '2024-08-30', 'Unpaid', 440.80, 'PT1008'),
(5009, '2024-09-14', 'Paid', 550.90, 'PT1009'),
(5010, '2024-10-19', 'Unpaid', 660.10, 'PT1010');

INSERT INTO appointment (appointmentid, appointmentdate, appointmenttime, status, reasonforvisit, patientid, doctorid) VALUES
('A1001', '2024-06-01', '09:00', 'Scheduled', 'Routine Checkup', 'PT1001', 1001),
('A1002', '2024-06-02', '10:30', 'Completed', 'Flu Symptoms', 'PT1002', 1002),
('A1003', '2024-06-03', '11:15', 'Cancelled', 'Skin Rash', 'PT1003', 1003),
('A1004', '2024-06-04', '13:00', 'Scheduled', 'Pediatric Consultation', 'PT1004', 1004),
('A1005', '2024-06-05', '14:45', 'Completed', 'Diabetes Management', 'PT1005', 1005),
('A1006', '2024-06-06', '15:30', 'Scheduled', 'Cardiology Follow-up', 'PT1006', 1006),
('A1007', '2024-06-07', '08:30', 'Completed', 'Orthopedic Evaluation', 'PT1007', 1007),
('A1008', '2024-06-08', '09:45', 'Cancelled', 'Mental Health Check-in', 'PT1008', 1008),
('A1009', '2024-06-09', '10:15', 'Scheduled', 'Oncology Consultation', 'PT1009', 1009),
('A1010', '2024-06-10', '11:30', 'Completed', 'Gynecological Exam', 'PT1010', 1010),
('A1011', '2024-06-11', '12:00', 'Scheduled', 'Annual Physical Exam', 'PT1011', 1001);

INSERT INTO treatment (treatmentid, treatmentdescription, cost, appointmentid) VALUES
(2001, 'General physical examination including vital signs and health history review.', 150.00, 'A1001'),
(2002, 'Diagnosis and treatment of influenza symptoms including medication prescription.', 200.00, 'A1002'),
(2003, 'Evaluation and treatment of skin rash with topical ointment prescription.', 180.00, 'A1003'),
(2004, 'Comprehensive pediatric consultation and growth assessment.', 220.00, 'A1004'),
(2005, 'Diabetes management plan development and medication adjustment.', 250.00, 'A1005'),
(2006, 'Cardiology follow-up including ECG and medication review.', 300.00, 'A1006'),
(2007, 'Orthopedic evaluation for joint pain and mobility assessment.', 275.00, 'A1007'),
(2008, 'Mental health check-in with counseling session.', 230.00, 'A1008'),
(2009, 'Oncology consultation including treatment options discussion.', 350.00, 'A1009'),
(2010, 'Gynecological exam including Pap smear and health counseling.', 210.00, 'A1010');

INSERT INTO prescription (prescriptionid, doctorid, patientid, appointmentid, medicinename, startdate, enddate, dosage) VALUES
(3001, 1001, 'PT1001', 'A1001', 'Lisinopril', '2024-06-01', '2024-12-01', '10mg once daily'),
(3002, 1002, 'PT1002', 'A1002', 'Oseltamivir', '2024-06-02', '2024-06-12', '75mg twice daily'),
(3003, 1003, 'PT1003', 'A1003', 'Hydrocortisone Cream', '2024-06-03', '2024-06-17', 'Apply to affected area twice daily'),
(3004, 1004, 'PT1004', 'A1004', 'Amoxicillin', '2024-06-04', '2024-06-14', '500mg three times daily'),
(3005, 1005, 'PT1005', 'A1005', 'Metformin', '2024-06-05', '2025-06-05', '500mg twice daily'),
(3006, 1006, 'PT1006', 'A1006', 'Atorvastatin', '2024-06-06', '2025-06-06', '20mg once daily'),
(3007, 1007, 'PT1007', 'A1007', 'Ibuprofen', '2024-06-07', '2024-06-17', '400mg every 6 hours as needed'),
(3008, 1008, 'PT1008', 'A1008', 'Sertraline', '2024-06-08', '2025-06-08', '50mg once daily'),
(3009, 1009, 'PT1009', 'A1009', 'Tamoxifen', '2024-06-09', '2025-06-09', '20mg once daily'),
(3010, 1010, 'PT1010', 'A1010', 'Ethinyl Estradiol/Norgestimate', '2024-06-10', '2025-06-10', '1 tablet daily');

INSERT INTO conducts (doctorid, appointmentid) VALUES
(1001, 'A1001'),
(1002, 'A1002'),
(1003, 'A1003'),
(1004, 'A1004'),
(1005, 'A1005'),
(1006, 'A1006'),
(1007, 'A1007'),
(1008, 'A1008'),
(1009, 'A1009'),
(1010, 'A1010'),
(1001, 'A1011');

INSERT INTO treats (doctorid, patientid) VALUES
(1001, 'PT1001'),
(1002, 'PT1002'),
(1003, 'PT1003'),
(1004, 'PT1004'),
(1005, 'PT1005'),
(1006, 'PT1006'),
(1007, 'PT1007'),
(1008, 'PT1008'),
(1009, 'PT1009'),
(1010, 'PT1010'),
(1001, 'PT1011');

INSERT INTO patientallergy (patientid, allergy) VALUES
('PT1001', 'Peanuts'),
('PT1002', 'Penicillin'),
('PT1003', 'Shellfish'),
('PT1004', 'Latex'),
('PT1005', 'Pollen'),
('PT1006', 'Dust Mites'),
('PT1007', 'Bee Stings'),
('PT1008', 'Gluten'),
('PT1009', 'Eggs'),
('PT1010', 'Milk'),
('PT1011', 'Soy');

INSERT INTO patientphone (patientid, phone) VALUES
('PT1001', '206-555-1212'),
('PT1001', '206-555-1002'),
('PT1002', '310-555-2555'),
('PT1003', '312-555-3679'),
('PT1004', '212-555-4000'),
('PT1005', '512-555-5555'),
('PT1006', '305-555-6101'),
('PT1007', '602-555-7111'),
('PT1008', '214-555-8888'),
('PT1009', '415-555-9999'),
('PT1010', '313-555-2323');

INSERT INTO patientemail (patientid, email) VALUES
('PT1001', 'johndoe@gmail.com'),
('PT1002', 'janesmith02@outlook.com'),
('PT1003', 'emilyjohnson@hotmail.com'),
('PT1004', 'michaelbrown@icq.com'),
('PT1005', 'sarahdavis@aol.com'),
('PT1006', 'davidwilson@ebay.com'),
('PT1008', 'jamesmartinez@comcast.net'),
('PT1010', 'danielhernandez@comcast.net'),
('PT1011', 'sophialopez@gmail.com'),
('PT1011', 'sophialopez2@hotmail.com');