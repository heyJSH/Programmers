/*
[ANIMAL_INS I] 테이블
 : ANIMAL_ID            -- 동물id
    , ANIMAL_TYPE       -- 생물 종
    , DATETIME          -- 보호 시작일
    , INTAKE_CONDITION  -- 보호 시작 시 상태
    , NAME              -- 이름
    , SEX_UPON_INTAKE   -- 성별 및 중성화 여부
    
[ANIMAL_OUTS O] 테이블
 : ANIMAL_ID            -- 동물id, FOREIGN KEY(ins 테이블의 animal_id)
    , ANIMAL_TYPE       -- 생물 종
    , DATETIME          -- 입양일
    , NAME              -- 이름
    , SEX_UPON_OUTCOME  -- 성별 및 중성화 여부
    
[문제]
 : 입양을 간 동물 중, 보호 기간이 가장 길었던 동물 두 마리의 
  아이디와 이름을 조회하는 SQL문을 작성해주세요. 
  이때 결과는 보호 기간이 긴 순으로 조회해야 합니다.
  
-- 기본 구문
SELECT ANIMAL_ID
        , NAME
    FROM ANIMAL_OUTS
;

-- 보호기간 = TO_CHAR(O.DATETIME - I.DATETIME +1)
-- 보호기간이 가장 길었던 두마리
-- 가장 긴 것 : MAX(보호기간)
-- 그 다음 긴것 : MAX(보호기간)을 제외한 MAX(보호기간)
-- 보호 기간이 긴 순으로 조회
 : ORDER BY 보호기간
-- 동물ID, 보호시작일, 입양일, 보호기간 조회
SELECT O.ANIMAL_ID
        , I.DATETIME AS START_DATE
        , O.DATETIME AS END_DATE
        , TRUNC(O.DATETIME - I.DATETIME +1) AS DURATION
    FROM ANIMAL_INS I, ANIMAL_OUTS O
    WHERE I.ANIMAL_ID = O.ANIMAL_ID
    ORDER BY TRUNC(O.DATETIME - I.DATETIME +1) DESC
;

-- 보호기간 최대값 구하기
SELECT MAX(TRUNC(O.DATETIME - I.DATETIME +1))
            AS FIRST_DURATION
    FROM ANIMAL_INS I, ANIMAL_OUTS O
    WHERE I.ANIMAL_ID = O.ANIMAL_ID
    ORDER BY TRUNC(O.DATETIME - I.DATETIME +1) DESC
;

-- RN 포함한 동물ID, 이름, 보호기간을 보호기간 내림차순 정렬
-- ROWNUM, ORDER BY는 행번호 먼저 지정 후 순서 정렬하므로
-- ORDER BY 먼저 한 후, ROWNUM 지정해주기
SELECT ROWNUM AS RN, T.ANIMAL_ID, T.NAME, T.DURATION
    FROM (SELECT O.ANIMAL_ID
                , O.NAME
                , I.DATETIME AS START_DATE
                , O.DATETIME AS END_DATE
                , TRUNC(O.DATETIME - I.DATETIME +1) AS DURATION
            FROM ANIMAL_INS I, ANIMAL_OUTS O
            WHERE I.ANIMAL_ID = O.ANIMAL_ID
            ORDER BY TRUNC(O.DATETIME - I.DATETIME +1) DESC
          ) T
;
*/
-- 답안
SELECT ANIMAL_ID, NAME
    FROM (SELECT ROWNUM AS RN, T.ANIMAL_ID, T.NAME, T.DURATION
                FROM (SELECT O.ANIMAL_ID
                            , O.NAME
                            , I.DATETIME AS START_DATE
                            , O.DATETIME AS END_DATE
                            , TRUNC(O.DATETIME - I.DATETIME +1) 
                                AS DURATION
                        FROM ANIMAL_INS I, ANIMAL_OUTS O
                        WHERE I.ANIMAL_ID = O.ANIMAL_ID
                        ORDER BY DURATION DESC
                        ) T
            )
    WHERE RN IN (1,2)
    -- 혹은 WHERE RN=1 OR RN=2
;