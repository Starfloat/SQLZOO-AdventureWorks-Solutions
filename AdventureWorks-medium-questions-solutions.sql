/* https://sqlzoo.net/wiki/AdventureWorks_medium_questions */

--6.
/* A "Single Item Order" is a customer order where only one item is ordered. 
Show the SalesOrderID and the UnitPrice for every Single Item Order.
*/
SELECT SalesOrderID, UnitPrice
FROM SalesOrderDetail
WHERE OrderQty = 1

--7.
/* Where did the racing socks go? List the product name and the CompanyName for all Customers who ordered ProductModel 'Racing Socks'.
*/
SELECT ProductModel.name, CompanyName
FROM ProductModel
JOIN Product ON (ProductModel.ProductModelID=Product.ProductModelID)
JOIN SalesOrderDetail ON (Product.ProductID=SalesOrderDetail.ProductID)
JOIN SalesOrderHeader ON (SalesOrderDetail.SalesOrderID=SalesOrderHeader.SalesOrderID)
JOIN Customer         ON (SalesOrderHeader.CustomerID=Customer.CustomerID)
WHERE ProductModel.name = 'Racing Socks'

--8.
/* Show the product description for culture 'fr' for product with ProductID 736.
*/
Select Description
FROM ProductDescription
JOIN ProductModelProductDescription ON (ProductDescription.ProductDescriptionID=ProductModelProductDescription.ProductDescriptionID)
JOIN ProductModel ON (ProductModelProductDescription.ProductModelID=ProductModel.ProductModelID)
JOIN Product ON   (ProductModel.ProductModelID=Product.ProductModelID)
WHERE culture = 'fr' AND ProductID = 736

--9.
/*Use the SubTotal value in SaleOrderHeader to list orders from the largest to the smallest. 
For each order show the CompanyName and the SubTotal and the total weight of the order.
*/
SELECT CompanyName, SubTotal, SUM(Weight*OrderQty)
FROM Customer
JOIN SalesOrderHeader ON (Customer.CustomerID=SalesOrderHeader.CustomerID)
JOIN SalesOrderDetail ON (SalesOrderHeader.SalesOrderID=SalesOrderDetail.SalesOrderID)
JOIN Product          ON (SalesOrderDetail.ProductID=Product.ProductID)
GROUP BY CompanyName, SubTotal
ORDER BY SubTotal DESC

--10.
/*How many products in ProductCategory 'Cranksets' have been sold to an address in 'London'?
*/
SELECT COUNT(ProductCategory.Name)
FROM ProductCategory
JOIN Product ON (ProductCategory.ProductCategoryID=Product.ProductCategoryID)
JOIN SalesOrderDetail ON (Product.ProductID=SalesOrderDetail.ProductID)
JOIN SalesOrderHeader ON (SalesOrderDetail.SalesOrderID=SalesOrderHeader.SalesOrderID)
JOIN Address          ON (SalesOrderHeader.ShiptoAddressID=Address.AddressID)
WHERE ProductCategory.Name = 'Cranksets' AND City = 'London'
