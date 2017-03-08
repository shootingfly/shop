macro login?
  env.session.int?("token")
end

def cart_count
  Cart.get_num("select sum(number) from Cart where user_id = 1").to_s[0...-2]
end

def login(env)
  if login?
    yield
  else
    env.redirect "/login"
  end
end

macro current_user
  env.session.int?("token")
end

def generate_token
  "hello"
end

def cates
  Cate.all
end

macro li(url)
	"<li#{" class=active" if env.request.path == {{url}} }>"
end
