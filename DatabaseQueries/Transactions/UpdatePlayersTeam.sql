BEGIN TRANSACTION;

BEGIN TRY
    -- Update the player's team
    UPDATE Player
    SET TeamID = 11, MarketValue = 550000
    WHERE PlayerID = 5;

    -- Log the transfer
    INSERT INTO PlayerTransfer (PlayerID, FromTeamID, ToTeamID, TransferDate, MarketValue)
    VALUES (5, 10, 11, GETDATE(), 550000);

    -- Commit the transaction if both operations succeed
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    -- Rollback the transaction if any operation fails
    ROLLBACK TRANSACTION;
    -- Optionally throw the error
    THROW;
END CATCH;
