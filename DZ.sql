
CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL
);


CREATE TABLE publishers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author_id INT NOT NULL REFERENCES authors(id) ON DELETE CASCADE,
    publisher_id INT NOT NULL REFERENCES publishers(id) ON DELETE CASCADE,
    edition VARCHAR(50),
    year_of_publication INT,
    storage_location VARCHAR(100)
);


CREATE TABLE readers (
    id SERIAL PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F')),
    education_level VARCHAR(50)
);


CREATE TABLE book_loans (
    id SERIAL PRIMARY KEY,
    book_id INT NOT NULL REFERENCES books(id) ON DELETE CASCADE,
    reader_id INT NOT NULL REFERENCES readers(id) ON DELETE CASCADE,
    loan_date DATE NOT NULL,
    expected_return_date DATE NOT NULL,
    actual_return_date DATE
);


INSERT INTO authors (last_name, first_name) VALUES
('Пушкин', 'Александр'),
('Толстой', 'Лев');


INSERT INTO publishers (name) VALUES
('Эксмо'),
('АСТ');


INSERT INTO books (title, author_id, publisher_id, edition, year_of_publication, storage_location) VALUES
('Евгений Онегин', 1, 1, '1-е', 1833, 'Полка 1'),
('Война и мир', 2, 2, '2-е', 1869, 'Полка 2');


INSERT INTO readers (last_name, first_name, birth_date, gender, education_level) VALUES
('Иванов', 'Иван', '1990-01-01', 'M', 'Высшее'),
('Петрова', 'Анна', '1995-05-15', 'F', 'Среднее');


INSERT INTO book_loans (book_id, reader_id, loan_date, expected_return_date, actual_return_date) VALUES
(1, 1, '2025-01-20', '2025-01-30', NULL),
(2, 2, '2025-01-21', '2025-01-31', '2025-01-29');



SELECT 
    books.title, 
    authors.last_name || ' ' || authors.first_name AS author,
    publishers.name AS publisher
FROM books
JOIN authors ON books.author_id = authors.id
JOIN publishers ON books.publisher_id = publishers.id;


SELECT 
    readers.last_name || ' ' || readers.first_name AS reader,
    books.title AS book,
    book_loans.loan_date,
    book_loans.expected_return_date,
    book_loans.actual_return_date
FROM book_loans
JOIN books ON book_loans.book_id = books.id
JOIN readers ON book_loans.reader_id = readers.id;


