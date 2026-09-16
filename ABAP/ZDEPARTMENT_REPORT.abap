*&---------------------------------------------------------------------*
*& Report ZDEPARTMENT_REPORT
*&---------------------------------------------------------------------*
*& Description: Department-wise Employee Summary Report
*& Author:      MCA Student Project
*& Date:        2026
*& Purpose:     Display employee count and average salary per department
*&              Demonstrates: Internal Tables, Aggregation, LOOP,
*&              COLLECT, and basic data processing
*&---------------------------------------------------------------------*
REPORT zdepartment_report.

*----------------------------------------------------------------------*
* TYPE DEFINITIONS
*----------------------------------------------------------------------*
* Custom structure to hold department summary data
* We define our own type because we need fields that don't exist
* in the ZEMPLOYEE table (like employee count and average salary).

TYPES: BEGIN OF ty_dept_summary,
         department   TYPE zemployee-department, "Department name
         emp_count    TYPE i,          "Number of employees
         total_salary TYPE p DECIMALS 2, "Sum of salaries
         avg_salary   TYPE p DECIMALS 2, "Average salary
       END OF ty_dept_summary.

*----------------------------------------------------------------------*
* DATA DECLARATIONS
*----------------------------------------------------------------------*
* Internal table to hold all employee records from database
DATA: lt_employee TYPE TABLE OF zemployee.

* Work area for processing one employee at a time
DATA: ls_employee TYPE zemployee.

* Internal table to hold department summary
DATA: lt_dept_summary TYPE TABLE OF ty_dept_summary.

* Work area for department summary
DATA: ls_dept_summary TYPE ty_dept_summary.

* Variables
DATA: lv_total_emp TYPE i.  "Grand total of all employees

*----------------------------------------------------------------------*
* START-OF-SELECTION - Main Processing Block
*----------------------------------------------------------------------*
START-OF-SELECTION.

* Display report header
  WRITE: / '======================================================'.
  WRITE: / '       Department-wise Employee Summary Report'.
  WRITE: / '======================================================'.
  SKIP.

* Call modularized subroutines
  PERFORM fetch_employee_data.
  PERFORM build_department_summary.
  PERFORM display_department_report.

*----------------------------------------------------------------------*
* FORM fetch_employee_data - Get all employee records
*----------------------------------------------------------------------*
FORM fetch_employee_data.

* Fetch all employee records from ZEMPLOYEE table
  SELECT * FROM zemployee
    INTO TABLE lt_employee.

* Check if data exists
  IF sy-subrc <> 0.
    WRITE: / 'No employee data found in ZEMPLOYEE table.'.
    WRITE: / 'Please run ZEMPLOYEE_TEST_DATA first to insert sample data.'.
    STOP.  "Stop report execution
  ENDIF.

  lv_total_emp = lines( lt_employee ).
  WRITE: / 'Total employees found:', lv_total_emp.
  SKIP.

ENDFORM.

*----------------------------------------------------------------------*
* FORM build_department_summary - Process data by department
*----------------------------------------------------------------------*
* This subroutine demonstrates how to process data and build
* a summary using internal tables and loops.
*----------------------------------------------------------------------*
FORM build_department_summary.

* Loop through each employee record
  LOOP AT lt_employee INTO ls_employee.

    "Try to find if this department already exists in our summary table
    READ TABLE lt_dept_summary
      INTO ls_dept_summary
      WITH KEY department = ls_employee-department.

    IF sy-subrc = 0.
      "Department found - update existing entry
      ls_dept_summary-emp_count    = ls_dept_summary-emp_count + 1.
      ls_dept_summary-total_salary = ls_dept_summary-total_salary + ls_employee-salary.

      "Update the record in the internal table
      MODIFY lt_dept_summary FROM ls_dept_summary INDEX sy-tabix.

    ELSE.
      "New department - create a new entry
      CLEAR ls_dept_summary.
      ls_dept_summary-department   = ls_employee-department.
      ls_dept_summary-emp_count    = 1.
      ls_dept_summary-total_salary = ls_employee-salary.

      "Add to the summary table
      APPEND ls_dept_summary TO lt_dept_summary.
    ENDIF.

  ENDLOOP.

* Now calculate average salary for each department
  LOOP AT lt_dept_summary INTO ls_dept_summary.

    IF ls_dept_summary-emp_count > 0.
      ls_dept_summary-avg_salary = ls_dept_summary-total_salary
                                   / ls_dept_summary-emp_count.
    ENDIF.

    MODIFY lt_dept_summary FROM ls_dept_summary INDEX sy-tabix.

  ENDLOOP.

ENDFORM.

*----------------------------------------------------------------------*
* FORM display_department_report - Display the summary
*----------------------------------------------------------------------*
FORM display_department_report.

* Display column headers
  WRITE: / '--------------------------------------------------------------'.
  WRITE: / 'Department',
        22 'Employees',
        35 'Total Salary',
        55 'Average Salary'.
  WRITE: / '--------------------------------------------------------------'.

* Loop through department summary and display each row
  LOOP AT lt_dept_summary INTO ls_dept_summary.

    WRITE: / ls_dept_summary-department,
          22 ls_dept_summary-emp_count,
          35 ls_dept_summary-total_salary CURRENCY 'INR',
          55 ls_dept_summary-avg_salary CURRENCY 'INR'.

  ENDLOOP.

  WRITE: / '--------------------------------------------------------------'.

* Display grand total
  SKIP.
  WRITE: / 'Grand Total Employees:', lv_total_emp.
  WRITE: / '======================================================'.

ENDFORM.
