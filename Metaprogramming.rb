# Intro 
# Ruby has metaprogramming capabilities 
# A traditional program is mainly code that manipulates a data structure and produces output 
# Metaprogramming allows us to write code that writes code 
# It lets you perform a task in a few minutes that may take you hours to do in other languages 

# Define keyword arguments and learn why they are useful
# Define mass assignment and learn why it is useful
# Practice using keyword arguments and mass assignment

# Keyword Arguments 

# At this point we know methods can be defined to take in arguments 
# and the methods can take in multiple arguments 
def print_name_and_greeting(greeting, name)
  puts "#{greeting}, #{name}"
end

print_name_and_greeting("'sup", "Hillary")
# 'sup, Hillary
# => nil 
# RIght now, whoever uses our method needs to remember exactly what order to pass in the argument 
# They need to know that the first argument is greeting and the second argument is a name 
# Arguments defined this way are known as positional arguments 
# becaue the position they are passed in makes a difference when the function is called 

# Maybe another developer working on te code base doesn't see the file where the method is defined 
# but only sees the method being invoked 
# after all, when you invoke a method, the argumetns aren't labeled or anything 
# what this type of disaster would befall us 
print_name_and_greeting("Kanye", "hello")
# Kanye, hello
# => nil 
# What a weid way to greet Kanye 

# Using Keyword Arguments 
# Keyword Arguments are a special way of passing arguments into a method 
# They behave like hashes, pairing a key that functions as a parameter name with its value 

# Walk Through Example 
# happy_birthday 
def happy_birthday(name: "Beyonce", current_age: 31)
  puts "Happy Birthday, #{name}"
  current_age += 1
  puts "You are now #{current_age} years old"
end 

# Here we've defined our method to take in keyword arguments 
# Our keyword arguments consist of two key/value pairs :name and :current_age 
# We have given our keyword arguments default values of "Beyonce" and "31" but we didn't have to 

def happy_birthday(name:, current_age:)
  puts "Happy Birthday, #{name}"
  current_age += 1
  puts "You are now #{current_age} years old"
end 
# WE can reference name and current_age inside our method body, as if they were barewords 
# even though they are the key in our keyword argument 
# Keyword arguments allow you to name the argument that you pass in as key in a hash 
# Then the method body can use the value of those keys, referenced by their name 
happy_birthday(current_age: 31, name: "Carmelo Anthony")
# Happy Birthday, Carmelo Anthony
# You are now 32 years old 

# Mass Assignment 
# ANother benefit of using keyword arguments is the ability to "mass assign" attributes to an object 
# Initialize individual people with a name and an age 
# take in a person's attributes as keyword arguments 
class Person
  attr_accessor :name, :age

  def initialize(name:, age:)
    @name = name
    @age = age
  end
end 

# Now, we have the added benefit of being able to use mass assignment to instantiate new people object 
# If a method is defined to accept keyword arguments 
# we can create the hash that the method is expecting to accept as an argument 
# set the hash equal to a variable and pass that variable to 
# the method as an argument 
person_attributes = { name: "Sophie", age: 26 }
sophie = Person.new(person_attributes)
# => #<Person:0x007f9bd5814ae8 @name="Sophie", @age=26> 

# Starting with RUby version 3 
# The use of hash for keyword arguments will be deprecated 
# So the above code will throw an error message
 # To get around this error you can use double splat operator (**) to convert 
 # a hash to keyword arguments 
person_attributes = { name: "Sophie", age: 26 }
sophie = Person.new(**person_attributes) 
