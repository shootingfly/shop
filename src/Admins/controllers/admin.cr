get "/root" do |env|
  if admin_login?
    redirect "/admin/home"
  else
    page_title = "后台登录"
    flash = query["ret"]?
    render "src/Admins/views/adminLogin.ecr"
  end
end

post "/root" do |env|
  username = body["username"]
  password = body["password"]
  admin = Admin.find(username: username, password: password)
  if admin.size == 0
    redirect "/root?ret=登录失败，用户名或密码错误"
  else
    env.response.cookies << HTTP::Cookie.new("admin_token", username, http_only: true)
    redirect "/admin/home"
  end
end

get "/admin/logout" do |env|
  env.response.cookies << HTTP::Cookie.new("admin_token", "", secure: true)
  redirect "/root"
end

before_all "/admin/*" do |env|
  raise "Please Login Before" unless admin_login?
end

get "/admin/home" do |env|
  admin_view "adminHome", "后台首页"
end
