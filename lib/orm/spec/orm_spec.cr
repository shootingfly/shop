require "./spec_helper"

# TODO: Write tests

# it "works" do
#   false.should eq(false)
# end

# it "self.count" do
#   count = User.count
#   count.should eq(User.count)
# end

# it "self.first" do
#   user = User.first
#   user.name.should eq("2")
# end

# it "self.first(where)" do
#   sql = "where name = '4'"
#   user = User.first(where: sql)
#   user.name.should eq("4")
# end

# it "self.all" do
#   users = User.all
#   users.size.should eq(User.count)
# end
# it "create table" do
#   puts Cat.create(true)
#   true.should eq(true)
# end
# it "self.insert" do
#   User.insert(name: "2", bar: "")
#   true.should eq(true)
# end
# it "self.update" do
#   User.update(1, name: "4")
#   User.find(1).name.should eq("4")
# end

it "self.find(**where)" do
  users = Cat.find(name: "3")
  puts users.created_at
  users.size.should_not eq(3)
end

# it "table = User2" do
#   # User.table_name = "users"
#   users = User.all
#   users.size.should_not eq(1)
# end

# it "self.delete" do
#   flag = Post.delete(2)
#   flag.rows_affected.should eq(1)
# end

# puts User.rand(2)
# users = User.rand(1)
# p User.save({
#   name: "333",
#   bar:  "444",
# })
# p User.first
# p User.all
# p User.count
# p users.name
