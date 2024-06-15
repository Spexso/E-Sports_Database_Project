SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN TRANSACTION;

BEGIN TRY
    -- Create the new tournament
    INSERT INTO Tournament (TournamentName, VenueID, PrizePool, SponsorID, StartDate, EndDate)
    VALUES ('Winter Championship', 1, 300000, 1, '2024-12-01', '2024-12-10');

    DECLARE @NewTournamentID INT;
    SET @NewTournamentID = SCOPE_IDENTITY();

    -- Ensure that no other transactions modify the matches for this tournament
    SELECT * FROM Match WITH (UPDLOCK, HOLDLOCK) WHERE TournamentID = @NewTournamentID;

    -- Schedule the initial match for the new tournament
    INSERT INTO Match (TournamentID, Team1ID, Team2ID, MatchDate, WinnerTeamID)
    VALUES (@NewTournamentID, 10, 12, '2024-12-02', NULL);

    -- Commit the transaction if both operations succeed
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    -- Rollback the transaction if any operation fails
    ROLLBACK TRANSACTION;
    -- Optionally, throw the error
    THROW;
END CATCH;
