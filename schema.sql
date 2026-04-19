-- =============================================================================
-- NOVA Pharmacy Management System
-- CSF 212 Database Systems -- Mini Project, BITS Pilani Hyderabad Campus
-- =============================================================================
-- Run with: sqlplus user/pass @schema.sql
-- Enable DBMS_OUTPUT before running reporting procedures:
--   SET SERVEROUTPUT ON;
-- =============================================================================


-- ============================================================
-- SCHEMA: Tables
-- ============================================================

CREATE TABLE Doctor (
    AadharID CHAR(12) PRIMARY KEY,
    Name VARCHAR(100),
    Specialization VARCHAR(100),
    YearsOfExperience INT
    );

CREATE TABLE Patient (
    AadharID CHAR(12) PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255),
    Age INT,
    PrimaryPhysician CHAR(12),
    FOREIGN KEY (PrimaryPhysician) REFERENCES Doctor(AadharID) ON DELETE CASCADE
    );

CREATE TABLE PharmaCompany (
    CompanyName VARCHAR(100) PRIMARY KEY,
    Phone VARCHAR(15)
    );

CREATE TABLE Drug (
    TradeName VARCHAR(100),
    CompanyName VARCHAR(100),
    Formula VARCHAR(255),
    PRIMARY KEY (TradeName, CompanyName),
    FOREIGN KEY (CompanyName) REFERENCES PharmaCompany(CompanyName) ON DELETE CASCADE
    );

CREATE TABLE Pharmacy (
    PharmacyName VARCHAR(100) PRIMARY KEY,
    Address VARCHAR(255),
    Phone VARCHAR(15)
    );

CREATE TABLE Sales (
    PharmacyName VARCHAR(100),
    TradeName VARCHAR(100),
    CompanyName VARCHAR(100),
    Price DECIMAL(10,2),
    PRIMARY KEY (PharmacyName, TradeName, CompanyName),
    FOREIGN KEY (PharmacyName) REFERENCES Pharmacy(PharmacyName) ON DELETE CASCADE,
    FOREIGN KEY (TradeName, CompanyName) REFERENCES Drug(TradeName, CompanyName) ON DELETE CASCADE
    );

CREATE TABLE Prescription (
    PrescriptionID INT PRIMARY KEY,
    PatientID CHAR(12),
    DoctorID CHAR(12),
    PDate DATE,
    UNIQUE (PatientID, DoctorID, PDate),
    FOREIGN KEY (PatientID) REFERENCES Patient(AadharID) ON DELETE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES Doctor(AadharID) ON DELETE CASCADE
    );

CREATE TABLE PrescriptionDrug (
    PrescriptionID INT,
    TradeName VARCHAR(100),
    CompanyName VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (PrescriptionID, TradeName, CompanyName),
    FOREIGN KEY (PrescriptionID) REFERENCES Prescription(PrescriptionID) ON DELETE CASCADE,
    FOREIGN KEY (TradeName, CompanyName) REFERENCES Drug(TradeName, CompanyName) ON DELETE CASCADE
    );

CREATE TABLE Contract (
    ContractID INT PRIMARY KEY,
    PharmacyName VARCHAR(100),
    CompanyName VARCHAR(100),
    Supervisor VARCHAR(100),
    Content VARCHAR(200),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (PharmacyName) REFERENCES Pharmacy(PharmacyName) ON DELETE CASCADE,
    FOREIGN KEY (CompanyName) REFERENCES PharmaCompany(CompanyName) ON DELETE CASCADE
    );

-- ============================================================
-- PROCEDURES: Insert
-- ============================================================

CREATE OR REPLACE PROCEDURE Insert_Pharmacy(
    p_name IN VARCHAR,
    p_address IN VARCHAR,
    p_phone IN VARCHAR
    ) AS
    BEGIN
    INSERT INTO Pharmacy (PharmacyName, Address, Phone)
    VALUES (p_name, p_address, p_phone);
    END;
/

CREATE OR REPLACE PROCEDURE Insert_PharmaCompany(
    c_name IN VARCHAR,
    c_phone IN VARCHAR
    ) AS
    BEGIN
    INSERT INTO PharmaCompany (CompanyName, Phone)
    VALUES (c_name, c_phone);
    END;
