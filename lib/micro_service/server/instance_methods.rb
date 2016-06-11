module MicroService
	class Server < ::ActiveRecord::Base
		module InstanceMethods
			def self.included(base)
				base.table_name = "micro_service_servers"
			end

			# Net::HTTP request instance able to communicate with the server described here
			def signed_request(request)
				require "open-uri"
				require "net/http"
				require "openssl"

				uri = URI.parse(self.url.to_s)
				http = Net::HTTP.new(uri.host, uri.port)
				http.use_ssl = true if uri.scheme == "https"

				prefix = "MicroService"

				yield http,request,prefix

				# Populate with authorization header
				request["Authorization"] = "#{prefix} #{self.send(:valid_authentication_header)}"

				http.request(request)
			end

			private
				# Generates a valid authentication header for use in requests to this server
				def valid_authentication_header
					require "cgi"

					algorithm = "sha256";
					url = CGI.escape(self.url.to_s)
					client_id = self.client_id
					secret = self.secret
					timestamp = (Time.now.to_i)*1000
					str = "algorithm=HmacSHA256&client_id=#{client_id}&service_url=#{url}&timestamp=#{timestamp}";
					signature = ::MicroService::SignedRequest::Utils.sign(str, secret, algorithm)

					# Header!
					"#{str}&signature=#{CGI::escape(signature)}"
				end
		end
	end
end