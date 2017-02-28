set character_set_database=utf8;
set character_set_server=utf8;
set character_set_client=utf8;
set character_set_connection=utf8;
use shop;
-- create database shop;
drop table  if exists users;
drop table if exists products;
drop table if exists categories;
drop table if exists orders;
drop table if exists carts;
-- 用户表： 用户名 密码 默认电话 默认地址
-- 关联关系 ： 一个用户多个订单 一个用户多个购物车项

create table users (
	id serial primary key,
	username char(8) not null,
	password char(32) not null,
	phone char(11) not null,
	address char(12) not null
)default character set utf8;
-- 商品表： 商品名 单价 库存 销量 状态[销售中 已下柜] 
-- 关联关系： 一个商品属于一个分类 一个订单多个商品 一个购物项对应一个商品
create table products (
	id serial primary key,
	name varchar(255) not null,
	price float not null,
	stock int not null,
	sale int not null,
	on_sale boolean not null,
	category_id int not null
)default character set utf8;;
-- 分类表： 分类名 分类描述 显示顺序
-- 关联关系： 一个分类有多个商品
create table categories (
	id serial primary key,
	name char(8) not null,
	remark char(20) null,
	show_order int null
)default character set utf8;

-- 订单表： 订单总价 收货地址 收货人 收货电话 订单商品集 订单状态[已取消 待支付 配送中 已完成 ]  预计送达时间  个人备注
-- 关联关系： 一个订单属于一个用户， 一个订单有一个商品集 （二维数组：商品id和购买数量）
create table orders (
	id serial primary key,
	total float not null,
	state char(3) not null,
	arrived_time datetime not null,
	remark varchar(22) null,
	products_set varchar(22) not null,
	address char(8) not null,
	phone char(12) not null,
	user_id int not null
)default character set utf8;

-- 购物项表： 
-- 关联关系：一个购物车属于一个用户， 一个购物车有一个商品集（二维数组：商品id和购买数量）
create table carts (
	id serial primary key,
	products_set varchar(12) null,
	user_id int not null
)default character set utf8;