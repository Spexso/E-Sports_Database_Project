SELECT 
    Tournament.TournamentID,
    Tournament.TournamentName,
    Venue.VenueName
FROM 
    Tournament
LEFT OUTER JOIN 
    Venue ON Tournament.VenueID = Venue.VenueID;
