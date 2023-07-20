-- favorites 안의 사용자아이디와 캠핑장번호로 즐겨찾기 된 캠핑장정보를 조회하는 view 생성
create or replace view favorites_view
as
select rownum as rn, f.fseq, f.bseq, m.mid, b.cname, b.image, b.phone, f.fav_check  
from favorites f, member m, businessman b
where f.mid = m.mid and f.bseq = b.bseq


-- reservation 안의 사용자아이디와 캠핑장번호로 예약정보와 캠핑장정보를 조회하는 view를 생성
create or replace view reservate_view
as
select r.reseq, b.bseq, c.cseq, b.bid, c.cname, c.c_class, c.res_sta, r.mid, 
m.name, m.mphone, r.price, r.people, r.res_date, r.chk_in, r.chk_out
from reservation r, businessman b, camping c, member m
where r.cseq = c.cseq and b.bseq=c.bseq and m.mid = r.mid


-- camping 안의 캠핑장 이름으로 정보 조회하는 view
create or replace view camping_view
as
select c.cseq, c.bseq, c.cname, b.caddress1, b.caddress2, b.caddress3, b.facilities,
		b.phone, b.image, c.c_image, b.content, c.c_content, b.category, c.c_class, c.res_sta, c.price,
		c.min_people, c.max_people, c.c_indate
from businessman b, camping c
where b.bseq = c.bseq










-- 사용자
insert into member(mid, pwd, name, mphone, email)
values('qndrl12', '1234', '이준표', '010-8010-4755', 'qndrl12@naver.com');

insert into admin(aid, pwd)
values('admin', 'admin');

-- 사업자
insert into businessman(bseq, bid, pwd, name, phone, email, cname, caddress1, caddress2, caddress3, facilities, image, content, category) 
values(businessman_seq.nextval, 'dp', '1234', '이대표', '010-1111-1111', 'abc@abc.com' , 
'해여림 빌리지', '경기도','여주시', '산북면 해여림로 78', '바베큐장, 주차장', 'camp01.jpg',
'다양한 컨텐츠로 즐거운 일상탈출 맛있는 음식과 깨끗한 시설 친절한 서비스 고객감동 서비스가 시작되는 여기는 캠핑장입니다.', '오토캠핑');

insert into businessman(bseq, bid, pwd, name, phone, email, cname, caddress1, caddress2, caddress3, facilities, image, content, category) 
values(businessman_seq.nextval, 'qwer', '1234', '이원일', '010-1111-1111', 
'abc@abc.com' , '한강공원 난지캠핑장', '서울시','마포구', '한강난지로 28', 
'바베큐장, 공용주차장', 'camp01.jpg',
'난지캠핑장은 서울시 마포구 난지한강공원에 자리했다. 강변북로 가양대교 북단을 지나 난지한강공원 방향으로 가면 도착한다. 자동차를 이용하는 캠퍼는 공영주차장을 이용해야 한다. ', 
'camping');

Insert into BUSINESSMAN(BSEQ,BID,PWD,NAME,PHONE,EMAIL,CNAME,CADDRESS1,CADDRESS2,CADDRESS3,FACILITIES,IMAGE,CONTENT,CATEGORY) 
values (businessman_seq.nextval,'aaa','1234','이원일','010-6666-1111','abc@abc.com',
'화양숲노리캠핑장','충청북도','괴산군','청천면 화양로 834-9',null,null,null,null);

Insert into BUSINESSMAN(BSEQ,BID,PWD,NAME,PHONE,EMAIL,CNAME,CADDRESS1,CADDRESS2,CADDRESS3,FACILITIES,IMAGE,CONTENT,CATEGORY) 
values (businessman_seq.nextval,'bbb','1234','이원이','010-6666-1111','abc@abc.com',
'경안글로브','경상북도','경주시','강동면 새마을로 1124-50',null,null,null,null);

Insert into BUSINESSMAN(BSEQ,BID,PWD,NAME,PHONE,EMAIL,CNAME,CADDRESS1,CADDRESS2,CADDRESS3,FACILITIES,IMAGE,CONTENT,CATEGORY) 
values (businessman_seq.nextval,'ccc','1234','이원삼','010-6666-1111','abc@abc.com',
'웰리힐리파크 오토캠핑장','강원도','횡성군','둔내면 두원리 194 두원리',null,null,null,null);

