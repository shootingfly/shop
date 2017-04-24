macro view(filename, title)
	page_title = {{title}}
	render "src/Apps/views/#{{{filename}}}.ecr", "src/Layouts/layout.ecr"
end

macro view(filename)
	render "src/Apps/views/#{{{filename}}}.ecr", "src/Layouts/layout.ecr"
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

macro body
	env.params.body
end

macro url
	env.params.url
end

macro query
	env.params.query
end

macro json
	env.params.json
end

macro redirect(path)
	env.redirect {{path}}
end

macro session
	env.session
end

macro cookie(string)
	env.request.cookies[{{string}}].value
end

macro cookie?(string)
	env.request.cookies.has_key?({{string}})
end

class Object
  macro def methods : Array(Symbol)
    {{ @type.methods.map { |x| %(:"#{x.name}").id } }}
  end
end

module Status
  Dealing    = "待处理"  # 用户提交订单默认态
  Dealed     = "已接单"  # 商家接收订单
  Delivering = "待发货"  #
  Delivered  = "已发货"  # 商家发出订单
  Finished   = "订单完成" # 用户收到货
  Canceled   = "已取消"  # 用户取消订单
end
