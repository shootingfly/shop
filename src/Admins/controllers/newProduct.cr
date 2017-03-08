# 添加商品
get "/admin/newProduct" do |env|
	admin_view "newProduct", "添加商品"
end

post "/admin/newProduct" do |env|
	Product.insert(				
	name: env.params.body["name"],	
	price: env.params.body["price"],	
	stock: env.params.body["stock"],	
	sale: env.params.body["sale"],	
	on_sale: env.params.body["on_sale"],	
	cate_id: env.params.body["cate_id"],	
	)
	admin_view "newProduct", "添加商品", "添加成功！"
end