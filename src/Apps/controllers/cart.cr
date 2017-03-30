def add_cart(env, product_id)
  login? = current_user ? true : false
  situation = [login?, env.request.cookies.has_key?("cart_item")]
  case situation
  when [false, true]
    carts = Array(CartItem).from_json(env.request.cookies["cart_item"].value)
    bool = true
    carts.map! do |cart|
      if cart.product_id == product_id
        cart.number += 1
        bool = false
      end
      cart
    end
    carts << CartItem.from_json(%({"id": #{Time.now.epoch.to_i}, "product_id": #{product_id}, "number": 1})) if bool
    env.response.cookies << HTTP::Cookie.new("cart_item", carts.to_json)
  when [false, false]
    carts = Array(CartItem).from_json(%([{"id": #{Time.now.epoch.to_i},"product_id": #{product_id}, "number": 1}]))
    env.response.cookies << HTTP::Cookie.new("cart_item", carts.to_json)
  else
    item = Cart.find(user_id: current_user, product_id: product_id)[0]?
    item ? Cart.update(item.id, number: item.number + 1) : Cart.insert(user_id: current_user, product_id: product_id, number: 1)
  end
end

get "/cart" do |env|
  carts = [] of Cart
  products = [] of Product
  if current_user
    carts = Cart.find(user_id: current_user)
  elsif cookies = env.request.cookies["cart_item"]?.try &.value
    carts = Array(CartItem).from_json(cookies)
  end
  products = Product.find(carts.map(&.product_id)) if carts.any?
  view "cart_index", "购物车"
end

get "/cart/delete/:id" do |env|
  id = env.params.url["id"].to_i
  if current_user
    Cart.delete(id)
  else
    carts = Array(CartItem).from_json(env.request.cookies["cart_item"].value)
    carts.map! { |cart| cart.number = cart.number - 1 if cart.id == id; cart }
    carts.reject! { |cart| cart.number == 0 }
    env.response.cookies << HTTP::Cookie.new("cart_item", carts.to_json)
  end
  env.redirect "/cart"
end

get "/cart/clear" do |env|
  if current_user
    Cart.delete(user_id: current_user)
  else
    env.response.cookies << HTTP::Cookie.new("cart_item", "")
  end
  env.redirect "/cart"
end

get "/cart/add/:product_id" do |env|
  product_id = env.params.url["product_id"].to_i
  add_cart(env, product_id)
  redirect_back
end
