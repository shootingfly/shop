get "/admin/manageCate" do |env|
	items = Cate.all
	admin_view "manageCate", "分类管理"
end