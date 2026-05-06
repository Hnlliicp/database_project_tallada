-- all movies 
SELECT * FROM Movie;

-- actors in movies
SELECT 
    Actor.act_fname,
    Actor.act_lname,
    Movie.mov_title,
    Movie_cast.role
FROM Movie_cast
JOIN Actor ON Movie_cast.act_id = Actor.act_id
JOIN Movie ON Movie_cast.mov_id = Movie.mov_id;

-- movie ratings
SELECT 
    Movie.mov_title,
    Rating.rev_stars,
    Reviewer.rev_name
FROM Rating
JOIN Movie ON Rating.mov_id = Movie.mov_id
JOIN Reviewer ON Rating.rev_id = Reviewer.rev_id;

-- Movies with their genre
SELECT 
    Movie.mov_title,
    Genres.gen_title
FROM Movie_genres
JOIN Movie ON Movie_genres.mov_id = Movie.mov_id
JOIN Genres ON Movie_genres.gen_id = Genres.gen_id;