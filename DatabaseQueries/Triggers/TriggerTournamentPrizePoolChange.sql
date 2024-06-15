CREATE TRIGGER TournamentPrizePoolChange_trigger
ON Tournament
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM inserted i JOIN deleted d ON i.TournamentID = d.TournamentID WHERE i.PrizePool <> d.PrizePool)
    BEGIN
        INSERT INTO TournamentPrizePoolChange (TournamentID, OldPrizePool, NewPrizePool, ChangeDate)
        SELECT d.TournamentID, d.PrizePool, i.PrizePool, GETDATE()
        FROM inserted i
        JOIN deleted d ON i.TournamentID = d.TournamentID
        WHERE i.PrizePool <> d.PrizePool;
    END
END;
