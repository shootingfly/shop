# class User
# 	@@table_name = "User"
# 	property! id : Int32
# 	property! created_at : Time
# 	property! updated_at : Time

# 	property!

# 	def User.drop
# 	end

# 	def User.create
# 	end

# 	def User.insert(**hash)
# 	end

# 	def User.insert(user)
# 	end

# 	def User.update(**hash)
# 	end

# 	def User.update(user)
# 	end

# 	def User.find(id) : User
# 	end

# 	def User.find(**hash) : User
# 	end

# 	def User.where(**hash) : Array(User)
# 	end

# 	def User.where_limit(**hash, limit) : Array(User)
# 	end

# 	def User.order(**hash) : Array(User)
# 	end

# 	def User.first : User
# 	end

# 	def User.last : User
# 	end

# 	def User.all : Array(User)
# 	end

# 	def User.rand
# users = User.where("ssq = asdf").order(name: desc).limit(2)
# User.where("value = 2 order by 3 limit 2")
# users = User.all.array
# user = User.first.instance
