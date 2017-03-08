require "kemal"
require "kemal-session"
require "./Globals/*"
require "./Models/*"

require "./Apps/helper"
require "./Apps/controllers/*"

require "./Admins/helper"
require "./Admins/controllers/*"

get "/" do |env|
  view "main/home", "主页"
end

Kemal.run
