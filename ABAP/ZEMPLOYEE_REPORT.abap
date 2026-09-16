*&---------------------------------------------------------------------*
*& Report ZEMPLOYEE_REPORT
*&---------------------------------------------------------------------*
*& Description: Main Employee Report with Selection Screen
*& Author:      MCA Student Project
*& Date:        2026
*& Purpose:     Display, search, and filter employee records
*&              Demonstrates: Selection Screen, Open SQL, Internal
*&              Tables, Work Areas, Modularization, Basic OOP
*&---------------------------------------------------------------------*
REPORT zemployee_report.

*----------------------------------------------------------------------*
* SELECTION SCREEN - User Input Parameters
*----------------------------------------------------------------------*
* Parameters and Select-Options allow users to filter data.
* All fields are OPTIONAL so the user can see all records
* by pressing Execute (F8) without entering anything.

* BLOCK b1 creates a visual frame around the selection fields
* NOTE: After creating this program in SE38, set the text element:
*   Goto → Text Elements → Selection Texts → TEXT-001 = 'Employee Search Criteria'
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

* p_empid: User can enter a specific Employee ID
PARAMETERS: p_empid TYPE zemployee-emp_id OPTIONAL.

* p_dept: User can enter a department name to filter
PARAMETERS: p_dept  TYPE zemployee-department OPTIONAL.

* p_stat: User can enter status (ACTIVE or INACTIVE)
PARAMETERS: p_stat  TYPE zemployee-status OPTIONAL.

SELECTION-SCREEN END OF BLOCK b1.

*----------------------------------------------------------------------*
* DATA DECLARATIONS
*----------------------------------------------------------------------*
* Internal table: holds MULTIPLE employee records from the database
DATA: lt_employee TYPE TABLE OF zemployee.

* Work area: holds ONE employee record at a time during processing
DATA: ls_employee TYPE zemployee.

* Variables for statistics
DATA: lv_total    TYPE i,          "Total number of employees
      lv_sum      TYPE p DECIMALS 2, "Sum of all salaries
      lv_average  TYPE p DECIMALS 2. "Average salary

*----------------------------------------------------------------------*
* LOCAL CLASS DEFINITION - Basic OOP Demonstration
*----------------------------------------------------------------------*
* This local class demonstrates basic Object-Oriented ABAP.
* It has one attribute and one method.

CLASS lcl_employee DEFINITION.
  PUBLIC SECTION.

    "Method to get the total count of employees in the table
    METHODS: get_employee_count
               RETURNING VALUE(rv_count) TYPE i.

    "Method to display a welcome message
    METHODS: display_header.

ENDCLASS.

*----------------------------------------------------------------------*
* LOCAL CLASS IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lcl_employee IMPLEMENTATION.

  METHOD get_employee_count.
    "This method counts all records in the ZEMPLOYEE table
    SELECT COUNT(*)
      FROM zemployee
      INTO rv_count.
  ENDMETHOD.

  METHOD display_header.
    WRITE: / '======================================================'.
    WRITE: / '    SAP ABAP Employee Management & Reporting System'.
    WRITE: / '======================================================'.
    SKIP.
  ENDMETHOD.

ENDCLASS.

*----------------------------------------------------------------------*
* START-OF-SELECTION - Main Processing Block
*----------------------------------------------------------------------*
START-OF-SELECTION.

* Create an object of our local class (NEW is the modern syntax since ABAP 7.40)
  DATA(lo_emp) = NEW lcl_employee( ).

* Display the report header using our OOP method
  lo_emp->display_header( ).

* Display total employee count using OOP method
  DATA(lv_emp_count) = lo_emp->get_employee_count( ).
  WRITE: / 'Total Records in Database:', lv_emp_count.
  SKIP.

* Call modularized subroutines using PERFORM
  PERFORM get_employee_data.
  PERFORM display_employee_data.
  PERFORM calculate_statistics.

*----------------------------------------------------------------------*
* FORM get_employee_data - Retrieve data from database
*----------------------------------------------------------------------*
* This subroutine builds the SELECT query based on user input.
* It demonstrates Open SQL and dynamic filtering.
*----------------------------------------------------------------------*
FORM get_employee_data.

