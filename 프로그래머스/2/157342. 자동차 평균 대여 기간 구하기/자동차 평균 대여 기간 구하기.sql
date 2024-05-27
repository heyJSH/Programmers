/*
0. 문제
 : CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서
   평균 대여 기간이 7일 이상인 자동차들의
   자동차 ID와 평균 대여 기간(컬럼명: AVERAGE_DURATION)
   리스트를 출력하는 SQL문을 작성해주세요.
   평균 대여 기간은 소수점 두번째 자리에서 반올림하고, 
   결과는 평균 대여 기간을 기준으로 내림차순 정렬해주시고, 
   평균 대여 기간이 같으면 자동차 ID를 기준으로 내림차순 정렬해주세요.
   
1. 테이블
 : CAR_RENTAL_COMPANY_RENTAL_HISTORY
2. 사용 컬럼
 : HISTORY_ID       -- 자동차 대여 기록 ID
   , CAR_ID         -- 자동차 ID
   , START_DATE     -- 대여 시작일
   , END_DATE       -- 대여 종료일
3. 출력 컬럼
 : CAR_ID                       -- 평균 대여 기간이 7일 이상일 것
   , AVERAGE_DURATION           -- 평균 대여 기간
4. 조건
 - 평균 대여 기간이 7일 이상일 것
 - 평균 대여 기간 : 소수점 두번째 자리에서 반올림
    ROUND(평균대여기간, 2)
 - AVERAGE_DURATION 내림차순, CAR_ID 내림차순
    ORDER BY AVERAGE_DURATION DESC
   , ORDER BY CAR_ID DESC

-- CAR_ID 별로 평균 대여기록 구하기
-- 대여기록 출력
-- 대여기록 = TO_CHAR(END_DATE - START_DATE) +1
SELECT CAR_ID
        , TO_CHAR(END_DATE - START_DATE)
            AS RENTAL_DURATION
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
;

-- CAR_ID 중복없이 정렬
SELECT CAR_ID
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
    GROUP BY CAR_ID
    ORDER BY CAR_ID DESC
;

-- 평균 대여 기간 구하기
SELECT CAR_ID
        , ROUND( AVG(TO_CHAR(END_DATE - START_DATE) +1), 1 ) 
            AS AVERAGE_DURATION
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
    GROUP BY CAR_ID
    ORDER BY AVERAGE_DURATION DESC, CAR_ID DESC
;
*/

-- 답안
-- 평균 대여 기간 7일 이상의 목록 조회
SELECT CAR_ID
        , ROUND( AVG(TO_CHAR(END_DATE - START_DATE) +1), 1 ) 
            AS AVERAGE_DURATION
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
    GROUP BY CAR_ID
    HAVING AVG(TO_CHAR(END_DATE - START_DATE) +1) >= 7
    ORDER BY AVERAGE_DURATION DESC, CAR_ID DESC
;