macro view(filename, title)
	page_title = {{title}}
	# if env.request.headers["User-Agent"] =~ /Mobile/
	# 	render "src/Apps/views/#{{{filename}}}.ecr", "src/Layouts/mlayout.ecr"
	# else
		render "src/Apps/views/#{{{filename}}}.ecr", "src/Layouts/layout.ecr"
	# end
end

macro view(filename)
	# if env.request.headers["User-Agent"] =~ /Mobile/
	# 	render "src/Apps/views/#{{{filename}}}.ecr", "src/Layouts/mlayout.ecr"
	# else
		render "src/Apps/views/#{{{filename}}}.ecr", "src/Layouts/layout.ecr"
	# end
end

macro admin_view(filename, title, flash = "")
	page_title = {{title}}
	flash = {{ flash }}
	render "src/Admins/views/#{{{filename}}}.ecr", "src/Layouts/admin.ecr"
end

macro redirect_back
	if env.session.string?("return_to")
		env.redirect env.session.string("return_to")
	else
		env.redirect "/"
	end
end

macro cookie(string)
	env.request.cookies[{{string}}].value
end

macro cookie?(string)
	env.request.cookies.has_key?({{string}})
end
