단일행 서브쿼리

SELECT * 
    FROM products
WHERE buyPrice > ( SELECT AVG( buyPrice )
                        FROM products )

다중행 서브쿼리

SELECT * 
    FROM products
    WHERE 
        buyPrice in (SELECT MIN(buyPrice)
                    FROM products
                    GROUP BY productLine);

SELECT * 
    FROM products
    WHERE 
        buyPrice > ANY (SELECT MIN(buyPrice)
                    FROM products
                    GROUP BY productLine);

SELECT * 
    FROM products
    WHERE 
        buyPrice > ALL (SELECT MIN(buyPrice)
                    FROM products
                    GROUP BY productLine);