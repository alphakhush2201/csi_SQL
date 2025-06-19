EXEC UpdateOrderDetails 
    @OrderID = 43659, 
    @ProductID = 776,
    @UnitPrice = 450.00,   -- Change price
    @Quantity = 3,         -- Change quantity
    @Discount = NULL;  