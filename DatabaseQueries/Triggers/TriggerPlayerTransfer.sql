CREATE TRIGGER PlayerTransfer_trigger
ON Player
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the player's team has changed
    IF EXISTS (SELECT 1 FROM inserted i JOIN deleted d ON i.PlayerID = d.PlayerID WHERE i.TeamID <> d.TeamID)
    BEGIN
        -- Insert the transfer details into PlayerTransfer
        INSERT INTO PlayerTransfer (PlayerID, FromTeamID, ToTeamID, TransferDate, TransferFee)
        SELECT d.PlayerID, d.TeamID, i.TeamID, GETDATE(), i.MarketValue
        FROM inserted i
        JOIN deleted d ON i.PlayerID = d.PlayerID
        WHERE i.TeamID <> d.TeamID;
    END
END;
