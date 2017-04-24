get "/admin/deleteUser/:id" do |env|
	id = url["id"].to_i
	User.delete(id)
	redirect_back
end