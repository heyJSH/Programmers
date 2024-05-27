/*

-- ① CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 조회한다.
SELECT *
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY H
;

-- ② 2022년 9월에 대여한 것에 한하여 대여기간을 계산한다.
SELECT history_id
        , to_number(H.end_date - H.start_date + 1) AS duration
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY H
    WHERE to_char(start_date, 'yyyy-mm-dd') LIKE '2022-09%'
;

-- ③ HISTORY_ID, CAR_ID, START_DATE, END_DATE, RENT_TYPE를 조회한다.
SELECT history_id
        , car_id
        , to_char(start_date, 'yyyy-mm-dd') AS start_date
        , to_char(end_date, 'yyyy-mm-dd') AS end_date
        ,   CASE WHEN to_number(H.end_date - H.start_date +1) >= 30
                THEN '장기대여'
            ELSE '단기대여'
            END AS rent_type
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY H
    WHERE to_char(start_date, 'yyyy-mm-dd') LIKE '2022-09%'
    ORDER BY history_id DESC
;

-- ④ 이때 조회하는 START_DATE, END_DATE의 형식은 YYYY-MM-DD 이어야 한다.

-- ⑤ CASE 표현식을 사용하여 대여기간이 30일 이상일 경우 '장기 대여', 그 밖의 경우 '단기 대여'라 표현한다.
-- 장기대여, 단기대여 : CASE WHEN 사용 (컬럼 : rent_type)
SELECT 
        CASE WHEN to_number(H.end_date - H.start_date +1) >= 30
            THEN '장기대여'
        ELSE '단기대여'
        END AS rent_type
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY H
;

-- * 대여 기간의 경우 당일 반납도 생각하여야 하기 때문에 +1을 통해 당일 반납도 포함하여 조회한다.

-- ⑥ 조회한 HISTORY_ID, CAR_ID, START_DATE, END_DATE, RENT_TYPE를 ORDER BY를 이용하여 내림차순(DESC) 정렬한다.
SELECT history_id
        , car_id
        , to_char(start_date, 'yyyy-mm-dd') AS start_date
        , to_char(end_date, 'yyyy-mm-dd') AS end_date
        ,   CASE WHEN to_number(H.end_date - H.start_date +1) >= 30
                THEN '장기대여'
            ELSE '단기대여'
            END AS rent_type
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY H
    WHERE to_char(start_date, 'yyyy-mm-dd') LIKE '2022-09%'
    ORDER BY history_id DESC
;

문제 : start_date가 22년도9월에 속하는 대여 기록에 대해,
    대여기간 >= 30 이면 '장기대여'
    대여기간 < 30 이면 '단기대여' 출력 ▶ 'rent_type' 컬럼추가
조건 : history_id 를 기준으로 내림차순 정렬
    'start_date'와 'end_date'는 'yyyy-mm-dd' 포맷으로 처리
테이블 1 : CAR_RENTAL_COMPANY_RENTAL_HISTORY H
 - 컬럼 : history_id, car_id, start_date, end_date

-- start_date, end_date 포맷
to_char(start_date, 'yyyy-mm-dd')
to_char(end_date, 'yyyy-mm-dd')

-- rent_type 컬럼
SELECT 
        CASE WHEN 
    FROM 
    WHERE 
;






*/

-- 
SELECT history_id
        , car_id
        , to_char(start_date, 'yyyy-mm-dd') AS start_date
        , to_char(end_date, 'yyyy-mm-dd') AS end_date
        ,   CASE WHEN to_char(H.end_date - H.start_date +1) >= 30
                THEN '장기 대여'
            ELSE '단기 대여'
            END AS rent_type
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY H
    WHERE to_char(start_date, 'yyyy-mm') LIKE '2022-09'
    ORDER BY history_id DESC
;