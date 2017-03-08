macro admin_li(url)
  "<li#{" class=active" if env.request.path =~ {{url}} }>"
end

macro admin_href
    href =
      case env.request.path
      when /manage/
        env.request.path.sub "manage", "new"
      when /new/
        env.request.path.sub "new", "manage"
      when /edit/
        env.request.path.sub("edit", "manage").sub(/\/\d+/, "")
      end
end

macro admin_login?
  env.session.string?("admin_token")
end
