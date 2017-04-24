# 编辑商品
get "/admin/editProduct/:id" do |env|
	id = url["id"].to_i
	item = Product.find(id)[0]
	admin_view "editProduct", "编辑商品"
end

post "/admin/editProduct/:id" do |env|
	id = url["id"].to_i
	if Product.update(id,				
		name: body["name"],	
		price: body["price"],	
		stock: body["stock"],	
		sale: body["sale"],	
		on_sale: body["on_sale"],	
		cate_id: body["cate_id"],	
	)
		redirect "/admin/manageProduct"
	else
		redirect_back
	end
end