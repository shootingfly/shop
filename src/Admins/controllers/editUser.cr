# 编辑用户
get "/admin/editUser/:id" do |env|
	id = env.params.url["id"].to_i
	item = User.find(id)[0]
	admin_view "editUser", "编辑用户"
end

post "/admin/editUser/:id" do |env|
	id = env.params.url["id"].to_i
	if User.update(id,				
		username: env.params.body["username"],	
		password: env.params.body["password"],	
		address: env.params.body["address"],	
		phone: env.params.body["phone"],	
	)
		env.redirect "/admin/manageUser"
	else
		redirect_back
	end
end