/

CREATE OR REPLACE PROCEDURE Insert_Doctor(
    d_aadhar IN CHAR,
    d_name IN VARCHAR,
    d_specialization IN VARCHAR,
    d_exp IN INT
    ) AS
    BEGIN
    INSERT INTO Doctor (AadharID, Name, Specialization, YearsOfExperience)
    VALUES (d_aadhar, d_name, d_specialization, d_exp);
    END;
/

CREATE OR REPLACE PROCEDURE Insert_Patient(
    p_aadhar IN CHAR,
    p_name IN VARCHAR,
    p_address IN VARCHAR,
    p_age IN INT,
    p_physician IN CHAR
    ) AS
    BEGIN
    INSERT INTO Patient (AadharID, Name, Address, Age, PrimaryPhysician)
    VALUES (p_aadhar, p_name, p_address, p_age, p_physician);
    END;
/

CREATE OR REPLACE PROCEDURE Insert_Drug(
    t_name IN VARCHAR,
    c_name IN VARCHAR,
    formula IN VARCHAR
    ) AS
    BEGIN
    INSERT INTO Drug (TradeName, CompanyName, Formula)
    VALUES (t_name, c_name, formula);
    END;
/

CREATE OR REPLACE PROCEDURE Insert_Prescription(
    p_id IN INT,
    patient_id IN CHAR,
    doctor_id IN CHAR,
    p_date IN DATE
    ) AS
    BEGIN
    INSERT INTO Prescription (PrescriptionID, PatientID, DoctorID, PDate)
    VALUES (p_id, patient_id, doctor_id, p_date);
    END;
/

CREATE OR REPLACE PROCEDURE Insert_Contract(
    con_id IN INT,
    pharmacy_name IN VARCHAR,
    company_name IN VARCHAR,
    supervisor IN VARCHAR,
    content IN VARCHAR,
    start_d IN DATE,
    end_d IN DATE
    ) AS
    BEGIN
    INSERT INTO Contract (ContractID, PharmacyName, CompanyName, Supervisor, Content, StartDate, EndDate)
    VALUES (con_id, pharmacy_name, company_name, supervisor, content, start_d, end_d);
    END;
/

CREATE OR REPLACE PROCEDURE Insert_Sales(
    pharmacy_name IN VARCHAR,
    trade_name IN VARCHAR,
    company_name IN VARCHAR,
    price IN DECIMAL
    ) AS
    BEGIN
    INSERT INTO Sales (PharmacyName, TradeName, CompanyName, Price)
    VALUES (pharmacy_name, trade_name, company_name, price);
    END;
/

CREATE OR REPLACE PROCEDURE Insert_PrescriptionDrug(
    presc_id IN INT,
    trade_name IN VARCHAR,
    company_name IN VARCHAR,
    qty IN INT
    ) AS
    BEGIN
    INSERT INTO PrescriptionDrug (PrescriptionID, TradeName, CompanyName, Quantity)
    VALUES (presc_id, trade_name, company_name, qty);
    END;
/

-- ============================================================
-- PROCEDURES: Delete
-- ============================================================

CREATE OR REPLACE PROCEDURE Delete_PharmaCompany(
    c_name IN VARCHAR
    ) AS
    BEGIN
    DELETE FROM PharmaCompany WHERE CompanyName = c_name;
    END;
/

CREATE OR REPLACE PROCEDURE Delete_Doctor(
    d_aadhar IN CHAR
    ) AS
    BEGIN
    DELETE FROM Doctor WHERE AadharID = d_aadhar;
    END;
/

CREATE OR REPLACE PROCEDURE Delete_Patient(
    p_aadhar IN CHAR
    ) AS
    BEGIN
    DELETE FROM Patient WHERE AadharID = p_aadhar;
    END;
/

CREATE OR REPLACE PROCEDURE Delete_Drug(
    t_name IN VARCHAR,
    c_name IN VARCHAR
    ) AS
    BEGIN
    DELETE FROM Drug WHERE TradeName = t_name AND CompanyName = c_name;
    END;
/

