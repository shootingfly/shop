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

# Cate.insert(name: "日用", show_order: 1)
Admin.insert(username: "username", password: "password")
Cate.insert(name: "鲜花", cate_id: "flower", show_order: 2)
Cate.insert(name: "服务", cate_id: "server", show_order: 3)
Cate.insert(name: "猫粮", cate_id: "foods", show_order: 4)
User.insert(username: "username", password: "password", address: "西二625", phone: "15603006662")
Product.insert(name: "方便面", price: "4.5", stock: 30, sale: 1, on_sale: 1, cate_id: "foods")
Product.insert(name: "矿泉水", price: "1.5", stock: 20, sale: 1, on_sale: 1, cate_id: "foods")
Product.insert(name: "玫瑰", price: "99", stock: 10, sale: 1, on_sale: 1, cate_id: "flower")
Product.insert(name: "手机贴膜", price: "10", stock: 99, sale: 1, on_sale: 1, cate_id: "server")
Cart.insert(product_id: 1, user_id: 1, number: 1)
