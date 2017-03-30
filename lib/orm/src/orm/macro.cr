macro table(kclass, **names)
	class {{kclass.id}}
		@@table_name = "`{{kclass}}`"

		def self.table_name= (value)
			@@table_name = value
		end

		{% for key, value in names %}
			property! {{key}} : {{value}}
		{% end %}
		property! id : Int32
		property! created_at : Time
		property! updated_at : Time

		def self.drop
			exec "drop table if exists #{@@table_name}"
		end

		def self.create(exec? = true, drop? = false)
			drop if drop?
			sql =<<-END
			create table if not exists #{@@table_name} (
				`id` int not null auto_increment primary key,  {% for key, value in names %}
				`{{key}}` #{ TYPES["{{value}}"] }, {% end %}
				`created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
				`updated_at` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  
			)ENGINE=InnoDB DEFAULT CHARSET=utf8
			END
			exec? ? exec(sql) : sql
		end

		def self.insert(**hash)
			sql = "insert into #{@@table_name} set"
			hash.each do |key, value|
				sql += " #{key} = '#{value}',"
			end
			sql = sql.rchop(',')
			exec sql
		end

		def self.update(id : Int32, **hash)
			sql = "update #{@@table_name} set"
			hash.each do |key, value|
				sql += " #{key} = '#{value}',"
			end
			sql = sql.rchop(',') + " where id = #{id}"
			exec sql
		end

		def self.where(id : Int32)
			query "select * from #{@@table_name} where id = #{id}"
		end

		def self.where(where : String)
			query "select * from #{@@table_name} " + where
		end

		def self.find(id : Int32 | Array(Int32))
			if typeof(id) == Array(Int32)
				id = id.to_s[1...-1]
			end
			query "select * from #{@@table_name} where id in (#{id})"
		end

		def self.find(where : String)
			query "select * from #{@@table_name} " + where
		end

		def self.find(**where)
			sql = "select * from #{@@table_name} where "
			where.each do |key, value|
				sql += " #{key} = '#{value}' and"
			end
			query  sql.rchop("and")
		end

		def self.all : Array(self)
			query "select * from #{@@table_name} "
		end

		def self.count(where = "")
			scalar "select count(*) from #{@@table_name} " + where
		end

		def self.get_num(sql : String)
			scalar sql
		end

		def self.get(sql : String, hash)
			query_one sql, hash
		end

		def self.delete(id : Int32 | Array(Int32) )
			if typeof(id) == Array(Int32)
				id = id.to_s[1...-1]
			end
			exec "delete from #{@@table_name} where id in (#{id})"
		end

		def self.delete(**where)
			sql = "delete * from #{@@table_name} where "
			where.each do |key, value|
				sql += " #{key} = '#{value}' and"
			end
			exec  sql.rchop("and")
		end

		def self.delete(where : String)
			exec "delete from #{@@table_name} " + where
		end

		def self.truncate
			exec "truncate #{@@table_name}"
		end

		def self.first(num =1, where = "")
			query "select * from #{@@table_name} " + where + " limit #{num}"
		end

		def self.last(num = 1, where = "")
			query "select * from #{@@table_name} " + where + " order by id desc limit #{num} "
		end

		def self.rand(num = 1, where = "")
			query "select *  from #{@@table_name} " + where + "  order by rand() limit #{num}"
		end

		private def self.from_rs(%rs : DB::ResultSet)
			results = Array(self).new
			%rs.each do
				obj =  self.new
				%rs.each_column do |col|
					case col
					{% for key, value in names %}
					when {{key.stringify}}
						obj.{{key}} = %rs.read({{value}})
					{% end %}
					when "id"
						obj.id = %rs.read(Int32)
					when "created_at"
						obj.created_at = %rs.read(Time)
					when "updated_at"
						obj.updated_at = %rs.read(Time)
					end
				end
				results << obj
			end
			results
		end

		private def self.query(sql : String)
			DB.open DB_URL do |db|
				db.query(sql) do |rs|
					from_rs(rs)
				end
			end
		end

		private def self.query_one(sql, hash)
			DB.open DB_URL do |db|
				db.query_one(sql, as: hash)
			end
		end

		private def self.scalar(sql : String)
			DB.open DB_URL do |db|
				result = db.scalar(sql)
			end
		end

		private def self.exec(sql : String)
			DB.open DB_URL do |db|
				db.exec sql
			end
		end

		TYPES = {
			String: "varchar(255)",
			Int32:  "integer unsigned",
			Int64: "bigint unsigned",
			Float32: "float",
			Float64: "double",
			Time: "datetime",
			Nil: "null",
			Bool: "bool"
		}

	end
	{{kclass.id}}.create
end
class Object
  macro def methods : Array(Symbol)
    {{ @type.methods.map { |x| %(:"#{x.name}").id } }}
  end
end
# class Array(T)
# 	macro method_missing(call)
#   		self[0].{{call.name.id}}
# 	end
# end
