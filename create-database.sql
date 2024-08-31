/* Create aloka database */

-- Create then use aloka database
CREATE DATABASE IF NOT EXISTS aloka;
USE aloka;

-- 1. Create states table   
DROP TABLE IF EXISTS states; 
CREATE TABLE states (
	state_id CHAR(2) PRIMARY KEY,
    state_name VARCHAR(20)
	);
    
-- 2. Create cities table
DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
	city_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    state_id CHAR(2),
    city_name VARCHAR(50),
    FOREIGN KEY (state_id) REFERENCES states(state_id)
    );
    
-- 3. Create hotels table
DROP TABLE IF EXISTS hotels; 
CREATE TABLE hotels (
	hotel_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    city_id INT UNSIGNED,
    state_id CHAR(2),
    hotel_name VARCHAR(100) NOT NULL,
    hotel_address VARCHAR(50),
    FOREIGN KEY (city_id) REFERENCES cities(city_id),
    FOREIGN KEY (state_id) REFERENCES states(state_id)
	);    

-- 4. Create customers table
DROP TABLE IF EXISTS customers; 
CREATE TABLE customers (
    customer_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    primary_email VARCHAR(60) UNIQUE NOT NULL,
	birth_date DATE,
    state CHAR(2),
    active_status TINYINT DEFAULT 1, -- 1 indicates active status, 0 indicates inactive status
    create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (state) REFERENCES states(state_id)
    );

-- 5. Create hotel_bookings table
DROP TABLE IF EXISTS hotel_bookings; 
CREATE TABLE hotel_bookings (
    booking_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    customer_id INT UNSIGNED NOT NULL,
    hotel_id INT UNSIGNED NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
    );

-- 6. Create payments table
DROP TABLE IF EXISTS payments;
CREATE TABLE payments (
	payment_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    customer_id INT UNSIGNED NOT NULL,
    booking_id INT UNSIGNED NOT NULL,
	amount DECIMAL(8, 2) NOT NULL,
	payment_date DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (booking_id) REFERENCES hotel_bookings(booking_id)
	);

/* After creating the above tables I imported data via the MySQL Workbench table data import wizard.
I imported the csvs, which contain values created by Microsoft Copilot. */