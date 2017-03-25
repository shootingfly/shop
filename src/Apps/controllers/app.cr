def success?(username, password) : String
  user = User.find(username: username)[0]?
  if user.nil?
    return "用户名错误"
  elsif user.password != password
    return "密码错误"
  else
    return user.id.to_s
  end
end

get "/" do |env|
  if env.request.cookies["auth_token"]?
    env.session.string("auth_token", env.request.cookies["auth_token"].value)
  end
  view "app_home", "主页"
end

get "/about" do |env|
  env.response.cookies << HTTP::Cookie.new("auth_token", "1")
  view "app_about", "关于我们"
end

get "/faq" do |env|
  view "app_faq", "常见问题"
end

get "/login" do |env|
  env.session.string("back", env.request.headers["Referer"])
  view "app_login", "登录"
end

post "/login" do |env|
  if ret = success?(env.params.body["username"], env.params.body["password"])
    env.session.string("auth_token", ret)
    redirect_back
  else
    view "app_login", "登录", ret
  end
end

get "/register" do |env|
  env.session.string("back", env.request.headers["Referer"])
  view "app_register", "注册"
end

post "/register" do |env|
  success? = User.insert(username: env.params.body["username"],
    password: env.params.body["password"],
    address: env.params.body["address"],
    phone: env.params.body["phone"],
  )
  if success?
    user = User.find(username: env.params.body["username"])[0]
    env.session.string("auth_token", user.id.to_s)
  else
    view "app_register", "注册", "用户名已存在"
  end
end

get "/logout" do |env|
  env.session.destroy
  redirect_back
end
