CREATE TABLE Employee_Hierarchy (
    EMPLOYEEID VARCHAR(20),
    REPORTINGTO NVARCHAR(MAX),
    EMAILID NVARCHAR(MAX),
    LEVEL INT,
    FIRSTNAME NVARCHAR(MAX),
    LASTNAME NVARCHAR(MAX)
);  


CREATE FUNCTION dbo.FIRST_NAME (@Email NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    RETURN LEFT(@Email, CHARINDEX('.', @Email) - 1);
END;
GO


CREATE FUNCTION dbo.LAST_NAME (@Email NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    RETURN SUBSTRING(@Email, CHARINDEX('.', @Email) + 1, CHARINDEX('@', @Email) - CHARINDEX('.', @Email) - 1);
END;
GO


CREATE PROCEDURE SP_hierarchy
AS
BEGIN
    
    TRUNCATE TABLE Employee_Hierarchy;


    WITH HierarchyCTE AS (
        SELECT 
            EMPLOYEEID, 
            ReportingTo, 
            EMAILID, 
            0 AS LEVEL,
            dbo.FIRST_NAME(EMAILID) AS FIRSTNAME,
            dbo.LAST_NAME(EMAILID) AS LASTNAME
        FROM EMPLOYEE_MASTER
        WHERE ReportingTo IS NULL

        UNION ALL

        SELECT 
            e.EMPLOYEEID, 
            e.ReportingTo, 
            e.EMAILID, 
            h.LEVEL + 1,
            dbo.FIRST_NAME(e.EMAILID),
            dbo.LAST_NAME(e.EMAILID)
        FROM EMPLOYEE_MASTER e
        INNER JOIN HierarchyCTE h ON e.ReportingTo = h.EMPLOYEEID
    )
    
    INSERT INTO Employee_Hierarchy
    SELECT * FROM HierarchyCTE;
END;
GO


CREATE TABLE EMPLOYEE_MASTER (
    EMPLOYEEID VARCHAR(20),
    ReportingTo VARCHAR(20),
    EMAILID NVARCHAR(MAX)
);

INSERT INTO EMPLOYEE_MASTER (EMPLOYEEID, ReportingTo, EMAILID) VALUES
('H1', NULL, 'john.doe@example.com'),
('H2', NULL, 'jane.smith@example.com'),
('H3', 'H1', 'bob.white@example.com'),
('H4', 'H1', 'charlie.brown@example.com'),
('H5', 'H3', 'emily.gray@example.com'),
('H6', 'H3', 'frank.wilson@example.com'),
('H7', 'H4', 'hannah.taylor@example.com'),
('H8', 'H4', 'jack.roberts@example.com'),
('H9', 'H5', 'kate.evans@example.com'),
('H10', 'H5', 'laura.hall@example.com');


EXEC SP_hierarchy;
SELECT * FROM Employee_Hierarchy;





