CREATE VIEW TournamentSchedule_view AS
SELECT 
    tr.TournamentName,
    m.MatchID,
    m.MatchDate,
    t1.TeamName AS Team1,
    t2.TeamName AS Team2,
    v.VenueName,
    v.Address,
    v.City,
    v.Country
FROM 
    Match m
LEFT JOIN 
    Tournament tr ON m.TournamentID = tr.TournamentID
LEFT JOIN 
    Team t1 ON m.Team1ID = t1.TeamID
LEFT JOIN 
    Team t2 ON m.Team2ID = t2.TeamID
LEFT JOIN 
    Venue v ON tr.VenueID = v.VenueID;
