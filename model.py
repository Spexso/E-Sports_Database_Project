from sqlalchemy import create_engine, Column, Integer, String, ForeignKey, DECIMAL, Date, DateTime, Float, UniqueConstraint
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker

Base = declarative_base()

class Manager(Base):
    __tablename__ = 'Manager'
    ManagerID = Column(Integer, primary_key=True, autoincrement=True)
    Name = Column(String(100), nullable=False)
    Email = Column(String(100), unique=True, nullable=False)
    PhoneNumber = Column(String(15))
    Experience = Column(String(255))

class Sponsor(Base):
    __tablename__ = 'Sponsor'
    SponsorID = Column(Integer, primary_key=True, autoincrement=True)
    SponsorName = Column(String(100), nullable=False)
    ContactEmail = Column(String(100), unique=True, nullable=False)
    ContactPhone = Column(String(15))

class Game(Base):
    __tablename__ = 'Game'
    GameID = Column(Integer, primary_key=True, autoincrement=True)
    GameName = Column(String(100), nullable=False)

class Team(Base):
    __tablename__ = 'Team'
    TeamID = Column(Integer, primary_key=True, autoincrement=True)
    TeamName = Column(String(100), nullable=False)
    ManagerID = Column(Integer, ForeignKey('Manager.ManagerID'))
    SponsorID = Column(Integer, ForeignKey('Sponsor.SponsorID'))

class Nationality(Base):
    __tablename__ = 'Nationality'
    NationalityID = Column(Integer, primary_key=True, autoincrement=True)
    Nationality = Column(String(50), unique=True)
    Country = Column(String(50))
    Region = Column(String(50))

class Player(Base):
    __tablename__ = 'Player'
    PlayerID = Column(Integer, primary_key=True, autoincrement=True)
    Nickname = Column(String(50), nullable=False)
    MainGame = Column(String(50), nullable=False)
    NationalityID = Column(Integer, ForeignKey('Nationality.NationalityID'))
    Age = Column(Integer)
    TeamID = Column(Integer, ForeignKey('Team.TeamID'), nullable=True)
    Email = Column(String(100))
    Phone = Column(String(15))
    MarketValue = Column(Integer, nullable=True)

class Caster(Base):
    __tablename__ = 'Caster'
    CasterID = Column(Integer, primary_key=True, autoincrement=True)
    Name = Column(String(100), nullable=False)
    Email = Column(String(100), unique=True, nullable=False)
    PhoneNumber = Column(String(15))
    MainCastingGameID = Column(Integer, ForeignKey('Game.GameID'))

class Venue(Base):
    __tablename__ = 'Venue'
    VenueID = Column(Integer, primary_key=True, autoincrement=True)
    VenueName = Column(String(100), nullable=False)
    Address = Column(String(255))
    City = Column(String(100))
    Country = Column(String(100))
    Capacity = Column(Integer)

class Tournament(Base):
    __tablename__ = 'Tournament'
    TournamentID = Column(Integer, primary_key=True, autoincrement=True)
    TournamentName = Column(String(100), nullable=False)
    VenueID = Column(Integer, ForeignKey('Venue.VenueID'))
    PrizePool = Column(Float)
    SponsorID = Column(Integer, ForeignKey('Sponsor.SponsorID'))
    StartDate = Column(Date)
    EndDate = Column(Date)

class TeamOwner(Base):
    __tablename__ = 'TeamOwner'
    OwnerID = Column(Integer, primary_key=True, autoincrement=True)
    Name = Column(String(100), nullable=False)
    Email = Column(String(100), unique=True, nullable=False)
    PhoneNumber = Column(String(15))
    TeamID = Column(Integer, ForeignKey('Team.TeamID'))

class Build(Base):
    __tablename__ = 'Build'
    BuildID = Column(Integer, primary_key=True, autoincrement=True)
    BuildName = Column(String(100), nullable=False)
    PlayerID = Column(Integer, ForeignKey('Player.PlayerID'))
    GameID = Column(Integer, ForeignKey('Game.GameID'))

class Streamer(Base):
    __tablename__ = 'Streamer'
    StreamerID = Column(Integer, primary_key=True, autoincrement=True)
    PlayerID = Column(Integer, ForeignKey('Player.PlayerID'), unique=True)
    StreamingPlatform = Column(String(100), nullable=False)
    Email = Column(String(100), unique=True, nullable=False)
    PhoneNumber = Column(String(15))
    FavoriteGameID = Column(Integer, ForeignKey('Game.GameID'))

class Match(Base):
    __tablename__ = 'Match'
    MatchID = Column(Integer, primary_key=True, autoincrement=True)
    TournamentID = Column(Integer, ForeignKey('Tournament.TournamentID'))
    Team1ID = Column(Integer, ForeignKey('Team.TeamID'))
    Team2ID = Column(Integer, ForeignKey('Team.TeamID'))
    MatchDate = Column(Date)
    WinnerTeamID = Column(Integer, ForeignKey('Team.TeamID'))

class Schedule(Base):
    __tablename__ = 'Schedule'
    ScheduleID = Column(Integer, primary_key=True, autoincrement=True)
    TournamentID = Column(Integer, ForeignKey('Tournament.TournamentID'))
    MatchID = Column(Integer, ForeignKey('Match.MatchID'))
    ScheduledDateTime = Column(DateTime)

class SponsorshipDeal(Base):
    __tablename__ = 'SponsorshipDeal'
    SponsorshipDealID = Column(Integer, primary_key=True, autoincrement=True)
    SponsorID = Column(Integer, ForeignKey('Sponsor.SponsorID'))
    TeamID = Column(Integer, ForeignKey('Team.TeamID'))
    DealValue = Column(Float)
    StartDate = Column(Date)
    EndDate = Column(Date)

class PlayerStatistics(Base):
    __tablename__ = 'PlayerStatistics'
    PlayerStatisticsID = Column(Integer, primary_key=True, autoincrement=True)
    PlayerID = Column(Integer, ForeignKey('Player.PlayerID'))
    MatchesPlayed = Column(Integer)
    Wins = Column(Integer)
    Losses = Column(Integer)
    KDA = Column(DECIMAL(5, 2))
    AverageScore = Column(DECIMAL(5, 2))

class TeamStatistics(Base):
    __tablename__ = 'TeamStatistics'
    TeamStatisticsID = Column(Integer, primary_key=True, autoincrement=True)
    TeamID = Column(Integer, ForeignKey('Team.TeamID'))
    MatchesPlayed = Column(Integer)
    Wins = Column(Integer)
    Losses = Column(Integer)

class Event(Base):
    __tablename__ = 'Event'
    EventID = Column(Integer, primary_key=True, autoincrement=True)
    EventType = Column(String(50), nullable=False)
    EventDate = Column(Date)
    Description = Column(String(255))

class PlayerTransfer(Base):
    __tablename__ = 'PlayerTransfer'
    TransferID = Column(Integer, primary_key=True, autoincrement=True)
    PlayerID = Column(Integer, ForeignKey('Player.PlayerID'))
    FromTeamID = Column(Integer, ForeignKey('Team.TeamID'))
    ToTeamID = Column(Integer, ForeignKey('Team.TeamID'))
    TransferDate = Column(Date)
    TransferFee = Column(Float)

# Creating the SQLite database
engine = create_engine('sqlite:///esports.db')
Base.metadata.create_all(engine)
