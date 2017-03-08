get "/admin/manageProduct" do |env|
	items = Product.all
	admin_view "manageProduct", "商品管理"
end