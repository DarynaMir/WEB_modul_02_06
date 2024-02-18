-- таблиці груп
DROP TABLE IF EXISTS groups CASCADE;
CREATE TABLE groups (
	id SERIAL PRIMARY KEY,
	name VARCHAR (50) NOT NULL
);

-- таблиці студентів
DROP TABLE IF EXISTS students CASCADE;
CREATE TABLE students (
	id SERIAL PRIMARY KEY,
	fullname VARCHAR (100) NOT NULL,
	group_id INTEGER REFERENCES groups(id)
);

-- таблиці викладачів
DROP TABLE IF EXISTS teachers CASCADE;
CREATE TABLE teachers (
	id SERIAL PRIMARY KEY,
	name VARCHAR (100) NOT NULL
);

-- таблиці предметів
DROP TABLE IF EXISTS subjects CASCADE;
CREATE TABLE subjects (
	id SERIAL PRIMARY KEY,
	name VARCHAR (100) NOT NULL,
	teacher_id INTEGER REFERENCES teachers(id)
);

-- таблиці оцінок
DROP TABLE IF EXISTS grades CASCADE;
CREATE TABLE grades (
	id SERIAL PRIMARY KEY,
	student_id INTEGER REFERENCES students(id),
	subject_id INTEGER REFERENCES subjects(id),
	grade INTEGER CHECK (grade >= 0 AND grade <= 100),
	grade_date DATE NOT NULL
);
