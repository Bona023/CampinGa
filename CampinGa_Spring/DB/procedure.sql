-- 신규/추천 캠핑장
create or replace procedure getNewRecoCamping(
    p_cur1 out SYS_REFCURSOR,
    p_cur2 out SYS_REFCURSOR
)
IS
BEGIN
    open p_cur1 for
        select bseq, cname, content, image 
        from (select * from businessman order by bseq desc) where chkyn='Y' and rownum<=4;
    open p_cur2 for
        select cname, image, bseq 
        from businessman where chkyn='Y' and rownum<=8 ORDER BY rownum DESC;
END;

select * from businessman;

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
        where chkyn='Y' 
            and caddress1 like '%'||p_address1||'%' 
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
        FROM businessman where chkyn='Y';
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
        FROM businessman where chkyn='Y' and category=p_cate;
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
        FROM businessman where chkyn='Y' and cname LIKE '%'||p_name||'%';
END;


-- bseq로 캠핑장 정보 검색
CREATE OR REPLACE PROCEDURE campDetailByBseq(
    p_bseq IN businessman.bseq%type,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR    
        SELECT cname, phone, email, caddress1, caddress2, caddress3, facilities, image, content, category, campimages
        FROM businessman where chkyn='Y' and bseq=p_bseq;
END;
 select * from businessman;

-- 즐겨찾기 조회

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
    p_rc OUT SYS_REFCURSOR,
    p_resdate OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR 
    SELECT * FROM camping_view WHERE cseq=p_cseq;
    OPEN p_resdate FOR
    select to_char(chk_in,'yyyy-mm-dd') as chk_in, to_char(chk_out,'yyyy-mm-dd') as chk_out from reservation
	where cseq=p_cseq and chk_out>=sysdate order by chk_in;
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



-- 관리자 페이지에서의 각 메뉴의 컬럼 갯수 count
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



-- 관리자 : 회원조회
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



--  관리자 : 캠핑장 관리 조회
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

-- 관리자 : 리뷰 삭제
CREATE OR REPLACE  PROCEDURE deleteReview(
    p_rseq IN review.rseq%type
)
IS
BEGIN
        delete from review where rseq=p_rseq;
        commit;
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


-- 관리자 : 예약
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
-- 사업자 정보 수정
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

-- 사업자 휴면 전환
CREATE OR REPLACE PROCEDURE dormantBusiness(
    p_bid IN businessman.bid%TYPE )
IS
BEGIN
    update businessman set chkyn='N' where bid=p_bid;
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


-- 사업자 마이페이지 메뉴별 컬럼 갯수  count
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



-- 사업자 예약리스트
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

SELECT * FROM camping;
SELECT * FROM businessman;
SELECT * FROM reservation;
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

CREATE OR REPLACE PROCEDURE dormantMember(
    p_mid IN member.mid%TYPE )
IS
BEGIN
    update member set chkyn='N' where mid=p_mid;
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



--  사용자 즐겨찾기 삭제
CREATE OR REPLACE PROCEDURE deleteMyFavorites(
   p_fseq IN favorites.fseq%TYPE )
IS
BEGIN
    delete from favorites where fseq=p_fseq;
    commit;
END;

-- 캠핑장 객실 리스트
CREATE OR REPLACE  PROCEDURE campingRoomList(
    p_bseq IN camping_view.bseq%type,
    p_startNum IN number,
    p_endNum IN number,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR
        SELECT * FROM (
            SELECT * FROM (
                SELECT ROWNUM AS rn, c.*FROM 
                    ((select * from camping_view where bseq=p_bseq order by cseq) c)
            ) WHERE rn >= p_startNum
        ) WHERE rn <= p_endNum;
END;

select * from camping_view;

-- 사업자 페이징 관련 총 컬럼 갯수 확인
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

-- 캠핑장 객실 삭제
CREATE OR REPLACE PROCEDURE deleteCampingRoom(
    p_cseq IN camping.cseq%type
)
IS
BEGIN
   delete from camping where cseq=p_cseq;
   commit;
END;

-- 캠핑장 객실 하나만
CREATE OR REPLACE  PROCEDURE campingRoomOne(
    p_cseq IN camping_view.bseq%type,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN    
  OPEN p_rc FOR
        select * from camping_view where cseq=p_cseq;
END;
-- 캠핑장 객실 수정
create or replace procedure updateCampingRoom(
    p_c_class IN camping.c_class%type,
    p_price IN camping.price%type,
    p_min_people IN camping.min_people%type,
    p_max_people IN camping.max_people%type,
    p_c_image IN camping.c_image%type,
    p_cseq IN camping.cseq%type
)
is
begin
    update camping set c_class=p_c_class, price=p_price, min_people=p_min_people, max_people=p_max_people,
    c_image=p_c_image
    where cseq = p_cseq;
    commit;
end;

-- 캠핑장 객실 추가
CREATE OR REPLACE PROCEDURE insertCampingRoom(
    p_bseq IN camping.bseq%type,
    p_cname IN camping.cname%type,
    p_c_class IN camping.c_class%type,
    p_c_content IN camping.c_content%type,
    p_price IN camping.price%type,
    p_min_people IN camping.min_people%type,
    p_max_people IN camping.max_people%type,
    p_c_image IN camping.c_image%type
)
IS
BEGIN
    insert into camping ( cseq, bseq, cname, c_class, c_content, price, min_people, max_people, c_image)
    values( camping_seq.nextval, p_bseq, p_cname, p_c_class, p_c_content, p_price, p_min_people, p_max_people, p_c_image);
    commit;
END;


-- 02-14
-- 메인 롤링 이미지를 위한 테이블, 시퀀스 생성
CREATE TABLE mainBanners( 
  mbseq NUMBER(5) NOT NULL unique,
  NAME VARCHAR2(100),
  ORDER_SEQ NUMBER(1),
  IMAGE VARCHAR2(50 BYTE),
  USEYN CHAR(1 BYTE) DEFAULT 'Y',
  INDATE DATE DEFAULT sysdate );

CREATE SEQUENCE mb_seq INCREMENT BY 1 START WITH 1;

select * from mainbanners;
-- 메인 이미지 리스트 가져오기
CREATE OR REPLACE PROCEDURE adminBannerlist(
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR SELECT * FROM mainBanners ORDER BY useyn DESC, order_seq ASC;    
END;

-- 배너 추가
CREATE OR REPLACE PROCEDURE adminBannerWrite(
    p_name IN mainBanners.name%type,
    p_order_seq IN mainBanners.order_seq%type,
    p_useyn IN mainBanners.useyn%type,
    p_image IN mainBanners.image%type
)
IS
BEGIN
    UPDATE mainBanners SET order_seq=order_seq+1 WHERE order_seq>=p_order_seq and order_seq<=5;    
    INSERT INTO mainBanners ( mbseq, name, order_seq, useyn, image )
    VALUES ( mb_seq.nextval, p_name, p_order_seq, p_useyn, p_image);
    UPDATE mainBanners SET useyn='N'  WHERE order_seq=6;
    COMMIT;
END;



-- 배너 순서만 바꾸기
CREATE OR REPLACE PROCEDURE bannerOrderUpdate(
    p_mbseq IN mainBanners.mbseq%type,
    p_order_seq IN mainBanners.order_seq%type
)
IS
    v_oseq number(1);
BEGIN
    -- 바꾸려는 순서를 가지고 있는 사진을 원래의 본인의 순서로 배정
    -- 그 이후 바꾸려는 순서를 본인의 사진에 배정  
    -- 순서 외랑 변경할 경우도 같은데 변경후 사용여부를 N으로 변경 후 본인건 Y로 변경
    IF p_order_seq = 6 THEN
        UPDATE mainBanners SET order_seq=6 WHERE mbseq=p_mbseq;
    else
        select order_seq into v_oseq from mainBanners where mbseq=p_mbseq; 
        update mainBanners set order_seq=v_oseq where order_seq=p_order_seq;  
        update mainBanners set order_seq=p_order_seq, useyn='Y' where mbseq=p_mbseq;  
    END IF;
    UPDATE mainBanners SET useyn='N' WHERE order_seq=6;
    COMMIT;
END;

-- 배너 하나 가져오기
CREATE OR REPLACE PROCEDURE bannerSelectOne(
    p_mbseq IN mainBanners.mbseq%type,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR SELECT * FROM mainBanners WHERE mbseq=p_mbseq;    
END;



-- 배너 전체 수정
CREATE OR REPLACE PROCEDURE adminBannerUpdate(
    p_name IN mainBanners.name%type,
    p_order_seq IN mainBanners.order_seq%type,
    p_useyn IN mainBanners.useyn%type,
    p_image IN mainBanners.image%type,
    p_mbseq IN mainBanners.mbseq%type
)
IS
BEGIN
    UPDATE mainBanners SET order_seq=order_seq+1 WHERE order_seq>=p_order_seq and order_seq<=5;
    UPDATE mainBanners SET useyn='N'  WHERE order_seq=6;
    UPDATE mainBanners SET name=p_name, order_seq=p_order_seq, useyn=p_useyn, image=p_image
    WHERE mbseq=p_mbseq;
    COMMIT;
END;


UPDATE mainBanners SET useyn='N'  WHERE order_seq=6;
select*from mainBanners;

commit;



-- 메인에서 조회
CREATE OR REPLACE PROCEDURE getBannerList(
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR SELECT * FROM mainBanners WHERE order_seq<=5 and useyn='Y' ORDER BY order_seq;    
END;

-- 사업자 캠핑장 정보 수정 프로시져 
CREATE OR REPLACE PROCEDURE BsCampingInfoUpdate(
    p_bseq  IN businessman.bseq%type,
    p_cname  IN businessman.cname%type,
    p_image  IN businessman.image%type,
    p_content  IN businessman.content%type,
    p_category  IN businessman.category%type,
    p_caddress1  IN businessman.caddress1%type,
    p_caddress2  IN businessman.caddress2%type,
    p_caddress3  IN businessman.caddress3%type,
    p_facilities  IN businessman.facilities%type,
    p_campimages IN businessman.campimages%type
)
IS
BEGIN
    UPDATE businessman SET cname=p_cname, image=p_image, content=p_content, category=p_category, caddress1=p_caddress1, 
    caddress2=p_caddress2, caddress3=p_caddress3, facilities=p_facilities, campimages=p_campimages
    WHERE bseq=p_bseq;
    commit;
END;

select * from businessman;

-- 사업자 가입 프로시져
CREATE OR REPLACE PROCEDURE insertBusinessCam(
    p_bid IN businessman.bid%type,
    p_pwd IN businessman.pwd%type,
    p_name IN businessman.name%type,
    p_cname IN businessman.cname%type,
    p_phone IN businessman.phone%type,
    p_email IN businessman.email%type,
    p_caddress1 IN businessman.caddress1%type,
    p_caddress2 IN businessman.caddress2%type,
    p_caddress3 IN businessman.caddress3%type
)
IS
BEGIN
    insert into businessman ( bseq, bid, pwd, name, cname,  phone, email, caddress1, caddress2, caddress3 )
    values( businessman_seq.nextval, p_bid, p_pwd, p_name, p_cname, p_phone, p_email,  p_caddress1, p_caddress2, p_caddress3);
    commit;
END;

select * from member;

SET SERVEROUTPUT ON;
-- 관리자 : 사용자 휴면 설정/해제 
CREATE OR REPLACE PROCEDURE updateMemberDormant(
    p_mid in member.mid%type
)
IS
    v_chkyn varchar2(20);
BEGIN
    select chkyn into v_chkyn from member where mid=p_mid;
    IF (v_chkyn='Y') THEN
        update member set chkyn='N' where mid=p_mid;
        commit;
    ELSIF (v_chkyn='N') THEN
        update member set chkyn='Y' where mid=p_mid;
        commit;
    END IF;
END;


-- get Mid
CREATE OR REPLACE PROCEDURE returnMid(
    p_name IN member.name%type,
    p_mphone IN member.mphone%type,
    p_mid OUT member.mid%type
)
IS
BEGIN
    SELECT mid INTO p_mid FROM member WHERE name=p_name and mphone=p_mphone;
    EXCEPTION 
    when no_data_found then p_mid := '';
END;

select * from member;

-- get Bid
CREATE OR REPLACE PROCEDURE returnBid(
    p_name IN businessman.name%type,
    p_phone IN businessman.phone%type,
    p_bid OUT businessman.bid%type
)
IS
BEGIN
    SELECT bid INTO p_bid FROM businessman WHERE name=p_name and phone=p_phone;
    EXCEPTION 
    when no_data_found then p_bid := '';
END;




-- 본인확인 일반회원
CREATE OR REPLACE PROCEDURE confirmMid(
    p_mid IN member.mid%type,
    p_email IN member.email%type,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR
    SELECT * FROM member WHERE mid=p_mid and email=p_email;
    EXCEPTION 
    when no_data_found then p_rc := NULL;
END;




-- 본인확인 사업자회원
CREATE OR REPLACE PROCEDURE confirmBid(
    p_bid IN businessman.bid%type,
    p_email IN businessman.email%type,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR
    SELECT * FROM businessman WHERE bid=p_bid and email=p_email;
    EXCEPTION 
    when no_data_found then p_rc := NULL;
END;
