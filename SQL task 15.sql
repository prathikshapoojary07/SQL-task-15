use prathiksha_db;
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    City VARCHAR(50)
);
CREATE TABLE Accounts (
    Account_ID INT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Account_Type VARCHAR(30) NOT NULL,
    Opening_Balance DECIMAL(12,2) DEFAULT 0,

    FOREIGN KEY (Customer_ID)
        REFERENCES Customers(Customer_ID)
);
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Order_Date DATE NOT NULL,
    Order_Amount DECIMAL(12,2) NOT NULL,

    FOREIGN KEY (Customer_ID)
        REFERENCES Customers(Customer_ID)
);
CREATE TABLE Invoices (
    Invoice_ID INT PRIMARY KEY,
    Order_ID INT NOT NULL,
    Invoice_Date DATE NOT NULL,
    Due_Date DATE NOT NULL,
    Invoice_Amount DECIMAL(12,2) NOT NULL,

    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID)
);
CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY,
    Invoice_ID INT NOT NULL,
    Payment_Date DATE NOT NULL,
    Payment_Amount DECIMAL(12,2) NOT NULL,
    Payment_Method VARCHAR(30),

    FOREIGN KEY (Invoice_ID)
        REFERENCES Invoices(Invoice_ID)
);
CREATE TABLE Expenses (
    Expense_ID INT PRIMARY KEY,
    Expense_Date DATE NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Description VARCHAR(150),
    Amount DECIMAL(12,2) NOT NULL
);
CREATE TABLE Ledger (
    Ledger_ID INT PRIMARY KEY,
    Account_ID INT NOT NULL,
    Transaction_Date DATE NOT NULL,
    Transaction_Type VARCHAR(20) NOT NULL,
    Debit DECIMAL(12,2) DEFAULT 0,
    Credit DECIMAL(12,2) DEFAULT 0,
    Description VARCHAR(150),

    FOREIGN KEY (Account_ID)
        REFERENCES Accounts(Account_ID)
);
INSERT INTO Customers
VALUES
(1, 'Meera Finance', 'meera.finance@gmail.com', '9823456710', 'Udupi'),
(2, 'Devika Traders', 'devika.traders@gmail.com', '9823456711', 'Mysuru'),
(3, 'Nivan Technologies', 'nivan.tech@gmail.com', '9823456712', 'Mangaluru'),
(4, 'Aarohi Retail', 'aarohi.retail@gmail.com', '9823456713', 'Bengaluru'),
(5, 'Vihaan Services', 'vihaan.services@gmail.com', '9823456714', 'Kochi');
INSERT INTO Accounts
VALUES
(1001, 1, 'Current', 72000),
(1002, 2, 'Current', 58000),
(1003, 3, 'Savings', 46500),
(1004, 4, 'Current', 83000),
(1005, 5, 'Savings', 39000);
INSERT INTO Orders
VALUES
(201, 1, '2026-01-07', 68000),
(202, 2, '2026-01-19', 54000),
(203, 3, '2026-02-11', 88000),
(204, 4, '2026-03-08', 47000),
(205, 5, '2026-04-16', 62000);
INSERT INTO Invoices
VALUES
(301, 201, '2026-01-07', '2026-01-27', 68000),
(302, 202, '2026-01-19', '2026-02-08', 54000),
(303, 203, '2026-02-11', '2026-03-03', 88000),
(304, 204, '2026-03-08', '2026-03-28', 47000),
(305, 205, '2026-04-16', '2026-05-06', 62000);
INSERT INTO Payments
VALUES
(401, 301, '2026-01-21', 68000, 'Bank Transfer'),
(402, 302, '2026-02-02', 30000, 'UPI'),
(403, 303, '2026-02-27', 50000, 'Card'),
(404, 304, '2026-03-22', 47000, 'Bank Transfer'),
(405, 305, '2026-04-29', 25000, 'UPI');
INSERT INTO Expenses
VALUES
(501, '2026-01-11', 'Rent', 'Branch office rent', 18000),
(502, '2026-02-14', 'Salary', 'Staff payroll', 36000),
(503, '2026-03-09', 'Utilities', 'Electricity and internet', 9500),
(504, '2026-04-13', 'Marketing', 'Online promotion', 14500),
(505, '2026-05-17', 'Travel', 'Client travel', 8200);
INSERT INTO Ledger
VALUES
(601, 1001, '2026-01-07', 'Sales', 0, 68000, 'Corporate sale'),
(602, 1002, '2026-01-19', 'Sales', 0, 54000, 'Retail sale'),
(603, 1003, '2026-02-11', 'Sales', 0, 88000, 'Technology service'),
(604, 1004, '2026-03-08', 'Sales', 0, 47000, 'Retail order'),
(605, 1005, '2026-04-16', 'Sales', 0, 62000, 'Service contract'),
(606, 1001, '2026-02-14', 'Expense', 36000, 0, 'Salary expense');
SELECT * FROM Customers;
SELECT * FROM Accounts;
SELECT * FROM Orders;
SELECT * FROM Invoices;
SELECT * FROM Payments;
SELECT * FROM Expenses;
SELECT * FROM Ledger;
CREATE TABLE basic_financial_queries (
    transaction_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    transaction_type VARCHAR(30),
    transaction_date DATE,
    amount DECIMAL(12,2),
    department VARCHAR(50)
);

