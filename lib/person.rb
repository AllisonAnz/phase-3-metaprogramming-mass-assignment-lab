# Use keyword arguments to define an initialize method
# Use mass assignment to metaprogram an initialize method

# Create a Person class that accepts a hash upon initialization 
# They keys of the hash should conform to the attributes 
#   :name, :birthday, :hair_color, :eye_color, :height,
#   :weight, :handed, :complexion, :t_shirt_size,
#   :wrist_size, :glove_size, :pant_length, :pant_width

# Each key in the attr hash will become a property of an initialized Person instance 
# So you should make an attr_accessor for each above property 
class Person
  def initialize(attributes)
    attributes.each do |key, value|
      # create a getter and setter by calling the attr_accessor method 
      self.class.attr_accessor(key)
      self.send("#{key}=", value)
    end
  end

end


bob_attributes = { name: "Bob", hair_color: "Brown" }

bob = Person.new(bob_attributes)
bob.name       # => "Bob"
bob.hair_color # => "Brown"

susan_attributes = { name: "Susan", height: "5'11\"", eye_color: "Green" }

susan = Person.new(susan_attributes)
susan.name      # => "Susan"
susan.height    # => "5'11""
susan.eye_color # => "Green" 