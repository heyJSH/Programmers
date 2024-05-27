/*
0. 문제
 : USED_GOODS_BOARD와 USED_GOODS_USER 테이블에서
  중고 거래 게시물을 3건 이상 등록한 사용자의
  사용자 ID, 닉네임, 전체주소, 전화번호를 조회하는 SQL문을 작성해주세요.
  이때, 전체 주소는 시, 도로명 주소, 상세 주소가 함께 출력되도록 해주시고,
  전화번호의 경우 xxx-xxxx-xxxx 같은 형태로 하이픈 문자열(-)을 삽입하여 출력.
  결과는 회원 ID를 기준으로 내림차순 정렬해주세요.

1. 테이블1
 : USED_GOODS_BOARD B
2. 테이블1_사용 컬럼
 : BOARD_ID             -- 게시글ID
    , WRITER_ID         -- 작성자ID
    , TITLE             -- 게시글 제목
    , CONTENTS          -- 게시글 내용
    , PRICE             -- 가격
    , CREATED_DATE      -- 작성일
    , STATUS            -- 거래상태
    , VIEWS             -- 조회수
3. 테이블2
 : USED_GOODS_USER U
4. 테이블2_사용 컬럼
 : USER_ID              -- 회원ID
    , NICKNAME          -- 닉네임
    , CITY              -- 시
    , STREET_ADDRESS1   -- 도로명 주소
    , STREET_ADDRESS2   -- 상세 주소
    , TLNO              -- 전화번호
5. 출력 컬럼
 : 사용자 ID
    , 닉네임
    , 전체주소  -- 시, 도로명주소, 상세주소 함께 출력
    , 전화번호  -- xxx-xxxx-xxxx처럼 하이픈'-'출력
-- 회원 id기준 내림차순 정렬
 : ORDER BY USER_ID DESC
 
-- 기본 구문
SELECT USER_ID              -- U.USER_ID = B.WRITER_ID
        , NICKNAME
        , TOTAL_ADDRESS
        , TLNO
    FROM USED_GOODS_USER U
    ORDER BY USER_ID DESC
;

-- total_address 출력
SELECT CITY || ' ' || STREET_ADDRESS1 || STREET_ADDRESS2
        AS TOTAL_ADDRESS
    FROM USED_GOODS_USER
    ORDER BY USER_ID DESC
;

-- 전화번호 포맷 변경
SELECT 
        SUBSTR(U.TLNO, 1, 3) || '-' || SUBSTR(U.TLNO, 4, 4)
            || '-' || SUBSTR(U.TLNO, 8, 4)
                AS NEW_TLNO
    FROM USED_GOODS_USER U
    ORDER BY USER_ID DESC
;

-- USER_ID, NICKNAME, TOTAL_ADDRESS, NEW_TLNO 출력
SELECT USER_ID              -- U.USER_ID = B.WRITER_ID
        , NICKNAME
        , CITY || ' ' || STREET_ADDRESS1 || STREET_ADDRESS2
            AS TOTAL_ADDRESS
        , SUBSTR(TLNO, 1, 3) || '-' || SUBSTR(TLNO, 4, 4)
            || '-' || SUBSTR(TLNO, 8, 4)
                AS NEW_TLNO
    FROM USED_GOODS_USER
    ORDER BY USER_ID DESC
;

-- 중고거래 게시물 3건 이상 등록한 목록 조회
-- USED_GOODS_BOARD 테이블에서
    -- 동일한 WRITER_ID의
    -- CREATED_DATE을 COUNT하여 3 이상인 목록을 조회
SELECT WRITER_ID, COUNT(CREATED_DATE)
    FROM USED_GOODS_BOARD B
    GROUP BY WRITER_ID
    HAVING COUNT(CREATED_DATE) >= 3
;
*/

-- ||로 연결
SELECT USER_ID              -- U.USER_ID = B.WRITER_ID
        , NICKNAME
        , CITY || ' ' || STREET_ADDRESS1 || ' ' || STREET_ADDRESS2
            AS TOTAL_ADDRESS
        , SUBSTR(TLNO, 1, 3) || '-' || SUBSTR(TLNO, 4, 4)
            || '-' || SUBSTR(TLNO, 8, 4)
                AS NEW_TLNO
    FROM USED_GOODS_USER
    WHERE USER_ID IN
            (
                SELECT WRITER_ID
                    FROM USED_GOODS_BOARD B
                    GROUP BY WRITER_ID
                    HAVING COUNT(CREATED_DATE) >= 3
              )
    ORDER BY USER_ID DESC
;