INSERT INTO basic_financial_queries VALUES
(1,'Meera Finance','Income','2026-01-07',68000,'Sales'),
(2,'Devika Traders','Income','2026-01-19',54000,'Sales'),
(3,'Nivan Technologies','Expense','2026-02-14',36000,'HR'),
(4,'Aarohi Retail','Income','2026-03-08',47000,'Sales'),
(5,'Vihaan Services','Expense','2026-04-13',14500,'Marketing'),
(6,'Tara Enterprises','Income','2026-05-09',79000,'Sales'),
(7,'Meera Finance','Expense','2026-05-17',8200,'Travel'),
(8,'Devika Traders','Income','2026-06-15',61000,'Sales');

-- 2.1 Display all records
SELECT * FROM basic_financial_queries;

-- 2.2 Income transactions
SELECT *
FROM basic_financial_queries
WHERE transaction_type='Income';

-- 2.3 Transactions above 50000
SELECT *
FROM basic_financial_queries
WHERE amount > 50000;

-- 2.4 Transactions between two dates
SELECT *
FROM basic_financial_queries
WHERE transaction_date BETWEEN '2026-01-01' AND '2026-03-31';

-- 2.5 Sorting by amount
SELECT *
FROM basic_financial_queries
ORDER BY amount DESC;

-- 2.6 GROUP BY summary
SELECT
    department,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount,
    ROUND(AVG(amount),2) AS average_amount
FROM basic_financial_queries
GROUP BY department;

-- 2.7 CASE expression
SELECT
    transaction_id,
    customer_name,
    amount,
    CASE
        WHEN amount >= 70000 THEN 'High'
        WHEN amount >= 30000 THEN 'Medium'
        ELSE 'Low'
    END AS transaction_category
FROM basic_financial_queries;

-- ============================================================================
-- QUESTION 3: JOIN OPERATIONS
-- ============================================================================

