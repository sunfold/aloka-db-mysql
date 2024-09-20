/* Initial exploratory queries to understand more about the data.
Each section has prompt(s)/question(s), followed by the answer(s), and then the queries themselves. */



/* Determine how many states have no active customers. ANSWER: 31 */
SELECT COUNT(state_name)
FROM states
WHERE state_id NOT IN 
	(SELECT state
	FROM customers);


/* Determine which state has the highest count of active customers. ANSWER: CA with 6 customers. */
SELECT state, 
	COUNT(state) AS count_state
FROM customers
WHERE active_status = 1
GROUP BY state
ORDER BY count_state DESC
LIMIT 1;


/* Find the minimum, average rounded to 2 places, and maximum amount in payments.
Also find the range, standard deviation, and the count of records in payments.
ANSWER: Min = 567.89, Avg = 2147.79, Max = 4657.89, Range = 4000, Stdev = approx. 976.58, Count = 35 */
SELECT MIN(amount) as min_amount, 
	ROUND(AVG(amount), 2) as avg_amount, 
	MAX(amount) as max_amount,
	MAX(amount) - MIN(amount) as amount_range,
	STDDEV_POP(amount) as amount_stdv,
	COUNT(*) as count_payments
FROM payments;


/* Rank the rounded average gross revenue per customer, partitioned by customer state, ordered by average per state descending.
Limit to 5 entries. ANSWER: 1. MD = $3456.78, 2. WA = $3234.56, 3. OR = $2733.96, SC = $2679.01, NV = $2567.89 */
WITH cavg AS (
	SELECT customer_id, 
		AVG(amount) as avg_amount
	FROM payments
	GROUP BY customer_id
	ORDER BY avg_amount DESC
),
savg AS (
	SELECT c.state, 
		ROUND(AVG(cavg.avg_amount), 2) AS avg_per_state
	FROM cavg
		INNER JOIN customers as c
		USING (customer_id)
	GROUP BY c.state
	ORDER BY avg_per_state DESC
)
SELECT RANK() OVER(ORDER BY avg_per_state DESC) AS ranking,
	state,
	avg_per_state
FROM savg
ORDER BY avg_per_state DESC
LIMIT 5;


/* Find the minimum, rounded avg, maximum, and rounded standard deviation for length of stay in hotel_bookings per year.
Order by average length of stay descending. ANSWER (in terms of average stay): 2022 = 11.00 days, 2024 = 10.54 days, 2023 = 9.63 days */
WITH ddiff AS (
	SELECT EXTRACT(YEAR FROM check_in_date) AS years,
		DATEDIFF(check_out_date, check_in_date) AS date_diff
	FROM hotel_bookings
),
statdiff AS (
	SELECT years,
		MIN(date_diff) as min_stay,
		ROUND(AVG(date_diff), 2) as avg_stay,
		MAX(date_diff) as max_stay,
		ROUND(STDDEV_POP(date_diff), 2) as stddev_stay
	FROM ddiff
	GROUP BY years
)
SELECT years,
	avg_stay,
	min_stay, 
	max_stay,
	stddev_stay
FROM statdiff
ORDER BY avg_stay DESC;


/* Find the total gross revenue per month, per year, for 2023 and 2024. Compare to overall average gross revenue.
Order by highest gross revenue descending. Which month had the highest gross revenue, and what is the overall average gross revenue per month?
ANSWER: February 2024 had the highest monthly gross revenue at $11,726.14. The overall average gross revenue per month is $6558.01. */
WITH dtcte as (
SELECT SUM(amount) as gross_rev,
	YEAR(payment_date) AS year,
	MONTH(payment_date) AS month
FROM payments
GROUP BY YEAR(payment_date), MONTH(payment_date)
)

SELECT
	year,
	month,
	SUM(gross_rev) OVER(PARTITION BY year, month ORDER BY year, month) AS gross_revenue,
	AVG(gross_rev) OVER() as overall_avg_gross_revenue
FROM dtcte
WHERE year IN (2023, 2024)
ORDER BY gross_rev DESC;


/* Determine gross revenue for each hotel. Order by total gross revenue ascending. Which hotel has had the lowest gross revenue?
ANSWER: Phoenix Grand Hotel has had the lowest gross revenue of $789.01. */
SELECT
	hotel_name,
	SUM(amount) as gross_revenue
FROM payments p
	INNER JOIN hotel_bookings
	USING(booking_id)
	
	INNER JOIN hotels
	USING(hotel_id)
GROUP BY hotel_name
ORDER BY gross_revenue;

/* Compare average revenue per each hotel with overall average for all hotels, and calculate the difference between the two. */
SELECT DISTINCT hotel_name, 
	ROUND(AVG(amount) OVER(ORDER BY hotel_name), 2) AS avg_per_hotel,
    ROUND(AVG(amount) OVER(), 2) AS overall_avg,
    ROUND(AVG(amount) OVER(ORDER BY hotel_name) - AVG(amount) OVER(), 2) AS difference
FROM hotels
	INNER JOIN hotel_bookings
	USING (hotel_id)
    
    INNER JOIN payments
    USING (booking_id)
ORDER BY avg_per_hotel DESC;