get "/product/:cate_id" do |env|
  cate_id = env.params.url["cate_id"]
  products = Product.find(cate_id: cate_id)
  view "product/index", "商品"
end

get "/product/search/:name" do |env|
  name = env.params.url["name"]
  products = Product.find(name: name)
  view "product/index", "商品"
end
