CREATE TABLE SwapTest (
    A INT,
    B INT
);

INSERT INTO SwapTest VALUES (10, 20);
UPDATE SwapTest
SET A = A + B,
    B = A - B,
    A = A - B;
