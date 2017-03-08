require "admin"
require "../Models/model"
auto_admin(all, Product, 商品, name: text, price: text, stock: text, sale: text, on_sale: text, cate_id: text)
auto_admin(all, User, 用户, username: text, password: password, address: text, phone: text)
auto_admin(all, Cate, 分类, name: text, cate_id: text, show_order: text)
