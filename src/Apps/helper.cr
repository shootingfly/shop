macro login?
	env.request.cookies.has_key?("auth_token")
end

macro current
	User.find(token: cookie("auth_token"))[0].as(User)
end

macro current_user
	User.find(token: cookie("auth_token"))[0].as(User).id
end

# macro current
# 	user = nil
# 	if env.request.cookies["auth_token"]?
# 		user = User.find(token: env.request.cookies["auth_token"].value)[0]?
# 	end
# 	user
# end

macro active?(url)
	"mdui-list-item-active" if env.request.path == {{url}}
end

macro nav_active?(url)
	"mdui-bottom-nav-active" if env.request.path =~ {{url}}
end
