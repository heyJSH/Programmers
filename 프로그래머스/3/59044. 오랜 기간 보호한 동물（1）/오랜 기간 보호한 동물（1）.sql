/*
<오랜 기간 보호한 동물(1)>
0. 문제
 : 아직 입양을 못 간 동물 중, 
   가장 오래 보호소에 있었던 동물 3마리의
   이름과 보호 시작일을 조회하는 SQL문을 작성해주세요. 
   이때 결과는 보호 시작일 순으로 조회해야 합니다.
[ANIMAL_INS I 테이블]
 : ANIMAL_ID            -- 동물id
    , ANIMAL_TYPE       -- 생물 종
    , DATETIME          -- 보호 시작일
    , INTAKE_CONDITION  -- 보호 시작 시 상태
    , NAME              -- 이름
    , SEX_UPON_INTAKE   -- 성별 및 중성화 여부
    
[ANIMAL_OUTS O 테이블]
 : ANIMAL_ID            -- 동물id
    , ANIMAL_TYPE       -- 생물 종
    , DATETIME          -- 입양일
    , NAME              -- 이름
    , SEX_UPON_OUTCOME  -- 성별 및 중성화 여부

-- 보호시작일 순으로 조회(오름차순)
 : ORDER BY O.DATETIME
 
-- 보호기간 = SYSDATE - 보호시작일
TRUNC( TO_CHAR(SYSDATE - I.DATETIME +1) )

-- 방법1> 외부조인
-- 입양X의 이름, 보호시작일, '보호기간 = SYSDATE - 보호시작일 +1' 조회(보호기간 내림차순)
SELECT I.NAME
        , I.DATETIME
        , TRUNC( TO_CHAR(SYSDATE - I.DATETIME +1) ) AS DURATION
    FROM ANIMAL_INS I, ANIMAL_OUTS O
    WHERE I.ANIMAL_ID = O.ANIMAL_ID(+)      -- 외부조인
        AND O.DATETIME IS NULL
    ORDER BY DURATION DESC
;

-- ROWNUM, 입양X의 이름, 보호시작일, '보호기간 = SYSDATE - 보호시작일 +1' 조회(보호기간 내림차순)
SELECT ROWNUM AS RN, T.*
    FROM (SELECT I.NAME
                , I.DATETIME
                , TRUNC( TO_CHAR(SYSDATE - I.DATETIME +1) ) AS DURATION
            FROM ANIMAL_INS I, ANIMAL_OUTS O
            WHERE I.ANIMAL_ID = O.ANIMAL_ID(+)
                AND O.DATETIME IS NULL
            ORDER BY DURATION DESC
           ) T
;

-- 답안1> 보호기간이 긴 3마리의 이름, 보호시작일 조회(보호시작일 오름차순)
SELECT T2.NAME, T2.DATETIME
    FROM ( SELECT ROWNUM AS RN, T1.*
                FROM (SELECT I.NAME
                            , I.DATETIME
                            , TRUNC( TO_CHAR(SYSDATE 
                                - I.DATETIME +1) ) AS DURATION
                        FROM ANIMAL_INS I, ANIMAL_OUTS O
                        WHERE I.ANIMAL_ID = O.ANIMAL_ID(+)
                            AND O.DATETIME IS NULL
                        ORDER BY DURATION DESC
                    ) T1
           ) T2
    WHERE RN IN (1,2,3)
    ORDER BY T2.DATETIME
;


-- 방법2> ANSI 외부조인
-- 입양X의 이름, 보호시작일, '보호기간 = SYSDATE - 보호시작일 +1' 조회(보호기간 내림차순)
SELECT I.NAME
        , I.DATETIME
        , TRUNC( TO_CHAR(SYSDATE - I.DATETIME +1) ) AS DURATION
    FROM ANIMAL_INS I
    LEFT JOIN ANIMAL_OUTS O
    ON I.ANIMAL_ID = O.ANIMAL_ID
    WHERE O.DATETIME IS NULL
    ORDER BY DURATION DESC
;

-- ROWNUM, 입양X의 이름, 보호시작일, '보호기간 = SYSDATE - 보호시작일 +1' 조회(보호기간 내림차순)
SELECT ROWNUM AS RN, T.*
    FROM ( SELECT I.NAME
                , I.DATETIME
                , TRUNC( TO_CHAR(SYSDATE - I.DATETIME +1) ) AS DURATION
            FROM ANIMAL_INS I
            LEFT JOIN ANIMAL_OUTS O
            ON I.ANIMAL_ID = O.ANIMAL_ID
            WHERE O.DATETIME IS NULL
            ORDER BY DURATION DESC
          ) T
;

-- 답안2> 보호기간이 긴 3마리의 이름, 보호시작일 조회(보호시작일 오름차순)
SELECT T2.NAME, T2.DATETIME
    FROM ( SELECT ROWNUM AS RN, T1.*
            FROM ( SELECT I.NAME
                        , I.DATETIME
                        , TRUNC( TO_CHAR(SYSDATE 
                            - I.DATETIME +1) ) AS DURATION
                    FROM ANIMAL_INS I
                    LEFT JOIN ANIMAL_OUTS O
                    ON I.ANIMAL_ID = O.ANIMAL_ID
                    WHERE O.DATETIME IS NULL
                    ORDER BY DURATION DESC
                ) T1
           ) T2
    WHERE RN IN (1,2,3)
    ORDER BY T2.DATETIME
;
*/
-- 외부조인(+)
SELECT T2.NAME, T2.DATETIME
    FROM ( SELECT ROWNUM AS RN, T1.*
                FROM (SELECT I.NAME
                            , I.DATETIME
                            , TRUNC( TO_CHAR(SYSDATE 
                                - I.DATETIME +1) ) AS DURATION
                        FROM ANIMAL_INS I, ANIMAL_OUTS O
                        WHERE I.ANIMAL_ID = O.ANIMAL_ID(+)
                            AND O.DATETIME IS NULL
                        ORDER BY DURATION DESC
                    ) T1
           ) T2
    WHERE RN IN (1,2,3)
    ORDER BY T2.DATETIME
;