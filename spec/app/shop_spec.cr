require "./spec_helper"
require "../src/Apps/controllers/cart"

unless current_user
  it "render cart" do
    request = HTTP::Request.new("Get", "/cart")
    response = call_request_on_app(request)
    response.body.should contain("购物车为空")
  end

  it "false" do
    false.should eq(false)
  end
end
