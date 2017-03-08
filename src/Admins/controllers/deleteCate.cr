get "/admin/deleteCate/:id" do |env|
	id = env.params.url["id"].to_i
	Cate.delete(id)
	redirect_back
end