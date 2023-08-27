-- https://medium.com/@gozdebarin/analysis-of-netflix-data-with-sql-9ee024431eb1

CREATE TABLE netflix_data (
    show_id INT PRIMARY KEY,
    type VARCHAR(10),
    title VARCHAR(255),
    director VARCHAR(255),
    cast VARCHAR(255),
    country VARCHAR(255),
    date_added DATE,
    release_year INT,
    rating VARCHAR(10),
    duration VARCHAR(20),
    listed_in VARCHAR(255),
    description TEXT,
    genre VARCHAR(255)
);

INSERT INTO netflix_data (show_id, type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description, genre)
VALUES
    (1, 'Movie', 'Movie 1', 'Director 1', 'Cast 1', 'Country 1', '2023-01-01', 2022, 'PG-13', '2h 30m', 'Action, Drama', 'Description 1', 'Action'),
    (2, 'Movie', 'Movie 2', 'Director 2', 'Cast 2', 'Country 2', '2023-01-02', 2021, 'R', '1h 45m', 'Comedy, Romance', 'Description 2', 'Comedy'),
    (3, 'TV Show', 'Show 1', 'Director 1', 'Cast 1', 'Country 1', '2023-01-03', 2020, 'TV-MA', '3 Seasons', 'Drama', 'Description 3', 'Drama');
    
    -- Get the number of records in the dataset
SELECT COUNT(*) AS total_records FROM netflix_data;

-- Count the number of TV shows and movies
SELECT
    type,
    COUNT(*) AS count
FROM netflix_data
GROUP BY type;

-- Top 10 directors with the most content
SELECT
    director,
    COUNT(*) AS content_count
FROM netflix_data
WHERE director IS NOT NULL
GROUP BY director
ORDER BY content_count DESC
LIMIT 10;
-- Longest and shortest duration
SELECT
    title,
    duration
FROM netflix_data
ORDER BY
    CASE WHEN duration LIKE '%h%' THEN CAST(SUBSTRING_INDEX(duration, 'h', 1) AS SIGNED) ELSE 0 END DESC,
    CASE WHEN duration LIKE '%m%' THEN CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(duration, 'h', -1), 'm', 1) AS SIGNED) ELSE 0 END DESC
LIMIT 1;

SELECT
    title,
    duration
FROM netflix_data
ORDER BY
    CASE WHEN duration LIKE '%h%' THEN CAST(SUBSTRING_INDEX(duration, 'h', 1) AS SIGNED) ELSE 0 END ASC,
    CASE WHEN duration LIKE '%m%' THEN CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(duration, 'h', -1), 'm', 1) AS SIGNED) ELSE 0 END ASC
LIMIT 1;

-- Top 10 longest movie titles
SELECT
    title,
    LENGTH(title) AS title_length
FROM netflix_data
WHERE type = 'Movie'
ORDER BY title_length DESC
LIMIT 10;

-- Content added per year
SELECT
    YEAR(date_added) AS year,
    COUNT(*) AS content_count
FROM netflix_data
GROUP BY year
ORDER BY year;
