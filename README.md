### Setup

* Ensure ruby 2.6.5 and postgres are installed
* Install gems:
  ```
  bundle
  ```
* Setup database:
  ```
  rails db:setup
  ```
* Run tests:
  ```
  rspec
  ```
* Start server:
  ```
  rails s
  ```
* Set up frontend:
  ```
  cd frontend
  yarn
  ```
* Start frontend:
  ```
  yarn start
  ```

### TODO:
* Add component tests with jest and react-testing-library
* Add tests for CSV export
* Add first/last pagination buttons
* Split player name into first and last name colums so that player name filter can search both.
* Stop table from collapsing to 0 height while waiting for API responses. Causes ugly flicker when going to next page. 
* Table needs a style pass - pretty boring right now
* Come up with a better solution for handling the mapping of presentation stat names ("Yds") and internal column names ("total_rushing_yards"). Right now the full list of presentation names is hardcoded in several places. Either have short names defined in the database or on the PlayerStatistic model.
* There are also a few places in the backend where each stat is listed (PlayerDataImporter and PlayerStatsExporter) - add a method to PlayerStatistic that provides that list instead.