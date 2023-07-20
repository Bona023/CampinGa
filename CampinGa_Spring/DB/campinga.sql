-- 신규/추천 캠핑장
create or replace procedure getNewRecoCamping(
    p_cur1 out SYS_REFCURSOR,
    p_cur2 out SYS_REFCURSOR
)
IS
BEGIN
    open p_cur1 for
        select bseq, cname, content, image 
        from (select * from businessman order by bseq desc) where rownum<=4;
    open p_cur2 for
        select cname, image, bseq 
        from businessman where rownum<=8;
END;


CREATE OR REPLACE PROCEDURE getMemberCam(
    p_mid IN member.mid%type,
    p_curvar OUT SYS_REFCURSOR
)
IS
    result_cur SYS_REFCURSOR;
BEGIN
    OPEN result_cur FOR SELECT * FROM member WHERE mid= p_mid;
        p_curvar := result_cur;
END;


CREATE OR REPLACE PROCEDURE insertMemberCam(
    p_mid IN member.mid%type,
    p_pwd IN member.pwd%type,
    p_name IN member.name%type,
    p_email IN member.email%type,
    p_mphone IN member.mphone%type
)
IS
BEGIN
    insert into member ( mid, pwd, name, email, mphone)
    values( p_mid, p_pwd, p_name, p_email, p_mphone);
    commit;
END;


-- 메인에서 캠핑장 검색
create or replace procedure getSearchResult(
    p_address1 in businessman.caddress1%type, 
    p_address2 in businessman.caddress2%type, 
    p_cname in businessman.caddress3%type,
    p_cur out SYS_REFCURSOR
)
IS
BEGIN
    open p_cur for
        select * from businessman 
        where caddress1 like '%'||p_address1||'%' 
            and caddress2 like '%'||p_address2||'%' 
            and cname like '%'||p_cname||'%';
END;

