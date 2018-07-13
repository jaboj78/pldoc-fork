create or replace package default_params as

FUNCTION Test
( I_ID IN NUMBER DEFAULT (1)
, I_ID2 IN NUMBER DEFAULT 2
, I_Name IN VARCHAR2 default ("aaa")
, I_Name2 IN VARCHAR2 default "bbb"
, I_CDate IN DATE DEFAULT SYSDATE
, I_CDate2 IN DATE DEFAULT (SYSDATE)
)
  RETURN  VARCHAR2;

end;