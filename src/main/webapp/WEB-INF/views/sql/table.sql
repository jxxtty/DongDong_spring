// 사용자
create user dong IDENTIFIED by dong;
grant connect, resource to dong;

//member 테이블
create table member
(
userid varchar2(20) primary key,
passwd varchar2(20) not null,
userName varchar2(20) not null,

nickName varchar2(20) not null,
addr varchar2(500) not null,
phone varchar2(11) not null,
email1 varchar2(20) not null,
email2 varchar2(20) not null,

userImage varchar2(100) not null
);


// 게시글
CREATE SEQUENCE post_num;

CREATE TABLE post(
        pNum NUMBER(10) PRIMARY KEY,
        userid VARCHAR2(20) NOT NULL,
        addr VARCHAR2(10) NOT NULL,
        pCategory VARCHAR2(5) NOT NULL,
        pTitle VARCHAR2(100) NOT NULL,
        pContent VARCHAR2(800) NOT NULL,
        pPrice NUMBER(10) NOT NULL,
        pImage VARCHAR2(100) NOT NULL,
        pHit NUMBER(5) NOT NULL,
        pDate DATE DEFAULT SYSDATE,
        pStatus VARCHAR2(1) DEFAULT '0',
        pPull VARCHAR2(3) DEFAULT '3'
);
ALTER TABLE post
ADD CONSTRAINT post_userid_fk FOREIGN KEY(userid)
REFERENCES member(userid) ON DELETE CASCADE;

ALTER TABLE post ADD (pStatus VARCHAR2(1));
update post set pstatus=0;

//Favorite, Purchase, Sale

CREATE table Favorite(
    pnum number(10),
    userid varchar2(20),

    CONSTRAINT FAVORITE_PNUM_FK FOREIGN KEY (pnum) REFERENCES POST (pnum) ON DELETE CASCADE, 
    CONSTRAINT FAVORITE_USERID_FK FOREIGN KEY (userid) REFERENCES member (userid) ON DELETE CASCADE, 
    CONSTRAINT FAVORITE_PK Primary Key(pnum,userid)
);

CREATE table Purchase(
    pnum number(10),
    userid varchar2(20),

    CONSTRAINT PURCHASE_PNUM_FK FOREIGN KEY (pnum) REFERENCES POST (pnum) ON DELETE CASCADE, 
    CONSTRAINT PURCHASE_USERID_FK FOREIGN KEY (userid) REFERENCES member (userid) ON DELETE CASCADE, 
    CONSTRAINT PURCHASE_PK Primary Key(pnum,userid)
);

CREATE table Sale(
    pnum number(10),
    userid varchar2(20),

    CONSTRAINT SALE_PNUM_FK FOREIGN KEY (pnum) REFERENCES POST (pnum) ON DELETE CASCADE, 
    CONSTRAINT SALE_USERID_FK FOREIGN KEY (userid) REFERENCES member (userid) ON DELETE CASCADE,
    CONSTRAINT SALE_PK Primary Key(pnum,userid)
);


주문서
create table orderSheet
(
oNUM varchar2(20) primary key,
pNum NUMBER(10) not null,
sUserid varchar2(20) not null,
bUserid varchar2(20) not null,
oAddr varchar2(50) not null,
oPrice NUMBER(10) not null,
oMessage varchar(200) not null,
oDate DATE DEFAULT SYSDATE
);
ALTER TABLE orderSheet
ADD CONSTRAINT orderSheet_pNum_fk FOREIGN KEY(pNum)
REFERENCES post(pNum) ON DELETE CASCADE;

Create SEQUENCE ORDERSHEET_NUM;