* ==============================================================
* DEBUGGER TIP: Set a BREAKPOINT on the SELECT statement below.
* This lets you inspect the SQL query and the data it returns.
* In SE38, click on the line and press the Breakpoint button.
* ==============================================================

* CASE 1: If Employee ID is provided, search by ID only
  IF p_empid IS NOT INITIAL.

    SELECT * FROM zemployee
      INTO TABLE lt_employee
      WHERE emp_id = p_empid.

* CASE 2: If Department and Status are both provided
  ELSEIF p_dept IS NOT INITIAL AND p_stat IS NOT INITIAL.

    SELECT * FROM zemployee
      INTO TABLE lt_employee
      WHERE department = p_dept
        AND status     = p_stat.

* CASE 3: If only Department is provided
  ELSEIF p_dept IS NOT INITIAL.

    SELECT * FROM zemployee
      INTO TABLE lt_employee
      WHERE department = p_dept.

* CASE 4: If only Status is provided
  ELSEIF p_stat IS NOT INITIAL.

    SELECT * FROM zemployee
      INTO TABLE lt_employee
      WHERE status = p_stat.

* CASE 5: No filters - get ALL employees
  ELSE.

    SELECT * FROM zemployee
      INTO TABLE lt_employee.

  ENDIF.

* Check if any records were found
  IF sy-subrc <> 0.
    WRITE: / 'No employee records found for the given criteria.'.
  ENDIF.

ENDFORM.

*----------------------------------------------------------------------*
* FORM display_employee_data - Display employee records
*----------------------------------------------------------------------*
* This subroutine loops through the internal table and displays
* each employee record using the WRITE statement.
*----------------------------------------------------------------------*
FORM display_employee_data.

* Check if there is data to display
  IF lt_employee IS INITIAL.
    WRITE: / 'No data to display.'.
    RETURN.   "Exit the FORM if no data
  ENDIF.

* Display column headers
  WRITE: / '----------------------------------------------------------------------'.
  WRITE: / 'Emp ID',
        12 'Name',
        35 'Department',
        50 'Designation',
        72 'Salary',
        85 'Location',
        100 'Status'.
  WRITE: / '----------------------------------------------------------------------'.

* ==============================================================
* DEBUGGER TIP: Set a BREAKPOINT on the LOOP statement below.
* Step through each iteration to see how the work area (ls_employee)
* gets populated with one record at a time from the internal table.
* ==============================================================

* LOOP through internal table - each iteration puts one row into ls_employee
  LOOP AT lt_employee INTO ls_employee.

    WRITE: / ls_employee-emp_id,
          12 ls_employee-first_name,
          25 ls_employee-last_name,
          35 ls_employee-department,
          50 ls_employee-designation,
          72 ls_employee-salary CURRENCY 'INR',
          85 ls_employee-location,
         100 ls_employee-status.

  ENDLOOP.

  WRITE: / '----------------------------------------------------------------------'.

ENDFORM.

*----------------------------------------------------------------------*
* FORM calculate_statistics - Calculate and display salary statistics
*----------------------------------------------------------------------*
* This subroutine demonstrates basic data processing:
* counting records, summing values, and calculating averages.
*----------------------------------------------------------------------*
FORM calculate_statistics.

* Check if there is data to process
  IF lt_employee IS INITIAL.
    RETURN.
  ENDIF.

  SKIP.
  WRITE: / '==================== STATISTICS ===================='.

* Count total employees using lines() built-in function
  lv_total = lines( lt_employee ).
  WRITE: / 'Total Employees:', lv_total.

* Calculate total salary by looping through records
  CLEAR: lv_sum.
  LOOP AT lt_employee INTO ls_employee.
    lv_sum = lv_sum + ls_employee-salary.
  ENDLOOP.

  WRITE: / 'Total Salary:   ', lv_sum CURRENCY 'INR'.

* Calculate average salary
  IF lv_total > 0.
    lv_average = lv_sum / lv_total.
    WRITE: / 'Average Salary: ', lv_average CURRENCY 'INR'.
  ENDIF.

  WRITE: / '===================================================='.

ENDFORM.
