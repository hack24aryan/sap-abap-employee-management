# Project Architecture

## System Architecture Overview

This project follows a simple **3-tier architecture** commonly used in SAP ABAP development:

```
┌─────────────────────────────────────────────┐
│              PRESENTATION LAYER             │
│         (Selection Screen + Report)         │
│                                             │
│  User enters filter criteria on the         │
│  Selection Screen and views the output      │
│  in the ABAP Report display.                │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│             APPLICATION LAYER               │
│          (ABAP Report Programs)             │
│                                             │
│  ABAP code processes the request:           │
│  - Reads user input from Selection Screen   │
│  - Builds Open SQL queries                  │
│  - Processes data using Internal Tables     │
│  - Calculates statistics                    │
│  - Formats and displays output              │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│              DATABASE LAYER                 │
│           (SAP HANA / Database)             │
│                                             │
│  ZEMPLOYEE transparent table stores         │
│  all employee records persistently.         │
│  Accessed via Open SQL statements.          │
└─────────────────────────────────────────────┘
```

## Program Flow

### ZEMPLOYEE_REPORT (Main Report)

```
 User Opens Report (SE38 / SA38)
          │
          ▼
 ┌──────────────────┐
 │ Selection Screen │  ← User enters filters:
 │                  │     Employee ID, Department, Status
 └────────┬─────────┘
          │ User presses F8 (Execute)
          ▼
 ┌──────────────────┐
 │  get_employee_   │  ← PERFORM calls this FORM routine
 │  data            │     Builds SELECT query based on filters
 └────────┬─────────┘
          │
          ▼
 ┌──────────────────┐
 │   Open SQL       │  ← SELECT * FROM zemployee
 │   SELECT         │     WHERE conditions based on user input
 └────────┬─────────┘
          │
          ▼
 ┌──────────────────┐
 │  Internal Table  │  ← lt_employee stores all matching rows
 │  (lt_employee)   │     Data moves from database to memory
 └────────┬─────────┘
          │
          ▼
 ┌──────────────────┐
 │  display_        │  ← PERFORM calls this FORM routine
 │  employee_data   │     LOOPs through internal table
 └────────┬─────────┘
          │
          ▼
 ┌──────────────────┐
 │  Work Area       │  ← ls_employee holds ONE row at a time
 │  (ls_employee)   │     WRITE displays each row
 └────────┬─────────┘
          │
          ▼
 ┌──────────────────┐
 │  calculate_      │  ← PERFORM calls this FORM routine
 │  statistics      │     Counts employees, calculates average
 └────────┬─────────┘
          │
          ▼
 ┌──────────────────┐
 │  Report Output   │  ← Final display with employee list
 │                  │     and summary statistics
 └──────────────────┘
```

### ZDEPARTMENT_REPORT

```
 User Opens Report
          │
          ▼
 ┌──────────────────┐
 │ Fetch All        │  ← SELECT * FROM zemployee
 │ Employees        │
 └────────┬─────────┘
          │
          ▼
 ┌──────────────────┐
 │ Build Summary    │  ← Group employees by department
 │ by Department    │     Calculate count and total salary
 └────────┬─────────┘
          │
          ▼
 ┌──────────────────┐
 │ Calculate        │  ← Average = Total Salary / Count
 │ Averages         │     for each department
 └────────┬─────────┘
          │
          ▼
 ┌──────────────────┐
 │ Display          │  ← Department | Count | Avg Salary
 │ Summary Report   │
 └──────────────────┘
```

## Component Roles

### 1. Selection Screen
- **What:** A user interface that appears before the report runs.
- **Role:** Accepts filter criteria from the user (Employee ID, Department, Status).
- **Why:** Allows the user to narrow down results without changing the code.

### 2. ABAP Report Programs
- **What:** Executable programs written in ABAP.
- **Role:** Contains all the business logic — data retrieval, processing, and display.
- **Programs in this project:**
  - `ZEMPLOYEE_TEST_DATA` — Inserts sample data
  - `ZEMPLOYEE_REPORT` — Main employee report with filtering
  - `ZDEPARTMENT_REPORT` — Department-wise summary

### 3. Open SQL
- **What:** SAP's database-independent SQL syntax.
- **Role:** Communicates with the database to read (SELECT), insert (INSERT), update (UPDATE), or delete (DELETE) records.
- **Why:** Open SQL works across all SAP-supported databases (HANA, Oracle, SQL Server, etc.).

### 4. ZEMPLOYEE Table
- **What:** A custom transparent table in the SAP Data Dictionary.
- **Role:** Persistent storage for employee master data.
- **Why:** Data remains available even after the program ends.

### 5. Internal Tables
- **What:** In-memory tables within an ABAP program.
- **Role:** Temporarily hold data retrieved from the database for processing.
- **Example:** `lt_employee` holds all matching employee records.

### 6. Work Areas
- **What:** A single-row structure that matches the table's structure.
- **Role:** Used to process one record at a time during a LOOP.
- **Example:** `ls_employee` holds one employee's data during each loop iteration.

### 7. FORM Routines (Modularization)
- **What:** Named blocks of reusable code.
- **Role:** Break the program into logical sections for readability.
- **Routines in this project:**
  - `get_employee_data` — Database retrieval
  - `display_employee_data` — Output formatting
  - `calculate_statistics` — Data analysis

### 8. Local Class (OOP)
- **What:** A class defined within the report program.
- **Role:** Demonstrates basic Object-Oriented ABAP concepts.
- **Class:** `lcl_employee` with methods `get_employee_count` and `display_header`.

## File Overview

| File | Purpose | Key Concepts |
|------|---------|---------------|
| ZEMPLOYEE_TEST_DATA.abap | Insert sample data | INSERT, Internal Tables |
| ZEMPLOYEE_REPORT.abap | Main report | Selection Screen, Open SQL, LOOP, FORM, OOP |
| ZDEPARTMENT_REPORT.abap | Department summary | Aggregation, TYPES, READ TABLE, MODIFY |
| ZEMPLOYEE Table | Data storage | Data Dictionary, Transparent Table |
