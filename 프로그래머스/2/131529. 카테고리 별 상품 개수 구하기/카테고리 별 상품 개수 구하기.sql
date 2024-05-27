-- 코드를 입력하세요
/* 0. 문제
PRODUCT 테이블에서 상품 카테고리 코드(PRODUCT_CODE 앞 2자리) 별
상품 개수를 출력하는 SQL문을 작성해주세요
결과는 상품 카테고리 코드를 기준으로 오름차순 정렬해주세요.

1. 테이블
 : PRODUCT
2. 테이블 속 컬럼명
 : PRODUCT_ID           -- 상품ID
    , PRODUCT_CODE      -- 상품코드
    , PRICE             -- 판매가
(상품 별로 중복되지 않은 8자리 상품코드 값을 가지며,
  앞 2자기는 카테고리 코드를 의미한다.)
3. 출력할 컬럼
 : 상품 카테고리 코드(PRODUCT_CODE 앞 2자리) 별 상품 개수
 -- CATEGORY     -- 카테고리
 -- PRODUCTS     -- 상품개수
4. ORDER BY CATEGORY ASC


-- 카테고리 출력
SELECT SUBSTR(TO_CHAR(P.PRODUCT_CODE), 1, 2)
    FROM PRODUCT P
;

-- 카테고리 컬럼을 추가하여 카테고리 출력
SELECT *
    FROM ( SELECT SUBSTR(TO_CHAR(P.PRODUCT_CODE), 1, 2) AS CATEGORY
                FROM PRODUCT P
          )
;

-- 카테고리 값 중복없이 출력
-- 중복제거1. DISTINCT
SELECT DISTINCT R.CATEGORY
    FROM ( SELECT SUBSTR(TO_CHAR(P.PRODUCT_CODE), 1, 2)
                    AS CATEGORY
                FROM PRODUCT P
          ) R
    ORDER BY CATEGORY ASC
;

-- 중복제거2. GROUP BY
SELECT R.CATEGORY
    FROM ( SELECT SUBSTR(TO_CHAR(P.PRODUCT_CODE), 1, 2)
                    AS CATEGORY
                FROM PRODUCT P
          ) R
    GROUP BY R.CATEGORY
    ORDER BY CATEGORY ASC
;


-- 상품개수 출력 → PRODUCTS
-- COUNT 사용 : 카테고리 앞 2자리가 같은 것끼리 개수 세야 함
-- COUNT1_1> DISTINCT + PARTITION BY
-- 기본 구문
 SELECT DISTINCT T1.*
    FROM ( SELECT col1
                  , COUNT(*) OVER(PARTITION BY a.col1) AS col2
            FROM 원본테이블 a
          ) T1
    WHERE T1.col > n ;      
    -- T1테이블의 col1 개수가 n개 초과하여 중복하는 것을 조건으로 하겠다.
 
 PARTITION BY는 DISTINCT를 무시한다.
 따라서, 테이블에 DISTINCT가 걸려 있어도 이를 무시하고 원본을 대상으로 작업을 수행한다.
 
SELECT DISTINCT R.CATEGORY, R.PRODUCTS
    FROM ( SELECT SUBSTR(TO_CHAR(P.PRODUCT_CODE), 1, 2)
                        AS CATEGORY
                  , COUNT(*) OVER
                            (PARTITION BY
                             SUBSTR(TO_CHAR(P.PRODUCT_CODE), 1, 2))
                        AS PRODUCTS
                FROM PRODUCT P
          ) R
    WHERE R.PRODUCTS > 0        -- 생략해도 같은 결과 출력
    ORDER BY CATEGORY ASC
;

-- COUNT1_2> DISTINCT + PARTITION BY
SELECT DISTINCT R.*
    FROM ( SELECT SUBSTR(TO_CHAR(P.PRODUCT_CODE), 1, 2)
                        AS CATEGORY
                  , COUNT(*) OVER
                            (PARTITION BY
                             SUBSTR(TO_CHAR(P.PRODUCT_CODE), 1, 2))
                        AS PRODUCTS
                FROM PRODUCT P
          ) R
    WHERE R.PRODUCTS > 0        -- 생략해도 같은 결과 출력
    ORDER BY CATEGORY ASC
;

-- COUNT2> GROUP BY + HAVING
SELECT R.CATEGORY
       , COUNT(*) AS PRODUCTS
    FROM ( SELECT SUBSTR(TO_CHAR(P.PRODUCT_CODE), 1, 2)
                    AS CATEGORY
                FROM PRODUCT P
          ) R
    GROUP BY R.CATEGORY
        HAVING COUNT(*) > 0     -- 생략해도 같은 결과 출력
    ORDER BY CATEGORY ASC
;
*/

-- 정답 3. COUNT2> GROUP BY + HAVING
SELECT R.CATEGORY
       , COUNT(*) AS PRODUCTS
    FROM ( SELECT SUBSTR(TO_CHAR(P.PRODUCT_CODE), 1, 2)
                    AS CATEGORY
                FROM PRODUCT P
          ) R
    GROUP BY R.CATEGORY
        HAVING COUNT(*) > 0     -- 생략해도 같은 결과 출력
    ORDER BY CATEGORY ASC
;