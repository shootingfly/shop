def add_cart(current_user, product_id)
  item = Cart.find(user_id: current_user, product_id: product_id)[0]?
  if item
    Cart.update(item.id, number: item.number + 1)
  else
    Cart.insert(user_id: current_user, product_id: product_id, number: 1)
  end
end

get "/cart" do |env|
  do_login_before!
  carts = Cart.find(user_id: current_user)
  products = Product.find(carts.map(&.product_id)) if carts.any?
  view "cart_index", "购物车"
end

get "/cart/delete/:id" do |env|
  Cart.delete(env.params.url["id"])
  env.redirect "/cart"
end

get "/cart/clear" do |env|
  Cart.delete(user_id: current_user)
  env.redirect "/cart"
end

get "/cart/add/:product_id" do |env|
  Cart.find(user_id: current_user, product_id: env.params.url["product_id"])
end

post "/cart/add" do |env|
  product_id = env.params.body["product_id"]
  add_cart(current_user, product_id)
  product_id
end
