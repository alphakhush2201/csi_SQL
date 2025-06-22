-- Step 1: Create Login
CREATE LOGIN UserTest WITH PASSWORD = 'StrongPass123!';

-- Step 2: Create User in Database
CREATE USER UserTest FOR LOGIN UserTest;

-- Step 3: Grant db_owner Role
EXEC sp_addrolemember 'db_owner', 'UserTest';
	