# macro search(name)
# 	%(<div>{{name}}:<input type="text" /><button>Search</button></div>)
# end
#
# macro page
# 	%(
# 	<div>
# 		<h1>Welcome!</h1>
# 		#{search(title)}
# 		#{search(content)}
# 	</div>
# 	)
# end
#
# macro comment_box(array)
# %(
# 	<div>
# 		#{comment_list({{array}})}
# 		#{comment_form}
# 	</div>
# )
# end
#
# module Indexable(T)
#   def mmm(&block)
#     sql = ""
#     self.each do |item|
#       sql += yield item
#     end
#     sql
#   end
# end
#
# macro comment_list(data)
# 	{{data}}.mmm do |item|
# 		%(
# 			<div>
# 				<div>
# 					<h3>#{item["author"]}</h3>
# 					<div>#{item["content"]}</div>
# 				<div>
# 			</div>
# 		)
# 	end
# end
#
# macro comment_form
# %(
# <form>
# 	<input type='text' placeholder='enter your name'/>
# 	<input type='text' placeholder='say something ...'/>
# 	<input type='submit' value='submit'/>
# </form>　　
# )
# end
#
# <%= page %>
# <% url = contents
#   if page_title == "商品管理"
#     [{author: "张三", content: "hello world"},{author: "李四", content: "hello world"}]
#   else
#     [{author: "张三", content: "hello world"}]
#   end
# %>
# <%= comment_box(url) %>
