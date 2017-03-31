# 编辑分类
get "/admin/editCate/:id" do |env|
	id = env.params.url["id"].to_i
	item = Cate.find(id)[0]
	admin_view "editCate", "编辑分类"
end

post "/admin/editCate/:id" do |env|
	id = env.params.url["id"].to_i
	if Cate.update(id,				
		name: env.params.body["name"],	
		cate_id: env.params.body["cate_id"],	
		show_order: env.params.body["show_order"],	
		icon: env.params.body["icon"],	
		color: env.params.body["color"],	
	)
		env.redirect "/admin/manageCate"
	else
		redirect_back
	end
end