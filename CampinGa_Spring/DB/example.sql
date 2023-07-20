-- 사업자 시퀀스 생성 --
drop sequence businessman_seq;
create sequence businessman_seq start with 1;

insert into member(mid, pwd, name, mphone, email)
values('qndrl12', '1234', '이준표', '010-8010-4755', 'qndrl12@naver.com');

select * from member;
select * from qna;

-- 사업자 입력 --
insert into businessman(bseq, bid, pwd, name, phone, email, cname, caddress1, caddress2, caddress3, facilities, image, content, category) 
values(businessman_seq.nextval, 'dp', '1234', '이대표', '010-1111-1111', 'abc@abc.com' , 
'해여림 빌리지', '경기도','여주시', '산북면 해여림로 78', '바베큐장, 주차장', 'camp01.jpg',
'다양한 컨텐츠로 즐거운 일상탈출 맛있는 음식과 깨끗한 시설 친절한 서비스 고객감동 서비스가 시작되는 여기는 캠핑장입니다.', 'camping');

insert into businessman(bseq, bid, pwd, name, phone, email, cname, caddress1, caddress2, caddress3, facilities, image, content, category) 
values(businessman_seq.nextval, 'bn', '1234', '김보나', '010-2222-1111', 'abc@abc.com' , 
'경주 텐타우스', '경상북도','경주시', '강동면 왕신숲골안길 5', '바베큐장, 주차장', 'camp02.jpg',
'안녕하세요 경주 텐타우스입니다.', 'campnic');

insert into businessman(bseq, bid, pwd, name, phone, email, cname, caddress1, caddress2, caddress3, facilities, image, content, category) 
values(businessman_seq.nextval, 'bw', '1234', '김보임', '010-3333-1111', 'abc@abc.com' , 
'연천 써니힐즈', '경기도','연천군', '장남면 장백로330번길 137-28', '바베큐장, 주차장', 'camp01.jpg',
'안녕하세요 연천 써니힐즈입니다.', 'auto');

insert into businessman(bseq, bid, pwd, name, phone, email, cname, caddress1, caddress2, caddress3, facilities, image, content, category) 
values(businessman_seq.nextval, 'bc', '1234', '김보정', '010-4444-1111', 'abc@abc.com' , 
'홍천 해솔캠핑장', '강원도','홍천군', '내촌면 논골길 91', '바베큐장, 주차장', 'camp02.jpg',
'안녕하세요 홍천 해솔캠핑장입니다.', 'caravane');

insert into businessman(bseq, bid, pwd, name, phone, email, cname, caddress1, caddress2, caddress3, facilities, image, content, category) 
values(businessman_seq.nextval, 'ba', '1234', '김보점', '010-5555-1111', 'abc@abc.com' , 
'태안 굼벵이 캠핑농원', '충청남도','태안군', '이원면 꾸지나무길 103-10', '바베큐장, 주차장', 'camp01.jpg',
'안녕하세요 태안 굼벵이 캠핑농원입니다', 'camping');

select * from businessman;
select * from camping;
delete from businessman where bseq=21;

select count(*) from camping where cname='해여림 빌리지';


drop sequence camping_seq;
create sequence camping_seq start with 1;

insert  into camping(cseq, bseq, cname, c_image, c_content, c_class, res_sta, price, min_people, max_people)
values (camping_seq.nextval, 21,'해여림 빌리지', 'camp02.jpg','해여림 AA방입니다.','해여림 AA', 'n', 200000, 4, 10);

insert  into camping(cseq, bseq, cname, c_image, c_content, c_class, res_sta, price, min_people, max_people)
values (camping_seq.nextval, 21,'해여림 빌리지', 'camp02.jpg','해여림 BB방입니다.','해여림 BB', 'n', 150000, 4, 8);

insert  into camping(cseq, bseq, cname, c_image, c_content, c_class, res_sta, price, min_people, max_people)
values (camping_seq.nextval, 21,'해여림 빌리지', 'camp02.jpg','해여림 CC방입니다.','해여림 CC', 'n', 250000, 6, 12);




insert  into camping(cseq, bseq, cname, facilities, image, content, category, c_class, res_sta, price, 
				min_people, max_people  )
values (camping_seq.nextval, 2,'경주 텐타우스','바베큐장, 주차장, 와이파이',
'camp01.jpg','다양한 컨텐츠로 즐거운 일상탈출 맛있는 음식과 깨끗한 시설 친절한 서비스 고객감동 서비스가 시작되는 여기는 캠핑장입니다.',
'camping','텐타우스 A', 'n', 200000, 4, 10);
insert  into camping(cseq, bseq, cname, facilities, image, content, category, c_class, res_sta, price, 
				min_people, max_people  )
