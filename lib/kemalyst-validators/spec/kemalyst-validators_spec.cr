require "./spec_helper"

class Person
  include Kemalyst::Validators
  property name : String?
  
  validate :name, "is required", -> (this : Person) { this.name != nil } 
  
  validate :name, "must be 3 characters long", -> (this : Person) do 
    if name = this.name
      return name.size > 2
    end
    return true
  end
  
  def initialize(@name = nil)
  end
end

describe Kemalyst::Validators do

  describe "presence" do
    it "validates presence of name" do
      person = Person.new(name: "John Doe")
      person.valid?.should eq true
    end
    it "returns false if name is not present" do
      person = Person.new
      person.valid?.should eq false
      person.errors[0].to_s.should eq "Name is required"
    end
  end

  describe "validate length" do
    it "returns valid if name is greater than 2 characters" do
      person = Person.new(name: "John Doe")
      person.valid?.should eq true
    end
    
    it "returns invalid if name is less than 2 characters" do
      person = Person.new(name: "JD")
      person.valid?.should eq false
      person.errors[0].to_s.should eq "Name must be 3 characters long"
    end
  end
end
