require "orm"

DB_URL = "mysql://rocky@localhost/shop"
table(Admin, username: String, password: String)
table(User, username: String, password: String, address: String, phone: String, token: String)
table(Cate, name: String, cate_id: String, show_order: Int32)
table(Product, name: String, price: Float32, stock: Int32, sale: Int32, on_sale: Bool, cate_id: String)
table(Cart, product_id: Int32, user_id: Int32, number: Int32)
table(Order, order_id: Int64, user_id: Int32, status: String, sum: Float32, content: String)
table(OrderItem, order_id: Int64, product_id: Int32, price: Float32, number: Int32, total: Float32)
