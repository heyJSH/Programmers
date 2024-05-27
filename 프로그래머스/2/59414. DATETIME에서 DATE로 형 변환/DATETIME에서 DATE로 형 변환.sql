/*
<DATETIME에서 DATE로 형 변환>
0. 문제
 : ANIMAL_INS 테이블에 등록된 모든 레코드에 대해, 
    각 동물의 아이디와 이름, 들어온 날짜를 조회하는 SQL문을 작성해주세요. 
    이때 결과는 아이디 순으로 조회해야 합니다.
1. 테이블
 : ANIMAL_INS
2. 사용 컬럼
 : ANIMAL_ID            -- 동물아이디
    , ANIMAL_TYPE       -- 생물 종
    , DATETIME          -- 보호 시작일
    , INTAKE_CONDITION  -- 보호 시작 시 상태
    , NAME              -- 이름
    , SEX_UPON_INTAKE   -- 성별 및 중성화 여부
3. 출력 컬럼
 : ANIMAL_ID
    , NAME
    , TO_CHAR(DATETIME, 'YYYY-MM-DD')
-- ANIMAL_ID순으로 조회
 : ORDER BY ANIMAL_ID
*/
SELECT ANIMAL_ID
        , NAME
        , TO_CHAR(DATETIME, 'YYYY-MM-DD')
    FROM ANIMAL_INS
    ORDER BY ANIMAL_ID
;