class Error
	include ActiveAttr::Model

	attribute :error_description
	attribute :error_code
	attribute :error_list

	def initialize(attributes = {})
    	attributes.each do |name, value|
      		send("#{name}=", value)
    	end
  	end
end