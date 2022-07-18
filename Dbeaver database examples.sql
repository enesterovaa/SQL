Задания по пробной базе данных из DBeaver.

1. Вывести всех клиентов (фамилию, имя и имейл), фамилия которых начинается на B

SELECT FirstName,
		 LastName,
		 Email
FROM Customer
WHERE LastName LIKE 'B%';

1*. Для каждой буквы алфавита вывести количество клиентов, для которых фамилия начинается с этой буквы. 
Букву вывести в отдельном столбце, назвать letter.
 
SELECT SUBSTR (LastName, 1, 1) letter, 
		 COUNT (*)
FROM Customer
GROUP BY  SUBSTR (LastName, 1, 1)
ORDER BY  1 ASC;

2. Вывести для каждого из клиентов из п. 1 сумму их инвойсов

SELECT Customer.FirstName,
		 Customer.LastName,
		 Invoice.CustomerId,
		 SUM(Invoice.Total)
FROM Customer
INNER JOIN Invoice
	ON Customer.CustomerId = Invoice.CustomerId
WHERE LastName LIKE 'B%'
GROUP BY  LastName;

3. Вывести для каждого из клиентов из п. 1 их максимальный инвойс и минимальный инвойс, а также разницу между ними
столбец максимальный инвойс назовите maxInvoice, минимальный инвойс - minInvoice, разницу между ними - delta

SELECT FirstName,
		 LastName,
		 Email,
		 Invoice.CustomerId,
		 MAX(Invoice.Total) AS максимальный_инвойс,
		 MIN(Invoice.Total) AS минимальный_инвойс,
		 MAX(Invoice.Total) - MIN(Invoice.Total) AS delta
FROM Customer
INNER JOIN Invoice
	ON Customer.CustomerId = Invoice.CustomerId
WHERE LastName LIKE 'B%'
GROUP BY  LastName;