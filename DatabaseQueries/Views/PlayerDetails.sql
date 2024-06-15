CREATE VIEW PlayerDetails_view AS
SELECT 
    p.PlayerID,
    p.Nickname,
    p.MainGame,
    n.Nationality,
    n.Country,
    t.TeamName,
    p.Age,
    p.Email,
    p.Phone,
    p.MarketValue
FROM 
    Player p
LEFT JOIN 
    Nationality n ON p.NationalityID = n.NationalityID
LEFT JOIN 
    Team t ON p.TeamID = t.TeamID;
