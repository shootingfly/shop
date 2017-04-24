get "/admin/deleteCate/:id" do |env|
	id = url["id"].to_i
	Cate.delete(id)
	redirect_back
end