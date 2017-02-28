get "/product/:category" do |env|
  category = env.params.url["category"]
  products = Product.find(cate_name: category)
  view "product/index", "商品"
end

get "/product/search/:name" do |env|
  name = env.params.url["name"]
  products = Product.find(name: name)
  view "product/index", "商品"
end
