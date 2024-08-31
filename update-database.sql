/* Update aloka database */

/* I updated customer values to change 5 states to CA, 3 states to NC, 2 states to SC, and 1 state to NY */
UPDATE customers
SET state = 'CA'
WHERE customer_id IN (12, 17, 24, 27, 28);

UPDATE customers
SET state = 'NC'
WHERE customer_id IN (5, 8, 18);

UPDATE customers
SET state = 'SC'
WHERE customer_id IN (7, 30);

UPDATE CUSTOMERS
SET STATE = 'NY'
WHERE customer_ID = 26;

-- ----------------------------------------------------------------------

/* I updated the dates of 8 records in hotel_bookings to add some variance within the data */

-- 2 records affected
UPDATE hotel_bookings
SET check_out_date = DATE_ADD(check_out_date, INTERVAL 6 DAY)
WHERE customer_id = 5;

-- 1 record affected
UPDATE hotel_bookings
SET check_out_date = DATE_ADD(check_out_date, INTERVAL 4 DAY)
WHERE customer_id = 6;

-- 2 records affected
UPDATE hotel_bookings
SET check_in_date = DATE_ADD(check_in_date, INTERVAL 3 DAY)
WHERE customer_id = 11;

-- 1 record affected
UPDATE hotel_bookings
SET check_in_date = DATE_ADD(check_in_date, INTERVAL 5 DAY)
WHERE customer_id = 14;

-- 2 records affected
UPDATE hotel_bookings
SET check_out_date = DATE_ADD(check_out_date, INTERVAL 11 DAY)
WHERE customer_id = 18;

-- 2 records affected
UPDATE hotel_bookings
SET check_in_date = DATE_ADD(check_in_date, INTERVAL 6 DAY)
WHERE customer_id = 20;