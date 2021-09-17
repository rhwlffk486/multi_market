create table sp_join(
	  role varchar2(15) not null
	, user_ID varchar2(50) primary key
	, user_PW varchar2(100) not null
	, user_name varchar2(15) not null
	, phone varchar2(40) not null
	, address1 varchar2(150) not null
	, address2 varchar2(150) not null
	, address3 varchar2(150) not null
	, email varchar2(60) not null
	, business_number varchar2(30)
	, bank varchar2(18)
	, account_number varchar2(50)
);
