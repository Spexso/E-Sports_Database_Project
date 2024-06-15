# E-Sports Database Project

## Overview

The E-Sports Database Project is designed to manage and maintain information related to e-sports tournaments, teams, players, sponsors, and other related entities. This project leverages a SQL-based database and a Flask web application to provide an interface for interacting with the database.

## Features

- **Database Management**: Create and manage the database for storing e-sports data.
- **Team Management**: Add, edit, and delete teams, along with their managers and sponsors.
- **Player Management**: Add, edit, and delete players, including their details and team associations.
- **Tournament Management**: Create and manage tournaments, including scheduling matches.
- **Sponsor Management**: Manage sponsor details and their associations with teams.
- **View Management**: Display details of players, teams, tournaments, and sponsors.

## Technologies Used

- **Backend**: Flask, SQLAlchemy
- **Database**: Microsoft SQL Server, SQLite
- **Frontend**: HTML, CSS, Jinja2 templates

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/Spexso/E-Sports_Database_Project.git
    cd E-Sports_Database_Project
    ```

2. Set up a virtual environment and install dependencies:
    ```sh
    python -m venv venv
    source venv/bin/activate   # On Windows use `venv\Scripts\activate`
    pip install Flask SQLAlchemy
    ```

3. Set up the database:
    - Create the database using the `DatabaseQueries/Basic/DatabaseCreation.sql` script.
    - Populate the database with initial data using the provided SQL scripts in the `DatabaseQueries` directory.

4. Configure the database connection in `app.py`:
    ```python
    engine = create_engine('mssql+pyodbc://.\\sqlexpress/ESportsDB?driver=ODBC+Driver+17+for+SQL+Server&Trusted_Connection=yes')
    ```

5. Run the application:
    ```sh
    python app.py
    ```

## Usage

- Access the application in your web browser at `http://127.0.0.1:5000`.
- Use the navigation menu to manage teams, players, tournaments, and sponsors.
- Utilize the forms to add or edit information, and view detailed tables of current data.

## File Structure

- `app.py`: Main Flask application file.
- `model.py`: SQLAlchemy models for database tables.
- `templates/`: Directory containing HTML templates for the web application.
- `DatabaseQueries/`: Directory containing SQL scripts for database creation and management.