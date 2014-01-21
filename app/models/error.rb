class Error
	include ActiveModel::Model
	attr_accessor :error_description, :error_code, :error_list
	# attribute :error_description
	# attribute :error_code
	# attribute :error_list

	# def initialize(attributes = {})
 #    	attributes.each do |name, value|
 #      		send("#{name}=", value)
 #    	end
 #  	end
end