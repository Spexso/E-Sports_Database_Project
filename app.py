from flask import Flask, render_template, request, redirect, url_for, flash
from model import Base, Manager, Sponsor, Game, Team, Nationality, Player, Caster, Venue, Tournament, TeamOwner, Build, Streamer, Match, Schedule, SponsorshipDeal, PlayerStatistics, TeamStatistics, Event, PlayerTransfer
from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker

app = Flask(__name__)
app.secret_key = 'supersecretkey'


# Configure the database connection
engine = create_engine('mssql+pyodbc://.\sqlexpress/ESportsDB?driver=ODBC+Driver+17+for+SQL+Server&Trusted_Connection=yes')
Base.metadata.bind = engine
DBSession = sessionmaker(bind=engine)
session = DBSession()

@app.route('/')
def index():
    teams = session.query(Team).all()
    players = session.query(Player).all()
    if not teams:
        print("No teams found.")
    if not players:
        print("No players found.")
    return render_template('index.html', teams=teams, players=players)

@app.route('/add_manager', methods=['GET', 'POST'])
def add_manager():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        phone = request.form['phone']
        experience = request.form['experience']
        new_manager = Manager(Name=name, Email=email, PhoneNumber=phone, Experience=experience)
        session.add(new_manager)
        session.commit()
        return redirect(url_for('index'))
    return render_template('add_manager.html')

@app.route('/team_sponsor_changes')
def team_sponsor_changes():
    query = """
        SELECT 
            tsc.ChangeID,
            tsc.TeamID,
            t.TeamName,
            tsc.OldSponsorID,
            os.SponsorName AS OldSponsorName,
            tsc.NewSponsorID,
            ns.SponsorName AS NewSponsorName,
            tsc.ChangeDate
        FROM 
            TeamSponsorChange tsc
        JOIN Team t ON tsc.TeamID = t.TeamID
        LEFT JOIN Sponsor os ON tsc.OldSponsorID = os.SponsorID
        LEFT JOIN Sponsor ns ON tsc.NewSponsorID = ns.SponsorID
    """
    team_sponsor_changes = session.execute(text(query)).fetchall()
    return render_template('team_sponsor_changes.html', team_sponsor_changes=team_sponsor_changes)


@app.route('/add_team', methods=['GET', 'POST'])
def add_team():
    if request.method == 'POST':
        team_name = request.form['team_name']
        manager_id = request.form['manager_id']
        sponsor_id = request.form['sponsor_id']
        new_team = Team(TeamName=team_name, ManagerID=manager_id, SponsorID=sponsor_id)
        session.add(new_team)
        session.commit()
        return redirect(url_for('index'))
    return render_template('add_team.html')

@app.route('/add_player', methods=['GET', 'POST'])
def add_player():
    if request.method == 'POST':
        nickname = request.form['nickname']
        main_game = request.form['main_game']
        nationality_id = request.form['nationality_id']
        age = request.form['age']
        team_id = request.form['team_id']
        email = request.form['email']
        phone = request.form['phone']
        market_value = request.form['market_value']
        new_player = Player(Nickname=nickname, MainGame=main_game, NationalityID=nationality_id, Age=age, TeamID=team_id, Email=email, Phone=phone, MarketValue=market_value)
        session.add(new_player)
        session.commit()
        return redirect(url_for('index'))
    return render_template('add_player.html')

@app.route('/add_tournament', methods=['GET', 'POST'])
def add_tournament():
    if request.method == 'POST':
        tournament_name = request.form['tournament_name']
        venue_id = request.form['venue_id']
        prize_pool = request.form['prize_pool']
        sponsor_id = request.form['sponsor_id']
        start_date = request.form['start_date']
        end_date = request.form['end_date']
        team1_id = request.form['team1_id']
        team2_id = request.form['team2_id']
        match_date = request.form['match_date']

        try:
            # Start a new transaction
            with engine.begin() as connection:
                # Insert the new tournament
                result = connection.execute(text("""
                    BEGIN TRANSACTION;
                    BEGIN TRY
                        -- Create the new tournament
                        INSERT INTO Tournament (TournamentName, VenueID, PrizePool, SponsorID, StartDate, EndDate)
                        VALUES (:tournament_name, :venue_id, :prize_pool, :sponsor_id, :start_date, :end_date);

                        DECLARE @NewTournamentID INT;
                        SET @NewTournamentID = SCOPE_IDENTITY();

                        -- Schedule the initial match for the new tournament
                        INSERT INTO Match (TournamentID, Team1ID, Team2ID, MatchDate, WinnerTeamID)
                        VALUES (@NewTournamentID, :team1_id, :team2_id, :match_date, NULL);

                        -- Commit the transaction if both operations succeed
                        COMMIT TRANSACTION;
                    END TRY
                    BEGIN CATCH
                        -- Rollback the transaction if any operation fails
                        ROLLBACK TRANSACTION;
                        -- Optionally throw the error
                        THROW;
                    END CATCH;
                """), {
                    'tournament_name': tournament_name,
                    'venue_id': venue_id,
                    'prize_pool': prize_pool,
                    'sponsor_id': sponsor_id,
                    'start_date': start_date,
                    'end_date': end_date,
                    'team1_id': team1_id,
                    'team2_id': team2_id,
                    'match_date': match_date
                })

            flash('Tournament and initial match successfully added.', 'success')
        except Exception as e:
            flash(f'Error adding tournament: {e}', 'danger')

        return redirect(url_for('index'))

    return render_template('add_tournament.html')

