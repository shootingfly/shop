require "secure_random"
def generate_token : String
  return SecureRandom.base64
end

get "/login" do |env|
  if env.request.headers["Referer"]? && !(env.request.headers["Referer"] =~ /login|register/)
    env.session.string("return_to", env.request.headers["Referer"])
  end
  flash = env.params.query["ret"]?
  view "app_login", "登录"
end

post "/login" do |env|
  user = User.find(phone: env.params.body["phone"])[0]?
  if user.nil?
    env.redirect "/login?ret=用户名错误"
  elsif user.password != env.params.body["password"]
    env.redirect "/login?ret=密码错误"
  else
    env.response.cookies << HTTP::Cookie.new("auth_token", user.token)
    redirect_back
  end
end

get "/register" do |env|
  if env.request.headers["Referer"]? && !(env.request.headers["Referer"] =~ /login|register/)
    env.session.string("return_to", env.request.headers["Referer"])
  end
  flash = env.params.query["ret"]?
  view "app_register", "注册"
end

post "/register" do |env|
  if User.find(phone: env.params.body["phone"])[0]?
    env.redirect "/register?ret=该手机已注册，请直接登录"
  else
    token = ""
    loop do
      token = generate_token()
      break unless User.find(token: token)[0]?
    end
    User.insert(
      phone: env.params.body["phone"],
      password: env.params.body["password"],
      username: env.params.body["username"],
      address: env.params.body["address"],
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
