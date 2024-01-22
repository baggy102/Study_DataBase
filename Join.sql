내부 조인

> 기본 형태

SELECT <열 목록>
FROM <테이블>
	INNER JOIN <두 번째 테이블>
	ON <조인 조건>
[WHERE 검색 조건]

> 예시

SELECT * FROM customers INNER JOIN orders
	ON customers.customerNumber = orders.customerNumber
	WHERE customers.customerNumer = '20';

SELECT customerNumber, customerName, city, contry, CONCAT(phone, postalCode) AS '배송'
	FROM customers
		INNER JOIN orders
		ON customers.customerNumber = orders.customerNumber;

SELECT customers.customerNumber, customerName, city, country, CONCAT(phone, postalCode) AS '배송'
	FROM customers
		INNER JOIN orders
		ON customers.customerNumber = orders.customerNumber;


외부조인

> 형태

SELECT <열 목록>
FROM <테이블(LEFT 테이블)>
	<LEFT | RIGHT | FULL> OUTER JOIN <두 번째 테이블(RIGHT 테이블)>
	ON <조인 조건>
[WHERE 검색 조건];

> 예시

> Left Outer JOIN

SELECT C.customerNumber, C.customerName, C.city, C.country
	FROM customers C
		LEFT OUTER JOIN orders O
		ON C.customerNumber = O.customerNumber
	ORDER BY C.customerNumber;