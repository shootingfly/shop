get "/" do |env|
  if env.request.headers["User-Agent"] =~ /Mobile/
    view "mobile/app_home", "主页"
  else
    view "app_home", "主页"
  end
end

get "/home" do |env|
  view "app_home", "首页"
end

get "/about" do |env|
  view "app_about", "关于我们"
end

get "/faq" do |env|
  view "app_faq", "常见问题"
end
