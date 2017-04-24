# 编辑用户
get "/admin/editUser/:id" do |env|
	id = url["id"].to_i
	item = User.find(id)[0]
	admin_view "editUser", "编辑用户"
end

post "/admin/editUser/:id" do |env|
	id = url["id"].to_i
	if User.update(id,				
		username: body["username"],	
		password: body["password"],	
		address: body["address"],	
		phone: body["phone"],	
	)
		redirect "/admin/manageUser"
	else
		redirect_back
	end
end