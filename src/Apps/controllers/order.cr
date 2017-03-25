post "/newOrder" do |env|
  carts = Cart.find(user_id: current_user)
  product_ids = [] of Int32
  carts.each { |cart| product_ids << cart.product_id }
  sum = 0.0
  contents = ""
  Product.find(product_ids).each_with_index do |product, i|
    total = carts[i].number * product.price
    sum += total
    contents += "#{product.id},#{product.price},#{carts[i].number},#{total} \n"
  end
  Order.insert(
    order_id: Time.now.epoch_ms,
    user_id: 1,
    status: "paying",
    sum: sum,
    content: contents,
  )
end
