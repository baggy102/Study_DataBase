# Database Study & Training

<details>
<summary>Sample DataBase</summary> 
 
## Source </br>
> https://www.mysqltutorial.org/getting-started-with-mysql/mysql-sample-database/

## DB ER Diagram
![image](https://github.com/baggy102/Study_DataBase/assets/127190426/efdab551-da10-4d1c-99f6-5b50c217f217)
</details>

<details>
<summary>JOIN</summary>

## JOIN
> JOIN은 관계형 데이터베이스의 가장 큰 장점이자, 대표적인 핵심 기능

### JOIN의 개요
> 다른 정보가 들어있는 두 개의 테이블과 연결 또는 결합해 데이터를 추출하는 것을 JOIN이라 한다.

일반적인 경우 행은 PRIMARY KEY(PK)나 FOREIGN KEY(FK) 값의 연관에 의해 JOIN이 성립된다. 
하지만 어떤 경우 PK, FK의 관계 없이도 논리적인 값들의 연관만으로 JOIN이 성립 가능하다.

customers 라는 테이블과 orders 라는 테이블이 있는 경우, 
customers 테이블을 기준으로 필요한 데이터를 검색하고 이 데이터와 연관된 팀 테이블의 특정 행을 찾아오는 과정이 JOIN을 이용하여 데이터를 검색하는 과정으로 볼 수 있다.

orders와 orderdetails 테이블도 조인 조건을 통해 필요한 데이터를 조합해서 가져올 수 있으며, 하나의 SQL 문장에서 customers, orders, orderdetails 등 여러 테이블을 조인해서 사용할 수도 있다. 

다만 한 가지 주의할 점은 FROM 절에 여러 테이블이 나열되더라도 SQL에서 데이터를 처리할 때는 단 두 개의 집합 간에만 조인이 일어난다. 
예를 들어 A, B, C, D 4개의 테이블을 조인하고자 할 경우 옵티마이저는 ( ( (A JOIN D) JOIN C) JOIN B)와 같이 순차적으로 조인을 처리하게 된다. 먼저 A와 D 테이블을 조인 처리하고, 그 결과 집합과 C 테이블을 다음 순서에 조인 처리하고, 마지막으로 3개의 테이블을 조인 처리한 집합과 B 테이블을 조인 수행하게 된다. 
</details>