values (camping_seq.nextval, 3,'연천 써니힐즈','바베큐장, 주차장, 와이파이',
'camp01.jpg','다양한 컨텐츠로 즐거운 일상탈출 맛있는 음식과 깨끗한 시설 친절한 서비스 고객감동 서비스가 시작되는 여기는 캠핑장입니다.',
'auto','써니힐즈 A', 'n', 200000, 4, 10);
insert  into camping(cseq, bseq, cname, facilities, image, content, category, c_class, res_sta, price, 
				min_people, max_people  )
values (camping_seq.nextval, 4,'홍천 해솔캠핑장','바베큐장, 주차장, 와이파이',
'camp01.jpg','다양한 컨텐츠로 즐거운 일상탈출 맛있는 음식과 깨끗한 시설 친절한 서비스 고객감동 서비스가 시작되는 여기는 캠핑장입니다.',
'caravane','해솔캠핑장 A', 'n', 200000, 4, 10);
insert  into camping(cseq, bseq, cname, facilities, image, content, category, c_class, res_sta, price, 
				min_people, max_people  )
values (camping_seq.nextval, 5,'태안 굼벵이 캠핑농원','바베큐장, 주차장, 와이파이',
'camp01.jpg','다양한 컨텐츠로 즐거운 일상탈출 맛있는 음식과 깨끗한 시설 친절한 서비스 고객감동 서비스가 시작되는 여기는 캠핑장입니다.',
'campnic','캠핑농원 A', 'n', 200000, 4, 10);



-- 관리자 입력 -- 
insert into admin(aid, pwd)
values('scott', '1234');


-- 즐겨찾기 시퀀스 생성 --
drop sequence favorites_seq;
create sequence favorites_seq start with 1;


insert into favorites(fseq, mid, bseq)
values(favorites_seq.nextval, 'qndrl12', 1);
insert into favorites(fseq, mid, bseq)
values(favorites_seq.nextval, 'qndrl12', 2);
insert into favorites(fseq, mid, bseq)
values(favorites_seq.nextval, 'dp', 3);
insert into favorites(fseq, mid, bseq)
values(favorites_seq.nextval, 'whsia', 3);
insert into favorites(fseq, mid, bseq)
values(favorites_seq.nextval, 'dp', 4);


select * from favorites; 

-- 리뷰 시퀀스 생성 --
drop sequence review_seq;
create sequence review_seq start with 1;

insert into review(rseq, bseq, mid, content)
values(review_seq.nextval, 1, 'qndrl12', '아주 좋아요');
insert into review(rseq, bseq, mid, content)
values(review_seq.nextval, 1, 'qndrl12', '캠핑장이 아주 좋아요');

-- 공지사항 시퀀스 생성 --
drop sequence notice_seq;
create sequence notice_seq start with 1;


