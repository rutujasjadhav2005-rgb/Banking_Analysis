CREATE DATABASE BankingDB;
Use BankingDB;

-- Create customer table
CREATE TABLE Customers(
CustomerID INT,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Email VARCHAR(100),
Phone VARCHAR(15)
);

describe Customers;

-- Create Accounts table
CREATE  TABLE Accounts(
AccountID INT,
AccountType VARCHAR(20),
Balance DECIMAL(10,2)
);
describe Accounts;

-- Create Transactions Table
CREATE TABLE Transactions(
TransactionID INT,
TransactionDate DATE,
Amount DECIMAL(10,2),
TransactionType VARCHAR(20)
);
describe Transactions;

-- Create Branches table
CREATE TABLE Branches(
BranchID INT,
BranchName VARCHAR(100),
BranchAddress VARCHAR(200),
BranchPhone VARCHAR(15)
);
describe Branches;

-- Create AccountBranches Table
CREATE TABLE AccountBranches(
AssignmentDate DATE
);
describe AccountBranches;

-- Create Loans Table
CREATE TABLE Loans(
LoanID INT,
LoanAmount DECIMAL(10,2),
InterestRate DECIMAL(5,2),
StartDate DATE,
EndDate DATE
);
describe Loans;

-- Add new Column
ALTER TABLE Customers
ADD DateOfBirth DATE;
describe Customers;

-- Modify Existing Column
ALTER TABLE Customers
MODIFY Phone VARCHAR(20);

-- Add Constraint
ALTER TABLE Accounts
ADD CONSTRAINT chk_MinBalance
CHECK (Balance>=1000);

DROP TABLE AccountBranches;

-- Add Primary key constraint to customerID in customer table
ALTER TABLE Customers
ADD PRIMARY KEY (CustomerID);

-- Now Connect Accounts Table using CustomerID from Customers table
ALTER TABLE Accounts
ADD CustomerID INT;

ALTER TABLE Accounts
ADD CONSTRAINT FK_Accounts_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

-- Ensure that every customer must have a first name.
ALTER TABLE Customers
MODIFY FirstName VARCHAR(50) NOT NULL;

-- Ensure that each customer email is unique
ALTER TABLE Customers
ADD CONSTRAINT uq_email UNIQUE (Email);

-- Add Primary Keys
ALTER TABLE Accounts
ADD CONSTRAINT PK_Accounts
PRIMARY KEY (AccountID);

ALTER TABLE Transactions
ADD CONSTRAINT PK_Transactions
PRIMARY KEY (TransactionID);

ALTER TABLE Branches
ADD CONSTRAINT PK_Branches
PRIMARY KEY (BranchID);

ALTER TABLE Loans
ADD CONSTRAINT PK_Loans
PRIMARY KEY (LoanID);

-- Add Required Columns


ALTER TABLE Transactions
ADD AccountID INT;

ALTER TABLE Loans
ADD CustomerID INT;


ALTER TABLE Transactions
ADD CONSTRAINT FK_Transactions_Accounts
FOREIGN KEY (AccountID)
REFERENCES Accounts(AccountID);

ALTER TABLE Loans
ADD CONSTRAINT FK_Loans_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

ALTER TABLE Accounts
ADD BranchID INT;

ALTER TABLE Accounts
ADD CONSTRAINT FK_Accounts_Branches
FOREIGN KEY (BranchID)
REFERENCES Branches(BranchID);

-- SQ3

-- INSERT
-- Insert Records into Customers Table
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, DateOfBirth)
VALUES (101,'Rahul','Sharma','rahul@gmail.com', '9876543210', '1998-04-15');

-- Insert Records into Accounts Table
INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance)
VALUES (201,101,'Savings',25000);

-- UPDATE
-- Update Customer Phone Number
SET SQL_SAFE_UPDATES=0;

UPDATE Customers
SET Phone='999999999'
WHERE CustomerID=101;

SELECT * FROM Customers
WHERE CustomerID=101;

-- Update Customer EmaiL Address
UPDATE Customers
SET Email='rahul.sharma@gmail.com'
WHERE CustomerID=101;

SELECT * FROM Customers
WHERE CustomerID=101;

INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, Phone, DateOfBirth)
VALUES
(102, 'Priya', 'Patil', 'priya@gmail.com', '9988776655', '2000-09-20'),
(103, 'Amit', 'Patel', 'amit.patel@gmail.com', '9876500001', '1995-06-18'),
(104, 'Sneha', 'Joshi', 'sneha.joshi@gmail.com', '9876500002', '1997-09-12'),
(105, 'Rohan', 'Kulkarni', 'rohan.k@gmail.com', '9876500003', '1993-11-25');

