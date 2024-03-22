# Assignment Questions

## Load Raw Data

1. Load the CSV file "Public_Art_Data.csv" into your database into a staging table.
2. After loading the data, run a simple query to ensure everything is loaded correctly.

## Figure out the keys

3. Write GROUP BY statements to check the keys in the staging table. Determine if "sac_id" or "Title" can be considered as keys.
4. Identify any issues with the keys, such as NULL values, duplicate titles or sac_ids, and multiple sac_ids sharing a common title.

## Fix empty descriptions

5. Write an UPDATE statement to replace all empty string values in the "description" column with NULL.

## Create clean public art table

6. Create a new table called "clean_seattle_public_art" with specific columns:
   - sac_id varchar(200)
   - project varchar(200)
   - title varchar(200)
   - description text
   - media varchar(200)
   - date varchar(200)
   - location varchar(200)
7. Make (sac_id, title) the primary key of the "clean_seattle_public_art" table.

## Load clean art data

8. Insert data into the "clean_seattle_public_art" table by selecting distinct values from the staging table and excluding cases where sac_id IS NULL.

## Create an artist table

9. Create a table "seattle_public_art_artist" with columns:
   - first_name varchar(100)
   - last_name varchar(100)
   - suffix varchar(10)
10. Make the primary key the combination of "first_name" and "last_name".

## Populate artist table

11. Insert data into the "seattle_public_art_artist" table by selecting values from the staging table. Handle errors related to NULL values and duplicates.

## Fix dirty artist data

12. Identify and delete records with problematic artist names in the "seattle_public_art_artist" table. For example, artists with incorrect names or multiple names in the same field.
13. Insert appropriate records for the cases where data was deleted.

## Create the many-to-many relationship

14. Create a table "seattle_public_art_artist_work" with columns:
    - sac_id varchar(200)
    - title varchar(200)
    - artist_first_name varchar(100)
    - artist_last_name varchar(100)
15. Make all four columns the primary key of the "seattle_public_art_artist_work" table.

## Populate artist work table

16. Use a join to find and insert clean artist and artwork data into the "seattle_public_art_artist_work" table.
17. Handle duplicate records and errors during insertion.

## Query your clean schema

18. Write a query to find the number of works for each artist in the clean schema. Group by artist names and count the number of works associated with each artist.
