# Databases using MySQL 8.0 Command Line Client:dolphin:

# Import Database in MySQL?
```
-- make sure add path --> C:\Program Files\MySQL\MySQL Server 8.0\bin
-- go to the saved database directory,
-- then type, mysql -u root -p
-- enter password
-- continue typing, source file.sql
done!
```

# Access your Database?
```sql
-- to view all databases --> show databases;
-- to access one of your databases --> use databasename;
-- to view all tables in your database, show tables;
```

# Access Database Using Python?
* To connect Python with MySQL, you need to first install mysql-connector-python.
* One of the ways to install it is by entering this code on your command prompt/terminal:

`pip install mysql-connector-python`

> C:\Users\Your Name\AppData\Local\Programs\Python\Python36-32\Scripts>python -m pip install mysql-connector-python

[Full documentation link](https://dev.mysql.com/doc/connector-python/en/connector-pythonintroduction.html)

# let's open your notebook and create connection :satisfied:

```sql
import mysql.connector

mydb = mysql.connector.connect (
host = 'localhost',
user = 'root',
password = 'yourpassword',
database = 'yourdatabase')
```
