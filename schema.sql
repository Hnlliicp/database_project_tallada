
CREATE TABLE Movie (
    mov_id INTEGER PRIMARY KEY,
    mov_title VARCHAR(300) NOT NULL,
    mov_year INTEGER,
    mov_time INTEGER,
    mov_lang VARCHAR(120),
    mov_dt_rel DATE,
    mov_rel_country VARCHAR(30)
);

CREATE TABLE Actor (
    act_id INTEGER PRIMARY KEY,
    act_fname VARCHAR(50) NOT NULL,
    act_lname VARCHAR(50) NOT NULL,
    act_gender CHAR(1)
);

CREATE TABLE Genres (
    gen_id INTEGER PRIMARY KEY,
    gen_title VARCHAR(300) NOT NULL
);

CREATE TABLE Director (
    dir_id INTEGER PRIMARY KEY,
    dir_fname VARCHAR(50) NOT NULL,
    dir_lname VARCHAR(50) NOT NULL
);

CREATE TABLE Reviewer (
    rev_id INTEGER PRIMARY KEY,
    rev_name VARCHAR(100)
);

CREATE TABLE Movie_cast (
    act_id INTEGER,
    mov_id INTEGER,
    role VARCHAR(200),

    PRIMARY KEY (act_id, mov_id),

    FOREIGN KEY (act_id)
        REFERENCES Actor(act_id)
        ON DELETE CASCADE,

    FOREIGN KEY (mov_id)
        REFERENCES Movie(mov_id)
        ON DELETE CASCADE
);

CREATE TABLE Movie_genres (
    mov_id INTEGER,
    gen_id INTEGER,

    PRIMARY KEY (mov_id, gen_id),

    FOREIGN KEY (mov_id)
        REFERENCES Movie(mov_id)
        ON DELETE CASCADE,

    FOREIGN KEY (gen_id)
        REFERENCES Genres(gen_id)
        ON DELETE CASCADE
);

CREATE TABLE Movie_direction (
    dir_id INTEGER,
    mov_id INTEGER,

    PRIMARY KEY (dir_id, mov_id),

    FOREIGN KEY (dir_id)
        REFERENCES Director(dir_id)
        ON DELETE CASCADE,

    FOREIGN KEY (mov_id)
        REFERENCES Movie(mov_id)
        ON DELETE CASCADE
);

CREATE TABLE Rating (
    mov_id INTEGER,
    rev_id INTEGER,
    rev_stars DECIMAL(3,1),
    num_o_ratings INTEGER,

    PRIMARY KEY (mov_id, rev_id),

    FOREIGN KEY (mov_id)
        REFERENCES Movie(mov_id)
        ON DELETE CASCADE,

    FOREIGN KEY (rev_id)
        REFERENCES Reviewer(rev_id)
        ON DELETE CASCADE
);