CREATE TRIGGER TeamSponsorChange_trigger
ON Team
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM inserted i JOIN deleted d ON i.TeamID = d.TeamID WHERE i.SponsorID <> d.SponsorID)
    BEGIN
        INSERT INTO TeamSponsorChange (TeamID, OldSponsorID, NewSponsorID, ChangeDate)
        SELECT d.TeamID, d.SponsorID, i.SponsorID, GETDATE()
        FROM inserted i
        JOIN deleted d ON i.TeamID = d.TeamID
        WHERE i.SponsorID <> d.SponsorID;
    END
END;
