get "/admin/dealOrder/:order_no" do |env|
  order = Order.find(order_no: url["order_no"])[0]
  Order.update(order.id, status: Status::Dealed)
  redirect "/admin/manageOrder"
end

get "/admin/deliverOrder/:order_no" do |env|
  order = Order.find(order_no: url["order_no"])[0]
  Order.update(order.id, status: Status::Delivered)
  redirect "/admin/manageOrder"
end

get "/admin/finishOrder/:order_no" do |env|
  order = Order.find(order_no: url["order_no"])[0]
  Order.update(order.id, status: Status::Finished)
  redirect "/admin/manageOrder"
end
