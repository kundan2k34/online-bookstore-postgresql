-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

--Import Data into Books Table By Using Inbuilt Import/Export Method
--Import Data into Customers Table By Using Inbuilt Import/Export Method
--Import Data into Orders Table By Using Inbuilt Import/Export Method

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;



-- 1) Retrieve all books in the "Fiction" genre:

select * from Books
where genre='Fiction';


-- 2) Find books published after the year 1950:

select * from Books
where published_year>1950;

-- 3) List all customers from the Canada:

select * from Customers
where country='Canada';

-- 4) Show orders placed in November 2023:

select * from orders
where order_date between '2023-11-01' and '2023-11-30';

-- 5) Retrieve the total stock of books available:

select sum(stock) as Total_stock
from Books;

-- 6) Find the details of the most expensive book:

select * from Books order by price desc limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:

select * from Orders
where quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:

select * from Orders
where total_amount>20;

-- 9) List all genres available in the Books table:

select Distinct genre from Books;

-- 10) Find the book with the lowest stock:

select * from Books
order by stock asc limit 1;

-- 11) Calculate the total revenue generated from all orders:

select sum(total_amount) as Revenue from Orders;





--SELECT * FROM Books;
--SELECT * FROM Customers;
--SELECT * FROM Orders;



-- 12) Retrieve the total number of books sold for each genre:

select b.Genre,sum(o.Quantity) as Total_books_sold
from Orders o
join Books b on o.book_id=b.book_id
group by b.Genre;

-- 13) Find the average price of books in the "Fantasy" genre:

select avg(price) as average_price
from Books
where Genre='Fantasy';

-- 14) List customers who have placed at least 2 orders:

select customer_id, count(Order_id) as ORDER_COUNT
from Orders
group by customer_id
having count(order_id)>=2;
--or
select o.customer_id,c.name, count(o.Order_id) as ORDER_COUNT
from Orders o
join customers c on o.customer_id=c.customer_id
group by o.customer_id, c.name
having count(order_id)>=2;


-- 15) Find the most frequently ordered book:

select book_id, count(order_id) as ORDER_COUNT
from Orders
group by book_id
order by ORDER_COUNT desc limit 1;
--or
select o.book_id,b.title,count(o.order_id) as ORDER_COUNT
from Orders o
join Books b on o.book_id=b.book_id
group by o.book_id,b.title
order by ORDER_COUNT desc limit 1;

-- 16) Show the top 3 most expensive books of 'Fantasy' Genre :

select * from books
where genre='Fantasy'
order by price desc limit 3;


-- 17) Retrieve the total quantity of books sold by each author:

select b.author,sum(o.quantity) as total_book_sold
from Books b
join Orders o on o.book_id=b.book_id
group by b.author;

-- 18) List the cities where customers who spent over $30 are located:

select distinct c.city,total_amount
from customers c
join orders o on o.customer_id=c.customer_id
where o.total_amount > 30;



-- 19) Find the customer who spent the most on orders:

select c.customer_id,c.name,sum(o.total_amount) as Total_Spent
from orders o
join customers c on c.customer_id=o.customer_id
group by c.name,c.customer_id
order by Total_Spent desc limit 1;

--20) Calculate the stock remaining after fulfilling all orders:

select b.book_id,b.title,b.stock,coalesce(sum(o.quantity),0) as ORDER_QUANTITY,
		b.stock-coalesce(sum(o.quantity),0) as REMAINING_QUANTITY
from books b
left join orders o on b.book_id=o.book_id
group by b.book_id order by b.book_id;













