# Assignment Questions

### 1. Load Raw Data

- Load the CSV file "Public_Art_Data.csv" into your database into a staging table.
- Run a simple query to ensure everything is loaded correctly.

### 2. Figure out the keys

- Write GROUP BY statements to check keys. Is sac_id a key? Title?
- Identify issues such as NULL values, duplicate titles, duplicate sac_ids, and common titles shared by multiple sac_ids.

### 3. Fix empty descriptions

- Write an UPDATE statement to replace all empty string values in the "description" column with NULL.

### 4. Create clean public art table

- Create a new table called "clean_seattle_public_art" with specified columns and make (sac_id, title) the primary key.

sac_id varchar(200)

project varchar(200)

title varchar(200)

description text

media varchar(200)

date varchar(200)

location varchar(200)

- Load clean art data into the "clean_seattle_public_art" table, excluding cases where sac_id IS NULL.

### 5. Create an artist table

- Create a table "seattle_public_art_artist" with specified columns and make the primary key the combination of "artist_first_name" and "artist_last_name".

first_name varchar(100)

last_name varchar(100)

suffix varchar(10)

### 6. Populate your artist table with all the artist data

- Use an INSERT statement to insert data into the "seattle_public_art_artist" table from the existing table "Public_Art_Data".

### 7. Fix the dirty artist data

- Write DELETE statements to remove bad artist data from the "seattle_public_art_artist" table.
These sac ids appear to have some problems with the artist name:

ESD00.074.06 (Jr. included in first name)

PR99.044 (three people listed in last name column）

PR99.043 (three people listed in last name column)

PR99.046 (three people listed in last name column)

PR99.045 (three people listed in last name column)

NEA97.024 (two people listed in last name column)

PR97.022 (two people listed in last name column)

LIB05.006 (First name repeated in last name column)

- Insert appropriate records for the problematic cases.

### 8. Create the many-to-many relationship between art and artist

- Create a table "seattle_public_art_artist_work" with specified columns and make the primary key all four columns.

sac_id varchar(200)

title varchar(200)

artist_first_name varchar(100)

artist_last_name varchar(100)

### 9. Populate your new artist table

- Find clean artists using a join and insert their data into the "seattle_public_art_artist_work" table.
- Use DISTINCT to handle duplicate records and insert data for problematic cases.

### 10. Now query your clean schema!

- Find the number of works for each artist using a query that considers the many-to-many relationship between art and artist.
