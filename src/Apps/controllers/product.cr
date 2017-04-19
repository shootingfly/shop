get "/product/:cate_id" do |env|
  cate_id = env.params.url["cate_id"]
  cate = Cate.find(cate_id: cate_id)[0]
  products = Product.find(cate_id: cate_id)
  page_title = cate.name
  view "product_index"
end

post "/product/search" do |env|
  name = env.params.body["name"]
  page_title = "搜索结果"
  products = Product.query("select * from Product where name like '%#{name}%'")
  view "product_index"
end
