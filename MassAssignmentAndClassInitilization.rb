# Mass Assignment and Class Initialization
# Understand how to use mass assignment to metaprogram a Ruby class

# Metaprogramming is the practice of writing code the writes code for us 
# What does that have to do about mass assignment?

# Say we want to use the Twitter API to create users for our own application 
# The senario is that we are developing a web application and 
# we want our users to be able to sign in via twitter 

# Thus our own users are puleed from Twitter and we need to take the data we get 
# from Twitter (user name, age, location) and make them instances of our 
# own User class 

class User
  attr_accessor :name, :age, :location, :user_name

  def initialize(user_name:, name:, age:, location:)
    @user_name = user_name
    @name = name
    @location = location
    @age = age
  end
end 

# Here we have our user class. It initializes with keyword arguments (hash of attributes)
# We wont go into the specifics on how to request and receive data from the Twitter API 
# Suffice to say that we send a request to the Twitter API and get a return value 
# of a hash full of user attributes 
twitter_user = { 
  name: "Sophie", 
  user_name: "sm_debenedetto", 
  age: 26, 
  location: "NY, NY"
} 

# With mass assignment, we can use the twitter_user hash to instantiate a new instance 
# of our own User class 
sophie = User.new(twitter_user)
# => #<User:0x007fa1293e68f0 @name="Sophie", @age=26, @user_name="sm_debenedetto", @location="NY, NY"> 

# Lets say twitter changes their API without telling us
# Now the request data from the API, return value looks like 
new_twitter_user = {
  name: "Sophie", 
  user_name: "sm_debenedetto", 
  location: "NY, NY"
} 
# Notice new_twitter_user no longer has an age 
# If we try to create a new Users using the same User class Code 
User.new(new_twitter_user)
# => ArgumentError: missing keyword: age 

# Say the change it again 
newest_twitter_user = {
  name: "Sophie", 
  user_name: "sm_debenedetto", 
  age: 26, 
  location: "NY, NY", 
  bio: "I'm a programmer living in NY!"
} 
# We get 
User.new(newest_twitter_user)
# => ArgumentError: unknown keyword: bio 

# We need a way to abstract away our User class Dependency on a specific attributes 
# We need a way for us to tell our User to get ready to accept some unspecified number and types of attributes 
#-----------------------------------------------------------------------------------------------

# Mass Assignment and Metaprogramming 
# Here is our new and improved User class 
class User
  attr_accessor :name, :user_name, :age, :location, :bio

  def initialize(attributes)
    attributes.each do |key, value| 
      self.send("#{key}=", value)
    end
  end
end 

# We define our initialize method to take in some unspecified attributes object 
# We iterate over each key/value pair in the attributes hash 
# The name of the key becomes the name of a setter method 
# The value associated with the key is the name of the value you want to pass to that method 
# The ruby #send method then calls the method name that is the key name, 
# with the argument of the value 
self.send("#{key}=", value) 
# Is the same as 
instance_of_user.key = value 
# Where each key/value pair is a member of our hash, one such iteration might read 
instance_of_user.name = "Sophie" 
# And have the same result as 
instance_of_user = User.new
instance_of_user.name = "Sophie" 


# A Closer Look at #send 
# the #send method is just another way of calling a method on an object 
# For Example, we know that instances of the User class 
# have a #name= method that allows us to send the name of a user to a particular string 
sophie = User.new
sophie.name = "Sophie" 

# Now, we use the #name getting method it will return the corrent name 
sophie.name
# => "Sophie" 

# Look at the same behavior using #send 
sophie = User.new
sophie.send("name=", "Sophie") 

# Above is considered to be clunky and ugly (syntactic vinegar)
# WE prefer the "syntactic sugar" of the first approach 

# The #send method, however is very usefule for our metaprogramming purpose 
# It allows us to abstract away the sepcific method call 
sophie = User.new
sophie.send("#{method_name}=", value) 

# This is what is happening in our initialize method in the above example 
# were self refers to the User instance that is being initizlied at the that point in time

#-------------------------------------------------------------------------------------------
# Taking things further: dynamically setting getters and setters 
# say we didn't want to specify the individual getter and msetter methods using name symboles like so 
class User
  # we don't want to do this anymore :(
  attr_accessor :name, :user_name, :age, :location, :bio

  def initialize(attributes)
    attributes.each do |key, value| 
      self.send("#{key}=", value)
    end
  end
end 

# Instead, we want to dynamically set those methods so that we have a getter and setter automatically 
# declared for every attributes in the attributes Hash 

# First we need to remember that attr_access is a class method 
# just like attr_reader and attr_writer 
# Meaning we can dynamically add getters or setters, or boeth by doing the following 
class User
  def initialize(attributes)
    attributes.each do |key, value|
      # create a getter and setter by calling the attr_accessor method
      self.class.attr_accessor(key)
      self.send("#{key}=", value)
    end
  end
end 
# By mkaing that one small change, we can now get and set every attribute o an object instantiated from User 