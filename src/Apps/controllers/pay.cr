module Alipay
  # PAY_OPTIONS = {
  #   service:        "alipay.wap.create.direct.pay.by.user",
  #   partner:        ALIPAY_PID,
  #   seller_id:      ALIPAY_PID,
  #   _input_charset: "utf-8",
  #   payment_type:   "1",
  #   notify_url:     "http://localhost:3000/payments/pay_return",
  #   return_url:     "http://localhost:3000/payments/pay_notify",
  #   out_trade_no:   "Your Payment Number",
  #   subject:        "",
  #   total_fee:      "",
  #   show_url:       "",
  #   body:           "",
  #   sign_type:      "MD5",
  #   sign:           "",
  # }
  ID           = "dasdasdadsadas"
  MD5_SECRET   = "SADSADASDSAD"
  URL          = "SADSADASDAS"
  RETURN_URL   = "http://localhost:3000/payments/pay_return"
  NOTIFY_URL   = "http://localhost:3000/payments/pay_notify"
  PAYMENT_TYPE = "1"
end

def build_request_options
  pay_options = {
    service:        "alipay.wap.create.direct.pay.by.user",
    partner:        Alipay::ID,
    seller_id:      Alipay::ID,
    _input_charset: "utf-8",
    payment_type:   "1",
    notify_url:     "http://localhost:3000/pay_return",
    return_url:     "http://localhost:3000/pay_notify",
    out_trade_no:   "Your Payment Number",
    subject:        "sadsad",
    total_fee:      "asdasd",
    show_url:       "asdsa",
    body:           "asdasd",
    sign_type:      "MD5",
    sign:           "asdsd",
  }
end

get "/pay" do |env|
  # pay_id = body["pay_id"].to_i
  # pay = Payment.find(user_id: current_user, pay_id: pay_id)
  pay_url = "https://mapi.alipay.com/gateway.do?_input_charset=utf-8"
  pay_options = build_request_options
  view "pay/pay", "确认订单"
end

get "/pay_return" do |env|
  render "app/home", "zhuye"
end
get "/pay_notify" do |env|
  render "app/home", "zhuye"
end
