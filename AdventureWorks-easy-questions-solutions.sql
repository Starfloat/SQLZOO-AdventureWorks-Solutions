/* https://sqlzoo.net/wiki/AdventureWorks_easy_questions */

--1.
/*Show the first name and the email address of customer with CompanyName 'Bike World'*/
SELECT FirstName, EmailAddress
FROM Customer
WHERE CompanyName = 'Bike World'

--2.
/*Show the CompanyName for all customers with an address in City 'Dallas'.*/
SELECT CompanyName
FROM Customer JOIN CustomerAddress ON (Customer.CustomerID=CustomerAddress.CustomerID)
              JOIN Address         ON (CustomerAddress.AddressID=Address.AddressID)
Where City = 'Dallas'

--3.
/*How many items with ListPrice more than $1000 have been sold?*/
SELECT Count(ProductID)
FROM Product
WHERE ListPrice > 1000

--4.
/*Give the CompanyName of those customers with orders over $100000. Include the subtotal plus tax plus freight.*/
SELECT CompanyName
FROM Customer JOIN SalesOrderHeader ON (Customer.CustomerID=SalesOrderHeader.CustomerID)
WHERE (SubTotal+TaxAmt+Freight) > 100000

--5.
/*Find the number of left racing socks ('Racing Socks, L') ordered by CompanyName 'Riding Cycles'*/
SELECT Count(Name)
FROM Product JOIN SalesOrderDetail ON (Product.ProductID=SalesOrderDetail.ProductID)
             JOIN SalesOrderHeader ON (SalesOrderDetail.SalesOrderID=SalesOrderHeader.SalesOrderID)
             JOIN Customer         ON (SalesOrderHeader.CustomerID=Customer.CustomerID)
WHERE Name = 'Racing Socks, L' AND CompanyName = 'Riding Cycles'
