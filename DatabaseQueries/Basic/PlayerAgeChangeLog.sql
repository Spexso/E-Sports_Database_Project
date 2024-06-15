CREATE TABLE PlayerAgeChange (
    ChangeID INT PRIMARY KEY IDENTITY,
    PlayerID INT,
    OldAge INT,
    NewAge INT,
    ChangeDate DATE,
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID)
);
