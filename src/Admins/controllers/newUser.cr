# 添加用户
get "/admin/newUser" do |env|
	admin_view "newUser", "添加用户"
end

post "/admin/newUser" do |env|
	User.insert(				
	username: env.params.body["username"],	
	password: env.params.body["password"],	
	address: env.params.body["address"],	
	phone: env.params.body["phone"],	
	)
	admin_view "newUser", "添加用户", "添加成功！"
end