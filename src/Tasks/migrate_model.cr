require "../Models/model"

# table(User, username: String, password: String, address: String, phone: String, token: String)
# table(Cate, name: String, remark: String, show_order: Int32)
# table(Product, name: String, price: Float32, stock: Int32, sale: Int32, on_sale: Bool, cate_id: String)
# table(Cart, product_id: Int32, user_id: Int32, number: Int32)
Admin.create
User.create
Cate.create
Product.create
Cart.create
Order.create(drop?: true)
# OrderItem.create(drop?: true)
