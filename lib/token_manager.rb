require "oauth2"

class TokenManager
	

	def self.get_token(username, password)
		begin
		    client_id = "15016098cbd09c9ac13c188fdbd7d4057fa350cd71dc0fa8e2ba42538fa20ac6"
			secret = "f1ae9ded8ec6ce56ef3f392f79aa565ccc67bb58f109187eb43ad42d4baa6c39"
			site = "http://localhost:3000"
		
			client = OAuth2::Client.new(client_id,secret, site: site)
			token = client.password.get_token(username,password)
			token	
		rescue OAuth2::Error => e
		 	e.message.split(/\n/)[-1] #last element contains the hash of the message
		end
		
	end
	def self.get_refresh_token(token, refresh_token)
		begin
			#get existing token
			existing_token = Doorkeeper::AccessToken.find_by_token(token)
			if existing_token && existing_token.expired?

				client_id = "15016098cbd09c9ac13c188fdbd7d4057fa350cd71dc0fa8e2ba42538fa20ac6"
				secret = "f1ae9ded8ec6ce56ef3f392f79aa565ccc67bb58f109187eb43ad42d4baa6c39"
				site = "http://localhost:3000"
				client = OAuth2::Client.new(client_id,secret, site: site)

				t = OAuth2::AccessToken.new(client, token, refresh_token: refresh_token)
				new_token = t.refresh!
				new_token
			else
				#token not expired or doesint exist
				{error: "Token Not found", error_description: "Token invalid or has not expired"}
			end
		rescue OAuth2::Error => e
			e.message.split(/\n/)[-1] #last element contains the hash of the message
		end
		
	end
end