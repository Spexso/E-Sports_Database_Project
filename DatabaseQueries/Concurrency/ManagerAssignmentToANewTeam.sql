SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION;

BEGIN TRY
    -- Acquire a lock on the team row
    SELECT * FROM Team WITH (UPDLOCK) WHERE TeamID = 1;

    -- Assign the new manager to the team
    UPDATE Team
    SET ManagerID = 3
    WHERE TeamID = 1;

    -- Acquire a lock on the manager row
    SELECT * FROM Manager WITH (UPDLOCK) WHERE ManagerID = 3;

    -- Update the manager's experience
    UPDATE Manager
    SET Experience = '6 years'
    WHERE ManagerID = 3;

    -- Commit the transaction if both operations succeed
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    -- Rollback the transaction if any operation fails
    ROLLBACK TRANSACTION;
    -- Optionally, throw the error
    THROW;
END CATCH;
