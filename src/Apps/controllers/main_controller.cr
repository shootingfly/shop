# 登录页面
get "/login" do |env|
  env.session.string("back", env.request.headers["Referer"])
  view "main/login", "登录"
end

# 登录表单
post "/login" do |env|
  user = User.find(username: env.params.body["username"])[0]?
  if user && env.params.body["password"] == env.params.body["password"]
    env.session.int("token", user.id)
    redirect_back(env.session.string("back"))
  elsif !user
    view "main/login", "登录", "无效用户名"
  else
    view "main/login", "登录", "无效密码"
  end
end

# 注册页面
get "/register" do |env|
  env.session.string("back", env.request.headers["Referer"])
  view "main/register", "注册"
end

# 注册表单
post "/register" do |env|
  if User.insert(
       username: env.params.body["username"],
       password: env.params.body["password"],
       address: env.params.body["address"],
       phone: env.params.body["phone"],
     )
    user = User.find(username: env.params.body["username"])[0]
    env.session.int("token", user.id)
    redirect_back(env.session.string("back"))
  else
    view "main/register", "注册", "用户名密码错误"
  end
end

# 注销
get "/logout" do |env|
  env.session.destroy
  redirect_back
end

# 常见问题页面
get "/faq" do |env|
  view "main/faq", "常见问题"
end

# 关于我们页面
get "/about" do |env|
  view "main/about", "关于我们"
end

# cart_delete

# deleteCart
# newCart
# indexCart
# deleteAllCart

# newOrder
# showOrder
# deleteOrder
# indexOrder
