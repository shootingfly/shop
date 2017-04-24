get "/admin/manageCate" do |env|
  items = Cate.order(show_order: "asc")
  admin_view "manageCate", "分类管理"
end
