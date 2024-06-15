CREATE TABLE TeamSponsorChange (
    ChangeID INT PRIMARY KEY IDENTITY,
    TeamID INT,
    OldSponsorID INT,
    NewSponsorID INT,
    ChangeDate DATE,
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID),
    FOREIGN KEY (OldSponsorID) REFERENCES Sponsor(SponsorID),
    FOREIGN KEY (NewSponsorID) REFERENCES Sponsor(SponsorID)
);
