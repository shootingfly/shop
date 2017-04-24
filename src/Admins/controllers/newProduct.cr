macro upload_file
end

# 添加商品
get "/admin/newProduct" do |env|
  admin_view "newProduct", "添加商品"
end

get "/admin/newProduct/:string" do |env|
  redirect "/admin/newProduct"
end

post "/admin/newProduct" do |env|
  file = env.params.files["image"]
  file_path = ""
  if !file.filename.is_a?(String)
    success? = false
  else
    file_path = ::File.join [Kemal.config.public_folder, "uploads/product_images/", file.filename.as(String)]
    File.open(file_path, "w") do |f|
      IO.copy(file.tmpfile, f)
    end
    success? = true
  end
  if success?
    image_path = "/uploads/product_images/#{file.filename.as(String)}"
  else
    image_path = ""
  end
  Product.insert(
    name: body["name"],
    price: body["price"],
    stock: body["stock"],
    sale: body["sale"],
    on_sale: body["on_sale"],
    cate_id: body["cate_id"],
    image: image_path
  )
  admin_view "newProduct", "添加商品", "添加成功！"
end
