# class User < Crecto::Model
#   schema "users" do
#     field :username, String
#     field :password, String
#     field :address, String
#     field :phone, String
#     created_at_field nil
#     updated_at_field nil
#     has_one :cart
#   end
#   validate_required [:username, :password, :address, :phone]
# end
