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
    , delivery varchar2(20) default '????????????'
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
    
    
    
insert into sp_category (cate_name, cate_code) values ('??????', '100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '101', '100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '102', '100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '103', '100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '104', '100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '105', '100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('?????????', '106', '100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '107', '100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '108', '100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '109', '100');

insert into sp_category (cate_name, cate_code) values ('??????', '200');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '201', '200');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '202', '200');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '203', '200');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '204', '200');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '205', '200');

insert into sp_category (cate_name, cate_code) values ('??????', '300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '301', '300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '302', '300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '303', '300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('?????????', '304', '300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '305', '300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '306', '300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('???', '307', '300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '308', '300');

insert into sp_category (cate_name, cate_code) values ('??????', '400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '401', '400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '402', '400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '403', '400');

insert into sp_category (cate_name, cate_code) values ('??????', '500');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '501', '500');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('?????????', '502', '500');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '503', '500');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '504', '500');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '505', '500');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '506', '500');

insert into sp_category (cate_name, cate_code) values ('????????????', '600');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '601', '600');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '602', '600');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '603', '600');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '604', '600');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '605', '600');

insert into sp_category (cate_name, cate_code) values ('??????', '700');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('TV', '701', '700');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('?????????', '702', '700');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('?????????', '703', '700');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('?????????', '704', '700');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('?????????', '705', '700');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '706', '700');

insert into sp_category (cate_name, cate_code) values ('?????????', '800');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('???????????????', '801', '800');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '802', '800');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '803', '800');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('?????????', '804', '800');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('?????????', '805', '800');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '806', '800');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '807', '800');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '808', '800');

insert into sp_category (cate_name, cate_code) values ('?????????', '900');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '901', '900');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '902', '900');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '903', '900');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '904', '900');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '905', '900');

insert into sp_category (cate_name, cate_code) values ('??????', '1000');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '1001', '1000');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '1002', '1000');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('???????????????', '1003', '1000');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('?????????', '1004', '1000');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '1005', '1000');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '1006', '1000');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '1007', '1000');

insert into sp_category (cate_name, cate_code) values ('??????', '1100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('???????????????', '1101', '1100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '1102', '1100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '1103', '1100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '1104', '1100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('?????????', '1105', '1100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '1106', '1100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '1107', '1100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '1108', '1100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '1109', '1100');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '1110', '1100');

insert into sp_category (cate_name, cate_code) values ('??????', '1200');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '1201', '1200');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('?????????', '1202', '1200');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '1203', '1200');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('?????????', '1204', '1200');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '1205', '1200');

insert into sp_category (cate_name, cate_code) values ('????????????', '1300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('???????????????', '1301', '1300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('???????????????', '1302', '1300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('???????????????', '1303', '1300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '1304', '1300');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '1305', '1300');

insert into sp_category (cate_name, cate_code) values ('??????', '1400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????????????????', '1401', '1400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('?????????????????????', '1402', '1400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('?????????????????????', '1403', '1400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('?????????????????????', '1404', '1400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '1405', '1400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('?????????', '1406', '1400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('????????????', '1407', '1400');
insert into sp_category (cate_name, cate_code, cate_code_ref) values ('??????', '1408', '1400');

commit;

select level, cate_name, cate_code, cate_code_ref from sp_category
    start with cate_code_ref is null connect by prior cate_code = cate_code_ref;