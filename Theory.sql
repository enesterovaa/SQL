#Запросы SQL
+---------+-----------------------+------------------+--------+--------+
| book_id | title                 | author           | price  | amount |
+---------+-----------------------+------------------+--------+--------+
| 1       | Мастер и Маргарита    | Булгаков М.А.    | 670.99 | 3      |
| 2       | Белая гвардия         | Булгаков М.А.    | 540.50 | 5      |
| 3       | Идиот                 | Достоевский Ф.М. | 460.00 | 10     |
| 4       | Братья Карамазовы     | Достоевский Ф.М. | 799.01 | 2      |
| 5       | Стихотворения и поэмы | Есенин С.А.      | 650.00 | 15     |
+---------+-----------------------+------------------+--------+--------+

1. Выбрать все записи таблицы book.

SELECT * FROM book;


2. Выбрать несколько (или один) столбцов из таблицы.

SELECT title, amount FROM book;


3. Выборка новых столбцов и присвоение им новых имен.
Пример 1.
Выбрать все названия книг и их количества из таблицы book , 
для столбца title задать новое имя Название.

SELECT title AS Название, amount 
FROM book;

Пример 2.
Выбрать названия книг и авторов из таблицы book, для поля title задать имя(псевдоним) Название, 
для поля author –  Автор. 

SELECT title AS Название, author AS Автор FROM book;


4. Выборка данных с созданием вычисляемого столбца.
Пример 1.
Вывести всю информацию о книгах, а также для каждой позиции посчитать ее стоимость 
(произведение цены на количество). Вычисляемому столбцу дать имя total.

SELECT title, author, price, amount, 
     price * amount AS total 
FROM book;

Пример 2.
Для упаковки каждой книги требуется один лист бумаги, цена которого 1 рубль 65 копеек. 
Посчитать стоимость упаковки для каждой книги (сколько денег потребуется, чтобы упаковать все экземпляры книги). 
В запросе вывести название книги, ее количество и стоимость упаковки, последний столбец назвать pack.

SELECT title, amount, amount * 1.65 AS pack FROM book;


5. Математические функции, округление.
Пример 1.
В конце года цену всех книг на складе пересчитывают – снижают ее на 30%. 
Написать SQL запрос, который из таблицы book выбирает названия, авторов, количества и вычисляет новые цены книг. 
Столбец с новой ценой назвать new_price, цену округлить до 2-х знаков после запятой.

SELECT title, author, amount,
	   /* ROUND(x,k)
	   округляет значение х до k знаков после запятой,
	   если k не указано, то х округляется до целого.

	   ROUND(4.361)=4
       ROUND(5.86592,1)=5.9
	
	Столбец price умножаем на цену - 30% = price*0.7 и округляем до 2 знаков после запятой.*/
	ROUND ((price * 0.7), 2) AS new_prise
FROM book;


6. Выборка данных, вычисляемые столбцы, логические функции.
Вносим в поле значение в зависимости от условия. Для этого используется функция IF:

IF(логическое_выражение, выражение_1, выражение_2)

Функция вычисляет логическое_выражение, если оно истина – в поле заносится значение выражения_1, 
в противном случае –  значение выражения_2. Все три параметра IF() являются обязательными.

Допускается использование вложенных функций, вместо выражения_1 или выражения_2 может стоять новая функция IF.
Пример 1.
Для каждой книги из таблицы book установим скидку следующим образом: если количество книг меньше 4, 
то скидка будет составлять 50% от цены, в противном случае 30%. Цена по скидке должна отображаться 
с двумя знаками после запятой.

SELECT title, amount, price, 
    ROUND(IF(amount<4, price*0.5, price*0.7),2) AS sale
FROM book; 

Пример 2.
Усложним вычисление скидки в зависимости от количества книг. 
Если количество книг меньше 4 – то скидка 50%, меньше 11 – 30%, в остальных случаях – 10%. 
И еще укажем какая именно скидка на каждую книгу.*/


SELECT title, amount, price,
    ROUND(IF(amount < 4, price * 0.5, IF(amount < 11, price * 0.7, price * 0.9)), 2) AS sale,
    IF(amount < 4, 'скидка 50%', IF(amount < 11, 'скидка 30%', 'скидка 10%')) AS Ваша_скидка
FROM book;

Пример 3.
При анализе продаж книг выяснилось, что наибольшей популярностью пользуются книги Михаила Булгакова, 
на втором месте книги Сергея Есенина. Исходя из этого решили поднять цену книг Булгакова на 10%, 
а цену книг Есенина - на 5%. Написать запрос, куда включить автора, название книги и новую цену, 
последний столбец назвать new_price. Значение округлить до двух знаков после запятой.