CREATE OR REPLACE PROCEDURE Delete_Sales(
    p_name IN VARCHAR,
    t_name IN VARCHAR,
    c_name IN VARCHAR
    ) AS
    BEGIN
    DELETE FROM Sales
    WHERE PharmacyName = p_name AND TradeName = t_name AND CompanyName = c_name;
    END;
/

CREATE OR REPLACE PROCEDURE Delete_Prescription(
    p_id IN INT
    ) AS
    BEGIN
    DELETE FROM Prescription WHERE PrescriptionID = p_id;
    END;
/

CREATE OR REPLACE PROCEDURE Delete_PrescriptionDrug(
    p_id IN INT,
    t_name IN VARCHAR,
    c_name IN VARCHAR
    ) AS
    BEGIN
    DELETE FROM PrescriptionDrug
    WHERE PrescriptionID = p_id AND TradeName = t_name AND CompanyName = c_name;
    END;
/

CREATE OR REPLACE PROCEDURE Delete_Contract(
    c_id IN INT
    ) AS
    BEGIN
    DELETE FROM Contract WHERE ContractID = c_id;
    END;
/

-- ============================================================
-- PROCEDURES: Update
-- ============================================================

CREATE OR REPLACE PROCEDURE Update_Patient_Address(
    p_aadhar IN CHAR,
    new_address IN VARCHAR
    ) AS
    BEGIN
    UPDATE Patient
    SET Address = new_address
    WHERE AadharID = p_aadhar;
    END;
/

CREATE OR REPLACE PROCEDURE Update_Pharmacy_Phone(
    p_name IN VARCHAR,
    new_phone IN VARCHAR
    ) AS
    BEGIN
    UPDATE Pharmacy
    SET Phone = new_phone
    WHERE PharmacyName = p_name;
    END;
/

CREATE OR REPLACE PROCEDURE Update_Contract_Supervisor(
    contract_id IN INT,
    new_supervisor IN VARCHAR
    ) AS
    BEGIN
    UPDATE Contract
    SET Supervisor = new_supervisor
    WHERE ContractID = contract_id;
    END;
/

-- ============================================================
-- PROCEDURES: Reporting
-- ============================================================

CREATE OR REPLACE PROCEDURE Prescription_Report(
    p_aadhar IN CHAR,
    start_date IN DATE,
    end_date IN DATE
    ) AS
    BEGIN
    FOR rec IN (
    SELECT
    pr.PrescriptionID,
    pr.DoctorID,
    d.Name AS DoctorName,
    pr.PDate,
    pd.TradeName,
    pd.CompanyName,
    pd.Quantity
    FROM
    Prescription pr
    JOIN
    PrescriptionDrug pd ON pr.PrescriptionID = pd.PrescriptionID
    JOIN
    Doctor d ON pr.DoctorID = d.AadharID
    WHERE
    pr.PatientID = p_aadhar
    AND pr.PDate BETWEEN start_date AND end_date
    ORDER BY
    pr.PDate, pr.PrescriptionID
    )
    LOOP
    DBMS_OUTPUT.PUT_LINE('Prescription ID: ' || rec.PrescriptionID ||
    ', Doctor: ' || rec.DoctorName ||
    ', Date: ' || TO_CHAR(rec.PDate, 'DD-MON-YYYY') ||
    ', Drug: ' || rec.TradeName || ' (' || rec.CompanyName || ')' ||
    ', Quantity: ' || rec.Quantity);
    END LOOP;
    END;
/

CREATE OR REPLACE PROCEDURE Prescription_Details_By_Date(
    p_aadhar IN CHAR,
    presc_date IN DATE
    ) AS
    BEGIN
    FOR rec IN (
    SELECT
    pr.PrescriptionID,
    d.Name AS DoctorName,
    pr.PDate,
    pd.TradeName,
    pd.CompanyName,
    pd.Quantity
    FROM
    Prescription pr
    JOIN
    Doctor d ON pr.DoctorID = d.AadharID
    JOIN
    PrescriptionDrug pd ON pr.PrescriptionID = pd.PrescriptionID
    WHERE
    pr.PatientID = p_aadhar
    AND pr.PDate = presc_date
    )
    LOOP
    DBMS_OUTPUT.PUT_LINE('Prescription ID: ' || rec.PrescriptionID ||
    ', Date: ' || TO_CHAR(rec.PDate, 'DD-MON-YYYY'));
    DBMS_OUTPUT.PUT_LINE('Doctor: ' || rec.DoctorName);
    DBMS_OUTPUT.PUT_LINE('Drug: ' || rec.TradeName || ' by ' || rec.CompanyName ||
    ', Quantity: ' || rec.Quantity);
    DBMS_OUTPUT.PUT_LINE('-------------------------');
    END LOOP;
    END;
