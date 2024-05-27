-- 코드를 입력하세요
/* 0. 문제
동물 보호소에 들어온 동물 이름 중,
이름에 "EL"이 들어가는 개의 아이디와 이름을 조회하는 SQL문을 작성해주세요.
이때 결과는 이름 순으로 조회해주세요. 단, 이름의 대소문자는 구분하지 않습니다.

1. 테이블
 : ANIMAL_INS
2. 테이블 속 컬럼명
 : ANIMAL_ID            -- 동물id
   , ANIMAL_TYPE        -- 생물 종
   , DATETIME           -- 보호 시작일
   , INTAKE_CONDITION   -- 보호 시작 시 상태
   , NAME               -- 이름
   , SEX_UPON_INTAKE    -- 성별 및 중성화 여부
3. 출력할 컬럼
 : ANIMAL_ID
   , NAME
4. 조건
-- ANIMAL_TYPE = 'Dog'
-- 이름 순으로 조회
    : ORDER BY NAME  
-- NAME에 "EL"이 들어간 목록 출력
-- 이름의 대소문자 구분하지 않음
    : 이름을 대문자로 반환하여 대문자로 'EL' 들어가는 목록을 조회
      (또는 반대로 소문자로 반환하여 소문자로 'el' 들어가는 목록을 조회)
    : WHERE UPPER(TO_CHAR(NAME)) LIKE ('%EL%')

-- 기본구문
SELECT ANIMAL_ID
        , NAME
    FROM ANIMAL_INS
    ORDER BY NAME
;
*/

SELECT ANIMAL_ID, NAME
    FROM ANIMAL_INS i
    WHERE UPPER(TO_CHAR(NAME)) LIKE ('%EL%')
        AND ANIMAL_TYPE = 'Dog'
    ORDER BY NAME