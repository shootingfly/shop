def add_cart(env, product_id)
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
  if login?
    carts = Cart.find(user_id: current_user)
  elsif cookie?("cart_item")
    carts = Array(CartItem).from_json(cookie("cart_item"))
  end
  total = 0
  if carts.any?
    products = Product.find(carts.map(&.product_id))
    products.size.times do |i|
      total += carts[i].number * products[i].price
    end
    view("cart/index", "购物车")
  else
    view("cart/empty", "空的购物车")
  end
end

# 购物车列表 购物车项加一，参数 cart_id
post "/cart/add/:cart_id" do |env|
  cart_id = url["cart_id"].to_i
  if login?
    item = Cart.find(id: cart_id)[0]
    Cart.update(cart_id, number: item.number + 1)
  else
    carts = Array(CartItem).from_json(env.request.cookies["cart_item"].value)
    carts.map! do |cart|
      if cart.id == cart_id
        cart.number += 1
      end
      cart
    end
    env.response.cookies << HTTP::Cookie.new("cart_item", carts.to_json)
  end
end

# 购物车列表 购物车项减一，参数 cart_id
post "/cart/delete/:cart_id" do |env|
  cart_id = url["cart_id"].to_i
  if login?
    item = Cart.find(cart_id)[0]
    if item.number == 1
      Cart.delete(cart_id)
    else
      Cart.update(item.id, number: item.number - 1)
    end
  else
    carts = Array(CartItem).from_json(env.request.cookies["cart_item"].value)
    carts.map! { |cart| cart.number = cart.number - 1 if cart.id == cart_id; cart }
    carts.reject! { |cart| cart.number == 0 }
    env.response.cookies << HTTP::Cookie.new("cart_item", carts.to_json)
  end
end

get "/cart/clear" do |env|
  if login?
    Cart.delete(user_id: current_user)
  else
    env.response.cookies << HTTP::Cookie.new("cart_item", "", secure: true)
  end
  env.redirect "/cart"
end

# 商品列表 加入购物车，参数 product_id
get "/cart/add/:product_id" do |env|
  product_id = url["product_id"].to_i
  add_cart(env, product_id)
end
