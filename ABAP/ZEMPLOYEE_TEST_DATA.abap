*&---------------------------------------------------------------------*
*& Report ZEMPLOYEE_TEST_DATA
*&---------------------------------------------------------------------*
*& Description: Inserts sample employee data into ZEMPLOYEE table
*& Author:      MCA Student Project
*& Date:        2026
*& Purpose:     Populate ZEMPLOYEE with 15 test records for development
*&---------------------------------------------------------------------*
REPORT zemployee_test_data.

*----------------------------------------------------------------------*
* DATA DECLARATIONS
*----------------------------------------------------------------------*
* Work area to hold one employee record at a time
DATA: ls_employee TYPE zemployee.

* Internal table to hold all sample employee records
DATA: lt_employee TYPE TABLE OF zemployee.

* Variable to count how many records were inserted
DATA: lv_count TYPE i.

*----------------------------------------------------------------------*
* START-OF-SELECTION - Main processing block
*----------------------------------------------------------------------*
START-OF-SELECTION.

  WRITE: / '============================================'.
  WRITE: / '  ZEMPLOYEE - Sample Data Insertion Program'.
  WRITE: / '============================================'.
  SKIP.

*----------------------------------------------------------------------*
* STEP 1: Clear any existing test data (optional safety step)
*----------------------------------------------------------------------*
* WARNING: This DELETE removes ALL records from the table.
* In a real SAP system, be very careful with DELETE statements.
  DELETE FROM zemployee.

  IF sy-subrc = 0.
    WRITE: / 'Existing data cleared successfully.'.
  ENDIF.

*----------------------------------------------------------------------*
* STEP 2: Prepare sample employee records
*----------------------------------------------------------------------*
* Each CLEAR resets the work area before filling it with new data.
* Each APPEND adds the work area content to the internal table.

* --- Employee 1 ---
  CLEAR ls_employee.
  ls_employee-mandt       = sy-mandt.       "Current client
  ls_employee-emp_id      = 'E1001'.
  ls_employee-first_name  = 'Rahul'.
  ls_employee-last_name   = 'Kumar'.
  ls_employee-email       = 'rahul.kumar@company.com'.
  ls_employee-phone       = '9876543210'.
  ls_employee-department  = 'IT'.
  ls_employee-designation = 'Software Developer'.
  ls_employee-salary      = 45000.
  ls_employee-joining_date = '20230115'.     "YYYYMMDD format
  ls_employee-location    = 'Noida'.
  ls_employee-status      = 'ACTIVE'.
  APPEND ls_employee TO lt_employee.

* --- Employee 2 ---
  CLEAR ls_employee.
  ls_employee-mandt       = sy-mandt.
  ls_employee-emp_id      = 'E1002'.
  ls_employee-first_name  = 'Priya'.
  ls_employee-last_name   = 'Singh'.
  ls_employee-email       = 'priya.singh@company.com'.
  ls_employee-phone       = '9876543211'.
  ls_employee-department  = 'HR'.
  ls_employee-designation = 'HR Executive'.
  ls_employee-salary      = 38000.
  ls_employee-joining_date = '20230301'.
  ls_employee-location    = 'Delhi'.
  ls_employee-status      = 'ACTIVE'.
  APPEND ls_employee TO lt_employee.

* --- Employee 3 ---
  CLEAR ls_employee.
  ls_employee-mandt       = sy-mandt.
  ls_employee-emp_id      = 'E1003'.
  ls_employee-first_name  = 'Amit'.
  ls_employee-last_name   = 'Sharma'.
  ls_employee-email       = 'amit.sharma@company.com'.
  ls_employee-phone       = '9876543212'.
  ls_employee-department  = 'Finance'.
  ls_employee-designation = 'Accountant'.
  ls_employee-salary      = 42000.
  ls_employee-joining_date = '20220610'.
  ls_employee-location    = 'Noida'.
  ls_employee-status      = 'ACTIVE'.
  APPEND ls_employee TO lt_employee.

* --- Employee 4 ---
  CLEAR ls_employee.
  ls_employee-mandt       = sy-mandt.
  ls_employee-emp_id      = 'E1004'.
  ls_employee-first_name  = 'Sneha'.
  ls_employee-last_name   = 'Patel'.
  ls_employee-email       = 'sneha.patel@company.com'.
  ls_employee-phone       = '9876543213'.
  ls_employee-department  = 'IT'.
  ls_employee-designation = 'ABAP Developer'.
  ls_employee-salary      = 52000.
  ls_employee-joining_date = '20210805'.
  ls_employee-location    = 'Bangalore'.
  ls_employee-status      = 'ACTIVE'.
  APPEND ls_employee TO lt_employee.

