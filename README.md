# 🗄 Online Bookstore Management System (PostgreSQL)

## 🔍 Overview

This project is a **PostgreSQL-based database system** for an online bookstore.
It demonstrates how to design a relational database, manage structured data, and perform business analysis using SQL queries.

The project is built using separate datasets for books, customers, and orders to follow proper database normalization.

---

## 📁 Project Files

* `online_bookstore.sql` → Contains table creation, data insertion, and analytical SQL queries
* `books.csv` → Dataset containing book details (title, author, price, stock)
* `customers.csv` → Dataset containing customer information (name, city, country)
* `orders.csv` → Dataset containing order details (quantity, total amount, relationships)

---

## 🏗 Database Design

### 📚 Tables Used

* **Books** → Stores book details
* **Customers** → Stores customer information
* **Orders** → Stores order transactions

### 🔗 Relationships

* One customer can place multiple orders
* One book can be ordered multiple times
* Orders table connects Customers and Books using foreign keys

---

## 📌 Key SQL Concepts Used

* 🔹 SELECT, WHERE, DISTINCT
* 🔹 INNER JOIN, LEFT JOIN
* 🔹 GROUP BY, ORDER BY
* 🔹 Aggregate Functions (SUM, COUNT)
* 🔹 Filtering & Sorting
* 🔹 COALESCE (handling NULL values)

---

## 📊 Sample Queries

### 🔹 Top Customer by Spending

```sql
select c.customer_id, c.name, sum(o.total_amount) as total_spent
from orders o
join customers c on c.customer_id = o.customer_id
group by c.customer_id, c.name
order by total_spent desc
limit 1;
```

### 🔹 Cities with High Spending Customers

```sql
select distinct c.city
from customers c
join orders o on o.customer_id = c.customer_id
where o.total_amount > 30;
```

### 🔹 Remaining Stock After Orders

```sql
select b.book_id, b.title, b.stock,
coalesce(sum(o.quantity),0) as order_quantity,
b.stock - coalesce(sum(o.quantity),0) as remaining_quantity
from books b
left join orders o on b.book_id = o.book_id
group by b.book_id
order by b.book_id;
```

---

## 📈 Key Insights

* Identified top spending customers
* Analyzed sales distribution across cities
* Calculated remaining inventory after orders
* Observed purchasing patterns using SQL queries

---

## 🚀 How to Run

1. Open PostgreSQL (pgAdmin / CLI)
2. Create a new database
3. Import CSV files into respective tables (books, customers, orders)
4. Run queries from `online_bookstore.sql`

---

## 🎯 Learning Outcomes

* Designed a normalized relational database
* Worked with multiple datasets (CSV files)
* Performed data analysis using SQL
* Applied JOINs and aggregation functions
* Handled NULL values using COALESCE

---

## 👨‍💻 Author

**Kundan Kumar**
🎓 B.Tech Computer Science (2025)

---

## ⭐ Support

If you found this project useful, please give it a ⭐ on GitHub!!
