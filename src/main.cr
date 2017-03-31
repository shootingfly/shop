require "kemal"
require "kemal-session"
require "./Globals/*"
require "./Models/*"

require "./Apps/helper"
require "./Apps/controllers/*"

require "./Admins/helper"
require "./Admins/controllers/*"

Kemal.run(port: 80)
