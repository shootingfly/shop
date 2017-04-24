get "/product/:cate_id" do |env|
  cate_id = url["cate_id"]
  cate = Cate.find(cate_id: cate_id)[0]
  products = Product.find(cate_id: cate_id)
  page_title = cate.name
  view "product/index"
end

post "/product/search" do |env|
  name = body["name"]
  products = Product.query("select * from Product where name like '%#{name}%'")
  if products.any?
    page_title = "搜索结果"
    view "product/index"
  else
    page_title = "找不到哦"
    view "product/empty"
  end
end
