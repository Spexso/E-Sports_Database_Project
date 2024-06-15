CREATE TABLE TournamentPrizePoolChange (
    ChangeID INT PRIMARY KEY IDENTITY,
    TournamentID INT,
    OldPrizePool MONEY,
    NewPrizePool MONEY,
    ChangeDate DATE,
    FOREIGN KEY (TournamentID) REFERENCES Tournament(TournamentID)
);
