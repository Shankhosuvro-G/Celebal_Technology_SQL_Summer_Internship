1. List of all customers
select FirstName, MiddleName, LastName from SalesLT.Customer;

2. list of all customers where company name ending in N
select FirstName, MiddleName, LastName, CompanyName from SalesLT.Customer
where CompanyName like '%N';

3. list of all customers who live in Berlin or London
select * from SalesLT.Address
where City = 'Berlin' or City='London';

4. list of all customers who live in UK or USA
select * from SalesLT.Address
where CountryRegion = 'United Kingdom' or CountryRegion=' United States %';

5. list of all products sorted by product name
select * from SalesLT.Product order by Name asc;

6. list of all products where product name starts with an A
select * from SalesLT.Product 
where Name like 'A%';

7. List of customers who ever placed an order
select SalesLT.Customer.FirstName, SalesLT.Customer.MiddleName, SalesLT.Customer.LastName
from SalesLT.Customer
join SalesLT.SalesOrderHeader
on SalesLT.Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerID;

8. list of Customers who live in London and have bought chai
select SalesLT.Customer.FirstName, SalesLT.Customer.MiddleName, SalesLT.Customer.LastName
from SalesLT.Customer
join SalesLT.SalesOrderHeader
on SalesLT.Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerID
join SalesLT.SalesOrderDetail
on SalesLT.SalesOrderDetail.SalesOrderID = SalesLT.SalesOrderHeader.SalesOrderID
join SalesLT.Product 
on SalesLT.Product.ProductID = SalesLT.SalesOrderDetail.ProductID
where SalesLT.Address.City = 'London' and SalesLT.Product.Name = 'Chai';

9. List of customers who never place an order
SELECT * FROM SalesLT.Customer
WHERE CustomerID NOT IN (SELECT CustomerID FROM SalesLT.SalesOrderHeader);

10. List of customers who ordered Tofu
select SalesLT.Customer.FirstName, SalesLT.Customer.MiddleName, SalesLT.Customer.LastName
from SalesLT.Customer
join SalesLT.SalesOrderHeader
on SalesLT.Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerID
join SalesLT.SalesOrderDetail
on SalesLT.SalesOrderDetail.SalesOrderID = SalesLT.SalesOrderHeader.SalesOrderID
join SalesLT.Product 
on SalesLT.Product.ProductID = SalesLT.SalesOrderDetail.ProductID
where SalesLT.Product.Name = 'Tofu';

11. Details of first order of the system
select top 1 * from SalesLT.SalesOrderHeader order by OrderDate asc ;

12. Find the details of most expensive order date
select top 1 * from SalesLT.SalesOrderHeader order by SubTotal asc ;

13. For each order get the OrderID and Average quantity of items in that order
select SalesOrderID,AVG(OrderQty) as AvgQuantity from saleslt.SalesOrderDetail
group by SalesOrderID;

14. For each order get the orderID, minimum quantity and maximum quantity for that order
select SalesOrderID,MIN(OrderQty) as MinQty , MAX(OrderQty) as MaxQt from saleslt.SalesOrderDetail
group by SalesOrderID;


