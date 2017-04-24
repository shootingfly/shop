struct RoomSocket
  property socket, room_id

  def initialize(@socket : HTTP::WebSocket, @room_id : Int32)
  end
end

SOCKETS = [] of RoomSocket # HTTP::WebSocket
ID      = [] of Int32
ws "/chat" do |socket, env|
  qq = query["qq"]
  name = query["name"]
  room_id = query["room_id"].to_i
  file_name = "./public/chat/#{room_id}.txt"
  `touch #{file_name}` unless File.exists?(file_name)
  more = File.read(file_name)
  socket.send(more)
  room_socket = RoomSocket.new(socket, room_id)
  SOCKETS << room_socket
  socket.on_message do |message|
    str = <<-END
<div class="mdui-col-xs-12 mdui-card">
  <div class="mdui-card-header">
    <img class="mdui-card-header-avatar" src="http://q4.qlogo.cn/g?b=qq&nk=#{qq}&s=100"/>
    <div class="mdui-card-header-title">#{name}</div>
    <div class="mdui-card-header-subtitle">#{Time.now.to_s("%m-%d %H:%M")}</div>
  </div>
  <!-- 卡片的内容 -->
  <div class="mdui-card-content">#{message}</div>
</div>
END
    File.open(file_name, "a+") { |f| f.puts(str) }
    SOCKETS.each { |room_socket| room_socket.socket.send(str) if room_socket.room_id == room_id }
  end
  socket.on_close do
    SOCKETS.delete room_socket
  end
end

get "/chatform" do |env|
  view "chat/form", "聊天室"
end

post "/chat" do |env|
  qq = body["qq"]
  name = body["name"]
  room_id = body["room_id"]
  view "chat/chat", "聊天室"
end

get "/foolish/:room_id" do |env|
  room_id = url["room_id"]
  view "chat/form_auto", "聊天室"
end
