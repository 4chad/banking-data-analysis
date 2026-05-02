# 📖 Data Dictionary — Banking Data Analysis Project

This document describes all columns across the two source datasets and the star schema tables derived from them.

---

## 📂 Source Datasets

### 1. Bank_Data_Analystics.xlsx
> 65,535 rows | 52 columns | Loan and client flat file — normalized into star schema

### 2. Debit_and_Credit_banking_data.xlsx
> 1,00,000 rows | 12 columns | Customer debit/credit transaction records

---

## ⭐ Star Schema Tables

The `Bank_Data_Analystics.xlsx` flat file was normalized into the following tables using Excel Power Query and Power Pivot.

---

### 🔵 fact_Loan
> Core loan transaction table. Each row represents one loan account.

| Column | Data Type | Description | Example |
|---|---|---|---|
| `Account ID` | Text | Unique identifier for each loan account | 0010XLG01 |
| `Client id` | Integer | Foreign key linking to dim_Client | 2 |
| `Product Id` | Text | Foreign key linking to dim_Product | JLG30K |
| `Center Id` | Integer | Foreign key linking to dim_Location | 100186 |
| `Credif Officer Name` | Text | Foreign key linking to dim_Officer *(note: typo in source — mapped correctly)* | BHANU PRATAP |
| `Loan Status` | Text | Current status of the loan | Fully Paid, Charged Off, Current |
| `Loan Amount` | Integer | Total loan amount sanctioned (₹) | 5000 |
| `Funded Amount` | Integer | Amount actually funded to borrower (₹) | 5000 |
| `Funded Amount Inv` | Integer | Amount funded by investors (₹) | 4975 |
| `Term` | Text | Repayment term of the loan | 36 months, 60 months |
| `Int Rate` | Float | Annual interest rate on the loan (decimal) | 0.1065 = 10.65% |
| `Total Pymnt` | Float | Total payment received till date (₹) | 5863.15 |
| `Total Pymnt inv` | Float | Total payment received by investors (₹) | 5833.84 |
| `Total Rec Prncp` | Float | Total principal recovered (₹) | 5000.00 |
| `Total Fees` | Float | Total fees charged on the loan (₹) | 0.94 |
| `Total Rrec int` | Float | Total interest recovered (₹) *(note: typo in source — "Rrec")* | 863.16 |
| `Total Rec Late fee` | Integer | Total late fees recovered (₹) | 0 |
| `Recoveries` | Float | Post charge-off gross recovery amount (₹) | 117.08 |
| `Collection Recovery fee` | Float | Collection recovery fee charged (₹) | 1.11 |
| `Disbursement Date` | Date | Date the loan was disbursed | 08/09/2017 |
| `Disbursement Date (Years)` | Text | Financial year of disbursement (Indian FY) | FY 2018 |
| `Closed Date` | Date | Date the loan was closed | 11/09/2019 |
| `NextMeetingDate` | Date | Next scheduled meeting/repayment date | 11/03/2020 |
| `Loan Transferdate` | Text | Whether the loan was transferred | Yes / No |
| `Is Delinquent Loan` | Text | Whether the loan has been delinquent | Y / N |
| `Is Default Loan` | Text | Whether the loan has defaulted | Y / N |
| `Delinq 2 Yrs` | Integer | Number of delinquencies in past 2 years | 0 |
| `Application Type` | Text | Type of loan application | INDIVIDUAL |
| `Verification Status` | Text | Income verification status | Verified, Source Verified, Not Verified |
| `Tranfer Logic` | Text | Internal transfer flag *(note: typo in source — "Tranfer")* | Yes / No |

---

### 🟢 dim_Client
> Client demographic information. One row per unique client.

| Column | Data Type | Description | Example |
|---|---|---|---|
| `Client id` | Integer | Primary key — unique client identifier | 2 |
| `Client Name` | Text | Full name of the client | Meera Chopra |
| `Age` | Text | Age range of the client (stored as range in source) | 36-45 |
| `Age_T` | Integer | Actual numeric age of the client | 36 |
| `Dateof Birth` | Date | Date of birth of the client | 01/01/1981 |
| `Gender ID` | Text | Gender of the client | Female, Male |
| `Caste` | Text | Social category of the client | OBC, SC, General |
| `Religion` | Text | Religion of the client | Christian, Hindu, Muslim |
| `Home Ownership` | Text | Client's home ownership status | RENT, OWN, MORTGAGE |
| `Close Client` | Text | Whether the client account is closed | YES / NO |

