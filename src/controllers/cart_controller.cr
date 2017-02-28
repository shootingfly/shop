# 购物车页面
get "/cart" do |env|
  if login?
    carts = Cart.find(user_id: current_user)
    products = [] of Product
    if carts.any?
      product_ids = [] of Int32
      carts.each do |cart|
        product_ids << cart.product_id
      end
      products = Product.find(product_ids)
    end
    view "cart/index", "购物车"
  else
    env.redirect "/login"
  end
end

# 删除购物项
get "/cart/delete/:cart_id" do |env|
  cart_id = env.params.url["cart_id"]
  Cart.delete(cart_id)
  env.redirect "/carts"
end

# 清空购物车
get "/cart/delete" do |env|
  Cart.delete("where user_id = #{current_user}")
  env.redirect "/carts"
end

# 加入购物车
get "/cart/add/:product_id" do |env|
  product_id = env.params.url["product_id"]
  cart = Cart.find(user_id: current_user, product_id: product_id)[0]?
  if cart
    Cart.update(cart.id, number: "number + 1")
  else
    Cart.insert(user_id: current_user, product_id: product_id, number: 1)
  end
  redirect_back
end
