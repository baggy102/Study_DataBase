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
