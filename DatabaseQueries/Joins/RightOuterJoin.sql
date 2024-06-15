SELECT 
    Player.PlayerID,
    Player.Nickname,
    Team.TeamName
FROM 
    Player
RIGHT OUTER JOIN 
    Team ON Player.TeamID = Team.TeamID;
