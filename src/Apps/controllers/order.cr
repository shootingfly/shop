def order_handle(env)
  carts = Cart.find(user_id: current_user)
  product_ids = carts.map &.product_id
  products = Product.find(product_ids)
  total_price = 0.0
  quantity = 0
  products.each_with_index do |product, i|
    total_price += carts[i].number * product.price
    quantity += carts[i].number
  end
  off_price = env.params.body["off_price"].to_f
  shipping = env.params.body["shipping"].to_f
  shipping_time = env.params.body["shipping_time"]
  shipping_address = env.params.body["shipping_address"]
  shipping_service = env.params.body["shipping_service"]
  pay_way = env.params.body["pay_way"]
  actual_price = total_price - off_price - shipping
  Order.insert(
    user_id: current_user,              # 用户ID
    order_number: Time.now.epoch,       # 订单号
    status: "待支付",                      # 订单状态
    product_detail: products,           # 商品信息
    quantity: quantity,                 # 商品总数
    actual_price: actual_price,         # 实付
    total_price: total_price,           # 总计
    off_detail: String,                 # 优惠信息
    off_price: off_price,               # 优惠
    shipping: shipping,                 # 配送费
    shipping_time: shipping_time,       # 期望配送时间
    shipping_address: shipping_address, # 配送地址
    shipping_service: shipping_service, # 配送服务
    pay_way: pay_way,                   # 支付方式
  )
end

post "/newOrder" do |env|
  if current_user
    order_handle(env)
  else
    env.redirect "/login"
  end
end

get "/order" do |env|
  # if current_user
  # orders = Order.find(user_id: current_user)
  # else
  orders = [] of Order
  # end
  view "order_index", "订单列表"
end

get "/order/:order_number" do |env|
  order_number = env.params.url["order_number"].to_i
  order = Order.find(user_id: current_user, order_number: order_number)
  view "order_show", "订单项"
end

#   carts = Cart.find(user_id: current_user)
#   product_ids = [] of Int32
#   carts.each { |cart| product_ids << cart.product_id }
#   sum = 0.0
#   contents = ""
#   Product.find(product_ids).each_with_index do |product, i|
#     total = carts[i].number * product.price
#     sum += total
#     contents += "#{product.id},#{product.price},#{carts[i].number},#{total} \n"
#   end
#   Order.insert(
#     order_id: Time.now.epoch_ms,
#     user_id: 1,
#     status: "paying",
#     sum: sum,
#     content: contents,
#   )
# end
