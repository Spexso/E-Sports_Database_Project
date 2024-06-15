SELECT 
    Team.TeamID,
    Team.TeamName,
    Manager.ManagerID,
    Manager.Name AS ManagerName
FROM 
    Team
FULL OUTER JOIN 
    Manager ON Team.ManagerID = Manager.ManagerID;