* --- Employee 5 ---
  CLEAR ls_employee.
  ls_employee-mandt       = sy-mandt.
  ls_employee-emp_id      = 'E1005'.
  ls_employee-first_name  = 'Vikram'.
  ls_employee-last_name   = 'Reddy'.
  ls_employee-email       = 'vikram.reddy@company.com'.
  ls_employee-phone       = '9876543214'.
  ls_employee-department  = 'Sales'.
  ls_employee-designation = 'Sales Executive'.
  ls_employee-salary      = 35000.
  ls_employee-joining_date = '20230720'.
  ls_employee-location    = 'Hyderabad'.
  ls_employee-status      = 'ACTIVE'.
  APPEND ls_employee TO lt_employee.

* --- Employee 6 ---
  CLEAR ls_employee.
  ls_employee-mandt       = sy-mandt.
  ls_employee-emp_id      = 'E1006'.
  ls_employee-first_name  = 'Neha'.
  ls_employee-last_name   = 'Gupta'.
  ls_employee-email       = 'neha.gupta@company.com'.
  ls_employee-phone       = '9876543215'.
  ls_employee-department  = 'IT'.
  ls_employee-designation = 'System Analyst'.
  ls_employee-salary      = 55000.
  ls_employee-joining_date = '20200415'.
  ls_employee-location    = 'Pune'.
  ls_employee-status      = 'ACTIVE'.
  APPEND ls_employee TO lt_employee.

* --- Employee 7 ---
  CLEAR ls_employee.
  ls_employee-mandt       = sy-mandt.
  ls_employee-emp_id      = 'E1007'.
  ls_employee-first_name  = 'Rajesh'.
  ls_employee-last_name   = 'Verma'.
  ls_employee-email       = 'rajesh.verma@company.com'.
  ls_employee-phone       = '9876543216'.
  ls_employee-department  = 'Finance'.
  ls_employee-designation = 'Finance Manager'.
  ls_employee-salary      = 65000.
  ls_employee-joining_date = '20190301'.
  ls_employee-location    = 'Delhi'.
  ls_employee-status      = 'ACTIVE'.
  APPEND ls_employee TO lt_employee.

* --- Employee 8 ---
  CLEAR ls_employee.
  ls_employee-mandt       = sy-mandt.
  ls_employee-emp_id      = 'E1008'.
  ls_employee-first_name  = 'Anjali'.
  ls_employee-last_name   = 'Mishra'.
  ls_employee-email       = 'anjali.mishra@company.com'.
  ls_employee-phone       = '9876543217'.
  ls_employee-department  = 'HR'.
  ls_employee-designation = 'HR Manager'.
  ls_employee-salary      = 58000.
  ls_employee-joining_date = '20200901'.
  ls_employee-location    = 'Noida'.
  ls_employee-status      = 'ACTIVE'.
  APPEND ls_employee TO lt_employee.

* --- Employee 9 ---
  CLEAR ls_employee.
  ls_employee-mandt       = sy-mandt.
  ls_employee-emp_id      = 'E1009'.
  ls_employee-first_name  = 'Suresh'.
  ls_employee-last_name   = 'Yadav'.
  ls_employee-email       = 'suresh.yadav@company.com'.
  ls_employee-phone       = '9876543218'.
  ls_employee-department  = 'Sales'.
  ls_employee-designation = 'Sales Manager'.
  ls_employee-salary      = 48000.
  ls_employee-joining_date = '20210612'.
  ls_employee-location    = 'Mumbai'.
  ls_employee-status      = 'ACTIVE'.
  APPEND ls_employee TO lt_employee.

* --- Employee 10 ---
  CLEAR ls_employee.
  ls_employee-mandt       = sy-mandt.
  ls_employee-emp_id      = 'E1010'.
  ls_employee-first_name  = 'Kavita'.
  ls_employee-last_name   = 'Joshi'.
  ls_employee-email       = 'kavita.joshi@company.com'.
  ls_employee-phone       = '9876543219'.
  ls_employee-department  = 'IT'.
  ls_employee-designation = 'Technical Lead'.
  ls_employee-salary      = 72000.
  ls_employee-joining_date = '20180905'.
  ls_employee-location    = 'Bangalore'.
  ls_employee-status      = 'ACTIVE'.
  APPEND ls_employee TO lt_employee.

