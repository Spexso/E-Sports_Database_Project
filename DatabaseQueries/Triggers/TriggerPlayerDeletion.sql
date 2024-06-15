CREATE TRIGGER DeletePlayer_trigger
ON Player
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Delete related records
    DELETE FROM PlayerStatistics
    WHERE PlayerID IN (SELECT PlayerID FROM DELETED);

	DELETE FROM PlayerAgeChange
    WHERE PlayerID IN (SELECT PlayerID FROM DELETED);

	DELETE FROM Build
    WHERE PlayerID IN (SELECT PlayerID FROM DELETED);

	DELETE FROM Streamer
    WHERE PlayerID IN (SELECT PlayerID FROM DELETED);

END;
