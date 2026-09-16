# ZEMPLOYEE - Custom Transparent Table

## Overview

The `ZEMPLOYEE` table is a **custom transparent table** created in the SAP Data Dictionary (SE11) to store employee information. In SAP, all custom objects start with **Z** or **Y** to distinguish them from standard SAP objects.

## Table Definition

| Field Name     | Data Type    | Length | Key | Description              |
|----------------|-------------|--------|-----|-------------------------|
| MANDT          | CLNT        | 3      | ✅  | Client (auto-filled)     |
| EMP_ID         | CHAR        | 10     | ✅  | Employee ID (Primary Key)|
| FIRST_NAME     | CHAR        | 30     |     | First Name               |
| LAST_NAME      | CHAR        | 30     |     | Last Name                |
| EMAIL          | CHAR        | 50     |     | Email Address            |
| PHONE          | CHAR        | 15     |     | Phone Number             |
| DEPARTMENT     | CHAR        | 20     |     | Department               |
| DESIGNATION    | CHAR        | 30     |     | Job Title/Designation    |
| SALARY         | CURR        | 13,2   |     | Monthly Salary (INR)     |
| JOINING_DATE   | DATS        | 8      |     | Date of Joining          |
| LOCATION       | CHAR        | 20     |     | Office Location          |
| STATUS         | CHAR        | 10     |     | ACTIVE or INACTIVE       |

> **Note:** MANDT (Client) is automatically included in SAP tables to support multi-client architecture. You don't need to manually fill this field — SAP handles it automatically.

## Key Fields

- **MANDT + EMP_ID** together form the **primary key** of this table.
- EMP_ID values follow the pattern: E1001, E1002, E1003, etc.

## Data Types Explained

| Data Type | Full Name             | Description                           |
|-----------|-----------------------|---------------------------------------|
| CLNT      | Client                | 3-digit SAP client number             |
| CHAR      | Character             | Text/string data                      |
| CURR      | Currency              | Monetary amount with decimal places   |
| DATS      | Date                  | Date in YYYYMMDD format               |

## How to Create ZEMPLOYEE in SAP (SE11)

### Step-by-Step Instructions

1. **Open Transaction SE11**
   - Enter `SE11` in the SAP command bar and press Enter.
   - This opens the **ABAP Dictionary** (Data Dictionary).

2. **Select "Database Table"**
   - In the radio button options, select **Database table**.
   - Enter the table name: `ZEMPLOYEE`.
   - Click **Create**.

3. **Enter Short Description**
   - Enter: `Custom Employee Master Data Table`

4. **Set Delivery Class**
   - Delivery Class: **A** (Application Table - master and transaction data)
   - Data Browser/Table View Maint.: **Display/Maintenance Allowed**

5. **Define Fields**
   - Go to the **Fields** tab.
   - Enter each field as shown in the table above.
   - For each field, specify:
     - **Field Name** (e.g., EMP_ID)
     - **Key** checkbox (check for MANDT and EMP_ID)
     - **Data Element** or built-in type
     - **Length**

6. **Technical Settings**
   - Click on **Technical Settings** button.
   - Data Class: **APPL0** (Master data, transparent tables)
   - Size Category: **0** (0 to 2,700 records expected)
   - Buffering: **Buffering not allowed** (for a simple project)
   - Click **Save** and go back.

7. **Save and Activate**
   - Press **Ctrl+S** to save.
   - Press **Ctrl+F3** to activate.
   - If prompted, assign it to a **package** (use `$TMP` for local/test objects).
   - The table is now created in the database!

8. **Verify the Table**
   - Go to transaction **SE16** or **SE16N**.
   - Enter table name `ZEMPLOYEE`.
   - The table should be empty and ready for data.

### Using Data Elements vs Built-in Types

For a beginner project, you can use **built-in types** directly:
- Instead of creating custom data elements, select **Built-in Type** checkbox
- Enter the data type and length directly

In a professional SAP project, you would create:
- **Domains** (define value ranges and technical properties)
- **Data Elements** (define field labels and documentation)
- **Table Fields** (reference the data elements)

For this beginner project, using built-in types is perfectly acceptable.

## Sample Data

| EMP_ID | FIRST_NAME | LAST_NAME | DEPARTMENT | DESIGNATION         | SALARY | LOCATION  | STATUS   |
|--------|------------|-----------|------------|---------------------|--------|-----------|----------|
| E1001  | Rahul      | Kumar     | IT         | Software Developer  | 45000  | Noida     | ACTIVE   |
| E1002  | Priya      | Singh     | HR         | HR Executive        | 38000  | Delhi     | ACTIVE   |
| E1003  | Amit       | Sharma    | Finance    | Accountant          | 42000  | Noida     | ACTIVE   |
| E1004  | Sneha      | Patel     | IT         | ABAP Developer      | 52000  | Bangalore | ACTIVE   |
| E1005  | Vikram     | Reddy     | Sales      | Sales Executive     | 35000  | Hyderabad | ACTIVE   |
| E1006  | Neha       | Gupta     | IT         | System Analyst      | 55000  | Pune      | ACTIVE   |
| E1007  | Rajesh     | Verma     | Finance    | Finance Manager     | 65000  | Delhi     | ACTIVE   |
| E1008  | Anjali     | Mishra    | HR         | HR Manager          | 58000  | Noida     | ACTIVE   |
| E1009  | Suresh     | Yadav     | Sales      | Sales Manager       | 48000  | Mumbai    | ACTIVE   |
| E1010  | Kavita     | Joshi     | IT         | Technical Lead      | 72000  | Bangalore | ACTIVE   |
| E1011  | Deepak     | Chauhan   | Finance    | Junior Accountant   | 32000  | Noida     | ACTIVE   |
| E1012  | Pooja      | Agarwal   | HR         | Recruiter           | 36000  | Gurugram  | INACTIVE |
| E1013  | Manish     | Tiwari    | IT         | Database Admin      | 60000  | Pune      | INACTIVE |
| E1014  | Ritu       | Saxena    | Sales      | Sales Coordinator   | 33000  | Jaipur    | ACTIVE   |
| E1015  | Arun       | Nair      | Finance    | Tax Analyst         | 46000  | Chennai   | ACTIVE   |

## How to View Data

1. Go to transaction **SE16N** (Data Browser).
2. Enter table name: `ZEMPLOYEE`.
3. Press **F8** (Execute).
4. All employee records will be displayed.

## Important Notes

- This table uses the **Z** prefix because it is a custom table.
- SAP standard tables do NOT start with Z or Y.
- The MANDT field ensures data is separated by SAP client.
- Always use `sy-mandt` when inserting data programmatically.
