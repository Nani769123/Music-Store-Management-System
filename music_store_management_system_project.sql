CREATE DATABASE music_store;

USE music_store;

-- 1. Genre and MediaType
CREATE TABLE Genre (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120)
);

-- 2. MediaType
CREATE TABLE MediaType (
    media_type_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120)
);

-- 3. Employee
CREATE TABLE Employee (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    last_name VARCHAR(120),
    first_name VARCHAR(120),
    title VARCHAR(120),
    reports_to INT,
    levels VARCHAR(255),
    birthdate DATE,
    hire_date DATE,
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20),
    phone VARCHAR(50),
    fax VARCHAR(50),
    email VARCHAR(100),
    FOREIGN KEY (reports_to) REFERENCES Employee(employee_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- 4. Customer
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(120),
    last_name VARCHAR(120),
    company VARCHAR(120),
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20),
    phone VARCHAR(50),
    fax VARCHAR(50),
    email VARCHAR(100),
    support_rep_id INT,
    FOREIGN KEY (support_rep_id) REFERENCES Employee(employee_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- 5. Artist
CREATE TABLE Artist (
    artist_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120)
);

-- 6. Album
CREATE TABLE Album (
    album_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(160),
    artist_id INT,
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 7. Track
CREATE TABLE Track (
    track_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200),
    album_id INT,
    media_type_id INT,
    genre_id INT,
    composer VARCHAR(220),
    milliseconds INT,
    bytes INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (album_id) REFERENCES Album(album_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (media_type_id) REFERENCES MediaType(media_type_id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- 8. Invoice
CREATE TABLE Invoice (
    invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    invoice_date DATE,
    billing_address VARCHAR(255),
    billing_city VARCHAR(100),
    billing_state VARCHAR(100),
    billing_country VARCHAR(100),
    billing_postal_code VARCHAR(20),
    total DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 9. InvoiceLine
CREATE TABLE InvoiceLine (
    invoice_line_id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_id INT,
    track_id INT,
    unit_price DECIMAL(10,2),
    quantity INT,
    FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (track_id) REFERENCES Track(track_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 10. Playlist
CREATE TABLE Playlist (
    playlist_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);

-- 11. PlaylistTrack
CREATE TABLE PlaylistTrack (
    playlist_id INT,
    track_id INT,
    PRIMARY KEY (playlist_id, track_id),
    FOREIGN KEY (playlist_id) REFERENCES Playlist(playlist_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (track_id) REFERENCES Track(track_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Employee (
    employee_id, last_name, first_name, title, reports_to,
    levels, birthdate, hire_date, address, city, state,
    country, postal_code, phone, fax, email
)
VALUES
(1, 'Adams', 'Andrew', 'General Manager', 9, 'L6', '1962-02-18', '2016-08-14',
 '11120 Jasper Ave NW', 'Edmonton', 'AB', 'Canada', 'T5K 2N1',
 '1 (780) 428-9482', '1 (780) 428-3457', 'andrew@chinookcorp.com'),

(2, 'Edwards', 'Nancy', 'Sales Manager', 1, 'L4', '1958-12-08', '2016-05-01',
 '825 8 Ave SW', 'Calgary', 'AB', 'Canada', 'T2P 2T3',
 '1 (403) 262-3351', '1 (403) 262-6712', 'nancy@chinookcorp.com'),

(3, 'Peacock', 'Jane', 'Sales Support Agent', 2, 'L1', '1973-08-29', '2017-04-01',
 '1111 6 Ave SW', 'Calgary', 'AB', 'Canada', 'T2P 5M5',
 '+1 (403) 387-3351', '+1 (403) 387-6712', 'jane@chinookcorp.com'),

(4, 'Park', 'Margaret', 'Sales Support Agent', 2, 'L1', '1947-09-19', '2017-05-03',
 '683 10 Street SW', 'Calgary', 'AB', 'Canada', 'T2P 5G3',
 '+1 (403) 262-3443', '+1 (403) 262-6712', 'margaret@chinookcorp.com'),

(5, 'Johnson', 'Steve', 'Sales Support Agent', 2, 'L1', '1965-03-03', '2017-05-08',
 '590 Columbia Blvd W', 'Lethbridge', 'AB', 'Canada', 'T1K 5N8',
 '+1 (403) 291-0987', '+1 (403) 291-0988', 'steve@chinookcorp.com'),

(6, 'Mitchell', 'Michael', 'IT Manager', 1, 'L4', '1972-07-01', '2016-04-01',
 '622 3rd Ave SW', 'Calgary', 'AB', 'Canada', 'T3B 0C5',
 '+1 (403) 246-9887', '+1 (403) 246-9899', 'michael@chinookcorp.com'),

(7, 'King', 'Robert', 'IT Staff', 6, 'L1', '1970-05-29', '2017-02-01',
 '1190 Hayter Rd', 'Edmonton', 'AB', 'Canada', 'T1K 5N8',
 '+1 (403) 456-9986', '+1 (403) 456-8485', 'robert@chinookcorp.com'),

(8, 'Callahan', 'Laura', 'IT Staff', 6, 'L1', '1968-01-09', '2017-02-01',
 '923 5 Ave SW', 'Lethbridge', 'AB', 'Canada', 'T1H 1Y8',
 '+1 (403) 467-3351', '+1 (403) 467-8772', 'laura@chinookcorp.com'),

(9, 'Madan', 'Mohan', 'Senior General Manager', NULL, 'L6', '1955-05-09', '2015-08-17',
 '943 2 Ave NW', 'Edmonton', 'AB', 'Canada', 'T5K 2N1',
 '+1 (780) 428-9482', '+1 (780) 428-3457', 'madan.mohan@chinookcorp.com');

-- While loading dataset it is just getting loaded of 362 records because of null values i have loaded locally
ALTER TABLE Track MODIFY album_id INT NULL;
ALTER TABLE Track MODIFY media_type_id INT NULL;
ALTER TABLE Track MODIFY genre_id INT NULL;
ALTER TABLE Track MODIFY milliseconds INT NULL;
ALTER TABLE Track MODIFY bytes INT NULL;
ALTER TABLE Track MODIFY unit_price DECIMAL(10,2) NULL;
SET GLOBAL local_infile = 1;
SHOW GLOBAL VARIABLES LIKE 'local_infile';
LOAD DATA LOCAL INFILE 'C:/Users/manik/Desktop/Innomatics/MySql/Project/track.csv'
INTO TABLE Track
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(track_id, name, album_id, media_type_id, genre_id, composer, milliseconds, bytes, unit_price)
SET 
    album_id = NULLIF(album_id, ''),
    media_type_id = NULLIF(media_type_id, ''),
    genre_id = NULLIF(genre_id, ''),
    composer = NULLIF(composer, ''),
    milliseconds = NULLIF(milliseconds, ''),
    bytes = NULLIF(bytes, ''),
    unit_price = NULLIF(unit_price, '');



SELECT * FROM Genre;
SELECT * FROM MediaType;
SELECT * FROM Employee;
SELECT * FROM Customer;
SELECT * FROM Artist;
SELECT * FROM Album;
SELECT COUNT(*) FROM Track;
SELECT * FROM Track;
SELECT * FROM Invoice;
SELECT COUNT(*) FROM InvoiceLine;
SELECT * FROM InvoiceLine;
SELECT * FROM Playlist;
SELECT COUNT(*) FROM PlaylistTrack;
SELECT * FROM PlaylistTrack;

/* 1. Who is the senior most employee based on job title? */
SELECT first_name, last_name, title
FROM Employee
ORDER BY title DESC
LIMIT 1;


/* 2. Which countries have the most Invoices? */
SELECT billing_country, COUNT(*) AS total_invoices
FROM Invoice
GROUP BY billing_country
ORDER BY total_invoices DESC;


/* 3. What are the top 3 values of total invoice? */
SELECT invoice_id, total
FROM Invoice
ORDER BY total DESC
LIMIT 3;


/* 4. Which city has the best customers? (City with highest total invoice value) */
SELECT billing_city, SUM(total) AS total_revenue
FROM Invoice
GROUP BY billing_city
ORDER BY total_revenue DESC
LIMIT 1;


/* 5. Who is the best customer? (Customer who spent the most money) */
SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total_spent
FROM Customer c
JOIN Invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 1;


/* 6. Email, first name, last name & Genre of all Rock listeners (Ordered by email) */
SELECT DISTINCT c.email, c.first_name, c.last_name, g.name AS genre
FROM Customer c
JOIN Invoice i ON c.customer_id = i.customer_id
JOIN InvoiceLine il ON i.invoice_id = il.invoice_id
JOIN Track t ON il.track_id = t.track_id
JOIN Genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
ORDER BY c.email ASC;


/* 7. Top 10 artists who created the most Rock tracks */
SELECT ar.name AS artist_name, COUNT(t.track_id) AS rock_track_count
FROM Artist ar
JOIN Album al ON ar.artist_id = al.artist_id
JOIN Track t ON al.album_id = t.album_id
JOIN Genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
GROUP BY ar.artist_id
ORDER BY rock_track_count DESC
LIMIT 10;


/* 8. Return all tracks longer than the average length */
SELECT name, milliseconds
FROM Track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM Track)
ORDER BY milliseconds DESC;


/* 9. Amount spent by each customer on each artist */
SELECT 
    c.first_name,
    c.last_name,
    ar.name AS artist_name,
    SUM(il.unit_price * il.quantity) AS total_spent
FROM Customer c
JOIN Invoice i ON c.customer_id = i.customer_id
JOIN InvoiceLine il ON i.invoice_id = il.invoice_id
JOIN Track t ON il.track_id = t.track_id
JOIN Album al ON t.album_id = al.album_id
JOIN Artist ar ON al.artist_id = ar.artist_id
GROUP BY c.customer_id, ar.artist_id
ORDER BY total_spent DESC;


/* 10. Most popular music genre in each country (highest purchases) */
WITH genre_counts AS (
    SELECT 
        c.country,
        g.name AS genre,
        COUNT(*) AS purchase_count
    FROM Customer c
    JOIN Invoice i ON c.customer_id = i.customer_id
    JOIN InvoiceLine il ON i.invoice_id = il.invoice_id
    JOIN Track t ON il.track_id = t.track_id
    JOIN Genre g ON t.genre_id = g.genre_id
    GROUP BY c.country, g.genre_id
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY country ORDER BY purchase_count DESC) AS rnk
    FROM genre_counts
)
SELECT country, genre, purchase_count
FROM ranked
WHERE rnk = 1
ORDER BY country;


/* 11. Top customer by spending in each country */
WITH customer_totals AS (
    SELECT 
        c.country,
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(i.total) AS total_spent
    FROM Customer c
    JOIN Invoice i ON c.customer_id = i.customer_id
    GROUP BY c.country, c.customer_id
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY country ORDER BY total_spent DESC) AS rnk
    FROM customer_totals
)
SELECT country, first_name, last_name, total_spent
FROM ranked
WHERE rnk = 1
ORDER BY country;
