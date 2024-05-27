/*
0. 문제
 : USED_GOODS_BOARD와 USED_GOODS_FILE 테이블에서
 조회수가 가장 높은 중고거래 게시물에 대한 첨부파일 경로를 조회하는 SQL문 작성.
 첨부파일 경로는 FILE ID를 기준으로 내림차순 정렬해주세요.
 기본적인 파일경로는 /home/grep/src/ 이며, 
 게시글 ID를 기준으로 디렉토리가 구분되고, 
 파일이름은 파일 ID, 파일 이름, 파일 확장자로 구성되도록 출력해주세요.
 조회수가 가장 높은 게시물은 하나만 존재합니다.
1. 테이블1
 : USED_GOODS_BOARD
1_1. 사용컬럼_테이블1
 : BOARD_ID         -- 게시글id
    , WRITER_ID     -- 작성자id
    , TITLE         -- 게시글 제목
    , CONTENTS      -- 게시글 내용
    , PRICE         -- 가격
    , CREATED_DATE  -- 작성일
    , STATUS        -- 거래상태
    , VIEWS         -- 조회수
2. 테이블2
 : USED_GOODS_FILE
2_1. 사용컬럼_테이블2
 : FILE_ID          -- 파일 id
    , FILE_EXT      -- 파일 확장자
    , FILE_NAME     -- 파일 이름
    , BOARD_ID      -- 게시글 id
    
-- 조회수가 가장 높은 중고거래 게시물(하나만 존재)
-- 조회수가 가장 높은 중고거래 게시물에 대한 첨부파일 경로 조회
-- 기본적인 파일경로 : /home/grep/src/
-- 파일이름(FILE_NAME)은 파일ID(FILE_ID), 파일이름(FILE_NAME)
    , 파일확장자(FILE_EXT)로 구성
-- 파일경로
 : /home/grep/src/ + BOARD_ID + '/' + FILE_ID + FILE_NAME + FILE_EXT
-- FILE_ID 기준으로 내림차순 정렬
 : ORDER BY FILE_ID DESC

-- 파일경로 조회
SELECT '/home/grep/src/' || BOARD_ID || '/' || FILE_ID
        || FILE_NAME || FILE_EXT as FILE_PATH
        , FILE_ID
    FROM USED_GOODS_FILE
    ORDER BY FILE_ID DESC
;
 
-- 가장 높은 조회수 조회
SELECT MAX(VIEWS)
    FROM USED_GOODS_BOARD
;

-- 조회수가 가장 높은 중고거래 게시물 조회
SELECT BOARD_ID
    FROM USED_GOODS_BOARD
    WHERE VIEWS = (SELECT MAX(VIEWS) FROM USED_GOODS_BOARD)
;

-- 답안1> '=' 사용
SELECT '/home/grep/src/' || BOARD_ID || '/' || FILE_ID
        || FILE_NAME || FILE_EXT as FILE_PATH
    FROM USED_GOODS_FILE F
    WHERE F.BOARD_ID
        = (SELECT B.BOARD_ID
                FROM USED_GOODS_BOARD B
                WHERE VIEWS = 
                    (SELECT MAX(VIEWS) FROM USED_GOODS_BOARD))
    ORDER BY FILE_ID DESC
;

-- 답안2> IN 사용
-- 답안
SELECT '/home/grep/src/' || BOARD_ID || '/' || FILE_ID
        || FILE_NAME || FILE_EXT as FILE_PATH
    FROM USED_GOODS_FILE F
    WHERE F.BOARD_ID
        IN (SELECT B.BOARD_ID
                FROM USED_GOODS_BOARD B
                WHERE VIEWS 
                    = (SELECT MAX(VIEWS) FROM USED_GOODS_BOARD))
    ORDER BY FILE_ID DESC
;
*/

-- 답안
SELECT '/home/grep/src/' || BOARD_ID || '/' || FILE_ID
        || FILE_NAME || FILE_EXT as FILE_PATH
    FROM USED_GOODS_FILE F
    WHERE F.BOARD_ID
        IN (SELECT B.BOARD_ID
                FROM USED_GOODS_BOARD B
                WHERE VIEWS
                    = (SELECT MAX(VIEWS) FROM USED_GOODS_BOARD))
    ORDER BY FILE_ID DESC
;