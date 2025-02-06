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
