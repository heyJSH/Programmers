-- 코드를 입력하세요
-- 코드를 입력하세요
/*
-- 사용 테이블 : USED_GOODS_BOARD
  의 컬럼 : board_id, writer_id, title, contents, price, created_date,
          status, views
-- 거래상태 sale이면 '판매중', reserved이면 '예약중', done이면 '거래완료'
-- 출력할 컬럼 : board_id, writer_id, title, price, status
-- 2022년 10월 5일에 등록된 중고 거래 게시물 중에서 출력
    WHERE to_date(created_date, 'yyyy-mm-dd') = '2022-10-05'
-- board_id 기준으로 내림차순 정렬
    ORDER BY board_id DESC

-- 기본 구문 틀
SELECT
        board_id, writer_id, title, price
        ,   CASE WHEN status = 'SALE' THEN '판매중'
            WHEN status = 'RESERVED' THEN '예약중'
            WHEN status = 'DONE' THEN '거래완료'
            END AS status
    FROM USED_GOODS_BOARD
    WHERE to_date(created_date, 'yyyy-mm-dd') = '2022-10-05'
    ORDER BY board_id DESC
;

*/
    
SELECT
        board_id, writer_id, title, price
        ,   CASE WHEN status = 'SALE' THEN '판매중'
            WHEN status = 'RESERVED' THEN '예약중'
            WHEN status = 'DONE' THEN '거래완료'
            END AS status
    FROM USED_GOODS_BOARD
    WHERE to_char(created_date, 'yyyy-mm-dd') = '2022-10-05'
    ORDER BY board_id DESC
;