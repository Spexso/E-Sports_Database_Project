SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;

BEGIN TRY
    -- Acquire a lock on the player row
    SELECT * FROM Player WITH (UPDLOCK, HOLDLOCK) WHERE PlayerID = 8;

    -- Update the player's team and market value
    UPDATE Player
    SET TeamID = 12, MarketValue = 10000
    WHERE PlayerID = 25;

    -- Log the transfer
    INSERT INTO PlayerTransfer (PlayerID, FromTeamID, ToTeamID, TransferDate, MarketValue)
    VALUES (25, 12, 13, GETDATE(), 550000);

    -- Commit the transaction if both operations succeed
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    -- Rollback the transaction if any operation fails
    ROLLBACK TRANSACTION;
    -- Optionally, throw the error
    THROW;
END CATCH;
