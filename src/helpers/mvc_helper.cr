class I18n
  def self.locate
    @@locate ||= "ss"
  end

  def self.locate=(value : String)
    @@locate = value
  end
end

def to(name)
  "#{name} help #{I18n.locate}"
end
