# 登录页面
get "/login" do |env|
  view "main/login", "登录"
end

# 登录表单
post "/login" do |env|
  username = env.params.body["username"]
  password = env.params.body["password"]
  user = User.find(username: username)[0]
  if user
    view "main/login", "登录", "无效用户名"
  elsif user.password != password
    view "main/login", "登录", "无效密码"
  else
    env.response.cookies << HTTP::Cookie.new("token", user.token, http_only: true)
    redirect_back
  end
end

# 注册页面
get "/register" do |env|
  view "main/register", "注册"
end

# 注册表单
post "/register" do |env|
  username = env.params.body["username"]
  password = env.params.body["password"]
  token = generate_token
  if User.insert(username: username, password: password, token: token)
    env.response.cookies << HTTP::Cookie.new("token", token, http_only: true)
    redirect_back
  else
    view "main/register", "注册", "用户名密码错误"
  end
end

# 注销
get "/logout" do |env|
  env.response.cookies << HTTP::Cookie.new("token", "", secure: true)
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
