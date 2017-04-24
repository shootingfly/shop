require "secure_random"

def generate_token : String
  return SecureRandom.base64
end

get "/login" do |env|
  if env.request.headers["Referer"]? && !(env.request.headers["Referer"] =~ /login|register/)
    env.session.string("return_to", env.request.headers["Referer"])
  end
  flash = query["ret"]?
  view "user/login", "登录"
end

post "/login" do |env|
  user = User.find(phone: body["phone"])[0]?
  if user.nil?
    redirect "/login?ret=用户名错误"
  elsif user.password != body["password"]
    redirect "/login?ret=密码错误"
  else
    user_id = user.as(User).id
    if cookie?("cart_item")
      carts = Array(CartItem).from_json cookie("cart_item")
      Cart.batch_insert(3, "user_id, product_id, number") do
        carts.map do |cart|
          [user_id, cart.product_id, cart.number]
        end
      end
      env.response.cookies << HTTP::Cookie.new("cart_item", "", secure: true)
    end
    env.response.cookies << HTTP::Cookie.new("auth_token", user.token)
    redirect_back
  end
end

get "/register" do |env|
  if env.request.headers["Referer"]? && !(env.request.headers["Referer"] =~ /login|register/)
    env.session.string("return_to", env.request.headers["Referer"])
  end
  flash = query["ret"]?
  view "user/register", "注册"
end

post "/register" do |env|
  if User.find(phone: body["phone"])[0]?
    redirect "/register?ret=该手机已注册，请直接登录"
  else
    token = ""
    loop do
      token = generate_token()
      break unless User.find(token: token)[0]?
    end
    User.insert(
      phone: body["phone"],
      password: body["password"],
      username: body["username"],
      address: body["address"],
      token: token
    )
    env.response.cookies << HTTP::Cookie.new("auth_token", token)
    redirect_back
  end
end

get "/logout" do |env|
  env.session.destroy
  env.response.cookies << HTTP::Cookie.new("auth_token", "", secure: true)
  redirect_back
end
