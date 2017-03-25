macro login?
  env.session.string?("auth_token") || env.request.cookies["auth_token"]?
end

def cart_count
  Cart.get_num("select sum(number) from Cart where user_id = 1").to_s[0...-2]
end

macro do_login_before!
  unless current_user
    env.redirect "/login"
  end
end

macro current_user
  env.session.string?("auth_token") || env.request.cookies["auth_token"]?
end

# macro current_user
#   1 || env.session.string?("auth_token")
# end

def generate_token
  "hello"
end

def cates
  Cate.all
end

macro li(url)
	"<li#{" class=active" if env.request.path == {{url}} }>"
end
