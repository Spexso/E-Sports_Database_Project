-- Grant all privileges to AdminRole
GRANT CONTROL ON DATABASE::ESportsDB TO AdminRole;

-- Grant privileges to manage teams
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Team TO ManagerRole;

-- Grant privileges to manage players
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Player TO ManagerRole;

-- Grant privileges to manage matches
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Match TO ManagerRole;

-- Grant read-only access to all tables
GRANT SELECT ON dbo.Manager TO ViewerRole;
GRANT SELECT ON dbo.Sponsor TO ViewerRole;
GRANT SELECT ON dbo.Game TO ViewerRole;
GRANT SELECT ON dbo.Team TO ViewerRole;
GRANT SELECT ON dbo.Nationality TO ViewerRole;
GRANT SELECT ON dbo.Player TO ViewerRole;
GRANT SELECT ON dbo.Caster TO ViewerRole;
GRANT SELECT ON dbo.Venue TO ViewerRole;
GRANT SELECT ON dbo.Tournament TO ViewerRole;
GRANT SELECT ON dbo.TeamOwner TO ViewerRole;
GRANT SELECT ON dbo.Build TO ViewerRole;
GRANT SELECT ON dbo.Streamer TO ViewerRole;
GRANT SELECT ON dbo.Match TO ViewerRole;
GRANT SELECT ON dbo.Schedule TO ViewerRole;
GRANT SELECT ON dbo.SponsorshipDeal TO ViewerRole;
GRANT SELECT ON dbo.PlayerStatistics TO ViewerRole;
GRANT SELECT ON dbo.TeamStatistics TO ViewerRole;
GRANT SELECT ON dbo.Event TO ViewerRole;
GRANT SELECT ON dbo.PlayerTransfer TO ViewerRole;

