CREATE TRIGGER VenueCapacityChange_trigger
ON Venue
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM inserted i JOIN deleted d ON i.VenueID = d.VenueID WHERE i.Capacity <> d.Capacity)
    BEGIN
        INSERT INTO VenueCapacityChange (VenueID, OldCapacity, NewCapacity, ChangeDate)
        SELECT d.VenueID, d.Capacity, i.Capacity, GETDATE()
        FROM inserted i
        JOIN deleted d ON i.VenueID = d.VenueID
        WHERE i.Capacity <> d.Capacity;
    END
END;
