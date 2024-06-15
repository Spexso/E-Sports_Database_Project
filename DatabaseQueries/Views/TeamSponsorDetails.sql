CREATE VIEW TeamSponsorDetails_view AS
SELECT 
    t.TeamID,
    t.TeamName,
    m.Name AS ManagerName,
    s.SponsorName,
    s.ContactEmail AS SponsorEmail,
    s.ContactPhone AS SponsorPhone
FROM 
    Team t
LEFT JOIN 
    Manager m ON t.ManagerID = m.ManagerID
LEFT JOIN 
    Sponsor s ON t.SponsorID = s.SponsorID;
