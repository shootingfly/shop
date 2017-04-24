# 添加分类
get "/admin/newCate" do |env|
  admin_view "newCate", "添加分类"
end

post "/admin/newCate" do |env|
  Cate.insert(
    name: body["name"],
    cate_id: body["cate_id"],
    show_order: body["show_order"],
    icon: body["icon"],
    color: body["color"],
  )
  Const.update_cate
  admin_view "newCate", "添加分类", "添加成功！"
end