CREATE TABLE customer_join_table (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE sales_join_table (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    sale_date DATE,
    product VARCHAR(100),
    amount DECIMAL(12,2)
);

INSERT INTO customer_join_table VALUES
(1,'Meera Finance','Udupi'),
(2,'Devika Traders','Mysuru'),
(3,'Nivan Technologies','Mangaluru'),
(4,'Aarohi Retail','Bengaluru'),
(5,'Vihaan Services','Kochi'),
(6,'Tara Enterprises','Pune');

INSERT INTO sales_join_table VALUES
(201,1,'2026-01-07','Cloud Subscription',68000),
(202,2,'2026-01-19','POS Equipment',26000),
(203,1,'2026-02-12','Network Devices',34000),
(204,3,'2026-03-08','ERP License',88000),
(205,4,'2026-04-20','Barcode Systems',12000),
(206,5,'2026-05-09','Consulting Package',62000);

SELECT * FROM customer_join_table;
SELECT * FROM sales_join_table;

-- 3.1 INNER JOIN
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    s.sale_id,
    s.product,
    s.amount
FROM customer_join_table c
INNER JOIN sales_join_table s
    ON c.customer_id=s.customer_id;

-- 3.2 LEFT JOIN
SELECT
    c.customer_id,
    c.customer_name,
    s.sale_id,
    s.amount
FROM customer_join_table c
LEFT JOIN sales_join_table s
    ON c.customer_id=s.customer_id;

-- 3.3 RIGHT JOIN
SELECT
    c.customer_id,
    c.customer_name,
    s.sale_id,
    s.amount
FROM customer_join_table c
RIGHT JOIN sales_join_table s
    ON c.customer_id=s.customer_id;

-- 3.4 JOIN + GROUP BY
SELECT
    c.customer_id,
    c.customer_name,
    COALESCE(SUM(s.amount),0) AS total_sales
FROM customer_join_table c
LEFT JOIN sales_join_table s
    ON c.customer_id=s.customer_id
GROUP BY c.customer_id,c.customer_name;

-- 3.5 Multiple-table JOIN
SELECT
    c.customer_name,
    o.order_id,
    o.order_amount,
    i.invoice_id,
    i.invoice_amount,
    p.payment_id,
    p.payment_amount
FROM normalized_customers c
JOIN normalized_orders o
    ON c.customer_id=o.customer_id
JOIN normalized_invoices i
    ON o.order_id=i.order_id
LEFT JOIN normalized_payments p
    ON i.invoice_id=p.invoice_id;

-- ============================================================================
-- QUESTION 4: VIEWS
-- ============================================================================

CREATE TABLE customer_view_table (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE invoice_view_table (
    invoice_id INT PRIMARY KEY,
    customer_id INT,
    invoice_amount DECIMAL(12,2),
    due_date DATE
);

CREATE TABLE payment_view_table (
    payment_id INT PRIMARY KEY,
    invoice_id INT,
    payment_amount DECIMAL(12,2),
    payment_date DATE
);

INSERT INTO customer_view_table VALUES
(1,'Meera Finance','Udupi'),
(2,'Devika Traders','Mysuru'),
(3,'Nivan Technologies','Mangaluru'),
(4,'Aarohi Retail','Bengaluru'),
(5,'Vihaan Services','Kochi'),
(6,'Tara Enterprises','Pune');

INSERT INTO invoice_view_table VALUES
(501,1,68000,'2026-01-27'),
(502,2,54000,'2026-02-08'),
(503,3,88000,'2026-03-03'),
(504,4,47000,'2026-03-28'),
(505,5,62000,'2026-05-06'),
(506,6,79000,'2026-05-29');

INSERT INTO payment_view_table VALUES
(601,501,68000,'2026-01-21'),
(602,502,30000,'2026-02-02'),
(603,503,50000,'2026-02-27'),
(604,504,47000,'2026-03-22'),
(605,505,25000,'2026-04-29'),
(606,506,79000,'2026-05-24');

CREATE OR REPLACE VIEW customer_balance_view AS
SELECT
    c.customer_id,
    c.customer_name,
    i.invoice_id,
    i.invoice_amount,
    COALESCE(SUM(p.payment_amount),0) AS paid_amount,
    i.invoice_amount-COALESCE(SUM(p.payment_amount),0) AS balance
FROM customer_view_table c
JOIN invoice_view_table i
    ON c.customer_id=i.customer_id
LEFT JOIN payment_view_table p
    ON i.invoice_id=p.invoice_id
GROUP BY
    c.customer_id,c.customer_name,
    i.invoice_id,i.invoice_amount;

SELECT * FROM customer_balance_view;

CREATE OR REPLACE VIEW overdue_balance_view AS
SELECT
    customer_id,
    customer_name,
    invoice_id,
    invoice_amount,
    paid_amount,
    balance
FROM customer_balance_view
WHERE balance > 0;

SELECT * FROM overdue_balance_view;

-- ============================================================================
-- QUESTION 5: SUBQUERIES
-- ============================================================================

CREATE TABLE customer_subquery_table (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    total_sales DECIMAL(12,2)
);

INSERT INTO customer_subquery_table VALUES
(1,'Meera Finance','Udupi',132000),
(2,'Devika Traders','Mysuru',115000),
(3,'Nivan Technologies','Mangaluru',154000),
(4,'Aarohi Retail','Bengaluru',69000),
(5,'Vihaan Services','Kochi',97000),
(6,'Tara Enterprises','Pune',141000);

SELECT * FROM customer_subquery_table;

-- 5.1 Customers with sales greater than average sales
SELECT *
FROM customer_subquery_table
WHERE total_sales >
    (SELECT AVG(total_sales)
     FROM customer_subquery_table);

-- 5.2 Customer with maximum sales
SELECT *
FROM customer_subquery_table
WHERE total_sales =
    (SELECT MAX(total_sales)
     FROM customer_subquery_table);

-- 5.3 Customers whose sales are above Meera Finance's sales
SELECT *
FROM customer_subquery_table
WHERE total_sales >
    (SELECT total_sales
     FROM customer_subquery_table
     WHERE customer_name='Meera Finance');

-- 5.4 Correlated subquery
SELECT
    c1.customer_name,
    c1.city,
    c1.total_sales
FROM customer_subquery_table c1
WHERE c1.total_sales >
    (SELECT AVG(c2.total_sales)
     FROM customer_subquery_table c2
     WHERE c2.city=c1.city);

-- 5.5 EXISTS subquery
SELECT
    c.customer_id,
    c.customer_name
FROM customer_subquery_table c
WHERE EXISTS (
    SELECT 1
    FROM normalized_orders o
    WHERE o.customer_id=c.customer_id
);

-- ============================================================================
-- QUESTION 6: CTE
-- ============================================================================

CREATE TABLE customer_cte_table (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    month_name VARCHAR(20),
    sales DECIMAL(12,2),
    expenses DECIMAL(12,2)
);

INSERT INTO customer_cte_table VALUES
(1,'Meera Finance','January',62000,27000),
(2,'Meera Finance','February',71000,31000),
(3,'Meera Finance','March',68000,29000),
(4,'Devika Traders','January',55000,24000),
(5,'Devika Traders','February',63000,28000),
(6,'Devika Traders','March',72000,32000),
(7,'Nivan Technologies','January',81000,39000),
(8,'Nivan Technologies','February',86000,41000),
(9,'Nivan Technologies','March',92000,44000);

SELECT * FROM customer_cte_table;

-- 6.1 CTE for profit
WITH customer_profit_cte AS (
    SELECT
        customer_id,
        customer_name,
        month_name,
        sales,
        expenses,
        sales-expenses AS profit
    FROM customer_cte_table
)
SELECT *
FROM customer_profit_cte
ORDER BY profit DESC;

-- 6.2 CTE + GROUP BY
WITH customer_summary_cte AS (
    SELECT
        customer_id,
        customer_name,
        SUM(sales) AS total_sales,
        SUM(expenses) AS total_expenses
    FROM customer_cte_table
    GROUP BY customer_id,customer_name
)
SELECT
    customer_id,
    customer_name,
    total_sales,
    total_expenses,
    total_sales-total_expenses AS total_profit
FROM customer_summary_cte
ORDER BY total_profit DESC;

-- 6.3 Multiple CTEs
WITH sales_cte AS (
    SELECT
        customer_id,
        SUM(sales) AS total_sales
    FROM customer_cte_table
    GROUP BY customer_id
),
expense_cte AS (
    SELECT
        customer_id,
        SUM(expenses) AS total_expenses
    FROM customer_cte_table
    GROUP BY customer_id
)
SELECT
    s.customer_id,
    c.customer_name,
    s.total_sales,
    e.total_expenses,
    s.total_sales-e.total_expenses AS profit
FROM sales_cte s
JOIN expense_cte e
    ON s.customer_id=e.customer_id
JOIN normalized_customers c
    ON s.customer_id=c.customer_id;

-- ============================================================================
-- QUESTION 7: WINDOW FUNCTIONS
-- ============================================================================

CREATE TABLE customer_window_table (
    sale_month DATE,
    customer_name VARCHAR(50),
    sales DECIMAL(12,2)
);

INSERT INTO customer_window_table
(sale_month,customer_name,sales)
VALUES
('2025-01-01','Meera',108000),
('2025-02-01','Devika',121000),
('2025-03-01','Meera',116000),
('2025-04-01','Aarohi',145000),
('2025-05-01','Devika',133000),
('2025-06-01','Meera',139000),
('2025-07-01','Aarohi',152000),
('2025-08-01','Devika',161000),
('2025-09-01','Meera',147000),
('2025-10-01','Aarohi',174000),
('2025-11-01','Devika',168000),
('2025-12-01','Meera',159000),
('2026-01-01','Meera',136000),
('2026-02-01','Devika',149000),
('2026-03-01','Meera',151000),
('2026-04-01','Aarohi',178000),
('2026-05-01','Devika',164000),
('2026-06-01','Meera',163000),
('2026-07-01','Aarohi',186000),
('2026-08-01','Devika',179000),
('2026-09-01','Meera',171000),
('2026-10-01','Aarohi',195000),
('2026-11-01','Devika',188000),
('2026-12-01','Meera',182000);

SELECT * FROM customer_window_table;

-- 7.1 RANK
SELECT
    sale_month,
    customer_name,
    sales,
    RANK() OVER (ORDER BY sales DESC) AS sales_rank
FROM customer_window_table;

-- 7.2 DENSE_RANK
SELECT
    sale_month,
    customer_name,
    sales,
    DENSE_RANK() OVER (ORDER BY sales DESC) AS sales_rank
FROM customer_window_table;

-- 7.3 ROW_NUMBER
SELECT
    sale_month,
    customer_name,
    sales,
    ROW_NUMBER() OVER (ORDER BY sales DESC) AS row_number_of_sales
FROM customer_window_table;

-- 7.4 Previous Month Sales using LAG
SELECT
    sale_month,
    customer_name,
    sales,
    LAG(sales) OVER (ORDER BY sale_month) AS previous_month_sales
FROM customer_window_table;

-- 7.5 Next Month Sales using LEAD
SELECT
    sale_month,
    customer_name,
    sales,
    LEAD(sales) OVER (ORDER BY sale_month) AS next_month_sales
FROM customer_window_table;

-- 7.6 Previous Year Sales using LAG
SELECT
    sale_month,
    customer_name,
    sales,
    LAG(sales,12) OVER (ORDER BY sale_month) AS previous_year_sales
FROM customer_window_table;

-- 7.7 Next Year Sales using LEAD
SELECT
    sale_month,
    customer_name,
    sales,
    LEAD(sales,12) OVER (ORDER BY sale_month) AS next_year_sales
FROM customer_window_table;

-- 7.8 Running Total of Sales
SELECT
    sale_month,
    customer_name,
    sales,
    SUM(sales) OVER (
        ORDER BY sale_month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM customer_window_table;

-- 7.9 Year-over-Year Growth
WITH yearly_sales AS (
    SELECT
        sale_month,
        customer_name,
        sales,
        LAG(sales,12) OVER (ORDER BY sale_month) AS previous_year_sales
    FROM customer_window_table
)
SELECT
    sale_month,
    customer_name,
    sales,
    previous_year_sales,
    ROUND(
        ((sales-previous_year_sales)/NULLIF(previous_year_sales,0))*100,
        2
    ) AS yoy_growth
FROM yearly_sales;

-- 7.10 All important window functions together
SELECT
    sale_month,
    customer_name,
    sales,
    RANK() OVER (ORDER BY sales DESC) AS sales_rank,
    DENSE_RANK() OVER (ORDER BY sales DESC) AS sales_dense_rank,
    ROW_NUMBER() OVER (ORDER BY sales DESC) AS sales_row_number,
    LAG(sales) OVER (ORDER BY sale_month) AS previous_month_sales,
    LEAD(sales) OVER (ORDER BY sale_month) AS next_month_sales
FROM customer_window_table;

-- ============================================================================
-- QUESTION 8: STORED PROCEDURES
-- ============================================================================

CREATE TABLE financial_procedure_table (
    id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    month_name VARCHAR(20),
    sales DECIMAL(10,2),
    expenses DECIMAL(10,2),
    tax_rate DECIMAL(5,2)
);

INSERT INTO financial_procedure_table VALUES
(1,'Meera','January',62000,27000,8),
(2,'Devika','January',57000,26000,8),
(3,'Aarohi','January',49000,22000,8),
(4,'Meera','February',71000,31000,8),
(5,'Devika','February',64000,29000,8),
(6,'Aarohi','February',56000,25000,8),
(7,'Meera','March',68000,29000,8),
(8,'Devika','March',72000,32000,8),
(9,'Aarohi','March',61000,27000,8);

SELECT * FROM financial_procedure_table;

DELIMITER //

-- 8.1 Tax calculation procedure
CREATE PROCEDURE calculate_project_tax(
    IN p_sales DECIMAL(10,2),
    IN p_tax_rate DECIMAL(10,2)
)
BEGIN
    SELECT
        p_sales AS sales,
        p_tax_rate AS tax_rate,
        ROUND((p_sales*p_tax_rate)/100,2) AS tax_amount;
END//

DELIMITER ;

CALL calculate_project_tax(75000,6);
CALL calculate_project_tax(42000,4);

CREATE TABLE month_end_report_table (
    month VARCHAR(30),
    total_sales DECIMAL(12,2),
    total_expenses DECIMAL(12,2),
    profit_loss DECIMAL(12,2)
);

DELIMITER //

-- 8.2 Month-end closing procedure
CREATE PROCEDURE month_end_closing_project(
    IN p_month VARCHAR(20)
)
BEGIN
    INSERT INTO month_end_report_table
    (month,total_sales,total_expenses,profit_loss)
    SELECT
        month_name,
        SUM(sales),
        SUM(expenses),
        SUM(sales)-SUM(expenses)
    FROM financial_procedure_table
    WHERE month_name=p_month
    GROUP BY month_name;
END//

DELIMITER ;

CALL month_end_closing_project('March');
CALL month_end_closing_project('February');

SELECT * FROM month_end_report_table;

DELIMITER //

-- 8.3 Customer summary procedure
CREATE PROCEDURE customer_summary_project(
    IN p_customer VARCHAR(50)
)
BEGIN
    SELECT
        customer_name,
        SUM(sales) AS total_sales,
        SUM(expenses) AS total_expenses,
        SUM(sales)-SUM(expenses) AS total_profit
    FROM financial_procedure_table
    WHERE customer_name=p_customer
    GROUP BY customer_name;
END//

DELIMITER ;

CALL customer_summary_project('Aarohi');
CALL customer_summary_project('Devika');

CREATE TABLE year_end_report_table (
    total_sales DECIMAL(12,2),
    total_expenses DECIMAL(12,2),
    total_profit DECIMAL(12,2)
);

DELIMITER //

-- 8.4 Year-end profit procedure
CREATE PROCEDURE year_end_profit_project()
BEGIN
    INSERT INTO year_end_report_table
    (total_sales,total_expenses,total_profit)
    SELECT
        SUM(sales),
        SUM(expenses),
        SUM(sales)-SUM(expenses)
    FROM financial_procedure_table;
END//

DELIMITER ;

CALL year_end_profit_project();
SELECT * FROM year_end_report_table;

-- ============================================================================
-- QUESTION 9: TRIGGERS
-- ============================================================================

CREATE TABLE financial_trigger_table (
    transaction_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    transaction_type VARCHAR(20),
    amount DECIMAL(12,2),
    transaction_date DATE
);

CREATE TABLE financial_audit_table (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id INT,
    customer_name VARCHAR(100),
    transaction_type VARCHAR(20),
    amount DECIMAL(12,2),
    action_type VARCHAR(20),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

-- 9.1 INSERT audit trigger
CREATE TRIGGER after_project_financial_insert
AFTER INSERT ON financial_trigger_table
FOR EACH ROW
BEGIN
    INSERT INTO financial_audit_table
    (transaction_id,customer_name,transaction_type,amount,action_type)
    VALUES
    (NEW.transaction_id,NEW.customer_name,NEW.transaction_type,
     NEW.amount,'INSERT');
END//

-- 9.2 UPDATE audit trigger
CREATE TRIGGER after_project_financial_update
AFTER UPDATE ON financial_trigger_table
FOR EACH ROW
BEGIN
    INSERT INTO financial_audit_table
    (transaction_id,customer_name,transaction_type,amount,action_type)
    VALUES
    (NEW.transaction_id,NEW.customer_name,NEW.transaction_type,
     NEW.amount,'UPDATE');
END//

-- 9.3 DELETE audit trigger
CREATE TRIGGER after_project_financial_delete
AFTER DELETE ON financial_trigger_table
FOR EACH ROW
BEGIN
    INSERT INTO financial_audit_table
    (transaction_id,customer_name,transaction_type,amount,action_type)
    VALUES
    (OLD.transaction_id,OLD.customer_name,OLD.transaction_type,
     OLD.amount,'DELETE');
END//

DELIMITER ;

INSERT INTO financial_trigger_table VALUES
(1,'Meera Finance','Credit',68000,'2026-09-04'),
(2,'Devika Traders','Debit',17000,'2026-09-05'),
(3,'Nivan Technologies','Credit',92000,'2026-09-06');

UPDATE financial_trigger_table
SET amount=73500
WHERE transaction_id=1;

DELETE FROM financial_trigger_table
WHERE transaction_id=2;

SELECT * FROM financial_trigger_table;
SELECT * FROM financial_audit_table;

-- ============================================================================
-- QUESTION 10: SECURITY FEATURES
-- ============================================================================

CREATE TABLE Customers_SECURITY_FEATURES (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100)
);

CREATE TABLE Transactions_SECURITY_FEATURES (
    Transaction_ID INT PRIMARY KEY,
    Customer_ID INT,
    Amount DECIMAL(10,2),
    TransactionDate DATE,
    FOREIGN KEY (Customer_ID)
        REFERENCES Customers_SECURITY_FEATURES(Customer_ID)
);

CREATE TABLE Salaries_SECURITY_FEATURES (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(100) NOT NULL,
    Salary DECIMAL(10,2)
);

INSERT INTO Customers_SECURITY_FEATURES VALUES
(1,'Meera Finance','meera.finance@example.com'),
(2,'Devika Traders','devika.traders@example.com'),
(3,'Nivan Technologies','nivan.tech@example.com');

INSERT INTO Transactions_SECURITY_FEATURES VALUES
(1,1,68000,'2026-09-01'),
(2,2,54000,'2026-09-02'),
(3,3,92000,'2026-09-03');

INSERT INTO Salaries_SECURITY_FEATURES VALUES
(101,'Finance Manager',78000),
(102,'Accountant',52000),
(103,'Financial Analyst',61000);

-- MySQL 8 roles
CREATE ROLE IF NOT EXISTS 'finance_manager_role';
CREATE ROLE IF NOT EXISTS 'finance_report_role';

GRANT SELECT,INSERT,UPDATE
ON unique_financial_db_project.*
TO 'finance_manager_role';

GRANT SELECT
ON unique_financial_db_project.*
TO 'finance_report_role';

-- Optional login users:
-- Uncomment these four lines only if your MySQL account has CREATE USER privilege.
-- CREATE USER 'project_finance'@'localhost' IDENTIFIED BY 'ProjectFinance@2026#';
-- CREATE USER 'project_report'@'localhost' IDENTIFIED BY 'ProjectReport@2026#';
-- GRANT 'finance_manager_role' TO 'project_finance'@'localhost';
-- GRANT 'finance_report_role' TO 'project_report'@'localhost';

-- Example privilege removal
-- REVOKE INSERT ON unique_financial_db_project.*
-- FROM 'project_report'@'localhost';

SHOW GRANTS FOR 'finance_manager_role';
SHOW GRANTS FOR 'finance_report_role';

-- ============================================================================
-- QUESTION 11: COMPREHENSIVE FINANCIAL REPORTING
-- ============================================================================

CREATE TABLE financial_reporting_table (
    report_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    report_date DATE,
    revenue DECIMAL(12,2),
    expenses DECIMAL(12,2),
    tax_amount DECIMAL(12,2),
    total_assets DECIMAL(12,2),
    total_liabilities DECIMAL(12,2),
    accounts_receivable DECIMAL(12,2),
    accounts_payable DECIMAL(12,2),
    net_profit DECIMAL(12,2),
    profit_margin DECIMAL(6,2)
);

INSERT INTO financial_reporting_table
(report_id,customer_name,report_date,revenue,expenses,tax_amount,
 total_assets,total_liabilities,accounts_receivable,accounts_payable,
 net_profit,profit_margin)
VALUES
(1,'Meera Finance','2026-01-31',94000,52000,7520,
 310000,98000,22000,14000,34480,36.68),
(2,'Devika Traders','2026-01-31',81000,46000,6480,
 245000,82000,18000,11000,28520,35.21),
(3,'Nivan Technologies','2026-01-31',103000,57000,8240,
 355000,121000,27000,17000,37760,36.66),
(4,'Meera Finance','2026-02-28',108000,59000,8640,
 325000,101000,25000,15000,40360,37.37),
(5,'Devika Traders','2026-02-28',89000,49000,7120,
 259000,85000,21000,12000,32880,36.94),
(6,'Nivan Technologies','2026-02-28',116000,62000,9280,
 371000,126000,30000,18000,44720,38.55),
(7,'Meera Finance','2026-03-31',112000,61000,8960,
 338000,106000,27000,16000,42040,37.54),
(8,'Devika Traders','2026-03-31',97000,53000,7760,
 268000,89000,23000,13000,36240,37.36),
(9,'Nivan Technologies','2026-03-31',124000,66000,9920,
 389000,132000,32000,19000,48080,38.77);

SELECT * FROM financial_reporting_table;

-- 11.1 Average financial performance
SELECT
    ROUND(AVG(revenue),2) AS average_revenue,
    ROUND(AVG(expenses),2) AS average_expenses,
    ROUND(AVG(net_profit),2) AS average_net_profit,
    ROUND(AVG(profit_margin),2) AS average_profit_margin
FROM financial_reporting_table;

-- 11.2 Total revenue, expenses, tax and profit
SELECT
    SUM(revenue) AS total_revenue,
    SUM(expenses) AS total_expenses,
    SUM(tax_amount) AS total_tax,
    SUM(net_profit) AS total_net_profit
FROM financial_reporting_table;

-- 11.3 Overall business financial summary
SELECT
    SUM(revenue) AS total_revenue,
    SUM(expenses) AS total_expenses,
    SUM(tax_amount) AS total_tax,
    SUM(net_profit) AS total_net_profit,
    SUM(total_assets) AS total_assets,
    SUM(total_liabilities) AS total_liabilities,
    SUM(accounts_receivable) AS total_receivables,
    SUM(accounts_payable) AS total_payables,
    ROUND(
        (SUM(net_profit)/NULLIF(SUM(revenue),0))*100,
        2
    ) AS overall_profit_margin
FROM financial_reporting_table;

-- 11.4 Customer-wise financial performance
SELECT
    customer_name,
    SUM(revenue) AS revenue,
    SUM(expenses) AS expenses,
    SUM(net_profit) AS net_profit,
    ROUND(AVG(profit_margin),2) AS average_profit_margin
FROM financial_reporting_table
GROUP BY customer_name
ORDER BY net_profit DESC;

-- 11.5 Monthly financial performance
SELECT
    report_date,
    SUM(revenue) AS monthly_revenue,
    SUM(expenses) AS monthly_expenses,
    SUM(net_profit) AS monthly_profit,
    ROUND(
        SUM(net_profit)/NULLIF(SUM(revenue),0)*100,
        2
    ) AS monthly_profit_margin
FROM financial_reporting_table
GROUP BY report_date
ORDER BY report_date;

-- 11.6 Liquidity indicators
SELECT
    SUM(total_assets) AS total_assets,
    SUM(total_liabilities) AS total_liabilities,
    SUM(accounts_receivable) AS accounts_receivable,
    SUM(accounts_payable) AS accounts_payable,
    ROUND(
        SUM(accounts_receivable) /
        NULLIF(SUM(accounts_payable),0),
        2
    ) AS receivable_to_payable_ratio
FROM financial_reporting_table;

-- 11.7 Highest-revenue customer
SELECT
    customer_name,
    SUM(revenue) AS total_revenue
FROM financial_reporting_table
GROUP BY customer_name
ORDER BY total_revenue DESC
LIMIT 1;

-- 11.8 Highest-profit reporting period
SELECT
    report_date,
    SUM(net_profit) AS total_period_profit
FROM financial_reporting_table
GROUP BY report_date
ORDER BY total_period_profit DESC
LIMIT 1;

-- 11.9 Management KPI dashboard
SELECT
    COUNT(DISTINCT customer_name) AS active_customers,
    SUM(revenue) AS revenue,
    SUM(expenses) AS expenses,
    SUM(tax_amount) AS tax,
    SUM(net_profit) AS net_profit,
    ROUND(SUM(net_profit)/NULLIF(SUM(revenue),0)*100,2)
        AS profit_margin,
    SUM(accounts_receivable) AS receivables,
    SUM(accounts_payable) AS payables
FROM financial_reporting_table;

-- 11.10 Profitability classification
SELECT
    customer_name,
    SUM(revenue) AS revenue,
    SUM(net_profit) AS net_profit,
    CASE
        WHEN SUM(net_profit)/NULLIF(SUM(revenue),0) >= 0.38
            THEN 'Strong Margin'
        WHEN SUM(net_profit)/NULLIF(SUM(revenue),0) >= 0.35
            THEN 'Stable Margin'
        ELSE 'Needs Review'
    END AS profitability_status
FROM financial_reporting_table
GROUP BY customer_name;

-- ============================================================================
-- FINAL DATABASE CHECK
-- ============================================================================

SHOW TABLES;

SELECT 'PROJECT COMPLETED SUCCESSFULLY' AS project_status;