SELECT author, title, 
	ROUND(if(author = 'Булгаков М.А.', price * 1.1, if (author = 'Есенин С.А.', price * 1.05, price)), 2) 
	AS new_price 
FROM book;


7. Выборка данных по условию.
Пример 1.
Вывести название и цену тех книг, цены которых меньше 600 рублей.

SELECT title, price 
FROM book
WHERE price < 600;

Пример 2. 
Вывести название, автора  и стоимость (цена умножить на количество) тех книг, стоимость которых больше 4000 рублей.

SELECT title, author, price * amount AS total
FROM book
WHERE price * amount > 4000; /* В логическом выражении после WHERE нельзя использовать названия столбцов, 
присвоенные им с помощью AS,  так как при выполнении запроса сначала вычисляется логическое выражение 
для каждой строки исходной таблицы, выбираются строки, для которых оно истинно. 
А только после этого формируется "шапка запроса" – столбцы, включаемые в запрос.*/

Пример 3.
Вывести автора, название  и цены тех книг, количество которых меньше 10.

SELECT author, title, price FROM book WHERE amount < 10;


8. Выборка данных, логические операции (AND, OR, NOT).
Пример 1.
Вывести название, автора и цену тех книг, которые написал Булгаков, ценой больше 600 рублей.

SELECT title, author, price 
FROM book
WHERE price > 600 AND author = 'Булгаков М.А.';

Пример 2.
Вывести название, цену  тех книг, которые написал Булгаков или Есенин, ценой больше 600 рублей.

SELECT title, author, price 
FROM book
WHERE (author = 'Булгаков М.А.' OR author = 'Есенин С.А.') AND price > 600; /* В данном запросе обязательно 
нужно поставить скобки, так как без них сначала вычисляется  author = 'Есенин С.А.' and price > 600, 
а потом уже выражение через or. Без скобок были бы отобраны все книги Булгакова и те книги Есенина, цена которых больше 600.*/

Пример 3.
Вывести название, автора,  цену  и количество всех книг, цена которых меньше 500 или больше 600, 
а стоимость всех экземпляров этих книг больше или равна 5000.

SELECT title, author, price, amount 
FROM book 
WHERE (price > 500 OR price < 600) AND (price * amount) > 5000;


9. Выборка данных, операторы BETWEEN, IN.
Пример 1.
Выбрать названия и количества тех книг, количество которых от 5 до 14 включительно.

SELECT title, amount 
FROM book
WHERE amount BETWEEN 5 AND 14;

Пример 2.
Выбрать названия и цены книг, написанных Булгаковым или Достоевским.

SELECT title, price 
FROM book
WHERE author IN ('Булгаков М.А.', 'Достоевский Ф.М.'); /*Можно записать и с OR, но так короче, если будет больше вариантов.*/

Пример 3.
Вывести название и авторов тех книг, цены которых принадлежат интервалу от 540.50 до 800 (включая границы),  
а количество или 2, или 3, или 5, или 7.

SELECT title, author 
FROM book
WHERE (price BETWEEN 540.50 AND 800) AND (amount IN (2, 3, 5, 7));


10. Выборка данных с сортировкой
При выборке можно указывать столбец или несколько столбцов, по которым необходимо отсортировать отобранные строки. 
Для этого используются ключевые слова ORDER BY, после которых задаются имена столбцов. 
При этом строки сортируются по первому столбцу, если указан второй столбец, 
сортировка осуществляется только для тех строк, у которых значения первого столбца одинаковы. 
По умолчанию ORDER BY выполняет сортировку по возрастанию. Чтобы управлять направлением сортировки вручную, 
после имени столбца указывается ключевое слово ASC (по возрастанию) или DESC (по убыванию). 

Столбцы после ключевого слова ORDER BY можно задавать:
-названием столбца;
-номером столбца;
-именем столбца (указанным после AS).
Важно! Если названия столбцов заключены в кавычки, то при использовании их в сортировке, необходимо записывать их БЕЗ КАВЫЧЕК

Пример 1.
Вывести название, автора и цены книг. Информацию  отсортировать по названиям книг в алфавитном порядке.

SELECT title, author, price
FROM book
ORDER BY title;

Аналогичный результат получится при использовании запроса:

SELECT title, author, price
FROM book
ORDER BY 1; /*значения 1...3 - это те колонки, которые вы выбрали в SELECT (Здесь 1 - title, 2 - author, 3 - price)*/

Пример 2.
Вывести автора, название и количество книг, в отсортированном в алфавитном порядке по автору и по убыванию количества, 
для тех книг, цены которых меньше 750 рублей.

SELECT author, title, amount AS Количество
FROM book
WHERE price < 750
ORDER BY author, amount DESC;

Пример 3.
Вывести  автора и название  книг, количество которых принадлежит интервалу от 2 до 14 (включая границы). 
Информацию  отсортировать сначала по авторам (в обратном алфавитном порядке), а затем по названиям книг (по алфавиту).

SELECT author, title
FROM book
WHERE amount BETWEEN 2 AND 14
ORDER BY author DESC, title ASC;


11. Выборка данных, оператор LIKE
Оператор LIKE используется для сравнения строк. В отличие от операторов отношения равно (=) и не равно (<>), 
LIKE позволяет сравнивать строки не на полное совпадение (не совпадение), а в соответствии с шаблоном. 
Шаблон может включать обычные символы и символы-шаблоны. При сравнении с шаблоном, 
его обычные символы должны в точности совпадать с символами, указанными в строке. 
Символы-шаблоны могут совпадать с произвольными элементами символьной строки.
% - Любая строка, содержащая ноль или более символов
_ (подчеркивание) - Любой одиночный символ.

Пример 1.
Вывести названия книг, начинающихся с буквы «Б».

SELECT title 
FROM book
WHERE title LIKE 'Б%'; /* эквивалентное условие 
title LIKE 'б%'
*/

Пример 2.
Вывести название книг, состоящих ровно из 5 букв.

SELECT title FROM book 
WHERE title LIKE "_____"

Пример 3.
Вывести книги, название которых длиннее 5 символов:

SELECT title FROM book 
WHERE title LIKE "______%";
/* эквивалентные условия 
title LIKE "%______"
title LIKE "%______%"
*/

Пример 4.
Вывести названия книг, которые содержат букву "и" как отдельное слово, если считать, 
что слова в названии отделяются друг от друга пробелами и не содержат знаков препинания.

SELECT title FROM book 
WHERE   title LIKE "_% и _%" /*отбирает слово И внутри названия */
    OR title LIKE "и _%" /*отбирает слово И в начале названия */
    OR title LIKE "_% и" /*отбирает слово И в конце названия */
    OR title LIKE "и" /* отбирает название, состоящее из одного слова И */

Пример 5:
Вывести названия книг, которые состоят ровно из одного слова, если считать, 
что слова в названии отделяются друг от друга пробелами.

SELECT title FROM book 
WHERE title NOT LIKE "% %"; /*Отсутствие пробела в названии означает, что оно состоит из одного слова. 
Чтобы это проверить используется оператор NOT LIKE, который в данном случае отберет все названия, в которых нет пробелов.*/

Пример 6.
Вывести название и автора тех книг, название которых состоит из двух и более слов, а инициалы автора содержат букву «С». 
Считать, что в названии слова отделяются друг от друга пробелами и не содержат знаков препинания, 
между фамилией автора и инициалами обязателен пробел, инициалы записываются без пробела в формате: 
буква, точка, буква, точка. Информацию отсортировать по названию книги в алфавитном порядке.  

SELECT title, author
FROM book
WHERE title LIKE "_% _%" AND (author LIKE "_% С.%." OR author LIKE "_% %.С.")
ORDER BY title ASC; 


12. Выбор уникальных элементов столбца.
Чтобы отобрать уникальные элементы некоторого столбца используется ключевое слово DISTINCT, 
которое размещается сразу после SELECT.

Пример 1.
Выбрать различных авторов, книги которых хранятся в таблице book.

SELECT DISTINCT author
FROM book;       


Другой способ – использование оператора GROUP BY, который группирует данные при выборке, 
имеющие одинаковые значения в некотором столбце. Столбец, по которому осуществляется группировка, 
указывается после GROUP BY .
С помощью GROUP BY можно выбрать уникальные элементы столбца, по которому осуществляется группировка. 
Результат будет точно такой же как при использовании DISTINCT.

SELECT  author
FROM book
GROUP BY author;


13. Выборка данных, групповые функции SUM и COUNT 

Пример 1.

Посчитать, сколько экземпляров книг каждого автора хранится на складе.

SELECT author, SUM(amount)
FROM book
GROUP BY author;

Пример 2.
Посчитать, сколько различных книг каждого автора хранится на складе.

