macro view(filename, title, flash = "")
	page_title = {{title}}
	flash = {{ flash }}
	env.response.cookies << HTTP::Cookie.new("reback", env.request.path)
	render "src/views/#{{{filename}}}.ecr", "src/layouts/layout.ecr"
end

macro redirect_back
	env.redirect (env.request.cookies["reback"]?.try &.value || "/")
end

class Layout
  @@num = 0

  def self.current_num(num = 0)
    puts "num: ", @@num
    @@num = @@num + num
  end
end
