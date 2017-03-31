require "admin"
require "../Models/model"
auto_admin(all, User, 用户, username: text, password: password, address: text, phone: text)
auto_admin(all, Cate, 分类, name: text, cate_id: text, show_order: text, icon: text, color: text)
auto_admin(all, Product, 商品, name: text, price: text, stock: text, sale: text, on_sale: text, cate_id: text)
auto_admin(index, Order, 订单,
  user_id: text,          # 用户ID
  order_number: text,     # 订单号
  status: text,           # 订单状态
  product_detail: text,   # 商品信息
  quantity: text,         # 商品总数
  actual_price: text,     # 实付
  total_price: text,      # 总计
  shipping_time: text,    # 期望配送时间
  shipping_address: text, # 配送地址
  shipping_service: text, # 配送服务
  pay_way: text           # 支付方式
)
# admin(User, text: [username, address, phone], password: password)
# admin()
# auto_admin(all, User, 用户,
#   text: [username, address, phone],
#   password: [password],
#   textarea: [remark]
# )
