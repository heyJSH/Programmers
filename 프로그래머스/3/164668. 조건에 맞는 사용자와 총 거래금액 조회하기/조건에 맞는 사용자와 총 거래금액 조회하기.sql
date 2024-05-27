/*
<조건에 맞는 사용자와 총 거래금액 조회하기>
0. 문제
 : USED_GOODS_BOARD와 USED_GOODS_USER 테이블에서 
   완료된 중고 거래의 총금액이 70만 원 이상인 사람의 
   회원 ID, 닉네임, 총거래금액을 조회하는 SQL문을 작성해주세요.
   결과는 총거래금액을 기준으로 오름차순 정렬해주세요.
1. 테이블1
 : USED_GOODS_BOARD B
1_2. 사용컬럼_테이블1
 : BOARD_ID         -- 게시글id
    , WRITER_ID     -- 작성자id
    , TITLE         -- 게시글 제목
    , CONTENTS      -- 게시글 내용
    , PRICE         -- 가격
    , CREATED_DATE  -- 작성일
    , STATUS        -- 거래상태
    , VIEWS         -- 조회수
2. 테이블2
 : USED_GOODS_USER U
2_2. 사용컬럼_테이블2
 : USER_ID              -- 회원 ID
    , NICKNAME          -- 닉네임
    , CITY              -- 시
    , STREET_ADDRESS1   -- 도로명 주소
    , STREET_ADDRESS2   -- 상세 주소
    , TLNO              -- 전화번호
3. 출력 컬럼
 : USER_ID U
    , NICKNAME
    , 총거래금액
    
-- 총거래금액을 기준으로 오름차순 정렬
 : ORDER BY 총거래금액

-- 완료된 중고 거래의 데이터 출력
SELECT *
    FROM USED_GOODS_BOARD B
    WHERE B.STATUS = 'DONE'
;

-- 거래완료된 목록의 B.작성자ID, B.가격, U.닉네임 조회
SELECT B.WRITER_ID, B.PRICE, U.NICKNAME
    FROM USED_GOODS_BOARD B
        , USED_GOODS_USER U
    WHERE B.WRITER_ID = U.USER_ID
        AND B.STATUS = 'DONE'
    GROUP BY B.WRITER_ID
    ORDER BY PRICE
;

-- 거래완료된 목록의 B.작성자ID, U.닉네임, B.동일 작성자의 총 판매가격 조회
SELECT B.WRITER_ID, U.NICKNAME, SUM(B.PRICE) TOTAL_PRICE
    FROM USED_GOODS_BOARD B
        , USED_GOODS_USER U
    WHERE B.WRITER_ID = U.USER_ID
        AND B.STATUS = 'DONE'
    GROUP BY B.WRITER_ID, U.NICKNAME
    ORDER BY TOTAL_PRICE
;
*/

-- 답안> 동등조건 사용
SELECT B.WRITER_ID, U.NICKNAME, SUM(B.PRICE) AS TOTAL_PRICE
    FROM USED_GOODS_BOARD B
        , USED_GOODS_USER U
    WHERE B.WRITER_ID = U.USER_ID
        AND B.STATUS = 'DONE'
    GROUP BY B.WRITER_ID, U.NICKNAME
    HAVING SUM(B.PRICE) >= 700000
    ORDER BY TOTAL_PRICE
;