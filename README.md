# AuthoLoad

Autho_load is an experiment in creating a scheme similar to Ryan Bate's CanCan for authrozation and pre-loading of resources, but that did not require 
the ability table instead using only the loading classes own model as the athoratative granter of access. 

## Installation

Add this line to your application's Gemfile:

    gem 'autho_load'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install autho_load
    

## Usage

# Warning
<dl>
  <dt>Tested on</dt>
  <dd>Ruby 1.9.3 rails 3.2.11 only.</dd>
  <dt>Assumptions</dt>
  <dd>you have some kind of authentication (tested with https://github.com/plataformatec/devise) that returns something like current_user, 
and that you are either using one of the 7 basic actions, (new, create, edit, update, show, index & delete) or you have extended the code to 
accomodate additional ones.</dd>
</dl>
# Basic

Assuming the class you want to call autho_load on is called Post, do the following:

1. Add <u>extend</u> AuthoLoad to the the model. Note that's extend, not include, as these will be class methods. 
class Post < ActiveRecord::Base
  extend AuthoLoad
  
2. Add your access logic to your model by creating all of the following methods.
      
    def self.indexable_by(current_user) # cu is the current_user
      # return a collection or nil
    end
    
    def self.newable_by(current_user)
      # return a new object or nil
    end
    
    def showable_by(current_user)
      # return the object or nil
    end     
    
    def editable_by(current_user)
     #  return the object or nil
    end
    
    def updateable_by(current_user)
      # return the object or nil (object will already contain updated values)
    end
    
    def createable_by(current_user)
      # return the object or nil (object will already contain updated values)
    end
          
    def destroyable_by(current_user)
      # return the object or nil
    end
	The method signatures are important, newable and indexable must be class methods.
	
	An example of access logic would be if Posts belong to Users, everybody can see a list of all posts, but only a user that has attribute admin true or a posts author can update it could look something like:
	
	 class Post < ActiveRecord::Base
  		 extend AuthoLoad
    	 belongs_to :user
		 
		 def self.indexable_by(current_user)
		   Post.all
		 end
		 
		def updateable_by(current_user)
	       if current_user.admin || current_user.id == self.user_id
	          self       
	       end
    	end
    end
    
 3. Add a before filter to your contoller. If you are using device, it would look something like
    before_filter :authenticate_user!, :autho_load!
    
 4. Write the method from the before filter
 	def autho_load!
      @resource = Post.autho_load(params, current_user)
      then process the invalid access if @resource.nil? 
   end
 	
   If resource is not nil, you simply do whatever you would have done with the authorized, loaded resource. 
     

 
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
