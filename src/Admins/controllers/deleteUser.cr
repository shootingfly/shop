get "/admin/deleteUser/:id" do |env|
	id = env.params.url["id"].to_i
	User.delete(id)
	redirect_back
end