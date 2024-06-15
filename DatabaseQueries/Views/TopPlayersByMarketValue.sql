CREATE VIEW TopPlayersByMarketValue_view AS
SELECT 
    TOP 100 PERCENT
    p.PlayerID,
    p.Nickname,
    p.MainGame,
    t.TeamName,
    p.Age,
    p.MarketValue
FROM 
    Player p
LEFT JOIN 
    Team t ON p.TeamID = t.TeamID
ORDER BY 
    p.MarketValue DESC;
