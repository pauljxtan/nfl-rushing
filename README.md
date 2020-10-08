# theScore "the Rush" Interview Challenge
At theScore, we are always looking for intelligent, resourceful, full-stack developers to join our growing team. To help us evaluate new talent, we have created this take-home interview question. This question should take you no more than a few hours.

**All candidates must complete this before the possibility of an in-person interview. During the in-person interview, your submitted project will be used as the base for further extensions.**

### Why a take-home challenge?
In-person coding interviews can be stressful and can hide some people's full potential. A take-home gives you a chance work in a less stressful environment and showcase your talent.

We want you to be at your best and most comfortable.

### A bit about our tech stack
As outlined in our job description, you will come across technologies which include a server-side web framework (like Elixir/Phoenix, Ruby on Rails or a modern Javascript framework) and a front-end Javascript framework (like ReactJS)

### Challenge Background
We have sets of records representing football players' rushing statistics. All records have the following attributes:
* `Player` (Player's name)
* `Team` (Player's team abbreviation)
* `Pos` (Player's postion)
* `Att/G` (Rushing Attempts Per Game Average)
* `Att` (Rushing Attempts)
* `Yds` (Total Rushing Yards)
* `Avg` (Rushing Average Yards Per Attempt)
* `Yds/G` (Rushing Yards Per Game)
* `TD` (Total Rushing Touchdowns)
* `Lng` (Longest Rush -- a `T` represents a touchdown occurred)
* `1st` (Rushing First Downs)
* `1st%` (Rushing First Down Percentage)
* `20+` (Rushing 20+ Yards Each)
* `40+` (Rushing 40+ Yards Each)
* `FUM` (Rushing Fumbles)

In this repo is a sample data file [`rushing.json`](/rushing.json).

##### Challenge Requirements
1. Create a web app. This must be able to do the following steps
    1. Create a webpage which displays a table with the contents of [`rushing.json`](/rushing.json)
    2. The user should be able to sort the players by _Total Rushing Yards_, _Longest Rush_ and _Total Rushing Touchdowns_
    3. The user should be able to filter by the player's name
    4. The user should be able to download the sorted data as a CSV, as well as a filtered subset
    
2. The system should be able to potentially support larger sets of data on the order of 10k records.

3. Update the section `Installation and running this solution` in the README file explaining how to run your code

### Submitting a solution
1. Download this repo
2. Complete the problem outlined in the `Requirements` section
3. In your personal public GitHub repo, create a new public repo with this implementation
4. Provide this link to your contact at theScore

We will evaluate you on your ability to solve the problem defined in the requirements section as well as your choice of frameworks, and general coding style.

### Help
If you have any questions regarding requirements, do not hesitate to email your contact at theScore for clarification.

### Installation and running this solution

This application requires [Docker](https://www.docker.com/) and [Docker
Compose](https://docs.docker.com/compose/), which are available for most
mainstream OSes.

A Makefile is included to abstract away the lower-level commands:

1. Run `make run` to build and start all containers.
2. Run `make db-setup` to migrate and seed the database with the provided data.
3. Navigate to http://localhost:8000.

To view all available commands, run `make help`.

You should hopefully see something like this:

![Sample](./sample.png)

#### Project structure and rationale

At a high-level, the application consists of three containers:

1. A PostgreSQL database (`nfl-rushing-db`) that stores the rushing statistics;
2. A backend Phoenix server (`nfl-rushing-backend`) that serves the rushing
  stats through a REST API;
3. A frontend Vue application (`nfl-rushing-frontend`) that renders the table as
  described above.

#### Other notes

- I'm aware that this is somewhat over-engineering things, as the requirements
  could've been fulfilled with Phoenix alone by reading the csv file directly
  and rendering the page server-side. However, given that this project is
  intended to evaluate full-stack competency, I have taken a few liberties :)

- I realized at some point that calling each row a "rush" is a bit of a
  misnomer, since each one obviously comprises multiple rushes. Going back and
  renaming everything seemed like a bit of a hassle for the purposes of this
  challenge, so I decided not to, but just wanted to mention it anyway. (There
  are only two hard things in CS, etc.)
