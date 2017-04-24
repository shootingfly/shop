get "/admin/deleteProduct/:id" do |env|
	id = url["id"].to_i
	Product.delete(id)
	redirect_back
end