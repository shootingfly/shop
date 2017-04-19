require "orm"
require "json"

DB_URL = "mysql://rocky@localhost/shop?initial_pool_size=1&&max_idle_pool_size=1"
table(Admin, username: String, password: String)
table(User, username: String, password: String, address: String, phone: String, token: String)
table(Cate, name: String, cate_id: String, show_order: Int32, icon: String, color: String)
table(Product, name: String, price: Float32, stock: Int32, sale: Int32, on_sale: Bool, cate_id: String)
table(Cart, product_id: Int32, user_id: Int32, number: Int32)
table(Order,
  user_id: Int32,           # 用户ID
  order_no: Int64,      # 订单号
  status: String,           # 订单状态
  product_detail: String,   # 商品信息
  quantity: Int32,          # 商品总数
  total: Float32,           # 总计
  shipping: Int32,          # 配送方式
  username: String,         # 用户名
  phone: String,            # 联系电话
  address: String,          # 配送地址
  pay_way: String           # 支付方式
)

class ProductDetail
  JSON.mapping(
    id: Int32,
    name: String,
    number: Int32,
    price: Float32,
  )
  def initialize(id,name,number,price)
    @id = id
    @name = name
    @number = number
    @price = price
  end
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
class Const
  @@cate = Cate.all
  def self.cate
    @@cate
  end
  def self.update_cate
    @@cate = Cate.all
  end
end
