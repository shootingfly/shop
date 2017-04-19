require "dir"
class Count
  @@count = 0
  def self.countplus
    @@count += 1
  end
  def self.count
    @@count
  end
end
def reverse_file(path : String)
  if File.directory?(path)
    Dir.entries(path).sort.each do |filename|
      if filename != "." && filename != ".."
        reverse_file(path + "/" + filename)
      end
    end
  else
    File.open(path, "r+") do |f|
      TXT.puts("######" + path + "\n")
      TXT.puts(f.gets_to_end)
    end
    Count.countplus
  end
end

TXT = File.open("/home/rocky/code.txt", "a+")
reverse_file(Dir.pwd)
TXT.close
puts Count.count
