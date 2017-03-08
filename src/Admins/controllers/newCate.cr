# 添加分类
get "/admin/newCate" do |env|
	admin_view "newCate", "添加分类"
end

post "/admin/newCate" do |env|
	Cate.insert(				
	name: env.params.body["name"],	
	cate_id: env.params.body["cate_id"],	
	show_order: env.params.body["show_order"],	
	)
	admin_view "newCate", "添加分类", "添加成功！"
end