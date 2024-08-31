# aloka-database
An exploration of a fictional domestic U.S. travel booking database, with initial values created by GenAI and modified by me

## Purpose
To practice and expand my skills and understanding in data analytics and SQL.

## Project Overview
I created a fictional domestic U.S. travel booking datababase, which focuses on customers and bookings for fictional hotels in real U.S. cities.
I have experience with analyzing existing databases in MySQL and PostgreSQL, but this is the first database I have created and locally hosted.
I generated the initial arbitrary values for each table in csv format using prompts I gave to generative AI -- specifically Microsoft Copilot.
I introduced more variability into the data by altering the CSVs before importing, and also altering imported data using SQL commands.

## Database Overview
The aloka database consists of the following tables:
* **cities** (consisting of multiple U.S. cities)
* **customers** (consisting of customer data from various U.S. states)
* **hotel_bookings** (limited to primary/foreign keys and check-in / check-out date columns)
* **hotels** (consisting of hotels and their addresses)
* **payments** (limited to primary/foreign keys, payment dates, and payment amounts columns)
* **states** (consisting of multiple U.S. states)

## The Data
The database was created with an initial dataset of 15 U.S. cities, 30 unique customers, 35 hotel booking and payment records, and 20 unique hotels.
All U.S. states were included in the states table.

## Rationale
I chose to limit the amount of records per table, and rather focus on variability within the data, for two main reasons:
1. I wanted the challenge of creating, maintaining, and analyzing a unique small dataset, without the temptation to piggyback on the analyses and efforts of others
2. No matter how many fake records I create using arbitrary input, AI, faker, etc., the data has no real-world application

## Credits
I would like to thank the many teachers -- including Tech with Tim, Programming with Mosh, and Alex the Analyst -- who have freely provided education and tutorials on programming, computer science, and data analytics on their social media platforms.