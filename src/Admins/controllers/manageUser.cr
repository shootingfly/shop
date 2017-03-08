get "/admin/manageUser" do |env|
	items = User.all
	admin_view "manageUser", "用户管理"
end