require "orm"
require "json"

DB_URL = "mysql://rocky@localhost/shop"
table(Admin, username: String, password: String)
table(User, username: String, password: String, address: String, phone: String, token: String)
table(Cate, name: String, cate_id: String, show_order: Int32, icon: String, color: String)
table(Product, name: String, price: Float32, stock: Int32, sale: Int32, on_sale: Bool, cate_id: String)
table(Cart, product_id: Int32, user_id: Int32, number: Int32)
table(
  Order,
  user_id: Int32,           # 用户ID
  order_number: Int32,      # 订单号
  status: String,           # 订单状态
  product_detail: String,   # 商品信息
  quantity: Int32,          # 商品总数
  actual_price: Float32,    # 实付
  total_price: Float32,     # 总计
  off_detail: String,       # 优惠信息
  off_price: Float32,       # 优惠
  shipping: Int32,          # 配送费
  shipping_time: Time,      # 期望配送时间
  shipping_address: String, # 配送地址
  shipping_service: String, # 配送服务
  pay_way: String           # 支付方式
)

class ProductDetail
  JSON.mapping(
    id: Int32,
    name: String,
    number: Int32,
    price: Float32,
  )
end

class OffDetail
  JSON.mapping(
    name: String,
    off_price: Int32,
  )
end

class CartItem
  JSON.mapping(
    id: Int32,
    product_id: Int32,
    number: Int32,
  )
end
