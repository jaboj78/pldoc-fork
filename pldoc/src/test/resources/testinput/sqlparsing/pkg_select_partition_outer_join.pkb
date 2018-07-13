

DECLARE 
	ty_customer_name_tab IS TABLE OF VARCHAR2(1);
	ty_year_month_tab IS TABLE OF VARCHAR2(6);
	ty_amount_tab IS TABLE OF NUMBER;

	l_customer_name ty_customer_name_tab ;
	l_year_month ty_year_month_tab ;
	l_amount ty_amount_tab;
BEGIN


--SELECT 
WITH year_months AS 
(
         SELECT TO_CHAR(
                   ADD_MONTHS(
                      DATE '2004-01-01', ROWNUM-1), 'YYYYMM') AS year_month
         FROM   dual
         CONNECT BY ROWNUM < 12
)
SELECT co.name
	,      ym.year_month
	,      NVL(SUM(co.amt),0) AS total_amount
INTO
	l_customer_name_tab
	,l_year_month_tab 
	,l_amount_tab
FROM   year_months ym
	 LEFT OUTER JOIN
	 customer_orders co PARTITION BY (co.name)
	 ON (TO_CHAR(co.dt,'YYYYMM') = ym.year_month)
GROUP  BY co.name ,      ym.year_month
ORDER  BY co.name ,      ym.year_month
;

END;
/