Для этого примера в таблицу book добавлена запись с пустыми значениями в столбцах amount и price:
+---------+-----------------------+------------------+--------+--------+
| book_id | title                 | author           | price  | amount |
+---------+-----------------------+------------------+--------+--------+
| 1       | Мастер и Маргарита    | Булгаков М.А.    | 670.99 | 3      |
| 2       | Белая гвардия         | Булгаков М.А.    | 540.50 | 5      |
| 3       | Идиот                 | Достоевский Ф.М. | 460.00 | 10     |
| 4       | Братья Карамазовы     | Достоевский Ф.М. | 799.01 | 3      |
| 5       | Игрок                 | Достоевский Ф.М. | 480.50 | 10     |
| 6       | Стихотворения и поэмы | Есенин С.А.      | 650.00 | 15     |
| 7       | Черный человек        | Есенин С.А.      | Null   | Null   |
+---------+-----------------------+------------------+--------+--------+

SELECT author, COUNT(author), COUNT(amount), COUNT(*)
FROM book
GROUP BY author;

Результат:
+------------------+---------------+---------------+----------+
| author           | COUNT(author) | COUNT(amount) | COUNT(*) |
+------------------+---------------+---------------+----------+
| Булгаков М.А.    | 2             | 2             | 2        |
| Достоевский Ф.М. | 3             | 3             | 3        |
| Есенин С.А.      | 2             | 1             | 2        |
+------------------+---------------+---------------+----------+

Из таблицы с результатами запроса видно, что функцию COUNT() можно применять к любому столбцу, 
в том числе можно использовать и *, если таблица не содержит пустых значений. 
Если же в столбцах есть значения Null, (для группы по автору Есенин в нашем примере), то

-COUNT(*) —  подсчитывает  все записи, относящиеся к группе, в том числе и со значением NULL;
-COUNT(имя_столбца) — возвращает количество записей конкретного столбца (только NOT NULL), относящихся к группе.

ВАЖНО.
Если столбец указан в SELECT  БЕЗ применения групповой функции, то он обязательно должен быть указан и в GROUP BY.
Иначе получим ошибку.

Пример 3.
Посчитать, количество различных книг и количество экземпляров книг каждого автора , хранящихся на складе.  
Столбцы назвать Автор, Различных_книг и Количество_экземпляров соответственно.

SELECT author AS Автор, COUNT(title) AS Различных_книг, SUM(amount) AS Количество_экземпляров
FROM book
GROUP BY author;

14. Выборка данных, групповые функции MIN, MAX и AVG

Пример 1.

Вывести минимальную цену книги каждого автора.

SELECT author, MIN(price) AS min_price
FROM book
GROUP BY author;

Пример 2.
Вывести фамилию и инициалы автора, минимальную, максимальную и среднюю цену книг каждого автора . 
Вычисляемые столбцы назвать Минимальная_цена, Максимальная_цена и Средняя_цена соответственно.

SELECT author, MIN(price) AS Минимальная_цена, MAX(price) AS Максимальная_цена, AVG(price) AS Средняя_цена
FROM book
GROUP BY author;

15. Выборка данных c вычислением, групповые функции
В качестве аргумента групповых функций  SQL может использоваться не только столбец, 
но и любое допустимое в SQL арифметическое выражение.

Пример 1.
Вывести суммарную стоимость книг каждого автора.

SELECT author, SUM(price * amount) AS Стоимость
FROM book
GROUP BY author;

Пример 2.
Для каждого автора вычислить суммарную стоимость книг S (имя столбца Стоимость), 
а также вычислить налог на добавленную стоимость  для полученных сумм (имя столбца НДС ) , 
который включен в стоимость и составляет k = 18%,  а также стоимость книг  (Стоимость_без_НДС) без него. 
Значения округлить до двух знаков после запятой. В запросе для расчета НДС(tax) и 
Стоимости без НДС(S_without_tax) использовать следующие формулы:

tax = (S * k/100) / (1 + k/100)

S_without_tax = S / (1 + k/100)

SELECT author, SUM(price * amount) AS Стоимость, 
ROUND(SUM(price * amount) * 0.18 / 1.18, 2) AS НДС, 
ROUND(SUM(price * amount)/1.18, 2) AS Стоимость_без_НДС
FROM book
GROUP BY author;

16. Вычисления по таблице целиком
Групповые функции позволяют вычислять итоговые значения по всей таблице. 
Например, можно посчитать общее количество книг на складе, вычислить суммарную стоимость и пр. 
Для этого после ключевого слова SELECT указывается групповая функция для выражения или имени столбца, 
а ключевые слова GROUP BY опускаются.

