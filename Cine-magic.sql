-- Day1
CREATE DATABASE CineMagic;
USE CineMagic;

CREATE TABLE movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    duration_minutes INT NOT NULL,
    age_restriction INT DEFAULT 0 CHECK (age_restriction IN (0, 13, 16, 18))
);

CREATE TABLE rooms (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    max_seats INT NOT NULL,
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'maintenance'))
);

CREATE TABLE showtimes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT NOT NULL,
    room_id INT NOT NULL,
    show_time DATETIME NOT NULL,
    ticket_price DECIMAL(10, 2) NOT NULL CHECK (ticket_price >= 0),
    
    CONSTRAINT fk_showtime_movie FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    CONSTRAINT fk_showtime_room FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE
);

CREATE TABLE bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    showtime_id INT NOT NULL,
    customer_name VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_booking_showtime FOREIGN KEY (showtime_id) REFERENCES showtimes(id) ON DELETE CASCADE
);

-- Day 2
UPDATE rooms 
SET status = 'maintenance' 
WHERE id = 1;

UPDATE showtimes 
SET room_id = 2 
WHERE room_id = 1;

DELETE FROM bookings 
WHERE phone = '0987654321';

DELETE FROM movies 
WHERE id = 3;
    
-- Day 3
SELECT * FROM movies 
WHERE duration_minutes BETWEEN 90 AND 120;

SELECT * FROM bookings 
WHERE showtime_id = 2 
ORDER BY booking_date DESC;

SELECT * FROM movies 
WHERE age_restriction = 18 OR duration_minutes > 150;

SELECT * FROM showtimes 
WHERE ticket_price > 100000 
AND MONTH(show_time) = MONTH(NOW()) 
AND YEAR(show_time) = YEAR(NOW());