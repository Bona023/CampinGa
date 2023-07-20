
/* Drop Tables */

DROP TABLE notice CASCADE CONSTRAINTS;
DROP TABLE admin CASCADE CONSTRAINTS;
DROP TABLE reservation CASCADE CONSTRAINTS;
DROP TABLE camping CASCADE CONSTRAINTS;
DROP TABLE camp_qna CASCADE CONSTRAINTS;
DROP TABLE favorites CASCADE CONSTRAINTS;
DROP TABLE review CASCADE CONSTRAINTS;
DROP TABLE businessman CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;
DROP TABLE mainBanners CASCADE CONSTRAINTS;

/* Main banner create sequence */

CREATE SEQUENCE mb_seq INCREMENT BY 1 START WITH 1;

/* Create Tables */

CREATE TABLE admin
(
	aid varchar2(30) NOT NULL,
	pwd varchar2(20) NOT NULL,
	PRIMARY KEY (aid)
);


CREATE TABLE businessman
(
	bseq number(5) NOT NULL,
	bid varchar2(30) NOT NULL,
	pwd varchar2(20) NOT NULL,
	name varchar2(20) NOT NULL,
	phone varchar2(20) NOT NULL,
	email varchar2(30) NOT NULL,
	cname varchar2(100) NOT NULL,
	caddress1 varchar2(20) NOT NULL,
	caddress2 varchar2(20) NOT NULL,
	caddress3 varchar2(100) NOT NULL,
	facilities varchar2(200),
	image varchar2(50),
	content varchar2(1000),
	category varchar2(20),
	chkyn varchar2(20) DEFAULT 'N',
	PRIMARY KEY (bseq)
);

CREATE TABLE camping
(
	cseq number(5) NOT NULL,
	bseq number(5) NOT NULL,
	cname varchar2(100) NOT NULL,
	c_image varchar2(50),
	c_content varchar2(1000),
	c_class varchar2(100) NOT NULL,
	res_sta varchar2(2) DEFAULT 'N',
	price number(10) DEFAULT 0,
	min_people number(2) DEFAULT 0,
	max_people number(2) DEFAULT 0,
	c_indate date DEFAULT sysdate,
	PRIMARY KEY (cseq)
);

CREATE TABLE camp_qna
(
	qseq number(5) NOT NULL,
	bseq number(5) NOT NULL,
	mid varchar2(30) NOT NULL,
	content varchar2(1000) NOT NULL,
	indate date DEFAULT sysdate,
	reply varchar2(1000),
	repyn varchar2(2) DEFAULT 'N',
	PRIMARY KEY (qseq)
);


CREATE TABLE favorites
(
	fseq number(5) NOT NULL,
	mid varchar2(30) NOT NULL,
	bseq number(5) NOT NULL,
	fav_check varchar2(5) DEFAULT 'N' NOT NULL,
	PRIMARY KEY (fseq)
);


CREATE TABLE member
(
	mid varchar2(30) NOT NULL,
	pwd varchar2(20) NOT NULL,
	name varchar2(20) NOT NULL,
	mphone varchar2(20) NOT NULL,
	email varchar2(30) NOT NULL,
	chkyn varchar2(20) DEFAULT 'Y',
	PRIMARY KEY (mid)
);


CREATE TABLE notice
(
	nseq number(5) NOT NULL,
	aid varchar2(30) NOT NULL,
	subject varchar2(100) NOT NULL,
	content varchar2(1000) NOT NULL,
	indate date DEFAULT sysdate,
	PRIMARY KEY (nseq)
);


CREATE TABLE reservation
(
	reseq number(5) NOT NULL,
	cseq number(5) NOT NULL,
	mid varchar2(30) NOT NULL,
	res_date date DEFAULT sysdate,
	price number(10) DEFAULT 0,
	people number(2) DEFAULT 0,
	chk_in date NOT NULL,
	chk_out date NOT NULL,
	PRIMARY KEY (reseq)
);


CREATE TABLE review
(
	rseq number(5) NOT NULL,
	bseq number(5) NOT NULL,
	mid varchar2(30) NOT NULL,
	content varchar2(1000) NOT NULL,
	indate date DEFAULT sysdate,
	PRIMARY KEY (rseq)
);

CREATE TABLE mainBanners( 
  mbseq NUMBER(5) NOT NULL unique,
  NAME VARCHAR2(100),
  ORDER_SEQ NUMBER(1),
  IMAGE VARCHAR2(50 BYTE),
  USEYN CHAR(1 BYTE) DEFAULT 'Y',
  INDATE DATE DEFAULT sysdate 
 );


/* Create Foreign Keys */

ALTER TABLE notice
	ADD FOREIGN KEY (aid)
	REFERENCES admin (aid)
	ON DELETE CASCADE
;


ALTER TABLE camping
	ADD FOREIGN KEY (bseq)
	REFERENCES businessman (bseq)
	ON DELETE CASCADE
;


ALTER TABLE camp_qna
	ADD FOREIGN KEY (bseq)
	REFERENCES businessman (bseq)
	ON DELETE CASCADE
;


ALTER TABLE favorites
	ADD FOREIGN KEY (bseq)
	REFERENCES businessman (bseq)
	ON DELETE CASCADE
;


ALTER TABLE review
	ADD FOREIGN KEY (bseq)
	REFERENCES businessman (bseq)
	ON DELETE CASCADE
;


ALTER TABLE reservation
	ADD FOREIGN KEY (cseq)
	REFERENCES camping (cseq)
	ON DELETE CASCADE
;


ALTER TABLE camp_qna
	ADD FOREIGN KEY (mid)
	REFERENCES member (mid)
	ON DELETE CASCADE
;


ALTER TABLE favorites
	ADD FOREIGN KEY (mid)
	REFERENCES member (mid)
	ON DELETE CASCADE
;


ALTER TABLE reservation
	ADD FOREIGN KEY (mid)
	REFERENCES member (mid)
	ON DELETE CASCADE
;


ALTER TABLE review
	ADD FOREIGN KEY (mid)
	REFERENCES member (mid)
	ON DELETE CASCADE
;



