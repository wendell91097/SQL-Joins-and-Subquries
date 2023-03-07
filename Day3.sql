--1. List all customers who live in Texas (use JOINs)
select customer_id, first_name, last_name, address.district
from customer
inner join address
on customer.address_id = address.address_id
where district = 'Texas'

--2. Get all payments above $6.99 with the Customer's Full Name

select first_name, last_name, payment.amount 
from customer
inner join payment
on customer.customer_id = payment.customer_id 
where payment.amount > 6.99

--3. Show all customers names who have made payments over $175(use subqueries)

select first_name, last_name
from customer
where customer_id in (
	select customer_id
	from payment
	group by customer_id 
	having sum(amount) > 175
	order by sum(amount) desc 
);

--OR looking for one payment over 175

select first_name, last_name
from customer
where customer_id in (
	select customer_id 
	from payment 
	where amount > 175
);


--4. List all customers that live in Nepal (use the city table)

select customer.first_name, customer.last_name, customer.email, country
from customer
full join address
on customer.address_id = address.address_id
full join city
on address.city_id = city.city_id 
full join country
on country.country_id = country.country_id 
where country = 'Nepal';

--5. Which staff member had the most transactions?

select staff.first_name, staff.last_name, count(payment_id)
from staff
full join payment
on staff.staff_id = payment.staff_id
group by staff.staff_id
order by count(payment_id) desc limit 1

--OR one without the amount of sales

select first_name, last_name 
from staff
where staff_id in (
	select staff_id
	from payment
	group by staff_id  
	order by count(payment_id) desc limit 1
);

--6. How many movies of each rating are there? 

--the ez answer

select rating, count(rating)
from film
group by rating
order by count(rating)

--OR do this

select rating, count(rating)
from film
inner join inventory
on film.film_id = inventory.film_id
group by rating
order by count(rating)

--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)

select *
from customer
where customer_id in (
	select customer_id
	from payment
	where amount > 6.99
	group by customer_id
--	THIS NEXT LINE WAS THE ONLY WAY I COULD THINK OF TO FIGURE OUT IF THERE WAS ONLY ONE PAYMENT
	having sum(customer_id) = customer_id 
	order by customer_id
);

--8. How many free rentals did our store give away?

select count(payment_id), amount
from payment
where amount = 0
group by amount