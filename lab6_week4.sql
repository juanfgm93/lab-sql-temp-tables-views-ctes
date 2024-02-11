# Create a customer summary report that summarizes rental history and payment details about customers in sakila.
# Step 1: Create a view with customer's ID, name, email address, and total number of rentals:

CREATE VIEW rent_custinfo AS (
				SELECT customer.customer_id, CONCAT(first_name, ' ', last_name) AS full_name, email, COUNT(*) AS rental_count
                FROM customer
                JOIN rental ON customer.customer_id = rental.customer_id
                GROUP BY customer_id);
SELECT * FROM rent_custinfo;

# Step 2: create a temporary table to calculate total amount paid by each customer.
CREATE TEMPORARY TABLE total_paid (
				SELECT rent_custinfo.customer_id, SUM(amount) AS total_amount
                FROM rent_custinfo
                JOIN payment ON payment.customer_id = rent_custinfo.customer_id
                GROUP BY customer_id
                ORDER BY total_amount DESC);
SELECT * FROM total_paid;

# Step 3: Create a CTE. Join the View and Temporary Table above. 
# CTE should include customer's name, email address, rental count, and total amount paid.
WITH summary_report AS (
						SELECT full_name, email, rental_count, total_amount
                        FROM rent_custinfo
                        JOIN total_paid ON rent_custinfo.customer_id = total_paid.customer_id
                        )
SELECT * , total_amount/rental_count AS average_payment_per_rental
FROM summary_report;
                        
                        
                        
                        
                        
                        
                        
                        
                        





