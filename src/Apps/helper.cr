macro login?
	cookie?("auth_token")
end

macro do_login!
	unless login?
		env.redirect "/login"
		halt(env, 302)
	end
end

macro current
	User.find(token: cookie("auth_token"))[0].as(User)
end

macro current_user
	User.find(token: cookie("auth_token"))[0].as(User).id
end

macro active?(url)
	"mdui-list-item-active" if env.request.path == {{url}}
end

macro nav_active?(url)
	"mdui-bottom-nav-active" if env.request.path =~ {{url}}
end
