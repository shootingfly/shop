# class User < Crecto::Model
#   schema "users" do
#     field :username, String
#     field :password, String
#     field :address, String
#     field :phone, String
#     created_at_field nil
#     updated_at_field nil
#   end
#   validate_required [:username, :password, :address, :phone]
# end

# class Category < Crecto::Model
#   schema "categories" do
#     field :name, String
#     field :remark, String
#     field :show_order, Int32
#     created_at_field nil
#     updated_at_field nil
#     has_many :products, Product
#   end
# end

# class Product < Crecto::Model
#   schema "products" do
#     field :name, String
#     field :price, Float32
#     field :stock, Int32
#     field :sale, Int32
#     field :on_sale, Bool
#     field :category_id, Int32
#     created_at_field nil
#     updated_at_field nil
#     belongs_to :categorie, Category
#   end
# end

# class Cart < Crecto::Model
#   schema "carts" do
#     field :products_set, String
#     field :user_id, Int32
#     created_at_field nil
#     updated_at_field nil
#     belongs_to :user, User
#   end
# end
