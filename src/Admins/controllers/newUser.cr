# 添加用户
get "/admin/newUser" do |env|
	admin_view "newUser", "添加用户"
end

post "/admin/newUser" do |env|
	User.insert(				
	username: body["username"],	
	password: body["password"],	
	address: body["address"],	
	phone: body["phone"],	
	)
	admin_view "newUser", "添加用户", "添加成功！"
end