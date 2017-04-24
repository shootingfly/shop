# 编辑分类
get "/admin/editCate/:id" do |env|
  id = url["id"].to_i
  item = Cate.find(id)[0]
  admin_view "editCate", "编辑分类"
end

post "/admin/editCate/:id" do |env|
  id = url["id"].to_i
  if Cate.update(id,
       name: body["name"],
       cate_id: body["cate_id"],
       show_order: body["show_order"],
       icon: body["icon"],
       color: body["color"],
     )
    Const.update_cate
    redirect "/admin/manageCate"
  else
    redirect_back
  end
end
