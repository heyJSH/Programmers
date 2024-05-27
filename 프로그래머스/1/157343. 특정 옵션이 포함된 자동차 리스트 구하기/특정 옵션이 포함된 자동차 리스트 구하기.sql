-- 코드를 입력하세요
SELECT car_id, car_type, daily_fee, options
    FROM CAR_RENTAL_COMPANY_CAR
    WHERE options LIKE '%네비게이션%'
    ORDER BY car_id DESC;