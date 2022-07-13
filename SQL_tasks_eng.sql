1. Select all records where the City column has the value "Berlin".

SELECT * from Customers WHERE City = “Berlin”;


2. Select CustomerName, City where the CustomerID column has the value 32.

SELECT CustomerName, City from Customers WHERE CustomerID = 32;


3. Select all records where the City column has the value 'Berlin' and the PostalCode column has the value 12209.

SELECT * from Customers WHERE City = “Berlin” and PostalCode = 12209;


4. Select 3 first rows of the CustomerName, City and Country columns

SELECT CustomerName, City, Country from Customers limit 3;


5. Select all records where the City column has the value 'Berlin', and also the records where the City column has the value 'London'.

SELECT * from Customers WHERE City = “Berlin” OR City = “London”;


6. Select CustomerName, Address, City from the Customers table, sort the result alphabetically by the column City.

SELECT CustomerName, Address, City from Customers ORDER BY City;


7. Select all records from the Customers table, sort the result alphabetically, first by the column Country, then, by the column City

SELECT * from Customers ORDER BY Country, City;


8. Select all records from the Customers where the PostalCode column is empty.

SELECT * from Customers WHERE PostalCode IS NULL;


9. Select CustomerID, CustomerName, PostalCode from the Customers where the PostalCode column is NOT empty.

SELECT CustomerID, CustomerName, PostalCode from Customers WHERE PostalCode IS NOT NULL;


10. Select all the different values from the Country column in the Customers table.

SELECT DISTINCT Country from Customers;


11. Select all records where the value of the City column starts with the letter "a".

SELECT * from Customers WHERE City LIKE “a%”;


12. Select all records where the value of the City column contains the letter "a" and sort by City in descending order.

SELECT * from Customers WHERE City LIKE “%a%” ORDER BY City DESC;


13. Select all records where the value of the City column starts with letter "a" and ends with the letter "b".

SELECT * from Customer WHERE City LIKE “a%b”;


14. Select all records where the value of the City column does NOT start with the letter "a" and where Country is not Germany.

SELECT * from Customers WHERE City NOT LIKE “a%”  and NOT Country = “Germany”;


15. Use the IN operator to select all the records where Country is either "Norway" or "France".

SELECT * from Customers WHERE Country IN (“Norway”, “France”);


16. Select all records from the City of “Bern”, "Berlin", "London" where IDs are greater than 10, but less than 30

SELECT * from Customers WHERE City IN (“Bern”, “Berlin”, “London”) AND CustomerID BETWEEN 10 AND 30;


17. Update the City column of all records in the Customers table.

UPDATE Customers SET City = “New York”;


18. Set the value of the City columns to 'Oslo', but only the ones where the Country column has the value "Norway".

UPDATE Customers SET City = “Oslo” WHERE Country = “Norway”;


19. Update the City value and the Country value for the Customer with ID = 32.

UPDATE Customers SET City = “New York” , Country = “USA” WHERE CustomerID = 32;


20. Delete all the records from the Customers table where the Country value is 'Norway'.

DELETE from Customers WHERE Country = “Norway”;
