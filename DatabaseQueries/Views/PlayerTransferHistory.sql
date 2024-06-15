CREATE VIEW PlayerTransferHistory_view AS
SELECT 
    pt.TransferID,
    p.Nickname AS PlayerName,
    pt.FromTeamID,
    ft.TeamName AS FromTeam,
    pt.ToTeamID,
    tt.TeamName AS ToTeam,
    pt.TransferDate,
    pt.MarketValue
FROM 
    PlayerTransfer pt
LEFT JOIN 
    Player p ON pt.PlayerID = p.PlayerID
LEFT JOIN 
    Team ft ON pt.FromTeamID = ft.TeamID
LEFT JOIN 
    Team tt ON pt.ToTeamID = tt.TeamID;
