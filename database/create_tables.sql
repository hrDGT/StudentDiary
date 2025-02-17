DO 
$do$
BEGIN
    CREATE TABLE semesters (
        id SERIAL PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        start_date DATE NOT NULL,
        end_date DATE NOT NULL
    );
EXCEPTION
    WHEN duplicate_table THEN
END 
$do$;

DO 
$do$
BEGIN
    CREATE TABLE disciplines (
        id SERIAL PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        semester_id INTEGER,
        FOREIGN KEY (semester_id) REFERENCES semesters(id) ON DELETE CASCADE
    );
EXCEPTION
    WHEN duplicate_table THEN
END 
$do$;

DO 
$do$
BEGIN
    CREATE TABLE labs (
        id SERIAL PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        deadline DATE NOT NULL,
        status VARCHAR(13) NOT NULL,
        grade INTEGER,
        discipline_id INTEGER,
        FOREIGN KEY (discipline_id) REFERENCES disciplines(id) ON DELETE CASCADE
    );
EXCEPTION
    WHEN duplicate_table THEN
END 
$do$;
