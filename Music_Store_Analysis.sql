/*Q1: Who is the senior most employee based on job title? */

SELECT title, last_name, first_name 
FROM employee
ORDER BY levels DESC
LIMIT 1;

/*Q2: Top 5 countries have the most Invoices? */

SELECT  billing_country, COUNT(*) AS total_invoices
FROM invoice
GROUP BY billing_country
ORDER BY total_invoices DESC
LIMIT 5;

/* Q3. What are top 3 values of total invoice?*/

SELECT total 
FROM invoice
ORDER BY total DESC
Limit 3;

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival
in the city we made the most money. Write a query that returns one city that has the highest sum
of invoice totals.Return both the city name & sum of all invoice totals */

SELECT billing_city, SUM(total) AS Invoice_total FROM invoice
GROUP BY billing_city
ORDER BY Invoice_total DESC 
LIMIT 1;

/* Q5: Who are the 3 best customer? The customers who have spent the most money will be declared 
the best customers. Write a query that returns the persons who has spent the most money.*/

SELECT customer.customer_id, first_name, last_name, SUM(total) AS total_spending
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total_spending DESC
LIMIT 3;

/* Q6: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

SELECT DISTINCT email,first_name,last_name 
FROM customer as cust
JOIN invoice AS inv ON cust.customer_id=inv.customer_id
JOIN invoice_line as invl ON inv.invoice_id=invl.invoice_id
WHERE track_id IN (
					SELECT track_id
					FROM track AS track 
					JOIN genre AS genre
					ON track.genre_id=genre.genre_id
					WHERE genre.name LIKE 'Rock')
ORDER BY email;

/* Q7: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

SELECT art.artist_id,art.name AS artist_name,COUNT(art.artist_id) AS number_of_songs
FROM artist AS art
JOIN album AS alb ON art.artist_id=alb.artist_id
JOIN track AS track ON alb.album_id=track.album_id
JOIN genre as gen ON track.genre_id=gen.genre_id
WHERE gen.name LIKE 'Rock'
GROUP BY art.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;

/* Q8: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest 
songs listed first. */

SELECT name AS track_name,milliseconds AS duration FROM track
WHERE milliseconds>(
			SELECT AVG(milliseconds) AS average_track_length 
			FROM track)
ORDER BY duration DESC;

