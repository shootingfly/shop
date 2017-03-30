get "/product/:cate_id" do |env|
  cate_id = env.params.url["cate_id"]
  cate = Cate.find(cate_id: cate_id)[0]
  page_title = cate.name
  products = Product.find(cate_id: cate_id)
  view "product_index", ""
end
