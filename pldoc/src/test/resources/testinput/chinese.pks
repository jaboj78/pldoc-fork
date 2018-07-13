PACKAGE ADMIN
  IS
  -- engineer group constant, default 102, 102 是 Oracle 技術服務中心的群組代碼
  engineer_group integer := 102; 
  /**
  -- Name: admin<br>  
  -- Purpose: 使用者與權限管理前端輸入畫面。使用到 util.popup_qry 的程式<br>
  --          並利用 sysage.user_util package 已寫好的公用程式<br>
  */ 
  PROCEDURE admin (p_id in varchar2 default null);
  
  /**
  Name: priv_mani<br>
  Purpose: 使用者與權限管理後端程式，此後端程式僅處理 ora_serv1.user_role
           相關的部分<br>
  @param p_action in varchar2 動作參數 (Add,Del,Upd)<br>
  p_id     in varchar2 使用者代碼 (= wwctx_api.get_user_id = sysage.wwsec_person$.id)<br>
  p_role    in varchar2 使用者角色<br>
  p_username in varchar2 p_id 為空值時，p_username 不得為空值，因需使用 p_username 取得id<br>
  */ 
  procedure priv_mani(
      p_action in varchar2,
      p_id     in varchar2,
      p_role   in varchar2 default null,
      p_username in varchar2 default null);
END; -- Package spec                                                                                                                   
                                                                                                   
                                                                                                                        
