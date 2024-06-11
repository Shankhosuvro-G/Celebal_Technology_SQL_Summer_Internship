--Create a procedure InsertOrderDetails that takes OrderID, ProductID, UnitPrice,
--Quantiy, Discount as input parameters and inserts that order information in the
--Order Details table. After each order inserted, check the @@rowcount value to
--make sure that order was inserted properly. If for any reason the order was not
--inserted, print the message: Failed to place the order. Please try again. Also your
--procedure should have these functionalities
--Make the UnitPrice and Discount parameters optional
--If no UnitPrice is given, then use the UnitPrice value from the product table.
--If no Discount is given, then use a discount of 0.
--Adjust the quantity in stock (UnitsInStock) for the product by subtracting the quantity
--sold from inventory.
--However, if there is not enough of a product in stock, then abort the stored procedure
--without making any changes to the database.
--Print a message if the quantity in stock of a product drops below its Reorder Level as a result of the update.

--Soluition
create procedure InsertOrderDetails
@OrderID int,
@ProductID int=NULL,
@UnitPrice money = NULL,
@Quantity int,
@Discount money=NULL
as
begin
if @UnitPrice is NULL
select @UnitPrice = ListPrice from SalesLT.Product where ProductID = @ProductID
if @Discount is NULL
set @Discount = 0
begin transaction
begin try
insert into SalesLT.SalesOrderDetail (OrderID, ProductID, UnitPrice, OrderQty, Discount)
values (@OrderID, @ProductID, @UnitPrice,@Quantity,@Discount)
declare @UnitsinStk int = (select UnitsInStock from SalesLT.Product where ProductID=@ProductID)
if @UnitsinStk < @Quantity
raiserror('Stock not available',16,1)
update SalesLT.Product
set UnitsInStock=@UnitsinStk-@Quantity where ProductID=@ProductID
if @@ROWCOUNT=0
raiserror ('Order was not inserted',16,1)
commit transaction
end try
begin catch
rollback transaction
raiserror('The order was not placed',16,1)
end catch
end


