# 编辑商品
get "/admin/editProduct/:id" do |env|
	id = env.params.url["id"].to_i
	item = Product.find(id)[0]
	admin_view "editProduct", "编辑商品"
end

post "/admin/editProduct/:id" do |env|
	id = env.params.url["id"].to_i
	if Product.update(id,				
		name: env.params.body["name"],	
		price: env.params.body["price"],	
		stock: env.params.body["stock"],	
		sale: env.params.body["sale"],	
		on_sale: env.params.body["on_sale"],	
		cate_id: env.params.body["cate_id"],	
	)
		env.redirect "/admin/manageProduct"
	else
		redirect_back
	end
end