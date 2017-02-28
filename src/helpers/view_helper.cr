def cart_count
  Cart.count
end

macro login?
  true || env.request.cookies["token"]?
end

def current_user
  1
end

def generate_token
  "hello"
end
