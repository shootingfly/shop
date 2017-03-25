get "/product/:cate_id" do |env|
  cate_id = env.params.url["cate_id"]
  products = Product.find(cate_id: cate_id)
  view "product_index", "商品"
end
