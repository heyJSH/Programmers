/*
0. 문제
 : PRODUCT 테이블에서 만원 단위의 가격대 별로 상품 개수를 출력
   각각 컬럼명은 PRICE_GROUP, PRODUCTS로 지정
   가격대 정보는 각 구간의 최소금액
   (10,000원 이상 ~ 20,000 미만인 구간인 경우 10,000)으로 표시
 - 결과는 가격대를 기준으로 오름차순 정렬
 - 상품 별로 중복되지 않는 8자리 상품코드 값을 가지며,
   앞 2자리는 카테고리 코드를 나타냅니다.
1. 테이블
 : PRODUCT 
2. 사용 컬럼
 : PRODUCT_ID           -- 상품ID
    , PRODUCT_CODE      -- 상품코드
    , PRICE             -- 판매가
3. 출력 컬럼
 : PRICE_GROUP      -- 상품 가격대
    , PRODUCTS      -- 가격대별 상품 개수



-- MIN(가격), MAX(가격)
-- MIN : 15,000원, MAX : 85,000원
SELECT MIN(PRICE), MAX(PRICE)
    FROM PRODUCT P
;
    
-- 몇만원인지 표시
SELECT PRICE, TRUNC(PRICE/10000)
    FROM PRODUCT P
;

-- 가격대별로 그룹을 나눠야 함
-- 방법> DECODE
SELECT PRODUCT_ID
        , DECODE( TRUNC(PRICE/10000)
                    , 0, '0'
                    , 1, '10000'
                    , 2, '20000'
                    , 3, '30000'
                    , 4, '40000'
                    , 5, '50000'
                    , 6, '60000'
                    , 7, '70000'
                    , 8, '80000') AS PRICE_GROUP
    FROM PRODUCT P
    ORDER BY PRICE_GROUP
;

-- 가격 : 중복 제거
SELECT *
    FROM (SELECT DECODE( TRUNC(PRICE/10000)
                    , 0, '0'
                    , 1, '10000'
                    , 2, '20000'
                    , 3, '30000'
                    , 4, '40000'
                    , 5, '50000'
                    , 6, '60000'
                    , 7, '70000'
                    , 8, '80000') AS PRICE_GROUP
                FROM PRODUCT P
                ) T
    GROUP BY T.PRICE_GROUP
    ORDER BY PRICE_GROUP
;

-- 가격대별 COUNT
-- 답안
SELECT T.PRICE_GROUP
        , COUNT(*) AS PRODUCTS
     FROM (SELECT DECODE( TRUNC(PRICE/10000)
                    , 0, '0'
                    , 1, '10000'
                    , 2, '20000'
                    , 3, '30000'
                    , 4, '40000'
                    , 5, '50000'
                    , 6, '60000'
                    , 7, '70000'
                    , 8, '80000') AS PRICE_GROUP
                FROM PRODUCT P
                ) T
    GROUP BY T.PRICE_GROUP
    ORDER BY PRICE_GROUP
;
*/

-- 다른 방법
SELECT  TRUNC(PRICE, -4) AS PRICE_GROUP, COUNT(PRODUCT_ID) PRODUCTS
    FROM    PRODUCT
    GROUP BY TRUNC(PRICE, -4)
    ORDER BY TRUNC(PRICE, -4)
;