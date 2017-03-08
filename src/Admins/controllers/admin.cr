get "/root" do |env|
  if admin_login?
    env.redirect "/admin/home"
  else
    page_title = "后台登录"
    flash = ""
    render "src/Admins/views/adminLogin.ecr"
  end
end

post "/root" do |env|
  username = env.params.body["username"]
  password = env.params.body["password"]
  admin = Admin.find(username: username, password: password)
  if admin.size == 0
    page_title = "后台登录"
    flash = "登录失败，用户名或密码错误"
    render "src/Admins/views/adminLogin.ecr"
    # admin_view "admin_login", "后台登录", flash: "登录失败，用户名或密码错误"
  else
    env.session.string("admin_token", username)
    env.redirect "/admin/home"
  end
end

get "/admin/logout" do |env|
  env.session.destroy
  env.redirect "/root"
end

before_all "/admin/*" do |env|
  raise "Please Login Before" unless admin_login?
end

get "/admin/home" do |env|
  admin_view "adminHome", "后台首页"
end
