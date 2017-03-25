macro view(filename, title, flash = "")
	page_title = {{title}}
	flash = {{ flash }}
	render "src/Apps/views/#{{{filename}}}.ecr", "src/Layouts/layout.ecr"
end

macro admin_view(filename, title, flash = "")
	page_title = {{title}}
	flash = {{ flash }}
	render "src/Admins/views/#{{{filename}}}.ecr", "src/Layouts/admin.ecr"
end

macro redirect_back(location = "")
	if env.request.headers["Referer"]?
		puts "heelo"
		env.redirect env.request.headers["Referer"]
	else
		puts "ss"
		env.redirect {{location}}
	end
end
