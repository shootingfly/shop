$(function(){
  $("#slides").slidesjs({
    navigation: false,
    pagination: false
  });
});
function fly(product_id) {
  x = document.body.scrollTop;
  flyer = $("#" + product_id + " img");
  flyer.parent().append(flyer.clone());
  var start = flyer.offset();
  var end = $("#end").offset();
  flyer.fly({
    start:{
      left: start.left,  //开始位置（必填）#fly元素会被设置成position: fixed
      top: start.top - x, //开始位置（必填）
    },
    end:{
      left: end.left, //结束位置（必填）
      top: end.top - x,  //结束位置（必填）
      width: 0, //结束时高度
      height: 0, //结束时高度
    }
  });
}
function add(product_id) {
  $.ajax({
    type: "GET",
    url: "/cart/add/" + product_id,
    success: function(data) {
      fly(product_id);
    }
  });
}
