CREATE TRIGGER PlayerAgeChange_trigger
ON Player
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM inserted i JOIN deleted d ON i.PlayerID = d.PlayerID WHERE i.Age <> d.Age)
    BEGIN
        INSERT INTO PlayerAgeChange (PlayerID, OldAge, NewAge, ChangeDate)
        SELECT d.PlayerID, d.Age, i.Age, GETDATE()
        FROM inserted i
        JOIN deleted d ON i.PlayerID = d.PlayerID
        WHERE i.Age <> d.Age;
    END
END;