Insert into BUSINESSMAN(BSEQ,BID,PWD,NAME,PHONE,EMAIL,CNAME,CADDRESS1,CADDRESS2,CADDRESS3,FACILITIES,IMAGE,CONTENT,CATEGORY) 
values (businessman_seq.nextval,'ddd','1234','이원사','010-6666-1111','abc@abc.com',
'산골캠핑장','강원도','영월군','무릉도원면 백년계곡길 158',null,null,null,null);

Insert into BUSINESSMAN(BSEQ,BID,PWD,NAME,PHONE,EMAIL,CNAME,CADDRESS1,CADDRESS2,CADDRESS3,FACILITIES,IMAGE,CONTENT,CATEGORY) 
values (businessman_seq.nextval,'eee','1234','이원오','010-6666-1111','abc@abc.com',
'마루아라힐링캠프','전라북도','부안군','줄포면 생태공원로 38',null,null,null,null);

Insert into BUSINESSMAN(BSEQ,BID,PWD,NAME,PHONE,EMAIL,CNAME,CADDRESS1,CADDRESS2,CADDRESS3,FACILITIES,IMAGE,CONTENT,CATEGORY) 
values (businessman_seq.nextval,'fff','1234','이원육','010-6666-1111','abc@abc.com',
'탄도항 노을 캠핑장','경기도','안산시','단원구 대부황금로 17-2',null,null,null,null);

Insert into BUSINESSMAN(BSEQ,BID,PWD,NAME,PHONE,EMAIL,CNAME,CADDRESS1,CADDRESS2,CADDRESS3,FACILITIES,IMAGE,CONTENT,CATEGORY) 
values (businessman_seq.nextval,'ggg','1234','이원칠','010-6666-1111','abc@abc.com',
'카라반2696','경기도','남양주시','화도읍 구암리 8-2',null,null,null,null);

Insert into BUSINESSMAN(BSEQ,BID,PWD,NAME,PHONE,EMAIL,CNAME,CADDRESS1,CADDRESS2,CADDRESS3,FACILITIES,IMAGE,CONTENT,CATEGORY) 
values (businessman_seq.nextval,'hhh','1234','이원팔','010-6666-1111','abc@abc.com',
'계수나무 울창한 캠핑장','경기도','남양주시','지둔로 344-0',null,null,null,null);

Insert into BUSINESSMAN(BSEQ,BID,PWD,NAME,PHONE,EMAIL,CNAME,CADDRESS1,CADDRESS2,CADDRESS3,FACILITIES,IMAGE,CONTENT,CATEGORY) 
values (businessman_seq.nextval,'iii','1234','이원구','010-6666-1111','abc@abc.com',
'비니비니글램핑','경기도','포천시','내촌면 금강로 2625-37',null,null,null,null);

Insert into BUSINESSMAN(BSEQ,BID,PWD,NAME,PHONE,EMAIL,CNAME,CADDRESS1,CADDRESS2,CADDRESS3,FACILITIES,IMAGE,CONTENT,CATEGORY) 
values (businessman_seq.nextval,'jjj','1234','이원십','010-6666-1111','abc@abc.com',
'스톤브룩 캠핑장','경기도','연천군','군남면 진은로606번길 110',null,null,null,null);



-- 해여림 빌리지 객실
insert  into camping(cseq, bseq, cname, c_image, c_content, c_class, res_sta, price, min_people, max_people)
values (camping_seq.nextval, 21,'해여림 빌리지', 'camp02.jpg','해여림 AA방입니다.','해여림 AA', 'n', 200000, 4, 10);

insert  into camping(cseq, bseq, cname, c_image, c_content, c_class, res_sta, price, min_people, max_people)
values (camping_seq.nextval, 21,'해여림 빌리지', 'camp02.jpg','해여림 BB방입니다.','해여림 BB', 'n', 150000, 4, 8);

insert  into camping(cseq, bseq, cname, c_image, c_content, c_class, res_sta, price, min_people, max_people)
values (camping_seq.nextval, 21,'해여림 빌리지', 'camp02.jpg','해여림 CC방입니다.','해여림 CC', 'n', 250000, 6, 12);
