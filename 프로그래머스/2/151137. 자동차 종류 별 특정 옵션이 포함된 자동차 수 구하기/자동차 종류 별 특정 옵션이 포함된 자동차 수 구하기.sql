/*
0. 문제
 : CAR_RENTAL_COMPANY_CAR 테이블에서
  '통풍시트', '열선시트', '가죽시트' 중 하나 이상의 옵션이 포함된 자동차가 
  자동차 종류 별로 몇 대인지 출력하는 SQL문을 작성해주세요. 
  이때 자동차 수에 대한 컬럼명은 CARS로 지정하고, 
  결과는 자동차 종류를 기준으로 오름차순 정렬해주세요.
1. 테이블
 : CAR_RENTAL_COMPANY_CAR
2. 사용 컬럼
 : CAR_ID       -- 자동차 id
    , CAR_TYPE  -- 자동차 종류
    , DAILY_FEE -- 일일 대여요금(원)
    , OPTIONS   -- 자동차 옵션 리스트
3. 출력 컬럼
 : CAR_TYPE     -- 자동차 종류
    , CARS      -- 자동차 수

-- 자동차 옵션 포함된 자동차 종류 조회
SELECT CAR_TYPE
    FROM CAR_RENTAL_COMPANY_CAR
    WHERE OPTIONS LIKE '%통풍시트%' 
        OR OPTIONS LIKE '%열선시트%'
        OR OPTIONS LIKE '%가죽시트%'
    ORDER BY CAR_TYPE ASC
;
*/

-- 답안
-- 자동차 종류 중복 제거 + COUNT
SELECT CAR_TYPE, COUNT(*) AS  CARS
    FROM CAR_RENTAL_COMPANY_CAR
    WHERE OPTIONS LIKE '%통풍시트%' 
        OR OPTIONS LIKE '%열선시트%'
        OR OPTIONS LIKE '%가죽시트%'
    GROUP BY CAR_TYPE
    ORDER BY CAR_TYPE ASC
;