-- Dimension Tables
CREATE TABLE DimCategory (
    CategoryID INT PRIMARY KEY,
    CategoryName NVARCHAR(100),
    SubCategoryName NVARCHAR(100)
);

CREATE TABLE DimSupplier (
    SupplierID INT PRIMARY KEY,
    SupplierName NVARCHAR(100),
    Country NVARCHAR(50)
);

CREATE TABLE DimProduct (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    CategoryID INT,
    SupplierID INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (CategoryID) REFERENCES DimCategory(CategoryID),
    FOREIGN KEY (SupplierID) REFERENCES DimSupplier(SupplierID)
);

CREATE TABLE DimCustomer (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(100),
    Email NVARCHAR(100),
    Phone NVARCHAR(15),
    Address NVARCHAR(200),
    City NVARCHAR(100),
    State NVARCHAR(50),
    ZipCode NVARCHAR(10)
);

CREATE TABLE DimRegion (
    RegionID INT PRIMARY KEY,
    RegionName NVARCHAR(100),
    Country NVARCHAR(50)
);

CREATE TABLE DimStore (
    StoreID INT PRIMARY KEY,
    StoreName NVARCHAR(100),
    RegionID INT,
    City NVARCHAR(50),
    State NVARCHAR(50),
    StoreType NVARCHAR(50),
    FOREIGN KEY (RegionID) REFERENCES DimRegion(RegionID)
);

CREATE TABLE DimDate (
    DateID INT PRIMARY KEY,
    Date DATE,
    Day INT,
    Month INT,
    Year INT,
    Quarter INT,
    Weekday NVARCHAR(50)
);

CREATE TABLE DimPromotion (
    PromotionID INT PRIMARY KEY,
    PromotionName NVARCHAR(100),
    DiscountPercentage DECIMAL(5, 2),
    StartDate DATE,
    EndDate DATE
);

CREATE TABLE DimEmployee (
    EmployeeID INT PRIMARY KEY,
    EmployeeName NVARCHAR(100),
    Role NVARCHAR(100),
    HireDate DATE,
    Department NVARCHAR(50)
);

-- Fact Table
CREATE TABLE SalesFact (
    SalesID INT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    StoreID INT,
    DateID INT,
    PromotionID INT,
    EmployeeID INT,
    Quantity INT,
    TotalAmount DECIMAL(10, 2),
    DiscountAmount DECIMAL(10, 2),
    FOREIGN KEY (ProductID) REFERENCES DimProduct(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID),
    FOREIGN KEY (StoreID) REFERENCES DimStore(StoreID),
    FOREIGN KEY (DateID) REFERENCES DimDate(DateID),
    FOREIGN KEY (PromotionID) REFERENCES DimPromotion(PromotionID),
    FOREIGN KEY (EmployeeID) REFERENCES DimEmployee(EmployeeID)
);
-- Insert data into DimCategory
INSERT INTO DimCategory (CategoryID, CategoryName, SubCategoryName) 
VALUES (1, 'Electronics', 'Smartphones'),
       (2, 'Electronics', 'Laptops'),
       (3, 'Home Appliances', 'Refrigerators');

-- Insert data into DimSupplier
INSERT INTO DimSupplier (SupplierID, SupplierName, Country)
VALUES (1, 'TechSupply Inc.', 'USA'),
       (2, 'GadgetWorld', 'China'),
       (3, 'AppliancePro', 'Germany');

-- Insert data into DimProduct
INSERT INTO DimProduct (ProductID, ProductName, CategoryID, SupplierID, Price) 
VALUES (1, 'iPhone 14', 1, 1, 999.99),
       (2, 'MacBook Pro', 2, 1, 1299.99),
       (3, 'Samsung Galaxy S22', 1, 2, 899.99),
       (4, 'LG Refrigerator', 3, 3, 599.99);

-- Insert data into DimCustomer
INSERT INTO DimCustomer (CustomerID, CustomerName, Email, Phone, Address, City, State, ZipCode) 
VALUES (1, 'John Doe', 'john@example.com', '123-456-7890', '123 Main St', 'Los Angeles', 'CA', '90001'),
       (2, 'Jane Smith', 'jane@example.com', '987-654-3210', '456 Oak St', 'New York', 'NY', '10001');

-- Insert data into DimRegion
INSERT INTO DimRegion (RegionID, RegionName, Country)
VALUES (1, 'West Coast', 'USA'),
       (2, 'East Coast', 'USA');

-- Insert data into DimStore
INSERT INTO DimStore (StoreID, StoreName, RegionID, City, State, StoreType) 
VALUES (1, 'LA Store', 1, 'Los Angeles', 'CA', 'Retail'),
       (2, 'NY Store', 2, 'New York', 'NY', 'Online');

-- Insert data into DimDate
INSERT INTO DimDate (DateID, Date, Day, Month, Year, Quarter, Weekday)
VALUES (1, '2024-10-01', 1, 10, 2024, 4, 'Monday'),
       (2, '2024-10-02', 2, 10, 2024, 4, 'Tuesday');

-- Insert data into DimPromotion
INSERT INTO DimPromotion (PromotionID, PromotionName, DiscountPercentage, StartDate, EndDate)
VALUES (1, 'Summer Sale', 10.00, '2024-06-01', '2024-06-30'),
       (2, 'Black Friday', 20.00, '2024-11-24', '2024-11-30');

-- Insert data into DimEmployee
INSERT INTO DimEmployee (EmployeeID, EmployeeName, Role, HireDate, Department)
VALUES (1, 'Alice Johnson', 'Sales Manager', '2020-05-15', 'Sales'),
       (2, 'Bob Brown', 'Cashier', '2022-03-01', 'Operations');
