create sequence sp_product_seq;
create sequence sp_cart_seq;
create sequence sp_order_details_seq;
create sequence sp_product_img_seq;
create sequence sp_reply_seq;

create table sp_category (
       cate_name varchar2(30) not null
     , cate_code varchar2(30) primary key
     , cate_code_ref varchar2(30) null
     , foreign key(cate_code_ref) references sp_category(cate_code)
);

create table sp_product (
      product_num number primary key
	, role varchar2(15) not null
    , product_ID varchar2(50) not null  
	, cate_code varchar2(30) not null
	, product_title varchar2(100) not null
	, product_price varchar2(26) not null
	, product_qty varchar2(26) not null
	, product_img varchar2(300) not null
	, product_content varchar2(4000) not null
	, product_date date default sysdate
);


create table sp_product_img(
	  product_ID varchar2(50) not null
	, product_num number not null
	, original_img varchar2(300) not null
	, thumbnail varchar2(300) not null
    , constraint fk_product_num foreign key (product_num)references sp_product (product_num)
);

alter table sp_product add
    constraint fk_product_category
    foreign key (cate_code)
    references sp_category(cate_code);

create table sp_reply (
      product_num number 
    , user_ID varchar2(50) not null
    , rep_num number 
    , rep_con varchar2(2000) not null
    , rep_date date default sysdate
    , primary key(product_number, rep_num)
);

alter table sp_reply
    add constraint sp_reply_product_number foreign key (product_num)
    references sp_product(product_num) on delete cascade;
    
alter table sp_reply
    add constraint sp_reply_user_ID foreign key (user_ID)
    references sp_join(user_ID) on delete cascade;
    
create table sp_cart (
      cart_num number
    , user_ID varchar2(50)
    , product_num number not null
    , product_ID varchar2(50) not null
    , product_qty number not null
    , add_date date default sysdate
    , primary key (cart_num, user_ID)
);


alter table sp_cart
    add constraint sp_cart_user_ID foreign key(user_ID)
    references sp_join(user_ID) on delete cascade;

alter table sp_cart
    add constraint sp_cart_product_num foreign key(product_num)
    references sp_product(product_num) on delete cascade;
    
create table sp_order (
      ORDER_ID VARCHAR2(50) not null primary key
    , product_ID varchar2(50) not null
    , USER_ID	VARCHAR2(50) not null
    , ORDER_ATTN VARCHAR2(50) not null
    , ADDRESS1 VARCHAR2(150) not null
    , ADDRESS2 VARCHAR2(150) not null
    , ADDRESS3 VARCHAR2(150) not null
    , ORDER_PHONE VARCHAR2(50) not null
    , AMOUNT NUMBER not null
    , delivery varchar2(20) default '배송준비'
    , ORDER_DATE DATE default sysdate
);

alter table sp_order
    add constraint sp_order_user_ID foreign key(user_ID)
    references sp_join(user_ID) on delete cascade;
    
create table sp_order_details (
      order_details_num number not null primary key
    , order_ID varchar2(50) not null
    , product_num number not null
    , product_qty number not null
);



alter table sp_order_details
    add constraint sp_order_details_order_ID foreign key(order_ID)
    references sp_order(order_ID) on delete cascade;
    
commit;
    
    
    
insert into sp_category (cate_name, cate_code) values ('패션', '100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('신발', '101', '100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('구두', '102', '100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('바지', '103', '100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('치마', '104', '100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('셔츠', '105', '100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('티셔츠', '106', '100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('아웃도어', '107', '100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('모자', '108', '100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('기타', '109', '100');

insert into sp_category (cate_name, cate_code) values ('뷰티', '200');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('메이크업', '201', '200');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('향수', '202', '200');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('헤어', '203', '200');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('네일', '204', '200');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('기타', '205', '200');

insert into sp_category (cate_name, cate_code) values ('식품', '300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('고기', '301', '300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('과일', '302', '300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('채소', '303', '300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('수산물', '304', '300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('음료', '305', '300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('인스턴트', '306', '300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('쌀', '307', '300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('기타', '308', '300');

insert into sp_category (cate_name, cate_code) values ('주방', '400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('주방가전', '401', '400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('주방기구', '402', '400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('일회용품', '403', '400');

insert into sp_category (cate_name, cate_code) values ('생활', '500');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('세면물품', '501', '500');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('집용품', '502', '500');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('세탁용품', '503', '500');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('욕실용품', '504', '500');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('주방물품', '505', '500');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('기타', '506', '500');

insert into sp_category (cate_name, cate_code) values ('인테리어', '600');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('침구', '601', '600');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('가구', '602', '600');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('수납', '603', '600');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('욕실용품', '604', '600');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('기타', '605', '600');

insert into sp_category (cate_name, cate_code) values ('가전', '700');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('TV', '701', '700');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('냉장고', '702', '700');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('컴퓨터', '703', '700');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('세탁기', '704', '700');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('청소기', '705', '700');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('기타', '706', '700');

insert into sp_category (cate_name, cate_code) values ('스포츠', '800');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('홈트레이닝', '801', '800');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('수영', '802', '800');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('골프', '803', '800');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('자전거', '804', '800');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('킥보드', '805', '800');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('낚시', '806', '800');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('등산', '807', '800');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('기타', '808', '800');

insert into sp_category (cate_name, cate_code) values ('자동차', '900');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('인테리어', '901', '900');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('세차', '902', '900');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('차량부품', '903', '900');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('오토바이', '904', '900');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('기타', '905', '900');

insert into sp_category (cate_name, cate_code) values ('도서', '1000');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('유아', '1001', '1000');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('소설', '1002', '1000');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('초중참고서', '1003', '1000');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('외국어', '1004', '1000');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('대학교제', '1005', '1000');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('만화', '1006', '1000');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('기타', '1007', '1000');

insert into sp_category (cate_name, cate_code) values ('완구', '1100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('캐릭터완구', '1101', '1100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('영아완구', '1102', '1100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('로봇', '1103', '1100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('블록', '1104', '1100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('물놀이', '1105', '1100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('야외완구', '1106', '1100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('실내완구', '1107', '1100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('보드', '1108', '1100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('조립', '1109', '1100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('기타', '1110', '1100');

insert into sp_category (cate_name, cate_code) values ('문구', '1200');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('사무용품', '1201', '1200');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('학용품', '1202', '1200');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('엽서', '1203', '1200');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('필기류', '1204', '1200');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('기타', '1205', '1200');

insert into sp_category (cate_name, cate_code) values ('반려동물', '1300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('강아지물품', '1301', '1300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('고양이물품', '1302', '1300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('관상어물품', '1303', '1300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('가축물품', '1304', '1300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('기타', '1305', '1300');

insert into sp_category (cate_name, cate_code) values ('헬스', '1400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('건강기능식품', '1401', '1400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('여성용건강식품', '1402', '1400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('남성용건강식품', '1403', '1400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('임산부건강식품', '1404', '1400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('헬스', '1405', '1400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('영양제', '1406', '1400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('다이어트', '1407', '1400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('기타', '1408', '1400');

commit;

select level, cate_name, cate_code, cate_code_ref from sp_category
    start with cate_code_ref is null connect by prior cate_code = cate_code_ref;