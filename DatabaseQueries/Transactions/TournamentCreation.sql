BEGIN TRANSACTION;
                    BEGIN TRY
                        -- Create the new tournament
                        INSERT INTO Tournament (TournamentName, VenueID, PrizePool, SponsorID, StartDate, EndDate)
                        VALUES (:tournament_name, :venue_id, :prize_pool, :sponsor_id, :start_date, :end_date);

                        DECLARE @NewTournamentID INT;
                        SET @NewTournamentID = SCOPE_IDENTITY();

                        -- Schedule the initial match for the new tournament
                        INSERT INTO Match (TournamentID, Team1ID, Team2ID, MatchDate, WinnerTeamID)
                        VALUES (@NewTournamentID, :team1_id, :team2_id, :match_date, NULL);

                        -- Commit the transaction if both operations succeed
                        COMMIT TRANSACTION;
                    END TRY
                    BEGIN CATCH
                        -- Rollback the transaction if any operation fails
                        ROLLBACK TRANSACTION;
                        -- Optionally throw the error
                        THROW;
                    END CATCH;