-- Insert data into SalesFact
INSERT INTO SalesFact (SalesID, ProductID, CustomerID, StoreID, DateID, PromotionID, EmployeeID, Quantity, TotalAmount, DiscountAmount)
VALUES 
    (1, 1, 1, 1, 1, 1, 1, 2, 1999.98, 200.00), -- John Doe buys 2 iPhones with a summer sale discount
    (2, 2, 2, 2, 2, 2, 2, 1, 1039.99, 260.00), -- Jane Smith buys 1 MacBook during Black Friday
    (3, 3, 1, 1, 1, 1, 1, 1, 809.99, 90.00),   -- John Doe buys 1 Samsung Galaxy with a summer sale discount
    (4, 4, 2, 1, 2, NULL, 2, 1, 599.99, 0.00); -- Jane Smith buys 1 LG Refrigerator with no promotion








-- Create Product Dimension Tables
CREATE TABLE Product_Category (
    Category_ID INT PRIMARY KEY,
    Category_Name VARCHAR(50)
);

CREATE TABLE Product_Subcategory (
    Subcategory_ID INT PRIMARY KEY,
    Subcategory_Name VARCHAR(50),
    Category_ID INT,
    FOREIGN KEY (Category_ID) REFERENCES Product_Category(Category_ID)
);

CREATE TABLE Product_Dimension (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100),
    Subcategory_ID INT,
    FOREIGN KEY (Subcategory_ID) REFERENCES Product_Subcategory(Subcategory_ID)
);

-- Create Customer Dimension Tables
CREATE TABLE Customer_Country (
    Country_ID INT PRIMARY KEY,
    Country_Name VARCHAR(50)
);

CREATE TABLE Customer_Region (
    Region_ID INT PRIMARY KEY,
    Region_Name VARCHAR(50),
    Country_ID INT,
    FOREIGN KEY (Country_ID) REFERENCES Customer_Country(Country_ID)
);

CREATE TABLE Customer_Dimension (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Region_ID INT,
    FOREIGN KEY (Region_ID) REFERENCES Customer_Region(Region_ID)
);

-- Create Store Dimension Tables
CREATE TABLE Store_Region (
    Store_Region_ID INT PRIMARY KEY,
    Store_Region_Name VARCHAR(50)
);

CREATE TABLE Store_Dimension (
    Store_ID INT PRIMARY KEY,
    Store_Name VARCHAR(100),
    Store_Region_ID INT,
    FOREIGN KEY (Store_Region_ID) REFERENCES Store_Region(Store_Region_ID)
);

-- Create Date Dimension Table
CREATE TABLE Date_Dimension (
    Date_ID INT PRIMARY KEY,
    Date DATE,
    Year INT,
    Quarter INT,
    Month INT,
    Day INT,
    Weekday_Name VARCHAR(20)
);


-- Create Sales Fact Table
CREATE TABLE Sales_Fact (
    Sale_ID INT PRIMARY KEY,
    Product_ID INT,
    Customer_ID INT,
    Store_ID INT,
    Date_ID INT,
    Quantity_Sold INT,
    Revenue DECIMAL(18, 2),
    Discount DECIMAL(5, 2),
    Profit DECIMAL(18, 2),
    FOREIGN KEY (Product_ID) REFERENCES Product_Dimension(Product_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer_Dimension(Customer_ID),
    FOREIGN KEY (Store_ID) REFERENCES Store_Dimension(Store_ID),
    FOREIGN KEY (Date_ID) REFERENCES Date_Dimension(Date_ID)
);
-- Inserting data into Product Dimension Tables
INSERT INTO Product_Category (Category_ID, Category_Name) VALUES (1, 'Electronics'), (2, 'Furniture');
INSERT INTO Product_Subcategory (Subcategory_ID, Subcategory_Name, Category_ID) VALUES (1, 'Smartphones', 1), (2, 'Laptops', 1), (3, 'Chairs', 2);
INSERT INTO Product_Dimension (Product_ID, Product_Name, Subcategory_ID) VALUES (1, 'iPhone 14', 1), (2, 'MacBook Pro', 2), (3, 'Office Chair', 3);

-- Inserting data into Customer Dimension Tables
INSERT INTO Customer_Country (Country_ID, Country_Name) VALUES (1, 'USA'), (2, 'Canada');
INSERT INTO Customer_Region (Region_ID, Region_Name, Country_ID) VALUES (1, 'California', 1), (2, 'Ontario', 2);
INSERT INTO Customer_Dimension (Customer_ID, Customer_Name, Region_ID) VALUES (1, 'John Doe', 1), (2, 'Jane Smith', 2);

-- Inserting data into Store Dimension Tables
INSERT INTO Store_Region (Store_Region_ID, Store_Region_Name) VALUES (1, 'West Coast'), (2, 'East Coast');
INSERT INTO Store_Dimension (Store_ID, Store_Name, Store_Region_ID) VALUES (1, 'San Francisco Store', 1), (2, 'New York Store', 2);

-- Inserting data into Date Dimension Table
INSERT INTO Date_Dimension (Date_ID, Date, Year, Quarter, Month, Day, Weekday_Name) VALUES (1, '2024-10-01', 2024, 4, 10, 1, 'Monday');

-- Inserting data into Sales Fact Table
INSERT INTO Sales_Fact (Sale_ID, Product_ID, Customer_ID, Store_ID, Date_ID, Quantity_Sold, Revenue, Discount, Profit) VALUES (1, 1, 1, 1, 1, 5, 5000.00, 50.00, 2000.00);