Пример 1.
Посчитать количество экземпляров книг на складе.

SELECT SUM(amount) AS Количество
FROM book;

Результатом такого запроса является единственная строка с вычисленными по таблице значениями.

Пример 2.
Посчитать общее количество экземпляров книг на складе и их стоимость .

SELECT SUM(amount) AS Количество, 
    SUM(price * amount) AS Стоимость
FROM book;

Пример 3.
Вывести  цену самой дешевой книги, цену самой дорогой и среднюю цену уникальных книг на складе. 
Названия столбцов Минимальная_цена, Максимальная_цена, Средняя_цена соответственно. 
Среднюю цену округлить до двух знаков после запятой.

Пояснение. В задании нужно посчитать среднюю цену уникальных книг на складе, 
а не среднюю цену всех экземпляров книг.

SELECT MIN(price) AS Минимальная_цена, MAX(price) AS Максимальная_цена, ROUND(AVG(price), 2) AS Средняя_цена
FROM book;

17. Выборка данных по условию, групповые функции
В запросы с групповыми функциями можно включать условие отбора строк, которое в обычных запросах 
записывается после WHERE. В запросах с групповыми функциями вместо WHERE используется ключевое слово HAVING , 
которое размещается после оператора GROUP BY.

Пример 1.

Найти минимальную и максимальную цену книг всех авторов, общая стоимость книг которых больше 5000. 
Результат вывести по убыванию минимальной цены.

SELECT author,
    MIN(price) AS Минимальная_цена, 
    MAX(price) AS Максимальная_цена
FROM book
GROUP BY author
HAVING SUM(price * amount) > 5000
ORDER BY Минимальная_цена DESC;

Пример 2.
Вычислить среднюю цену и суммарную стоимость тех книг, количество экземпляров которых принадлежит интервалу
от 5 до 14, включительно. Столбцы назвать Средняя_цена и Стоимость, значения округлить до 2-х знаков после запятой. 

 SELECT 
    ROUND(AVG(price), 2) AS Средняя_цена, 
    SUM(price * amount) AS Стоимость
FROM book
WHERE amount BETWEEN 5 AND 14;

18. Выборка данных по условию, групповые функции, WHERE и HAVING

WHERE и HAVING могут использоваться в одном запросе. При этом необходимо учитывать порядок выполнения  
SQL запроса на выборку на СЕРВЕРЕ:

FROM
WHERE
GROUP BY
HAVING
SELECT
ORDER BY
Сначала определяется таблица, из которой выбираются данные (FROM), 
затем из этой таблицы отбираются записи в соответствии с условием  WHERE, 
выбранные данные агрегируются (GROUP BY),  из агрегированных записей выбираются те, 
которые удовлетворяют условию после HAVING. Потом формируются данные результирующей выборки, 
как это указано после SELECT ( вычисляются выражения, присваиваются имена и пр. ). 
Результирующая выборка сортируется, как указано после ORDER BY.

Важно! Порядок ВЫПОЛНЕНИЯ запросов - это не порядок ЗАПИСИ ключевых слов в запросе на выборку. 
 
Порядок ВЫПОЛНЕНИЯ  нужен для того, чтобы понять, почему, например, в WHERE нельзя использовать 
имена выражений из SELECT. Просто SELECT выполняется компилятором позже, чем WHERE, 
поэтому ему неизвестно, какое там выражение написано.

Пример 1.

Вывести максимальную и минимальную цену книг каждого автора, кроме Есенина, количество экземпляров книг которого больше 10. 

SELECT author,
    MIN(price) AS Минимальная_цена,
    MAX(price) AS Максимальная_цена
FROM book
WHERE author <> 'Есенин С.А.'
GROUP BY author
HAVING SUM(amount) > 10;

Пример 2.
Посчитать стоимость всех экземпляров каждого автора без учета книг «Идиот» и «Белая гвардия». 
В результат включить только тех авторов, у которых суммарная стоимость книг (без учета книг «Идиот» и «Белая гвардия») 
более 5000 руб. Вычисляемый столбец назвать Стоимость. Результат отсортировать по убыванию стоимости.

SELECT author,
    SUM(price * amount) AS Стоимость
FROM book
WHERE title <> "Белая гвардия" AND title <> "Идиот"
GROUP BY author
HAVING SUM(price * amount) > 5000
ORDER BY Стоимость DESC;

19. 