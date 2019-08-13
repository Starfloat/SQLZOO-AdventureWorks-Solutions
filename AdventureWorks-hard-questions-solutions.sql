/*https://sqlzoo.net/wiki/AdventureWorks_hard_questions*/

--11.
/*For every customer with a 'Main Office' in Dallas show AddressLine1 of the 'Main Office' and AddressLine1 of the 'Shipping' address - if there is no shipping address leave it blank. 
Use one row per customer.
*/
SELECT CompanyName,
CASE WHEN AddressType = 'Main Office' THEN AddressLine1 ELSE '' END AS 'Main Office',
CASE WHEN AddressType = 'Shipping' THEN AddressLine1 ELSE '' END AS 'Shipping Address'
FROM Customer
JOIN CustomerAddress ON (Customer.CustomerID=CustomerAddress.CustomerID)
JOIN Address         ON (CustomerAddress.AddressID=Address.AddressID)
WHERE City = 'Dallas'

--12.
/*For each order show the SalesOrderID and SubTotal calculated three ways: 
A) From the SalesOrderHeader 
B) Sum of OrderQty*UnitPrice 
C) Sum of OrderQty*ListPrice
*/
SELECT SalesOrderDetail.SalesOrderID, SalesOrderHeader.SubTotal, SUM(OrderQty*UnitPrice), SUM(OrderQty*ListPrice)
FROM SalesOrderDetail 
JOIN SalesOrderHeader ON (SalesOrderDetail.SalesOrderID=SalesOrderHeader.SalesOrderID)
JOIN Product          ON (SalesOrderDetail.ProductID=Product.ProductID)
GROUP BY SalesOrderDetail.SalesOrderID, SalesOrderHeader.SubTotal

--13.
/*Show the best selling item by value.
*/
SELECT Name, SUM(OrderQty*UnitPrice) AS 'Best Selling Item By Value'
FROM Product
JOIN SalesOrderDetail ON (Product.ProductID=SalesOrderDetail.ProductID)
GROUP BY Name
ORDER BY Best_Selling_Item_By_Value DESC

--14.
/*Show how many orders are in the following ranges (in $):
*/
SELECT x.range, COUNT(Total) AS 'Num Orders', SUM(Total) AS 'Total Value'
FROM (
SELECT CASE
           WHEN SalesOrderDetail.UnitPrice*SalesOrderDetail.OrderQty BETWEEN 0 AND 99
            THEN '0-99'
           WHEN SalesOrderDetail.UnitPrice*SalesOrderDetail.OrderQty BETWEEN 100 AND 999
            THEN '100-999'
           WHEN SalesOrderDetail.UnitPrice*SalesOrderDetail.OrderQty BETWEEN 1000 AND 9999
            THEN '1000-9999'
           WHEN SalesOrderDetail.UnitPrice*SalesOrderDetail.OrderQty > 10000
            THEN '1000-'
           ELSE 'Error'
       END AS 'Range',
       SalesOrderDetail.UnitPrice*SalesOrderDetail.OrderQty As Total
       FROM SalesOrderDetail) x
GROUP BY x.Range
       
--15.
/*Identify the three most important cities. Show the break down of top level product category against city.
*/
