require "kemal"
require "./model"
require "./helpers/*"
require "./controllers/*"

get "/" do |env|
  view "main/home", "主页"
end

Kemal.run