/

CREATE OR REPLACE PROCEDURE Get_Drugs_By_Company(
    comp_name IN VARCHAR
    ) AS
    BEGIN
    FOR rec IN (
    SELECT TradeName, Formula
    FROM Drug
    WHERE CompanyName = comp_name
    ) LOOP
    DBMS_OUTPUT.PUT_LINE('Trade Name: ' || rec.TradeName || ', Formula: ' || rec.Formula);
    END LOOP;
    END;
/

CREATE OR REPLACE PROCEDURE Print_Stock_Position(
    p_name IN VARCHAR
    ) AS
    BEGIN
    FOR rec IN (
    SELECT
    s.TradeName,
    s.CompanyName,
    d.Formula,
    s.Price
    FROM
    Sales s
    JOIN
    Drug d ON s.TradeName = d.TradeName AND s.CompanyName = d.CompanyName
    WHERE
    s.PharmacyName = p_name
    ORDER BY
    s.TradeName
    ) LOOP
    DBMS_OUTPUT.PUT_LINE('Trade Name: ' || rec.TradeName ||
    ', Company: ' || rec.CompanyName ||
    ', Formula: ' || rec.Formula ||
    ', Price: ₹' || rec.Price);
    END LOOP;
    END;
/

CREATE OR REPLACE PROCEDURE Print_Contract_Details(
    p_name IN VARCHAR,
    c_name IN VARCHAR
    ) AS
    BEGIN
    FOR rec IN (
    SELECT
    ContractID,
    Supervisor,
    Content,
    TO_CHAR(StartDate, 'DD-MON-YYYY') AS StartDateStr,
    TO_CHAR(EndDate, 'DD-MON-YYYY') AS EndDateStr
    FROM
    Contract
    WHERE
    PharmacyName = p_name AND CompanyName = c_name
    ) LOOP
    DBMS_OUTPUT.PUT_LINE('Contract ID: ' || rec.ContractID);
    DBMS_OUTPUT.PUT_LINE('Supervisor: ' || rec.Supervisor);
    DBMS_OUTPUT.PUT_LINE('Content: ' || rec.Content);
    DBMS_OUTPUT.PUT_LINE('Start Date: ' || rec.StartDateStr);
    DBMS_OUTPUT.PUT_LINE('End Date: ' || rec.EndDateStr);
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
    END LOOP;
    END;
/

CREATE OR REPLACE PROCEDURE Print_Patients_For_Doctor(
    d_aadhar IN CHAR
    ) AS
    BEGIN
    FOR rec IN (
    SELECT
    AadharID,
    Name,
    Address,
    Age
    FROM
    Patient
    WHERE
    PrimaryPhysician = d_aadhar
    ORDER BY
    Name
    ) LOOP
    DBMS_OUTPUT.PUT_LINE('Patient AadharID: ' || rec.AadharID);
    DBMS_OUTPUT.PUT_LINE('Name: ' || rec.Name);
    DBMS_OUTPUT.PUT_LINE('Address: ' || rec.Address);
    DBMS_OUTPUT.PUT_LINE('Age: ' || rec.Age);
    DBMS_OUTPUT.PUT_LINE('---------------------------');
    END LOOP;
    END;
/

-- ============================================================
-- TRIGGERS
-- ============================================================

CREATE OR REPLACE TRIGGER Ensure_Minimum_Stock
BEFORE DELETE ON Sales
FOR EACH ROW
DECLARE
    v_count INT;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM Sales
    WHERE PharmacyName = :OLD.PharmacyName;

    IF v_count <= 10 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Deletion not allowed: A pharmacy must sell at least 10 drugs.');
    END IF;
END;
/
