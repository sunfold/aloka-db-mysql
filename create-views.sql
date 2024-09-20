/* Create views */



/* Create view to return all customers' concatenated ID + full name */
CREATE VIEW all_customers
AS 
SELECT concat(customer_id, ": ", first_name, " ", + last_name) AS full_customer
FROM customers;
