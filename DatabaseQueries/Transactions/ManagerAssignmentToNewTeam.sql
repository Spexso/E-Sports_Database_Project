BEGIN TRANSACTION;

BEGIN TRY
    -- Assign the new manager to the team
    UPDATE Team
    SET ManagerID = 3
    WHERE TeamID = 10;

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
    -- Optionally throw the error
    THROW;
END CATCH;
