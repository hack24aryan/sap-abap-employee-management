# Debugging Guide for SAP ABAP

## What is Debugging?

Debugging is the process of **running your program step-by-step** to inspect how data flows through your code. In SAP, the built-in debugger lets you:

- Pause the program at specific lines (breakpoints)
- Inspect variable values
- View internal table contents
- Step through each line of code
- Find and fix errors (bugs)

## Why is Debugging Important?

- It helps you **understand** how your code executes.
- It helps you **find errors** in your logic.
- It's a skill that **interviewers frequently ask about**.
- Every SAP ABAP developer uses the debugger daily.

## How to Debug in SAP

### Step 1: Open Your Report

1. Go to transaction **SE38** (ABAP Editor).
2. Enter the program name: `ZEMPLOYEE_REPORT`.
3. Click **Display** or **Change**.

### Step 2: Set a Breakpoint

A **breakpoint** tells the debugger to pause at a specific line.

1. Find this line in the code:
   ```abap
   SELECT * FROM zemployee
     INTO TABLE lt_employee.
   ```
2. Place your cursor on this line.
3. Click the **Breakpoint** button (or press **Ctrl+Shift+F12** in the editor, or simply click on the left margin).
4. A small stop sign icon appears next to the line.

### Step 3: Execute the Program in Debug Mode

**Option A: Direct Debugging**
1. From SE38, press **F8** to execute the program.
2. On the Selection Screen, press **F8** again.
3. The program will stop at your breakpoint.

**Option B: Enter /h in Command Bar**
1. On the Selection Screen, type `/h` in the command bar.
2. Press Enter. You'll see: "Debugging is switched on."
3. Press **F8** to execute. The debugger will activate.

### Step 4: Inspect Data in the Debugger

When the debugger opens, you'll see:

```
┌────────────────────────────────────────────┐
│  ABAP Debugger                             │
│                                            │
│  Current Line: SELECT * FROM zemployee     │
│                INTO TABLE lt_employee.     │
│                                            │
│  Variables:                                │
│  ┌──────────────┬─────────┐               │
│  │ Variable     │ Value   │               │
│  ├──────────────┼─────────┤               │
│  │ p_empid      │         │  (empty)      │
│  │ p_dept       │ IT      │  (user input) │
│  │ p_stat       │         │  (empty)      │
│  │ sy-subrc     │ 0       │               │
│  └──────────────┴─────────┘               │
│                                            │
│  [F5] Step  [F6] Step Over  [F7] Return   │
│  [F8] Continue                             │
└────────────────────────────────────────────┘
```

#### Inspecting Variables
- Double-click on any variable name to see its value.
- Type a variable name in the **Variable** field at the bottom.

#### Inspecting Internal Tables
1. Double-click on `lt_employee` in the code.
2. Or type `lt_employee` in the variable field.
3. Click the **Table** button (or press Ctrl+Shift+F1) to see all rows.
4. You'll see something like:

```
┌───┬────────┬───────────┬────────────┬────────┐
│ # │ EMP_ID │ FIRST_NAME│ DEPARTMENT │ SALARY │
├───┼────────┼───────────┼────────────┼────────┤
│ 1 │ E1004  │ Sneha     │ IT         │ 52000  │
│ 2 │ E1006  │ Neha      │ IT         │ 55000  │
│ 3 │ E1010  │ Kavita    │ IT         │ 72000  │
│ 4 │ E1013  │ Manish    │ IT         │ 60000  │
└───┴────────┴───────────┴────────────┴────────┘
```

### Step 5: Step Through the Code

Use these keys to navigate:

| Key | Action | Description |
|-----|--------|-------------|
| **F5** | Single Step | Execute current line, go into FORM/METHOD |
| **F6** | Step Over | Execute current line, skip over FORM/METHOD |
| **F7** | Return | Run until current FORM/METHOD ends |
| **F8** | Continue | Run until next breakpoint or end of program |

### Step 6: Step Through the LOOP

1. Set a breakpoint on the LOOP statement:
   ```abap
   LOOP AT lt_employee INTO ls_employee.
   ```

2. Press **F5** to step into each iteration.

3. After each iteration, inspect `ls_employee` (the work area):
   - **First iteration:** ls_employee contains Employee E1001
   - **Second iteration:** ls_employee contains Employee E1002
   - And so on...

4. This shows how the LOOP reads **one row at a time** from the internal table into the work area.

## What to Observe at Each Stage

### At the SELECT Statement

| What to Check | Expected Behavior |
|---------------|-------------------|
| `lt_employee` before SELECT | Empty (0 rows) |
| `lt_employee` after SELECT | Filled with matching rows |
| `sy-subrc` after SELECT | 0 = records found, 4 = no records |
| `sy-dbcnt` after SELECT | Number of rows retrieved |

### Inside the LOOP

| What to Check | Expected Behavior |
|---------------|-------------------|
| `ls_employee` | Contains current row's data |
| `sy-tabix` | Current loop iteration number (1, 2, 3...) |
| `ls_employee-emp_id` | Employee ID of current row |
| `ls_employee-salary` | Salary of current employee |

### At calculate_statistics

| What to Check | Expected Behavior |
|---------------|-------------------|
| `lv_total` | Total number of employees |
| `lv_sum` | Running total of salaries |
| `lv_average` | Calculated average salary |

## Common Debugging Tips

1. **Start simple:** Debug with no filters first to see all data.
2. **Check sy-subrc:** After every database operation, check if it was successful (0 = success).
3. **Use watchpoints:** Right-click a variable → Set Watchpoint → Program pauses when the value changes.
4. **Don't panic:** If you get stuck in the debugger, press **F8** repeatedly to continue, or close the session.
5. **Practice:** The more you debug, the better you understand ABAP.

## Recommended Debugging Exercise

1. Open `ZEMPLOYEE_REPORT` in SE38.
2. Set breakpoints at:
   - The `SELECT` statement in `get_employee_data`
   - The `LOOP` statement in `display_employee_data`
   - The salary addition line in `calculate_statistics`
3. Execute with Department = 'IT'.
4. At each breakpoint:
   - Check the internal table contents.
   - Check the work area values.
   - Check the counter/sum variables.
5. Step through 2-3 loop iterations to see data flow.

This exercise will give you a deep understanding of how ABAP processes data!
