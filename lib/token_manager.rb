require "oauth2"

class TokenManager
	

	def self.get_token(username, password)
		begin
		    client_id = "15016098cbd09c9ac13c188fdbd7d4057fa350cd71dc0fa8e2ba42538fa20ac6"
			secret = "f1ae9ded8ec6ce56ef3f392f79aa565ccc67bb58f109187eb43ad42d4baa6c39"
			site = "http://localhost:3000"
		
			client = OAuth2::Client.new(client_id,secret, site: site)
			token = client.password.get_token(username,password)
			token.to_hash	
		rescue OAuth2::Error => e
		 	e.message.split(/\n/)[-1] #last element contains the hash of the message
		end
		
	end
end