@app.route('/matches')
def matches():
    matches = session.execute(text("""
        SELECT 
            m.MatchID,
            t1.TeamName AS Team1,
            t2.TeamName AS Team2,
            m.MatchDate,
            m.WinnerTeamID,
            w.TeamName AS WinnerTeam
        FROM 
            Match m
        LEFT JOIN Team t1 ON m.Team1ID = t1.TeamID
        LEFT JOIN Team t2 ON m.Team2ID = t2.TeamID
        LEFT JOIN Team w ON m.WinnerTeamID = w.TeamID
    """)).fetchall()
    return render_template('matches.html', matches=matches)

@app.route('/player_details')
def player_details():
    player_details = session.execute(text('SELECT * FROM PlayerDetails_view')).fetchall()
    return render_template('player_details.html', player_details=player_details)


@app.route('/team_manager_details')
def team_manager_details():
    # Execute the full outer join query
    team_manager_details = session.execute(text("""
        SELECT 
            Team.TeamID,
            Team.TeamName,
            Manager.ManagerID,
            Manager.Name AS ManagerName
        FROM 
            Team
        FULL OUTER JOIN 
            Manager ON Team.ManagerID = Manager.ManagerID
    """)).fetchall()
    return render_template('team_manager_details.html', team_manager_details=team_manager_details)



@app.route('/team_sponsor_details')
def team_sponsor_details():
    team_sponsor_details = session.execute(text('SELECT * FROM TeamSponsorDetails_view')).fetchall()
    return render_template('team_sponsor_details.html', team_sponsor_details=team_sponsor_details)


@app.route('/edit_team/<int:id>', methods=['GET', 'POST'])
def edit_team(id):
    team = session.query(Team).get(id)
    if request.method == 'POST':
        team.TeamName = request.form['team_name']
        team.ManagerID = request.form['manager_id']
        team.SponsorID = request.form['sponsor_id']
        session.commit()
        return redirect(url_for('index'))
    return render_template('edit_team.html', team=team)

@app.route('/player_transfer_list')
def player_transfer_list():
    player_transfers = session.execute(text("""
        SELECT 
            pt.TransferID,
            p.Nickname AS PlayerName,
            t1.TeamName AS FromTeam,
            t2.TeamName AS ToTeam,
            pt.TransferDate,
            pt.TransferFee
        FROM 
            PlayerTransfer pt
        JOIN Player p ON pt.PlayerID = p.PlayerID
        LEFT JOIN Team t1 ON pt.FromTeamID = t1.TeamID
        LEFT JOIN Team t2 ON pt.ToTeamID = t2.TeamID
    """)).fetchall()
    return render_template('player_transfer_list.html', player_transfers=player_transfers)


@app.route('/edit_player/<int:id>', methods=['GET', 'POST'])
def edit_player(id):
    player = session.query(Player).get(id)
    if request.method == 'POST':
        player.Nickname = request.form['nickname']
        player.MainGame = request.form['main_game']
        player.NationalityID = request.form['nationality_id']
        player.Age = request.form['age']
        player.TeamID = request.form['team_id']
        player.Email = request.form['email']
        player.Phone = request.form['phone']
        player.MarketValue = request.form['market_value']
        session.commit()
        return redirect(url_for('index'))
    return render_template('edit_player.html', player=player)

@app.route('/delete_player/<int:id>')
def delete_player(id):
    player = session.query(Player).get(id)
    session.delete(player)
    session.commit()
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True)
