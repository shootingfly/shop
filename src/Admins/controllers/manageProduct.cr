get "/admin/manageProduct" do |env|
  items = Product.all
  admin_view "manageProduct", "商品管理"
end

get "/admin/manageProduct/:cate_id" do |env|
  items = Product.find(cate_id: url["cate_id"])
  admin_view "manageProduct", "商品管理"
end