-- 02-08
-- 카테고리 : ALL
create or replace PROCEDURE categoryAll(
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR    
        SELECT bseq, cname, category, facilities, caddress1, caddress2, caddress3, phone, image
        FROM businessman;
END;

-- 카테고리 조회
create or replace PROCEDURE categoryList(
    p_cate IN businessman.category%type,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR    
        SELECT bseq, cname, category, facilities, caddress1, caddress2, caddress3, phone, image
        FROM businessman where category=p_cate;
END;



-- 02-09
-- 캠핑장 이름 검색
CREATE OR REPLACE PROCEDURE campNameSerch(
    p_name IN businessman.cname%type,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR    
        SELECT bseq, cname, category, facilities, caddress1, caddress2, caddress3, phone, image
        FROM businessman where cname LIKE '%'||p_name||'%';
END;


-- bseq로 캠핑장 정보 검색
CREATE OR REPLACE PROCEDURE campDetailByBseq(
    p_bseq IN businessman.bseq%type,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR    
        SELECT cname, phone, email, caddress1, caddress2, caddress3, facilities, image, content, category
        FROM businessman where bseq=p_bseq;
END;


-- 즐겨찾기 조회 ()

CREATE OR REPLACE PROCEDURE getFav(
    p_mid IN member.mid%type,
    p_bseq IN businessman.bseq%type,
    p_fav OUT favorites.fav_check%type
)
IS
    c_fav favorites.fav_check%type;
BEGIN
    SELECT fav_check INTO c_fav FROM favorites 
    WHERE mid=p_mid and bseq=p_bseq;
    p_fav := c_fav;
EXCEPTION 
    when no_data_found then p_fav := 'n';
END;


-- 캠핑장 객실 한개 조회
create or replace PROCEDURE selectCampOne(
    p_cseq IN camping_view.cseq%type,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR 
    SELECT * FROM camping_view WHERE cseq=p_cseq;
END;

-- bseq로 캠핑장 객실 리스트 검색
CREATE OR REPLACE PROCEDURE selectCampingList(
    p_bseq IN businessman.bseq%type,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR    
        SELECT * FROM camping_view where bseq=p_bseq;
END;


-- 캠핑장 qna, review count조회
CREATE OR REPLACE PROCEDURE getCount(
    p_tableName IN number,
    p_bseq IN businessman.bseq%type,
    p_cnt OUT number
)
IS
    v_cnt NUMBER;
BEGIN
    IF p_tableName = 1 THEN
        SELECT COUNT(*) INTO v_cnt FROM camp_qna WHERE bseq=p_bseq;
    ELSIF p_tableName = 2 THEN
        SELECT COUNT(*) INTO v_cnt FROM review WHERE  bseq=p_bseq;
    END IF;
    p_cnt := v_cnt;
END;



-- 캠핑장 qna 조회
CREATE OR REPLACE PROCEDURE selectQnaByBseq(
    p_bseq IN businessman.bseq%type,
    p_startNum IN number,
    p_endNum IN number,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
   OPEN p_rc FOR
        SELECT * FROM (
            SELECT * FROM (
                SELECT ROWNUM AS rn, q.*FROM 
                    ( ( SELECT * FROM camp_qna WHERE bseq=p_bseq ORDER BY qseq DESC)q)
            ) WHERE rn >= p_startNum
        ) WHERE rn <= p_endNum;
END;



-- 캠핑장 review 조회
CREATE OR REPLACE PROCEDURE selectReviewByBseq(
    p_bseq IN businessman.bseq%type,
    p_startNum IN number,
    p_endNum IN number,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
   OPEN p_rc FOR
        SELECT * FROM (
            SELECT * FROM (
                SELECT ROWNUM AS rn, r.*FROM 
                    ( ( SELECT * FROM review WHERE bseq=p_bseq ORDER BY rseq DESC)r)
            ) WHERE rn >= p_startNum
        ) WHERE rn <= p_endNum;
END;

-- 멤버 조회
CREATE OR REPLACE PROCEDURE getMemberCam(
    p_mid IN member.mid%type,
    p_curvar OUT SYS_REFCURSOR
)
IS
    result_cur SYS_REFCURSOR;
BEGIN
    OPEN result_cur FOR SELECT * FROM member WHERE mid= p_mid;
        p_curvar := result_cur;
END;

-- 멤버 회원가입 등록
CREATE OR REPLACE PROCEDURE insertMemberCam(
    p_mid IN member.mid%type,
    p_pwd IN member.pwd%type,
    p_name IN member.name%type,
    p_email IN member.email%type,
    p_phone IN member.mphone%type
)
IS
BEGIN
    insert into member ( mid, pwd, name, email, mphone)
    values( p_mid, p_pwd, p_name, p_email, p_phone);
    commit;
END;

-- 사업자 조회 One
CREATE OR REPLACE PROCEDURE getBusinessCam(
    p_bid IN businessman.bid%type,
    p_curvar OUT SYS_REFCURSOR
)
IS
    result_cur SYS_REFCURSOR;
BEGIN
    OPEN result_cur FOR SELECT * FROM businessman WHERE bid= p_bid;
        p_curvar := result_cur;
END;


-- 02-10
-- 관리자 조회
CREATE OR REPLACE  PROCEDURE getAdminList(
    p_aid IN admin.aid%type,
    p_rc OUT SYS_REFCURSOR 
)
IS
BEGIN
        OPEN p_rc FOR
            select * from admin where aid=p_aid;
END;



-- 관리자 count
create or replace PROCEDURE AdminCount(
    p_key IN VARCHAR2,
    p_tableName IN number,
    p_cnt OUT number
)
IS
    v_cnt NUMBER;
BEGIN
    IF p_tableName = 1 THEN
        SELECT COUNT(*) INTO v_cnt FROM member WHERE name LIKE '%'||p_key||'%';
    ELSIF p_tableName = 2 THEN
        SELECT COUNT(*) INTO v_cnt FROM businessman WHERE cname LIKE '%'||p_key||'%';
    ELSIF p_tableName = 3 THEN
        SELECT COUNT(*) INTO v_cnt FROM RESERVATE_VIEW WHERE c_class LIKE '%'||p_key||'%';
    ELSIF p_tableName = 4 THEN
        SELECT COUNT(*) INTO v_cnt FROM review WHERE content LIKE '%'||p_key||'%';
    ELSIF p_tableName = 5 THEN
        SELECT COUNT(*) INTO v_cnt FROM notice;
    END IF;
    p_cnt := v_cnt;
END;



-- 관리자 : 회원 조회
CREATE OR REPLACE  PROCEDURE adminMemberList(
    p_key IN member.name%type,
    p_startNum IN number,
    p_endNum IN number,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR
        SELECT * FROM (
            SELECT * FROM (
                SELECT ROWNUM AS rn, m.*FROM 
                    ((select * from member where name like '%'||p_key||'%' order by mid desc) m)
            ) WHERE rn >= p_startNum
            
        ) WHERE rn <= p_endNum;
END;



--  관리자 :  캠핑장 관리 조회 
CREATE OR REPLACE  PROCEDURE adminCampingList(
    p_key IN businessman.cname%type,
    p_startNum IN number,
    p_endNum IN number,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR
        SELECT * FROM (
            SELECT * FROM (
                SELECT ROWNUM AS rn, b.*FROM 
                    (( select * from businessman where cname like '%'||p_key||'%' order by bseq desc) b)
            ) WHERE rn >= p_startNum
        ) WHERE rn <= p_endNum;
END;



-- 관리자 : 캠핑장 리뷰 조회
CREATE OR REPLACE  PROCEDURE adminReviewList(
     p_key IN review.content%type,
    p_startNum IN number,
    p_endNum IN number,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR
        SELECT * FROM (
            SELECT * FROM (
                SELECT ROWNUM AS rn, r.*FROM 
                    (( select * from review where content like '%'||p_key||'%' order by rseq desc) r) 
            ) WHERE rn >= p_startNum
        ) WHERE rn <= p_endNum;
END;




-- 관리자 : 공지사항
CREATE OR REPLACE  PROCEDURE adminNoticeList(
    p_startNum IN number,
    p_endNum IN number,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR
        SELECT * FROM (
            SELECT * FROM (
                SELECT ROWNUM AS rn, n.*FROM 
                    ( ( SELECT * FROM notice order by nseq desc)n)
            ) WHERE rn >= p_startNum
        ) WHERE rn <= p_endNum;
END;

select*from notice;


-- 관리자 :  예약
CREATE OR REPLACE  PROCEDURE adminRestList(
    p_key IN reservate_view.c_class%type,
    p_startNum IN number,
    p_endNum IN number,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR
        SELECT * FROM (
            SELECT * FROM (
                SELECT ROWNUM AS rn, re.*FROM 
                    ((select * from reservate_view where c_class like '%'||p_key||'%' order by reseq desc) re)
            ) WHERE rn >= p_startNum
        ) WHERE rn <= p_endNum;
END;



-- 공지사항 상세
CREATE OR REPLACE  PROCEDURE selectNoticeOne(
    p_nseq IN number,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR
        SELECT * FROM notice WHERE nseq=p_nseq;
END;


-- 02-13
-- 사업자 정보수정
create or replace PROCEDURE updateBusiness(
    p_bid IN businessman.bid%TYPE ,
    p_name IN businessman.name%TYPE ,
    p_phone IN businessman.phone%TYPE,
    p_email IN businessman.email%TYPE 
)
IS
BEGIN
    update businessman set name=p_name, phone=p_phone ,email=p_email
    where bid=p_bid;
    commit;
END;



-- 사업자 회원 탈퇴
CREATE OR REPLACE PROCEDURE deleteBusiness(
    p_bid IN businessman.bid%TYPE )
IS
BEGIN
    delete from businessman where bid=p_bid;
    commit;
END;


-- 사업자  count
create or replace PROCEDURE BusinessGetAllCount(
    p_bseq IN businessman.bseq%type,
    p_tableName IN number,
    p_cnt OUT number
)
IS
    v_cnt NUMBER;
BEGIN
    IF p_tableName = 1 THEN
        SELECT COUNT(*) INTO v_cnt FROM reservate_view WHERE bseq=p_bseq;
     ELSIF p_tableName = 2 THEN
        SELECT COUNT(*) INTO v_cnt FROM camp_qna WHERE bseq=p_bseq;
    ELSIF p_tableName = 3 THEN
        SELECT COUNT(*) INTO v_cnt FROM camping_view WHERE bseq=p_bseq;   
    END IF;
    p_cnt := v_cnt;
END;








-- 사업자 QnA 리스트 
CREATE OR REPLACE  PROCEDURE getBusinessQnaList(
    p_bseq IN businessman.bseq%type,
    p_startNum IN number,
    p_endNum IN number,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR
        SELECT * FROM (
            SELECT * FROM (
                SELECT ROWNUM AS rn, q.*FROM 
                    ((select * from camp_qna where bseq=p_bseq order by qseq desc) q)
            ) WHERE rn >= p_startNum
        ) WHERE rn <= p_endNum;
END;



-- 사업자 QnA 한개 가져오기
CREATE OR REPLACE  PROCEDURE getQnaOne(
    p_qseq IN camp_qna.qseq%type,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR
    SELECT * FROM camp_qna WHERE qseq=p_qseq;
END;



-- 사업자 예약 리스트
CREATE OR REPLACE PROCEDURE getBusinessRestList(
     p_bseq IN businessman.bseq%type,
     p_startNum IN NUMBER,
     p_endNUM IN NUMBER,
     p_rc   OUT     SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR
        SELECT * FROM (
            SELECT * FROM (
                SELECT rownum as rn, m.* FROM
                    ((SELECT * FROM reservate_view WHERE bseq=p_bseq order by res_date) m)
            )WHERE rn>=p_startNum
        )WHERE rn<=p_endNum;
END;






-- Member Mypage
-- count
CREATE OR REPLACE PROCEDURE getMyPageCount(
    p_mid IN member.mid%type,
    p_tableName IN number,
    p_cnt OUT number
)
IS
    v_cnt NUMBER;
BEGIN
    IF p_tableName = 1 THEN
        SELECT COUNT(*) INTO v_cnt FROM reservate_view WHERE mid=p_mid;
    ELSIF p_tableName = 2 THEN
        SELECT COUNT(*) INTO v_cnt FROM favorites_view WHERE mid=p_mid;
    END IF;
    p_cnt := v_cnt;
END;



-- 사용자 예약 리스트
CREATE OR REPLACE PROCEDURE getReservateList(
    p_mid IN member.mid%type,
    p_startNum IN number,
    p_endNum IN number,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR  
    SELECT * FROM (
    SELECT * FROM (
    SELECT ROWNUM AS rn, q.* FROM ((select * from reservate_view WHERE mid=p_mid order by reseq desc) q) 
    ) WHERE rn>= p_startNum
    ) WHERE rn<= p_endNum;
END;



-- 사용자 즐겨찾기 리스트
CREATE OR REPLACE PROCEDURE getFavoritesList(
    p_mid IN member.mid%type,
    p_startNum IN number,
    p_endNum IN number,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR  
       select * from ( 
				 select * from ( 
				 select rownum as rn, f.fseq, f.bseq, f.mid, f.cname, f.fav_check, f.phone from 
				 (( select * from favorites_view WHERE mid=p_mid order by fseq desc) f) 
				  ) WHERE rn>= p_startNum
             ) WHERE rn<= p_endNum;
END;



-- 사용자 업데이트
create or replace PROCEDURE updateMember(
    p_mid IN member.mid%TYPE ,
    p_name IN member.name%TYPE ,
    p_mphone IN member.mphone%TYPE,
    p_email IN member.email%TYPE 
)
IS
BEGIN
    update member set name=p_name, mphone=p_mphone ,email=p_email
    where mid=p_mid;
    commit;
END;



-- 사용자 탈퇴
CREATE OR REPLACE PROCEDURE deleteMember(
    p_mid IN member.mid%TYPE )
IS
BEGIN
    delete from member where mid=p_mid;
    commit;
END;



-- 사용자 예약 취소
CREATE OR REPLACE PROCEDURE cancelReservate(
    p_reseq IN reservation.reseq%TYPE )
IS
BEGIN
    delete from reservation where reseq=p_reseq;
    commit;
END;

select * from  favorites;



-- 사용자 즐겨찾기 삭제
CREATE OR REPLACE PROCEDURE deleteMyFavorites(
   p_fseq IN favorites.fseq%TYPE )
IS
BEGIN
    delete from favorites where fseq=p_fseq;
    commit;
END;