-- 공지사항 입력 --
insert into notice(nseq, aid, subject, content)
values( notice_seq.nextval, 'scott', 'CampinGa 오픈', '안녕하세요. 오지캠핑 관리자입니다.
오지/노지 캠핑만 다니다 보니 관련 정보가 많이 부족하고 찾기도 힘들어 홈페이지를 
구축해 보고자 시작하게된 개인적인 프로젝트입니다.
많은 관심 부탁드립니다. 아직 모바일웹버전은 버그가 많이 보이고 있는 상태입니다. 
빠른 세팅하도록 하겠습니다.감사합니다.');




create sequence camping_seq start with 1;
-- 캠핑장 정보 입력
insert  into camping(cseq, bseq, cname, facilities, image, content, category, c_class, res_sta, price, 
				min_people, max_people  )
values (camping_seq.nextval, 1,'해여림 빌리지','바베큐장, 주차장',
'camp02.jpg','다양한 컨텐츠로 즐거운 일상탈출 맛있는 음식과 깨끗한 시설 친절한 서비스 고객감동 서비스가 시작되는 여기는 캠핑장입니다.',
'camping','해여림 A', 'n', 100000, 4, 10);
insert  into camping(cseq, bseq, cname, facilities, image, content, category, c_class, res_sta, price, 
				min_people, max_people  )
values (camping_seq.nextval, 1,'해여림 빌리지','바베큐장, 주차장',
'camp02.jpg','다양한 컨텐츠로 즐거운 일상탈출 맛있는 음식과 깨끗한 시설 친절한 서비스 고객감동 서비스가 시작되는 여기는 캠핑장입니다.',
'camping','해여림 B', 'n', 100000, 4, 10);

insert  into camping(cseq, bseq, cname, facilities, image, content, category, c_class, res_sta, price, 
				min_people, max_people  )
values (camping_seq.nextval, 1,'해여림 빌리지','바베큐장, 주차장',
'camp02.jpg','다양한 컨텐츠로 즐거운 일상탈출 맛있는 음식과 깨끗한 시설 친절한 서비스 고객감동 서비스가 시작되는 여기는 캠핑장입니다.',
'camping','해여림 C', 'n', 100000, 4, 10);

insert  into camping(cseq, bseq, cname, facilities, image, content, category, c_class, res_sta, price, 
				min_people, max_people  )
values (camping_seq.nextval, 1,'해여림 빌리지','바베큐장, 주차장',
'camp02.jpg','다양한 컨텐츠로 즐거운 일상탈출 맛있는 음식과 깨끗한 시설 친절한 서비스 고객감동 서비스가 시작되는 여기는 캠핑장입니다.',
'camping','해여림 D', 'n', 100000, 4, 10);

insert  into camping(cseq, bseq, cname, facilities, image, content, category, c_class, res_sta, price, 
				min_people, max_people  )
values (camping_seq.nextval, 4,'홍천 해솔캠핑장','바베큐장, 주차장',
'w-1.jpg','다양한 컨텐츠로 즐거운 일상탈출 맛있는 음식과 깨끗한 시설 친절한 서비스 고객감동 서비스가 시작되는 여기는 캠핑장입니다.',
'camping','후시아 A', 'n', 200000, 4, 10);


select * from camping;

drop sequence qna_seq;
create sequence qna_seq start with 1;

insert into camp_qna(qseq, mid, bseq, content , repyn)
values (qna_seq.nextval, 'qndrl12', 1,'바베큐장 있나요?','n');
insert into camp_qna(qseq, mid, bseq, content , reply, repyn)
values (qna_seq.nextval, 'qndrl12', 1,'수영장잇나요?','아니요 없습니다','n');
  
select * from camp_qna;  

select * from(select * from(
					 select rownum as rn, q.* from(
					 (select * from camp_qna where bseq=1 order by qseq desc) q)
					 )where rn>=1
					 )where rn<=5;



select * from review;

insert into member(mid, pwd, name,mphone,email)values
('aaa','aaa','김보나','1111-2222-3333','aaaa@naver.com');
insert into member(mid, pwd, name,mphone,email)values
('bbb','bbb','김우리','1111-2222-3333','aaaa@naver.com');
insert into member(mid, pwd, name,mphone,email)values
('ccc','ccc','이병환','1111-2222-3333','aaaa@naver.com');
insert into member(mid, pwd, name, mphone, email)values
('dp','1111','이대표','010-2222-3333','aaaa@naver.com');
insert into member(mid, pwd, name,mphone,email)values
('eee','eee','정현우','1111-2222-3333','aaaa@naver.com');


select * from reservation; 

select * from camping_view where rowid IN (select max(rowid) from camping_view group by cname);

select count(*) as cnt from camping_view where rowid IN (select max(rowid) from camping_view group by cname);

drop sequence notice_seq;
create sequence notice_seq start with 1; 

insert into notice (nseq,aid,subject,content)values
(notice_seq.nextval,'scott', '캠핑 이벤트',
'[안전한 캠핑을 응원하는 만만한 캠핑 EVENT] 고캠핑 등록 캠핑장을 네이버에서 예약하고,1만 원 이상 N페이로 결제 후 
이용완료한 선착순 1만 명에게 한국관광공사가 네이버페이 1만 원을 적립해 드립니다! 자세한 이벤트 기간 및 참여방법은 게시된 
이미지를 통해 확인해 보세요~! 예약 관련문의 : 1644-5690 (네이버 고객센터 운영시간 09:00~18:00)
이벤트 관련문의 : 02-6429-3801 )');
insert into notice (nseq,aid,subject,content)values
(notice_seq.nextval,'scott','초캠러(초보캠퍼)를 위한 동계안전캠핑 5대수칙 알리기 이벤트>',
'미션1. CampinGa SNS 팔로우 하기! 
미션2. 게시글 댓글에 친구 태그하여 동계안전 캠핑 5대 기본수칙 널리~ 널리~ 알리기!
미션1,2 모두 참여한 불들 중 100분 에게 일산화탄소 경보기와 불멍이 마스크를!
미션2만 참여한 분들 중 200분께 손세정제와 불멍이 인형을 드립니다!
많은 참여 부탁드립니다.');
insert into notice (nseq,aid,subject,content)values
(notice_seq.nextval,'scott','2022년 등록 야영장 지원사업(1차) 추진계획 안내',
' 추진일정 : 
1. 기초지자체 공고 및 접수*(~21.9.30.)
2. 광역지자체 심사 후 문체부 요청(~10.7.)
3. 지원대상 확정(~10.22.) 
4. 보조금 교부(11월~)     
* 지역별로 일정이 상이할 수 있으며, 지방비 확보가 어려운 지역은 공모에 참가가 불가할 수 있는 바,
자세한 사항은 지자체 관광과에 문의하여 주시기 바랍니다.');

 create sequence reservation_seq start with 1; 
insert into reservation(reseq, cseq, mid, price, people, chk_in, chk_out)
values (reservation_seq.nextval, 1, 'qndrl12', 200000, 5, '2023/2/01','2023/2/03');


select * from RESERVATION where mid='dp';
select * from reservation;
select * from businessman;
select * from camping;

delete from BUSINESSMAN where bseq=8;
delete from BUSINESSMAN where bseq=9;
delete from BUSINESSMAN where bseq=10;

-- 뷰 생성

-- reservation 안의 사용자아이디와 캠핑장번호로 예약정보와 캠핑장정보를 조회하는 view를 생성
create or replace view reservate_view
as
select r.reseq, b.bseq, c.cseq, b.bid, c.cname, c.c_class, c.res_sta, r.mid, m.name, r.price, r.people, r.res_date, r.chk_in, r.chk_out
from reservation r, member m, businessman b, camping c
where m.mid = r.mid and r.cseq = c.cseq and b.bseq = c.bseq;

DROP view reservate_view CASCADE CONSTRAINTS;
select count(*) from reservate_view where bid = 'dp';

select res_date from reservate_view;

select * from reservate_view;

-- favorites 안의 사용자아이디와 캠핑장번호로 즐겨찾기 된 캠핑장정보를 조회하는 view 생성
create or replace view favorites_view
as
select rownum as rn, f.fseq, f.bseq, m.mid, b.cname, b.image, b.phone, f.fav_check  
from favorites f, member m, businessman b
where f.mid = m.mid and f.bseq = b.bseq;

DROP view favorites_view CASCADE CONSTRAINTS;
select * from favorites_view;
SELECT COUNT(cname) AS cnt, FROM favorites_view;

SELECT DISTINCT cname, COUNT(cname) OVER (PARTITION BY cname) AS cnt_fav, image, bseq
FROM favorites_view where rownum<=9 order by cnt_fav desc;




-- camping 안의 캠핑장 이름으로 정보 조회하는 view
create or replace view camping_view
as
select c.cseq, c.bseq, c.cname, b.caddress1, b.caddress2, b.caddress3, b.facilities,
		b.phone, b.image, c.c_image, b.content, c.c_content, b.category, c.c_class, c.res_sta, c.price,
		c.min_people, c.max_people, c.c_indate
from businessman b, camping c
where b.bseq = c.bseq;



DROP view camping_view CASCADE CONSTRAINTS;
select * from camping_view;

SELECT cseq, cname, caddress1, caddress2, caddress3, phone 
FROM camping_view where rowid in (select max(rowid) from camping_view GROUP BY cname);


select bseq, cname, content from (select * from camping_view order by c_indate desc) where rownum<=4;


-- review 안의 정보로 캠핑장이름 
create or replace view review_view
as
select r.rseq, r.mid, r.bseq, r.content, r.indate, b.bname
from review r, businessman b
where b.bseq = r.bseq;




-- paging 

select * from ( 
select * from ( 
select rownum as rn, c.* from ((
select * from camping_view where rowid IN (
select max(rowid) from camping_view group by cname)) c)) where rn>=1) where rn<=10;




select bseq, cname, content, image from businessman where rownum<=4 order by bseq desc;

select bseq, cname, content, image 
from (select * from businessman order by bseq desc) 
where rownum<=4;


select * from ( select * from ( 
select rownum as rn, b.* from ((select * from businessman) b)) where rn>=1) where rn<=5;



select * from(select * from(SELECT * FROM businessman) where caddress1 like '%경기%')where caddress2 like '%여주%';



select * from camping_view where bseq=1 order by cseq desc;

select to_char(chk_in,'yyyy-mm-dd') as cin, to_char(chk_out,'yyyy-mm-dd') as cout from reservation where cseq=2 and chk_out>=sysdate order by chk_in;


select * from ( select * from ( select rownum as rn, f.mid from (
				(select * from favorites_view where mid='qndrl12' order by fseq desc) f)
				)where rn>=1
				)where rn<=5;

select * from favorites_view
SELECT DISTINCT cname, COUNT(cname) OVER (PARTITION BY cname) AS cnt_fav
				FROM favorites_view where rownum<=8 order by cnt_fav desc;				

