use shop;
truncate products;
truncate users;
truncate orders;
truncate carts;
truncate categories;

insert into users (username, password, address, phone) values ('Hello', 'ss', 'sss', "1234");

insert into products (name, price, stock, sale, on_sale, category_id) values ("ss",'3.14', 10, 10, true, 1);
insert into products (name, price, stock, sale, on_sale, category_id) values ("ss",'3.14', 10, 10, true, 1);
insert into products (name, price, stock, sale, on_sale, category_id) values ("ss",'3.14', 10, 10, true, 1);

-- insert into products (name, price, stock, sale, on_sale, category_id) values ("谢",'3.14', 10, 10, true, 1);