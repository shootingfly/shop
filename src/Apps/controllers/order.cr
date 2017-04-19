# 提交订单页面
before_all "/orde*" do |env|
  unless login?
    env.redirect "/login"
    halt env, 302
  end
end


get "/order/new" do |env|
    username = current.username
    phone = current.phone
    address = current.address
    expected_at = Time.now
    pay_way = "货到付款"
    status = "待支付"
    carts = [] of Cart
    products = [] of Product
    carts = Cart.find(user_id: current_user) if login?
    products = Product.find(carts.map &.product_id) if carts.any?
    view "order_new", "提交订单"
end

# 提交订单
post "/order/new" do |env|
  order_no = Time.now.epoch_ms
  carts = [] of Cart
  products = [] of Product
  carts = Cart.find(user_id: current_user) if login?
  product_ids = carts.map &.product_id
  products = Product.find(product_ids) if carts.any?
  sql = "update Product set stock = case id "
  number = 0
  product_details = [] of ProductDetail
  products.size.times do |i|
    sql += "when #{products[i].id} then #{products[i].stock - carts[i].number} "
    product_details << ProductDetail.new(
      id: products[i].id,
      name: products[i].name,
      price: products[i].price * carts[i].number,
      number: carts[i].number
    )
    number += carts[i].number
  end
  sql += "end where id in (#{product_ids.to_s[1...-1]})"
  Product.exec(sql)

  Order.insert(
    user_id: current_user,
    # 个人信息
    username: env.params.body["username"],
    phone: env.params.body["phone"],
    address: env.params.body["address"],
    # 商品信息
    total: env.params.body["total"],
    product_detail: product_details.to_json,
    quantity: number,
    # 配送与支付信息
    shipping: 1,
    pay_way: env.params.body["pay_way"],
    order_no: order_no,
    status: "待支付"
  )
  if env.params.body["pay_way"] == "货到付款"
    env.redirect "/order/#{order_no}"
  else
    env.redirect "/pay"
  end
end

# 订单列表
get "/order" do |env|
  orders = Order.find(user_id: current_user)
  view "order_index", "我的订单"
end

# 查看单个订单
get "/order/:order_no" do |env|
  order = Order.find(order_no: env.params.url["order_no"].to_i64)[0]
  product_details = Array(ProductDetail).from_json(order.product_detail)
  view "order_show", "订单详情"
end

get "/order/delete/:order_no" do |env|
  order_no = env.params.url["order_no"].to_i64
  order = Order.find(order_no: order_no, user_id: current_user)[0]
  if order
    Order.delete(order_no: order_no)
    env.redirect "/order"
  else
    env.redirect "/"
  end
end
