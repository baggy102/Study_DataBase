# Database Study & Training

<details>
<summary>Sample DataBase</summary> 
 
## Source </br>
> https://www.mysqltutorial.org/getting-started-with-mysql/mysql-sample-database/

## DB ER Diagram
![image](https://github.com/baggy102/Study_DataBase/assets/127190426/efdab551-da10-4d1c-99f6-5b50c217f217)
</details>


## JOIN
<details>
<summary>개요</summary>
 <br/>
 

### JOIN
> JOIN은 관계형 데이터베이스의 가장 큰 장점이자, 대표적인 핵심 기능으로써 <br/>
> 다른 정보가 들어있는 두 개의 테이블과 연결 또는 결합해 데이터를 추출하는 것을 JOIN이라 한다.

일반적인 경우 행은 PRIMARY KEY(PK)나 FOREIGN KEY(FK) 값의 연관에 의해 JOIN이 성립된다. 
하지만 어떤 경우 PK, FK의 관계 없이도 논리적인 값들의 연관만으로 JOIN이 성립 가능하다.

customers 라는 테이블과 orders 라는 테이블이 있는 경우, 
customers 테이블을 기준으로 필요한 데이터를 검색하고 이 데이터와 연관된 팀 테이블의 특정 행을 찾아오는 과정이 JOIN을 이용하여 데이터를 검색하는 과정으로 볼 수 있다.

orders와 orderdetails 테이블도 조인 조건을 통해 필요한 데이터를 조합해서 가져올 수 있으며, 하나의 SQL 문장에서 customers, orders, orderdetails 등 여러 테이블을 조인해서 사용할 수도 있다. 

다만 한 가지 주의할 점은 FROM 절에 여러 테이블이 나열되더라도 SQL에서 데이터를 처리할 때는 단 두 개의 집합 간에만 조인이 일어난다. 
예를 들어 A, B, C, D 4개의 테이블을 조인하고자 할 경우 옵티마이저는 ( ( (A JOIN D) JOIN C) JOIN B)와 같이 순차적으로 조인을 처리하게 된다. 먼저 A와 D 테이블을 조인 처리하고, 그 결과 집합과 C 테이블을 다음 순서에 조인 처리하고, 마지막으로 3개의 테이블을 조인 처리한 집합과 B 테이블을 조인 수행하게 된다. 

### EQUI JOIN
> EQUI JOIN은 두 개의 테이블 간에 칼럼 값들이 서로 정확하게 일치하는 경우에 사용되는 방법

대부분 PK ↔ FK의 관계를 기반으로 한다. 그러나 일반적으로 테이블 설계 시에 나타난 PK ↔ FK의 관계를 이용하는 것이지 반드시 PK ↔ FK의 관계로만 EQUI JOIN이 성립하는 것은 아니다. 
**JOIN의 조건은 WHERE 절에 기술**하게 되는데 “=” 연산자를 사용해서 표현한다. 

```
SELECT 테이블1.칼럼명, 테이블2.칼럼명, ... FROM 테이블1, 테이블2 WHERE 테이블1.칼럼명1 = 테이블2.칼럼명2; 
```
```
SELECT 테이블1.칼럼명, 테이블2.칼럼명, ... FROM 테이블1 INNER JOIN 테이블2 ON 테이블1.칼럼명1 = 테이블2.칼럼명2;
```
<br/>

> [예제] customers 테이블과 orders 테이블에서 고객이름과 주문번호를 출력하시오.
```
SELECT customers.customerName, orders.orderNumber FROM customers, orders WHERE customers.customerNumber = orders.customerNumber;
```
<br/>

> INNER JOIN 사용
```
SELECT customers.customerName, orders.orderNumber FROM customers INNER JOIN orders ON customers.customerNumber = orders.customerNumber;
```
>결과
<img width="185" alt="image" src="https://github.com/baggy102/Study_DataBase/assets/127190426/2cfe372d-c3bf-4f5e-8d02-1513728a3bc7">

이때 SELECT 구문에 단순히 칼럼명이 오지 않고 **테이블명.칼럼**처럼 테이블명과 칼럼명이 같이 나타난다. 
모든 테이블에 칼럼들이 유일한 이름을 가진다면 상관없지만, JOIN에 사용되는 두 개의 테이블에 같은 칼럼명이 존재하는 경우에는 
옵티마이저는 어떤 칼럼을 사용해야 할지 모르기 때문에 **파싱 단계에서 에러**가 발생된다. 

또한 사용자가 조회할 데이터가 어느 테이블에 있는 칼럼을 말하는 것인지 쉽게 알 수 있게 하므로 **SQL에 대한 가독성이나 유지보수성**을 높일 수 있다.

조인 조건에 맞는 데이터만 출력하는 INNER JOIN에 참여하는 대상 테이블이 N개라고 했을 때, 
N개의 테이블로부터 필요한 데이터를 조회하기 위해 필요한 JOIN 조건은 대상 테이블의 개수에서 하나를 뺀 N-1개 이상이 필요하다.

### Non EQUI JOIN

> “=” 연산자가 아닌 다른(Between, >, >=, <, <= 등) 연산자들을 사용하여 JOIN을 수행하는 것이다.
> Non EQUI(비등가) JOIN은 두 개의 테이블 간에 칼럼 값들이 서로 정확하게 일치하지 않는 경우에 사용된다.

```
SELECT 테이블1.칼럼명, 테이블2.칼럼명, ... FROM 테이블1, 테이블2 WHERE 테이블1.칼럼명1 BETWEEN 테이블2.칼럼명1 AND 테이블2.칼럼명2;
```

> [예제] 어떤 사원이 받고 있는 급여가 어느 등급에 속하는 등급인지 알고 싶다는 요구사항에 대한 Non EQUI JOIN의 사례는 다음과 같다.
> [예제] SELECT E.ENAME, E.JOB, E.SAL, S.GRADE FROM EMP E, SALGRADE S WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

BETWEEN a AND b와 같은 SQL 연산자 뿐만 아니라 “>”나 “<”와 같은 다른 연산자를 사용했을 경우에도 모두 Non EQUI JOIN에 해당하며,
데이터 모델에 따라서 Non EQUI JOIN이 불가능한 경우도 있다.

### 3개 이상 TABLE JOIN

선수들 별로 홈그라운드 경기장이 어디인지를 출력하고 싶다고 했을 때, 선수 테이블과 운동장 테이블이 서로 관계가 없으므로 중간에 팀 테이블이라는 서로 연관관계가 있는 테이블을 추가해서 세 개의 테이블을 JOIN 해야만 원하는 데이터를 얻을 수 있다.

> [예제] customers 테이블의 customerNumer가 orders 테이블의 customerNumber와 PK-FK의 관계가 있다는 것을 알 수 있고, 
> orderdetails의 orderNumber와 orders 테이블의 orderNumber가 PK-FK 관계인 것을 생각하며 다음 SQL을 작성한다. 
> 세 개의 테이블에 대한 JOIN이므로 WHERE 절에 2개 이상의 JOIN 조건이 필요하다.

```
SELECT C.customerNumber, C.customerName, O.orderDate, O.orderNumber, D.productCode FROM customer C INNER JOIN orders O ON C.customerNumber = O.customerNumber INNER JOIN orderdetails D ON O.orderNumber = D.orderNumber ORDER BY customerNumber;
```

> 결과
<img width="340" alt="image" src="https://github.com/baggy102/Study_DataBase/assets/127190426/eec62643-3716-4aec-b0a5-db127a1426f1">

</details>

<details>
<summary>inner join & outer join & cross join</summary>
각기 다른 두 테이블을 합쳐서 결과를 내고 싶을 때

JOIN 기능적 분류

INNER JOIN은 두 테이블을 조인할 떄, 두 테입르에 모두 지정한 열의 데이터가 있는 경우
OUTER JOIN은 두 테이블을 조인할 때, 1개의 테이블에만 데이터가 있어도 결과가 나온다.

CROSS JOIN은 한쪽 테이블의 모든 행과 다른 쪽 테이블의 모든 행을 조인
SELF JOIN은 자기 자신과 조인한다는 의미로, 하나의 테이블을 사용한다.


회원 + 구매 테이블 => 배송정보


일대다 관계의 이해

회원 테이블의 아이디 (PK)는 비어있지 않으며 중복을 허용 x

구매 테이블에서 아이디(FK)

회원 테이블에서 여러개의 물건을 주문 했을 때
-> 
구매 테이블에 FK 로 여러개 값이 올 수 있다.

1대다 (=기본키, 외래키) 관계


내부조인

INNER JOIN은 교집합연산과 같다.
조인 키 컬럼 값이 양쪽 테이블 데이터 집합에서 공통적으로 존재하는 데이터만 조인해 결과 데이터 집합을 추출한다.

설명 (그림)

```
SELECT <열 목록>
FROM <테이블>
	INNER JOIN <두 번째 테이블>
	ON <조인 조건>
[WHERE 검색 조건]
```
이때 WHERE 조건은 생략 가능

> 예제
```
SELECT * FROM buy INNER JOIN member
	ON buy.mem_id = member.mem_id
	WHERE buy.mem_id = 'GRL';
```

```
SELECT mem_id, meme_name, prod_name, addr, CONCAT(phone1, phone2) AS '연락처'
	FROM buy
		INNER JOIN member
		ON buy.mem_id = member.mem_id;
```
-> mem_id 열 이름이 두 테이블에서 같기 때문에 error 발생
	어떤 테이블의 mem_id 인지 지정해주어야 한다.

```
SELECT buy.mem_id, meme_name, prod_name, addr, CONCAT(phone1, phone2) AS '연락처'
	FROM buy
		INNER JOIN member
		ON buy.mem_id = member.mem_id;
```

내부조인은
구매한 회원의 정보만 나온다.
회원 중 구매하지 않은 사람의 정보까지 다 나오게 하고싶으면?

한쪽 테이블의 모든 정보를 알고 싶은 경우에

외부조인
내부 조인은 두 테이블에 모두 데이터가 있어야만 결과 나온다.
이와 달리 외부 조인은 한쪽엠나 데이터가 있어도 결과가 나온다.

외부조인의 기본

LEFT OUTER JOIN
교집합 연산결과와 차집합 연산 결과를 합친것과 같다.
조인 키 컬럼 값이 양쪽 테이블 데이터 집합에서 공통적으로 존재하는 데이터와 Left outer join 키워드 왼쪽에 명시된 테이블에만 존재하는 데이터를 결과 집합으로 추출하게 된다.

RIHT OUTER JOIN
left outer join과 기준이 반대

FULL OUTER JOIN
합집합 연산 결과와 같ㅇ다.
조인 키 컬럼 값이 양쪽 테이블 데이터 집합에서 공통적으로 존재하는 데이터와 한쪽 테이블에만 존재하는 데이터도 모두 결과 데이터 집합으로 추출한다.

외부조인은 두 테이블을 조인할 때 필요한 내용이 한쪽 테이블에만 있어도 결과를 추출할 수 있다. 

형태
```
SELECT <열 목록>
FROM <테이블(LEFT 테이블)>
	<LEFT | RIGHT | FULL> OUTER JOIN <두 번째 테이블(RIGHT 테이블)>
	ON <조인 조건>
[WHERE 검색 조건];
```

> 예제

LEFT OUTER JOIN
```
SELECT M.mem_id, M.mem_name, B.prod_name, M.addr,
	FROM member M
		LEFT OUTER JOIN buy B
		ON M.mem_id = B.mem_id
	ORDER BY M.mem_id;
```

```
SELEVT M.mem_id, M.mem_name, B.prod_name, M.addr
	FROM buy B
		RIGHT OUTER JOIN member M
		ON M.mem_id = B.mem_id
	ORDER BY M.mem_id;
```
위치만 바꿔


기타조인

상호조인 (CROSS JOIN)
한쪽 테이블의 모든 행과 다른 쪽 테이블의 모든 행을 조인시키는 기능
조인 결과는 각 행의 개수를 곱한 개수가 된다.

대용량의 데이터를 생성할 필요가 있는 경우 사용한다.

자체조인 (SELF JOIN)
자기 자신과 조인하는 기능

![image](https://github.com/baggy102/Study_DataBase/assets/127190426/c202aa91-85f2-4159-8065-80552e596894)
 
</details>

<details>
<summary>서브 쿼리</summary> 
	
 ## 서브쿼리

서브쿼리는 Where 절에 비교조건으로 사용되는 Select 쿼리를 의미한다.
통상적으로 SQL을 작성할 때, 모든 테이블을 조인으로 작성하는 것 보다, 메인 집합을 만들고 서브쿼리를 사용하여 값을 비교해가는 절차적 SQL 작성이 간편한다.

하지만 서브쿼리를 사용하지 않고 조인으로 처리가 가능한 SQL임에도 불구하고, 단지 SQL 작성이 쉽다는 이유로 서브쿼리를 남용 할 경우, DB 서버에 심각한 성능 문제가 발생할 수 있다.
SQL에 서브쿼리가 여러 개 존재할 경우, Optimizer가 최적화 과정에서 잘못된 cost를 계산하는 경우가 빈번하기 때문.

### 서브 쿼리 개념

서브쿼리는 위치에 따라 다음과 같이 분류

 - SELECT 절 : 스칼라 서브쿼리(Svalar Subquery)
 - FROM 절 : 인라인 뷰(Inline view) 
 - WHERE 절, HAVING 절 : 중첩 서브쿼리(Nested Subquery)

스칼라 서브쿼리
주로 SELECT절에 위치하지만 컬럼이 올 수 있는 대부분의 위치에 사용. 컬럼 대신 사용되므로 반드시 하나의 값만ㅇ르 반환, 그렇지 않은 경우 에러가 발생한다.

인라인 뷰
FROM 절 등 테이블명이 올 수 있는 위치에 사용

중첩 서브쿼리
WHRER 절과 HAVING 절에 사용할 수 있다. 중첩 서브쿼리는 관계에 따라 다음과 같이 나눌 수 있다.
 - 비연관 서브쿼리 (메인 쿼리와 관계를 맺고 있지 않음, 서브쿼리 내 메인 쿼리의 칼럼이 존재하지 않음)
 - 연관 서브쿼리 (메인 쿼리와 관계를 맺고 있음, 서브쿼리 내 메인 쿼리의 컬럼이 존재)

중첩 서브쿼리는 변환하는 데이터 형태에 따라 다음과 같이 나뉨.
 - 단일 행 서브쿼리 (서브쿼리가 1건 이하의 데이터를 반환, 단일 행 비교 연산자와 함께 사용)
 - 다중 행 서브쿼리 (서브쿼리가 여러 건의 데이터를 반환, 다중 행 연산자와 함께 사용)
 - 다중 컬럼 서브쿼리 (서브쿼리가 여러 컬럼의 데이터를 반환)

### 자주 사용되는 서브쿼리 사용패턴

패턴 1
```
SELECT * 
	FROM emp 
WHERE sal > ( SELECT AVG( sal ) 
				FROM emp )
```

> 위 쿼리의 특징은 추출 결과가 반드시 1건이어야 한다. 만약, 서브쿼리의 결과로 2건 이상이 추출된다면 에러가 발생한다. 위와 같은 패턴은 보통 서브쿼리 부터 먼저 수행된 후, Main SQL의 칼럼 값과 비교하는 형태로 수행되는 것이 일반적이다.

패턴2
```
SELECT c1, c2, c3
	FROM SUBQUERY_T2 t2
WHERE c2 = 'A'
	AND EXISTS (
				SELECT /*+ NO_UNNEST */
						'x'
					FROM SUBQUERY_T1 t1
				WHERE t1.c5 = t2.c2
			  )
```

> 위 패턴은 EXISTS 나 IN 연산자 (또는 NOT EXISTS, NOT IN)를 사용한 경우로 서브 쿼리의 결과가 여러 건 추출될 수 있다. 서브쿼리 내 Main SQL과 연결 조건인 T1.C5 = T1.C2가 존재 (EXISTS, NOT EXISTS의 경우)하여, Main SQL에서 추출한 값을 상속 받아 서브쿼리의 테이블에 해당 값이 존재하는지 체크하는 방식으로 수행된다. 물론 반대로 서브쿼리가 먼저 수행되고 Main SQL에 값을 전달할 수도 있다.

### 서브쿼리의 특성
서브쿼리에서 추출되는 데이터가 중복 값이 많더라도, Main SQL의 데이터를 증가시키지 않는다.

### 서브쿼리 동작방식의 이해
서브쿼리의 동작방식은 크게 Filter 동작방식과 조인 동작방식으로 나뉨.
동작 방식에 따라 SQL 성능 차이가 발생

FILTER 동작방식

Main SQL에서 추출된 데이터 건수만큼 서브쿼리가 반복저긍로 수행되며 처리되는 방식

이 경우 Main SQL의 추출 결과가 100만건이라면 서브쿼리는 100만번 수행된다.
서브쿼리 조인 연결 칼럼에 적절한 인덱스가 없다면 100만번 Full Table Scan을 수행하게 됨.

</details>

<details>
<summary>인덱스 기본</summary> 

## 인덱스 특징과 종류

> 인덱스는 원하는 데이터를 쉽게 찾을 수 있도록 돕는 책의 찾아보기와 유사한 개념이다.

인덱스는 테이블을 기반으로 선택적으로 생성할 수 있는 구조이다.
테이블에 인덱스를 생성하지 않아도 되고, 여러 개를 생성해도 된다.

인덱스의 기본적인 목적은 검색 성능의 최적화이다.
즉, 검색 조건을 만족하는 데이터를 인덱스를 통해 효과적으로 찾을 수 있도록 돕는다.

하지만 Insert, Update, Delete 등과 같은 DML 작업은 테이블과 인덱스를 함께 변경해야 하기 때문에
오히려 느려질 수 있다는 단점이 존재한다. 

### 트리 기반 인덱스
> DBMS의 가장 일반적인 인덱스는 B-트리 인덱스이다.

<img width="584" alt="image" src="https://github.com/baggy102/Study_DataBase/assets/127190426/4569a44a-9695-4e6c-a8fb-ed939e393583">

인덱스 데이터는 인덱스를 구성하는 칼럼의 값으로 정렬된다.
만약 인덱스 데이터의 값이 동일하면 레코드 식별자의 순서로 저장된다.
B-트리 인덱스는 '='로 검색하는 일치 검색과 'BETWEEN', '>' 등과 같은 연산자로 검색하는 범위 검색 모두에 적합한 구조이다.

#### 인덱스에서 원하는 값을 찾는 과정
> 1. 브랜치 블록의 가장 왼쪽 값이 찾고자 하는 값보다 작거나 같으면 왼쪽 포인터로 이동
> 2. 찾고자 하는 값이 브랜치 블록의 값 사이에 존재하면 가운데 포인터로 이동
> 3. 오른쪽에 있는 값보다 크면 오른쪽 포인터로 이동

이 과정을 리프 블록을 찾을 때 까지 반복한다.</br>
리프 블록에서 찾고자 하는 값이 존재하면 해당 값을 찾은 것이고, 해당 값이 없으면 해당 값은 존재하지 않아 검색에 실패한다.


### 클러스터형 인덱스
SQL Server의 인덱스 종류는 저장 구조에 따라 클러스터형 인덱스와 비클러스터형 인덱스로 나뉜다.

특징
인덱스의 리프 페이지가 곧 데이터 페이지이다.
따라서 테이블 탐색에 필요한 레코드 식별자가 리프 페이지에 없다.
클러스터형 인덱스의 리프 페이지를 탐색하면 해당 테이블의 모든 칼럼 값을 곧바로 얻을 수 있다.

리프 페이지의 모든 로우는 인덱스 키 칼럼 순으로 물리적으로 정렬되어 저장된다.
테이블 로우는 물리적으로 한 가지 순서로만 정렬될 수 있다. 그러므로 클러스터형 인덱스는 테이블당 한개만 생성할 수 있다.

<br/>

## 전체 테이블 스캔과 인덱스 스캔

<img width="614" alt="image" src="https://github.com/baggy102/Study_DataBase/assets/127190426/4ca7fe1e-786f-4c52-9909-548192c909a3">

### 전체 테이블 스캔
전체 테이블 스캔 방식으로 데이터를 검색한다는 것은 
테이블에 존재하는 모든 데이터를 읽어 조건에 맞으면 결과로 추출하고, 맞지 않으면 버리는 방식으로 검색한다.

옵티마이저가 연산으로서 전체 테이블 스캔방식을 선택하는 경우
- SQL문에 조건이 존재하지 않는경우
- SQL문의 주어진 조건에 사용 가능한 인덱스가 없는 경우
- 옵티마이저의 취사 선택
- 그 밖 (병렬처리 방식, 전체 테이블 스캔 방식 힌트 사용)

### 인덱스 스캔
인덱스 스캔은 인덱스를 구성하는 칼럼의 값을 기반으로 데이터를 추출하는 액세스 기법이다.
리프 블록은 인덱스 구성하는 칼럼과 레코드 식별자로 구성되어 있다. 
따라서 인덱스의 리프 블록을 읽으면 인덱스 구성 칼럼의 값과 테이블으 ㅣ레코드 식별자를 알 수 있다.

인덱스는 인덱스 구성 칼럼의 순서로 정렬되어 있다.
인덱스 구성 칼럼이 A+B라면 먼저 A로 정렬되고, A가 동일한 경우 B로 정렬된다.
칼럼 A, B가 모두 동일한 경우에는 레코드 식별자로 정렬된다.

### 대표적인 인덱스 스캔 종류
Index Unique Scan : Unique 인덱스를 사용해 단 하나의 데이터를 추출하는 방식 (유일 인덱스 구성 칼럼에 대해 모두 '='로 값이 주어진 경우에만 가능한 인덱스 스캔 방식)
Index Range Scan : 한 건 이상의 데이터를 추출 ('='로 값이 주어지지 않은 경우와 비유일 인덱스를 이용하는 모든 액세스 방식은 인덱스 범위 스캔 방식으로 데이터를 액세스하는 것이다.)
Index Range Scan Descending

 
</details>