-- Insert 4 Records into Accounts Table
INSERT INTO Accounts
(AccountID, CustomerID, AccountType, Balance)
VALUES
(202, 102, 'Current', 40000),
(203, 103, 'Savings', 35000),
(204, 104, 'Current', 60000),
(205, 105, 'Savings', 45000);

-- Insert 5 Records into Transactions Table
INSERT INTO Transactions
(TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES
(301, 201, '2025-05-10', 5000, 'Deposit'),
(302, 202, '2025-05-11', 2500, 'Withdraw'),
(303, 203, '2025-05-12', 10000, 'Deposit'),
(304, 204, '2025-05-13', 3000, 'Withdraw'),
(305, 205, '2025-05-14', 7000, 'Deposit');

-- Insert 5 Records into Branches Table
INSERT INTO Branches
(BranchID, BranchName, BranchAddress, BranchPhone)
VALUES
(1, 'Mumbai Branch', 'Andheri, Mumbai', '0221111111'),
(2, 'Pune Branch', 'Shivaji Nagar, Pune', '0202222222'),
(3, 'Nashik Branch', 'College Road, Nashik', '0253222222'),
(4, 'Nagpur Branch', 'Sitabuldi, Nagpur', '0712333333'),
(5, 'Navi Mumbai Branch', 'Vashi, Navi Mumbai', '0224444444');



-- Insert 5 Records into Loans Table
INSERT INTO Loans
(LoanID, LoanAmount, InterestRate, StartDate, EndDate, CustomerID)
VALUES
(301, 500000, 8.50, '2025-01-15', '2030-01-15', 101),
(302, 300000, 9.25, '2025-02-10', '2028-02-10', 102),
(303, 750000, 8.75, '2025-03-20', '2032-03-20', 103),
(304, 250000, 10.00, '2025-04-05', '2029-04-05', 104),
(305, 1000000, 7.95, '2025-05-12', '2035-05-12', 105);

-- SQ4

-- View complete Customer information
SELECT * FROM Customers;

-- View Only required customer details
SELECT FirstName, LastName, Email, Phone
FROM Customers;

-- Retrivers Customers with Savings Accounts
SELECT * FROM Accounts
WHERE AccountType='Savings';

-- Retrives Accounts with Balance Greater than25k
SELECT * FROM Accounts
WHERE  Balance>25000;

-- Retrives Transactions Between Specific Amounts
SELECT * FROM Transactions
WHERE Amount BETWEEN 5000 AND 2000;

-- Retrives Records for Selected Customers
SELECT * FROM Customers
WHERE CustomerID IN (101,102,103);

-- Search Customers Using Partial Name Matching
SELECT * FROM Customers
WHERE FirstName LIKE 'R%';

-- Order by
-- Diplay Customers in Alphabetical order
SELECT * FROM Customers
ORDER BY FirstName ASC;

-- Display Accounts with Highest balance first
SELECT * FROM Accounts
ORDER BY Balance DESC;

-- Retrieve Unique accout types
SELECT DISTINCT AccountType
FROM Accounts;

-- Display top 3 highest balance accounts
SELECT * FROM Accounts
ORDER BY Balance DESC
LIMIT 3;

-- Skip Initial Records while Viewing transactions
SELECT * FROM Transactions
LIMIT 5 OFFSET 2;

-- Find Customers without Phone Numbers
SELECT * FROM Customers
WHERE Phone IS NULL;

-- Find Customers Having Email Addresses
SELECT * FROM Customers
WHERE Email IS NOT NULL;  

-- Categorize accounts using balance
SELECT AccountID,Balance,
CASE
WHEN Balance >=50000 THEN 'Premium Account'
WHEN Balance >=25000 THEN 'Standard Account'
ELSE 'Basic Account'
END AS AccountCategory
FROM Accounts;

-- Assign Rank Based on Account Balance
SELECT AccountID, Balance,
RANK() OVER (ORDER BY Balance DESC) AS BalanceRank
FROM Accounts;

-- Calculate Running Total of Transactions
SELECT TransactionID, Amount,
SUM(Amount) OVER (ORDER BY TransactionDate) AS RunningTotal
FROM Transactions;

-- Display Average Transaction Amount
SELECT TransactionID, Amount,
AVG(Amount) OVER () AS AverageTransaction
FROM Transactions;

-- SQ5
-- Search customers whose first name start from "A"
SELECT * FROM Customers
WHERE FirstName LIKE 'A%';

-- Search customers whose Email contains "gmail"
SELECT * FROM Customers
WHERE Email LIKE '%gmail%';

-- Search customers whose Last name ends with the "kar"
SELECT * FROM Customers
WHERE LastName LIKE '%kar';

-- Retrieve Records for Selected Account Types
SELECT * FROM Accounts
WHERE AccountType IN ('Savings', 'Cuurent');

-- Retrieve Transactions for Selected Transaction
SELECT * From Transactions
WHERE TransactionType IN ('Deposit', 'Withdrawal');

-- Retrieve records for selected customers
SELECT * FROM Customers
WHERE CustomerID IN (101,102,103);

-- Display Customers in ascending order of last name 
SELECT * FROM Customers
ORDER BY LastName ASC;

-- Display Accounts with highest balance first
SELECT * FROM Accounts
ORDER BY Balance DESC;

-- Display Transactions sorted by transaction date 
SELECT * FROM Transactions
ORDER BY TransactionDate DESC;

-- Display only top 5 highest balance account
SELECT * FROM Accounts
ORDER BY Balance DESC
LIMIT 5;

-- Display first 3 Customer records
SELECT * FROM Customers
LIMIT 3;

-- Skip initial transaction records while viewing data
SELECT * FROM Transactions 
LIMIT 5 OFFSET 3;

-- Display savings account customers sorted by balance
SELECT * FROM Accounts
WHERE AccountType = 'Savings'
ORDER BY Balance DESC;

-- Search customers using partial name and limit result
SELECT * FROM Customers
WHERE FirstName LIKE 'S%' LIMIT 5;

-- Display selewcted Transactions in sorted order
SELECT * FROM Transactions
WHERE TransactionType IN ('Deposit', 'Withdrawal')
ORDER BY TransactionDate DESC;

-- SQ6
-- String Function
-- Display all customer FirtsNAme in Uppercase
SELECT FirstName, UPPER(FirstName) AS UpperCaseName
FROM customers;

-- Display all customer FirstName in lowercase
SELECT FirstName, LOWER(FirstName) AS LowerCaseName
FROM customers;

-- find the total number of characters in each customer firstName
SELECT FirstName, LENGTH(FirstName) AS NameLength
FROM customers;

-- Display only the first three characters of customer firstname
SELECT FirstName, LEFT(FirstName,3) AS Initials
FROM customers;

-- Combine customer's first and last name
SELECT CONCAT(FirstName,'-',LastName) AS FullName
FROM Customers;

-- Math fuctions
SELECT ROUND(1256.75) AS Rounded_Value;

SELECT CEIL(1256.25) AS Ceiling_Value;

SELECT FLOOR(1256.75) AS Floor_Value;

SELECT ABS(-2500) AS Absolute_Value;

SELECT MOD(25,4) AS Remainder;

-- Date Fuctions
-- display the current system date.
select curdate();

-- displat the currec=nt system date and time
select Now();

-- display the birth of year
select CustomerID, YEAR(DateOfBirth) as BirthYear
From Customers;

-- Display the birth month
Select CustomerID, MONTH(DateOfBirth) As BirthMonth
From Customers;

-- calculate the number of days since birthdate
SELECT
CustomerID,
DATEDIFF(CURDATE(),DateOfBirth) AS Days
FROM customers;

-- Comparison Functions
-- categorize customers as adult or young based ontheir birth
select FirstName, DateOfBirth,
IF(year(DateOfBirth) <=1995, 'Adult', 'Young') As category
from Customers;

-- display 'not available' if a phone number is null
select FirstName, IFNULL(Phone, 'Not Available') As PhoneNumber
From Customers;

-- find the latest birth date
SELECT GREATEST(
'2000-09-20',
'1995-06-18',
'1997-09-12',
'1993-11-25'
) AS LatestBirthDate;

-- Compare two customer names
SELECT
    FirstName,
    NULLIF(FirstName,'Priya') AS Result
FROM Customers;

-- Calculate the total balance maintained across all customers account
select SUM(Balance) as total_balance
from Accounts;

-- Calculate the average balance maintained across all customer accounts to understand the typical amount held by customers.
SELECT AVG(Balance) AS average_balance
FROM Accounts;

-- Identify the highest balance maintained in any customer account.
SELECT MAX(Balance) AS highest_balance
FROM Accounts;

-- Identify the lowest balance maintained in any customer account
SELECT MIN(Balance) AS lowest_balance
FROM Accounts;

-- Determine the total number of customer accounts available in the system.
SELECT COUNT(*) AS total_accounts
FROM Accounts;

-- Analyze Account-wise Performance
SELECT 
    AccountType,
    SUM(Balance) AS TotalBalance
FROM Accounts
GROUP BY AccountType;

-- The bank management wants to identify only those account types whose total customer deposits exceed ₹25,000.
SELECT 
    AccountType,
    SUM(Balance) AS TotalBalance
FROM Accounts
GROUP BY AccountType
HAVING SUM(Balance) > 25000;

-- SQ7
-- Rank Customer Loans Using RANK()
Select LoanID, CustomerID, LoanAmount,
Rank() over(
order by LoanAmount DESC) as LoanRank
from Loans;

-- Rank Customer Loans Using DENSE_RANK()
select LoanID, CustomerID, LoanAmount,
DENSE_RANK() OVER(order by LoanAmount desc) as DenseRank
From Loans;

-- Assign Row Numbers Using ROW_NUMBER()
SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    ROW_NUMBER() OVER(
        ORDER BY LoanAmount DESC
    ) AS RowNumber
FROM Loans;

-- Understanding PARTITION BY
SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    ROW_NUMBER() OVER(
        PARTITION BY CustomerID
        ORDER BY LoanAmount DESC
    ) AS RowNum
FROM Loans;

-- Calculate Running Total Using SUM() OVER()
SELECT
    LoanID, CustomerID,LoanAmount,
    SUM(LoanAmount) OVER(
        ORDER BY LoanAmount DESC
    ) AS RunningTotal
FROM Loans;

-- Compare Previous Loan Records Using LAG()
SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    LAG(LoanAmount) OVER(
        ORDER BY LoanAmount DESC
    ) AS PreviousLoanAmount
FROM Loans;

-- Compare Next Loan Records Using LEAD()
SELECT
    LoanID, CustomerID, LoanAmount,
    LEAD(LoanAmount) OVER(
        ORDER BY LoanAmount DESC
    ) AS NextLoanAmount
FROM Loans;

-- Joins
-- inner 
-- Generate Accounts Transaction Reports
SELECT a.AccountID, a.AccountType, a.Balance,
t.TransactionID, t.TransactionDate, t.TransactionType, t.Amount
FROM Accounts a
INNER JOIN Transactions t
on a.AccountID=t.AccountID;

-- Left
-- Display All Accounts Including Those Without Transactions
SELECT a.AccountID, a.AccountType, a.Balance,
t.TransactionID, t.TransactionDate, t.TransactionType, t.Amount
FROM Accounts a
LEFT JOIN Transactions t
on a.AccountID=t.AccountID;

-- inner
-- Generate Deposit Transaction Reports
SELECT
    a.AccountID, a.AccountType, a.Balance,
    t.TransactionID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount
FROM Accounts a
INNER JOIN Transactions t
ON a.AccountID = t.AccountID
WHERE t.TransactionType = 'Deposit';

-- Generate High Balance Account Transaction Reports
SELECT
    a.AccountID, a.AccountType, a.Balance,
    t.TransactionID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount
FROM Accounts a
INNER JOIN Transactions t
ON a.AccountID = t.AccountID
WHERE a.Balance > 30000
ORDER BY a.Balance DESC;

select * From transactions;

SELECT
    TransactionID,
    TransactionDate,
    TransactionType,
    Amount,
    AccountID
FROM Transactions
WHERE Amount >
(
    SELECT AVG(Amount)
    FROM Transactions
);

select * from accounts;

SELECT
    AccountID,
    AccountType,
    Balance,
    CustomerID
FROM Accounts
WHERE Balance >
(
    SELECT AVG(Balance)
    FROM Accounts
)
ORDER BY Balance DESC;

SELECT
    AccountID,
    AccountType,
    Balance,
    CustomerID
FROM Accounts
WHERE AccountID IN
(
    SELECT AccountID
    FROM Transactions
    WHERE TransactionType = 'Deposit'
);

SELECT
    AccountID,
    AccountType,
    Balance,
    CustomerID
FROM Accounts
WHERE Balance =
(
    SELECT MAX(Balance)
    FROM Accounts
);

CREATE VIEW High_Balance_Accounts AS
SELECT
    AccountID,
    AccountType,
    Balance,
    CustomerID
FROM Accounts
WHERE Balance > 30000;

SELECT *
FROM High_Balance_Accounts;

CREATE OR REPLACE VIEW High_Balance_Accounts AS
SELECT
    a.AccountID, a.AccountType, a.Balance, a.CustomerID,
    t.TransactionID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount
FROM Accounts a
INNER JOIN Transactions t
ON a.AccountID = t.AccountID
WHERE a.Balance > 30000;

SELECT
    AccountID,
    AccountType,
    Balance,
    CustomerID,
    TransactionID,
    TransactionDate,
    TransactionType,
    Amount
FROM High_Balance_Accounts
ORDER BY Balance DESC;