---

### 🟢 dim_Location
> Branch and geographic information. One row per unique branch/center.

| Column | Data Type | Description | Example |
|---|---|---|---|
| `Center Id` | Integer | Primary key — unique center/branch identifier | 100186 |
| `Branch Name` | Text | Name of the bank branch | PATIALA |
| `City` | Text | City where the branch is located | PATIALA |
| `Region Name` | Text | Regional grouping of branches | LUDHIANA |
| `State Name` | Text | Full name of the state | PUNJAB |
| `State Abbr` | Text | Two-letter state abbreviation | PB |

---

### 🟢 dim_Product
> Loan product details. One row per unique product.

| Column | Data Type | Description | Example |
|---|---|---|---|
| `Product Id` | Text | Primary key — unique loan product identifier | JLG30K |
| `Product Code` | Text | Short code for the product type | XLG |
| `Grrade` | Text | Loan grade assigned to product *(note: typo in source — "Grrade")* | A, B, C, D |
| `Sub Grade` | Text | Sub-classification of the loan grade | B2, C4, C5 |
| `Purpose Category` | Text | Category of the loan's intended purpose | Services, Agriculture, Trade |

---

### 🟢 dim_Officer
> Loan officer information. One row per unique officer.

| Column | Data Type | Description | Example |
|---|---|---|---|
| `Credif Officer Name` | Text | Primary key — loan officer name *(note: typo in source — "Credif")* | BHANU PRATAP |
| `Disb By` | Text | Name of the officer who disbursed the loan | AKSHAY GUPTA |
| `BH Name` | Text | Branch Head name with ID prefix | 10420-MUNENDRA SINGH |
| `Bank Name` | Text | Name of the bank | 102-DBS |

---

## 💳 Debit_and_Credit_banking_data.xlsx

> Standalone transaction dataset. Not part of the star schema — used separately for transaction trend analysis in Tableau and Power BI.

| Column | Data Type | Description | Example |
|---|---|---|---|
| `Customer ID` | Text | Unique UUID identifier for each customer | db8b5d5f-995e-443d-... |
| `Customer Name` | Text | Full name of the customer | Justin Larson |
| `Account Number` | Integer | Bank account number of the customer | 6544894329 |
| `Transaction Date` | Date | Date the transaction occurred | 22/04/2024 |
| `Transaction Type` | Text | Whether money came in or went out | Credit, Debit |
| `Amount` | Float | Transaction amount (₹) | 2141.73 |
| `Balance` | Float | Account balance after the transaction (₹) | 9794.41 |
| `Description` | Text | Brief description of the transaction | Bonus Payment, Online Shopping |
| `Branch` | Text | Bank branch where transaction occurred | Main Branch, City Center Branch |
| `Transaction Method` | Text | Mode of transaction | Credit Card, Bank Transfer, UPI |
| `Currency` | Text | Currency of the transaction | INR |
| `Bank Name` | Text | Name of the bank | Axis Bank, Kotak Mahindra Bank |

---

## ⚠️ Data Quality Notes

These issues were identified in the source data and handled during Power Query cleaning:

| Issue | Column | Action Taken |
|---|---|---|
| Typo in column name | `Credif Officer Name` (should be Credit) | Mapped correctly in dim_Officer |
| Typo in column name | `Grrade` (should be Grade) | Retained as-is, documented here |
| Typo in column name | `Total Rrec int` (should be Rec) | Retained as-is, documented here |
| Typo in column name | `Tranfer Logic` (should be Transfer) | Retained as-is, documented here |
| Age stored as range | `Age` column (e.g. 36-45) | Kept range in dim_Client; numeric age in `Age_T` |
| Duplicate state column | Both ` State Abbr` and `State Abbr` exist | Leading space removed; deduplicated in dim_Location |
| Non-uniform date formats | `Disbursement Date`, `Closed Date` | Standardised to DD/MM/YYYY in Power Query |
| Non-unique Product IDs | `Product Id` had inconsistencies | Cleaned and deduplicated in dim_Product |

---

*Last updated: 2026 | Author: Sanskar*
