class User < ActiveRecord::Base
	has_secure_password
	validates_uniqueness_of :email
	has_and_belongs_to_many :roles

	def policies
		# h.each do |key, value|
		#   puts key
		#   value.each do |k,v|
		#     puts k
		#     puts v
		#   end
		# end

		#define policies
		#"UserController": {
        #     "index": "true",
        #     "create": "true"
        # },
        # "RoleController": {
        #     "create": "true",
        #     "destroy": "true"
        # },
        # "all": {
        #     "all": "all"
        # }
        policies = {}
        self.roles.each do |r|
        	r.policies.each do |controller,actions|
        		#if policis has key merge values else just add 
        		if policies.has_key?(controller)
        			#merge keys
        			actions.each do |action,access|
        				if !policies[controller].has_key?(action)
        					policies[controller][action] = access
        				end
        			end
        		else
        			policies[controller] = actions
        		end
        	end
        end
        policies
	end
end