* --- Employee 11 ---
  CLEAR ls_employee.
  ls_employee-mandt       = sy-mandt.
  ls_employee-emp_id      = 'E1011'.
  ls_employee-first_name  = 'Deepak'.
  ls_employee-last_name   = 'Chauhan'.
  ls_employee-email       = 'deepak.chauhan@company.com'.
  ls_employee-phone       = '9876543220'.
  ls_employee-department  = 'Finance'.
  ls_employee-designation = 'Junior Accountant'.
  ls_employee-salary      = 32000.
  ls_employee-joining_date = '20240201'.
  ls_employee-location    = 'Noida'.
  ls_employee-status      = 'ACTIVE'.
  APPEND ls_employee TO lt_employee.

* --- Employee 12 ---
  CLEAR ls_employee.
  ls_employee-mandt       = sy-mandt.
  ls_employee-emp_id      = 'E1012'.
  ls_employee-first_name  = 'Pooja'.
  ls_employee-last_name   = 'Agarwal'.
  ls_employee-email       = 'pooja.agarwal@company.com'.
  ls_employee-phone       = '9876543221'.
  ls_employee-department  = 'HR'.
  ls_employee-designation = 'Recruiter'.
  ls_employee-salary      = 36000.
  ls_employee-joining_date = '20230515'.
  ls_employee-location    = 'Gurugram'.
  ls_employee-status      = 'INACTIVE'.
  APPEND ls_employee TO lt_employee.

* --- Employee 13 ---
  CLEAR ls_employee.
  ls_employee-mandt       = sy-mandt.
  ls_employee-emp_id      = 'E1013'.
  ls_employee-first_name  = 'Manish'.
  ls_employee-last_name   = 'Tiwari'.
  ls_employee-email       = 'manish.tiwari@company.com'.
  ls_employee-phone       = '9876543222'.
  ls_employee-department  = 'IT'.
  ls_employee-designation = 'Database Admin'.
  ls_employee-salary      = 60000.
  ls_employee-joining_date = '20200110'.
  ls_employee-location    = 'Pune'.
  ls_employee-status      = 'INACTIVE'.
  APPEND ls_employee TO lt_employee.

* --- Employee 14 ---
  CLEAR ls_employee.
  ls_employee-mandt       = sy-mandt.
  ls_employee-emp_id      = 'E1014'.
  ls_employee-first_name  = 'Ritu'.
  ls_employee-last_name   = 'Saxena'.
  ls_employee-email       = 'ritu.saxena@company.com'.
  ls_employee-phone       = '9876543223'.
  ls_employee-department  = 'Sales'.
  ls_employee-designation = 'Sales Coordinator'.
  ls_employee-salary      = 33000.
  ls_employee-joining_date = '20240315'.
  ls_employee-location    = 'Jaipur'.
  ls_employee-status      = 'ACTIVE'.
  APPEND ls_employee TO lt_employee.

* --- Employee 15 ---
  CLEAR ls_employee.
  ls_employee-mandt       = sy-mandt.
  ls_employee-emp_id      = 'E1015'.
  ls_employee-first_name  = 'Arun'.
  ls_employee-last_name   = 'Nair'.
  ls_employee-email       = 'arun.nair@company.com'.
  ls_employee-phone       = '9876543224'.
  ls_employee-department  = 'Finance'.
  ls_employee-designation = 'Tax Analyst'.
  ls_employee-salary      = 46000.
  ls_employee-joining_date = '20220801'.
  ls_employee-location    = 'Chennai'.
  ls_employee-status      = 'ACTIVE'.
  APPEND ls_employee TO lt_employee.

*----------------------------------------------------------------------*
* STEP 3: Insert all records into the database table
*----------------------------------------------------------------------*
* INSERT ... FROM TABLE inserts all rows from the internal table
* into the database table ZEMPLOYEE in one operation.

  INSERT zemployee FROM TABLE lt_employee.

* sy-subrc = 0 means the insert was successful
* sy-dbcnt contains the number of rows inserted
  IF sy-subrc = 0.
    lv_count = sy-dbcnt.
    WRITE: / 'SUCCESS: ', lv_count, ' employee records inserted.'.
  ELSE.
    WRITE: / 'ERROR: Could not insert records. Check for duplicates.'.
  ENDIF.

  SKIP.
  WRITE: / '============================================'.
  WRITE: / '  Data insertion complete.'.
  WRITE: / '============================================'.
