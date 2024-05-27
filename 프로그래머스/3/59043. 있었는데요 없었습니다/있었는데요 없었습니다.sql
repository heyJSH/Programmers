/*
<있었는데요 없었습니다>
0. 문제
 : 관리자의 실수로 일부 동물의 입양일이 잘못 입력되었습니다.
   보호 시작일보다 입양일이 더 빠른 동물의 아이디와 이름을 조회하는 SQL문을 작성.
   이때 결과는 보호 시작일이 빠른 순으로 조회해야합니다.
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

-- 조회 : 보호 시작일이 빠른 순(오름차순)
 : ORDER BY I.DATETIME
 
-- 보호시작일 > 입양일인 ANIMAL_ID, NAME, 보호시작일, 입양일 조회(보호시작일 오름차순)
SELECT I.ANIMAL_ID, I.NAME
        , TO_CHAR(I.DATETIME, 'YYYY-MM-DD')
        , TO_CHAR(O.DATETIME, 'YYYY-MM-DD')
    FROM ANIMAL_INS I
        , ANIMAL_OUTS O
    WHERE I.ANIMAL_ID = O.ANIMAL_ID
        AND I.DATETIME > O.DATETIME
    ORDER BY I.DATETIME
;

-- 보호시작일 > 입양일인 ANIMAL_ID, NAME 조회(보호시작일 오름차순)
-- 방법1> 오라클 동등조인
SELECT I.ANIMAL_ID, I.NAME
    FROM ANIMAL_INS I
        , ANIMAL_OUTS O
    WHERE I.ANIMAL_ID = O.ANIMAL_ID
        AND I.DATETIME > O.DATETIME
    ORDER BY I.DATETIME
;
*/

-- 보호시작일 > 입양일인 ANIMAL_ID, NAME 조회(보호시작일 오름차순)
-- 방법2> ANSI 조인
SELECT I.ANIMAL_ID, I.NAME
    FROM ANIMAL_INS I
    INNER JOIN ANIMAL_OUTS O
    ON I.ANIMAL_ID = O.ANIMAL_ID
        AND I.DATETIME > O.DATETIME
    ORDER BY I.DATETIME
;