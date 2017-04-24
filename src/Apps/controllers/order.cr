# 提交订单
get "/order/new" do |env|
  do_login!
  carts = [] of Cart
  products = [] of Product
  data = {
    username:    current.username,
    phone:       current.phone,
    address:     current.address,
    expected_at: Time.now,
    pay_way:     "货到付款",
    status:      Status::Dealing,
    products:    products,
  }
  carts = Cart.find(user_id: current_user)
  products = Product.find(carts.map &.product_id) if carts.any?
  view "order/new", "提交订单"
end

# 提交订单
post "/order/new" do |env|
  do_login!
  order_no = Time.now.epoch_ms
  carts = [] of Cart
  products = [] of Product
  carts = Cart.find(user_id: current_user)
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
    username: body["username"],
    phone: body["phone"],
    address: body["address"],
    # 商品信息
    total: body["total"],
    product_detail: product_details.to_json,
    quantity: number,
    # 配送与支付信息
    shipping: 1,
    pay_way: body["pay_way"],
    order_no: order_no,
    status: Status::Dealing
  )
  if login?
    Cart.delete(user_id: current_user)
  else
    env.response.cookies << HTTP::Cookie.new("cart_item", "", secure: true)
  end
  if body["pay_way"] == "货到付款"
    env.redirect "/order/#{order_no}"
  else
    env.redirect "/pay"
  end
end

# 订单列表
get "/order" do |env|
  do_login!
  orders = Order.find(user_id: current_user)
  view "order/index", "我的订单"
end

# 查看单个订单
get "/order/:order_no" do |env|
  do_login!
  order = Order.find(order_no: url["order_no"].to_i64)[0]
  product_details = Array(ProductDetail).from_json(order.product_detail)
  page_title = "订单详情[#{order.status}]"
  view "order/show"
end

get "/order/delete/:order_no" do |env|
  do_login!
  order_no = url["order_no"].to_i64
  order = Order.find(order_no: order_no, user_id: current_user)[0]
  Order.delete(order_no: order_no)
  env.redirect "/order/clear"
end

get "/order/clear" do |env|
  do_login!
  orders = Order.find(user_id: current_user, status: Status::Finished)
  if orders.any?
    view "order/clear", "删除订单"
  else
    view "order/clear_empty", "订单为空"
  end
end
