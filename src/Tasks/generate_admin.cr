require "admin"
require "../Models/model"
password = gets.as(String)
exit if password != "123456"
admin(index, User, 用户, username: 用户名, address: 地址, phone: 电话)
admin(all, Cate, 分类, name: 分类名, cate_id: 分类ID, show_order: 显示顺序, icon: 图标, color: 颜色)
admin(all, Product, 商品,
  name: 商品名,
  price: 价格,
  stock: 库存,
  sale: 销量,
  on_sale: 销售中,
  cate_id: 分类ID
)
admin(index, Order, 订单,
  user_id: 用户ID,
  order_no: 订单号,
  status: 订单状态,
  quantity: 商品总数,
  total: 消费总额,
  shipping: 配送方式,
  username: 用户名,
  phone: 联系电话,
  address: 配送地址,
  pay_way: 支付方式
)
