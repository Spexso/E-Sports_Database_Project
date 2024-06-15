CREATE TABLE VenueCapacityChange (
    ChangeID INT PRIMARY KEY IDENTITY,
    VenueID INT,
    OldCapacity INT,
    NewCapacity INT,
    ChangeDate DATE,
    FOREIGN KEY (VenueID) REFERENCES Venue(VenueID)
);
