# DBMS Pharmacy — NOVA Pharmacy Management System

A relational database and PL/SQL application for **NOVA**, a fictional chain of pharmacies that sells drugs produced by multiple pharmaceutical companies. Built end-to-end using **Oracle SQL and PL/SQL** for the CSF 212 Database Systems mini-project at BITS Pilani, Hyderabad Campus.

The project covers the full database lifecycle: ER modeling, relational schema design, normalization, constraint enforcement, and a complete PL/SQL procedure layer for data manipulation and reporting.

---

## Table of Contents

- [Domain Overview](#domain-overview)
- [Schema Design](#schema-design)
- [Business Rules Enforced](#business-rules-enforced)
- [Stored Procedures](#stored-procedures)
- [Reporting Queries](#reporting-queries)
- [Triggers](#triggers)
- [Repository Structure](#repository-structure)
- [Running the Project](#running-the-project)
- [Sample Workflows](#sample-workflows)
- [Design Decisions](#design-decisions)
- [Team](#team)

---

## Domain Overview

NOVA operates a chain of pharmacies. The system has to track:

- **Patients** and the **doctors** who treat them (every patient has a primary physician).
- **Pharmaceutical companies** and the **drugs** they produce.
- **Pharmacies** in the chain, what drugs they stock, and at what prices.
- **Prescriptions** written by doctors for patients, with specific drugs and quantities.
- **Contracts** between pharmacies and pharmaceutical companies, each with a supervisor and date range.

The relationships across these entities — a drug sold at multiple pharmacies at different prices, a patient getting prescriptions from multiple doctors, the same drug appearing on multiple prescriptions — drive the schema design.

## Schema Design

The database uses **9 tables**, normalized to reduce redundancy and enforce referential integrity via foreign keys and cascade rules.

| Table | Primary Key | Purpose |
|---|---|---|
| `Doctor` | `AadharID` | Doctor records — name, specialization, experience |
| `Patient` | `AadharID` | Patient records — links to primary physician |
| `PharmaCompany` | `CompanyName` | Pharmaceutical companies — name, phone |
| `Drug` | `(TradeName, CompanyName)` | Drugs — trade name is unique *per company* |
| `Pharmacy` | `PharmacyName` | Individual NOVA pharmacies |
| `Sales` | `(PharmacyName, TradeName, CompanyName)` | Which drugs are sold at which pharmacy, and at what price |
| `Prescription` | `PrescriptionID` | A doctor's prescription for a patient on a date |
| `PrescriptionDrug` | `(PrescriptionID, TradeName, CompanyName)` | Drugs and quantities on each prescription |
| `Contract` | `ContractID` | Pharmacy–company contracts with dates and supervisor |

**Key modeling choices:**

- **Drug is uniquely identified by `(TradeName, CompanyName)`**, not trade name alone. This reflects the real-world constraint that two companies can both sell a drug called "PainAway" with different formulas.
- **Patient and Doctor both use `AadharID`** (the Indian national ID) as their primary key, matching the assignment's specification and keeping the schema consistent with real identity management.
- **`Sales` is a separate table** rather than an attribute on `Drug` because the same drug can be sold at multiple pharmacies at different prices. Making price a column on `Drug` would have been a normalization violation.
- **`PrescriptionDrug` is a junction table** implementing the many-to-many relationship between prescriptions and drugs, with an attached quantity.

## Business Rules Enforced

The assignment specifies several domain rules. They're enforced through a combination of primary keys, foreign keys, `UNIQUE` constraints, cascade rules, and triggers:

- **Primary physician link:** `Patient.PrimaryPhysician` is a foreign key to `Doctor.AadharID`. Deleting a doctor cascades to clean up dependent records.
- **Drug ownership:** `Drug.CompanyName` is a foreign key to `PharmaCompany.CompanyName` with `ON DELETE CASCADE` — if a company is deleted, its drugs go with it. This matches the spec: *"If a pharmaceutical company is deleted we don't have to keep the details of the drugs of the company."*
- **One prescription per doctor-patient-date:** `Prescription` has a `UNIQUE (PatientID, DoctorID, PDate)` constraint. A doctor can only write one prescription for a given patient on a given day.
- **Pharmacy minimum stock:** A trigger enforces the spec requirement that each pharmacy sells at least 10 drugs — see [Triggers](#triggers) below.
- **Cascading deletions** on `Prescription → PrescriptionDrug`, `Patient → Prescription`, and `Pharmacy → Sales` so orphaned records are never left behind.

## Stored Procedures

All data manipulation is wrapped in PL/SQL stored procedures rather than raw SQL. This matches the assignment requirement and keeps the application layer cleaner — a front-end or another system would call named procedures, not construct DML strings.

**Insert procedures** (one per table):
`Insert_Doctor`, `Insert_Patient`, `Insert_PharmaCompany`, `Insert_Drug`, `Insert_Pharmacy`, `Insert_Sales`, `Insert_Prescription`, `Insert_PrescriptionDrug`, `Insert_Contract`

**Delete procedures:**
`Delete_Doctor`, `Delete_Patient`, `Delete_PharmaCompany`, `Delete_Drug`, `Delete_Pharmacy`, `Delete_Sales`, `Delete_Prescription`, `Delete_PrescriptionDrug`, `Delete_Contract`

**Update procedures** (targeted updates for the fields that change most):
`Update_Patient_Address`, `Update_Pharmacy_Phone`, `Update_Contract_Supervisor`

Each procedure takes typed parameters matching its table's columns and performs input-bound insertion/deletion/update — no SQL injection surface, no string concatenation.

## Reporting Queries

Five reporting procedures cover the main read-side use cases specified by the assignment:

| Procedure | What It Does |
|---|---|
| `Prescription_Report(patient, start, end)` | All prescriptions for a patient within a date range, joined with doctor and drug details |
| `Prescription_Details_By_Date(patient, date)` | Full details of prescriptions for a patient on a specific date |
| `Get_Drugs_By_Company(company)` | All drugs manufactured by a pharmaceutical company |
| `Print_Stock_Position(pharmacy)` | Every drug sold at a pharmacy, with formula and price |
| `Print_Contract_Details(pharmacy, company)` | Contract details between a specific pharmacy and company |
| `Print_Patients_For_Doctor(doctor)` | All patients assigned to a given doctor as primary physician |

All reports use `DBMS_OUTPUT.PUT_LINE` for formatted console output and use proper `JOIN`s rather than nested subqueries where possible.

## Triggers

**`Ensure_Minimum_Stock`** — a `BEFORE DELETE` trigger on `Sales` that blocks any deletion which would reduce a pharmacy's drug count below 10. This enforces the assignment's rule that *"each pharmacy sells several drugs (at least 10)."*

```sql
CREATE OR REPLACE TRIGGER Ensure_Minimum_Stock
BEFORE DELETE ON Sales
FOR EACH ROW
DECLARE
    v_count INT;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Sales WHERE PharmacyName = :OLD.PharmacyName;

    IF v_count <= 10 THEN
        RAISE_APPLICATION_ERROR(-20001,
            'Deletion not allowed: A pharmacy must sell at least 10 drugs.');
    END IF;
END;
```

The trigger uses `RAISE_APPLICATION_ERROR` to return a meaningful error message to the caller rather than silently failing.

## Repository Structure

```
dbms-pharmacy/
├── README.md
├── schema.sql                   # Table definitions, procedures, and trigger
├── insertions.sql               # Sample dataset — doctors, patients, drugs, pharmacies, prescriptions
└── docs/
    └── project_specification.pdf   # Original assignment brief
```

---

## Running the Project

**Requirements:**
- Oracle Database (tested on Oracle XE / 19c)
- SQL*Plus or any Oracle-compatible client (SQL Developer, DBeaver)

**Setup:**

```sql
-- 1. Connect to your Oracle instance
sqlplus username/password@database

-- 2. Enable DBMS_OUTPUT to see report output
SET SERVEROUTPUT ON;

-- 3. Run the schema script (creates tables, procedures, trigger)
@schema.sql

-- 4. Populate with sample data
@insertions.sql
```

After this, the database is ready to query. Example calls are in the next section.

## Sample Workflows

**Look up all prescriptions for a patient in a date range:**
```sql
EXEC Prescription_Report('666666666666',
    TO_DATE('2025-04-01','YYYY-MM-DD'),
    TO_DATE('2025-04-15','YYYY-MM-DD'));
```

**See what a specific pharmacy stocks and charges:**
```sql
EXEC Print_Stock_Position('Apollo RX');
```

**List every patient under Dr. Asha Reddy's care:**
```sql
EXEC Print_Patients_For_Doctor('111111111111');
```

**Check contract details between a pharmacy and a company:**
```sql
EXEC Print_Contract_Details('Apollo RX', 'MediLife');
```

**Add a new prescription and its drugs:**
```sql
EXEC Insert_Prescription(116, '666666666666', '222222222222',
    TO_DATE('2025-04-20','YYYY-MM-DD'));
EXEC Insert_PrescriptionDrug(116, 'PainAway', 'MediLife', 3);
```

## Design Decisions

A few choices worth explaining:

- **Aadhar-based primary keys for people.** Using `AadharID` for both Patient and Doctor means we rely on a single, real-world unique identifier instead of inventing synthetic IDs. In a real production system this would need careful privacy handling, but for an academic project it keeps the schema tight.

- **Composite primary key on `Drug`.** `(TradeName, CompanyName)` rather than an artificial `DrugID` because trade names aren't globally unique — "PainAway" by MediLife and "PainAway" by a different company would be different drugs. Modeling this honestly required the composite key.

- **Cascade deletes used selectively.** We use `ON DELETE CASCADE` where the assignment explicitly requires it (company → drugs) and where records are clearly dependent (prescription → prescription drugs). For business-critical data like `Sales`, deletions are governed by a trigger instead, so accidental or malicious deletes can't silently strip a pharmacy bare.

- **`Sales` table stores price, not `Drug`.** The same drug can be sold at different prices at different pharmacies. Putting price on `Drug` would have denormalized the schema and lost this flexibility.

---

## Team

**Course assignment — CS F212 Database Systems, BITS Pilani Hyderabad Campus, April 2025**

- Nayonika R Narayanan
- [TEAMMATES TO BE ADDED]

---

*Course: CS F212 Database Systems · Second Semester 2024–25*
