get "/admin/deleteProduct/:id" do |env|
	id = env.params.url["id"].to_i
	Product.delete(id)
	redirect_back
end