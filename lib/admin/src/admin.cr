macro auto_admin(action, klass, chinese, **hash)

	{{action}}{{klass}}

	def new{{klass}}
		view_string =
%(
<form class="form-horizontal" action="/admin/new{{klass}}" method="post">
	{% for key, value in hash %}
	<div class="form-group">
		<label class="control-label col-sm-4">{{key}}</label>
		<div class="col-sm-4">
			<input class="form-control" type="{{value}}" name="{{key}}" placeholder="{{key}}" require>
		</div>
	</div>
	{% end %}
	<div class="form-group">
		<div class="col-sm-4 col-sm-offset-4">
			<input type="submit" value="提交" class="form-control btn btn-primary">
		</div>
	</div>
<form>
)
		controller_string =<<-EOF
		# 添加{{chinese}}
		get "/admin/new{{klass}}" do |env|
			admin_view "new{{klass}}", "添加{{chinese}}"
		end

		post "/admin/new{{klass}}" do |env|
			{{klass}}.insert(				{% for key, value in hash %}
			{{key}}: env.params.body["{{key}}"],	{% end %}
			)
			admin_view "new{{klass}}", "添加{{chinese}}", "添加成功！"
		end
		EOF

		File.write("src/Admins/views/new{{klass}}.ecr", view_string)
		File.write("src/Admins/controllers/new{{klass}}.cr", controller_string)
	end

	def edit{{klass}}
		view_string =
%(
<form class="form-horizontal" action="/admin/edit{{klass}}/<%= item.id %>"  method="post">
	{% for key, value in hash %}
	<div class="form-group">
		<label class="control-label col-sm-4">{{key}}</label>
		<div class="col-sm-4">
			<input class="form-control" type="{{value}}" name="{{key}}" value="<%= item.{{key}} %>" placeholder="{{key}}" require>
		</div>
	</div>
	{% end %}
	<div class="form-group">
		<div class="col-sm-4 col-sm-offset-4">
			<input type="submit" value="提交" class="form-control btn btn-primary">
		</div>
	</div>
<form>
)

		controller_string =<<-EOF
		# 编辑{{chinese}}
		get "/admin/edit{{klass}}/:id" do |env|
			id = env.params.url["id"].to_i
			item = {{klass}}.find(id)[0]
			admin_view "edit{{klass}}", "编辑{{chinese}}"
		end

		post "/admin/edit{{klass}}/:id" do |env|
			id = env.params.url["id"].to_i
			if {{klass}}.update(id,				{% for key, value in hash %}
				{{key}}: env.params.body["{{key}}"],	{% end %}
			)
				env.redirect "/admin/manage{{klass}}"
			else
				redirect_back
			end
		end
		EOF

		File.write("src/Admins/views/edit{{klass}}.ecr", view_string)
		File.write("src/Admins/controllers/edit{{klass}}.cr", controller_string)
	end

	def delete{{klass}}
		controller_string =<<-EOF
		get "/admin/delete{{klass}}/:id" do |env|
			id = env.params.url["id"].to_i
			{{klass}}.delete(id)
			redirect_back
		end
		EOF

		File.write("src/Admins/controllers/delete{{klass}}.cr",controller_string)
	end

	def index{{klass}}
		view_string =
%(
<table class="table table-bordered table-hover datatable">
	<thead>			{% for key, value in hash %}
		<th>{{key}}</th>	{% end %}
		<th>操作</th>
	</thead>
	<tbody>
	<% items.each do |item| %>
		<tr>					{% for key, value in hash %}
			<td><%= item.{{key}} %></td>	{% end %}
			<td>
				<a href="/admin/edit{{klass}}/<%= item.id %>" class="btn btn-sm">编辑</a>
				<a href="/admin/delete{{klass}}/<%= item.id %>" class="btn btn-sm">删除</a>
			</td>
		</tr>
	<% end %>
	</tbody>
</table>
)
		controller_string =<<-EOF
		get "/admin/manage{{klass}}" do |env|
			items = {{klass}}.all
			admin_view "manage{{klass}}", "{{chinese}}管理"
		end
		EOF

		File.write("src/Admins/views/manage{{klass}}.ecr", view_string)
		File.write("src/Admins/controllers/manage{{klass}}.cr", controller_string)

	end

	def all{{klass}}
		new{{klass}}
		edit{{klass}}
		delete{{klass}}
		index{{klass}}
	end
end
