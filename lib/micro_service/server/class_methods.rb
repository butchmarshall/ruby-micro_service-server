module MicroService
	class Server < ::ActiveRecord::Base
		module ClassMethods
			def self.extended(base)
				#base.belongs_to :add_on, :class_name => "Jive::AddOn", :foreign_key => :jive_add_on_id
				#base.validates :jive_add_on_id, :presence => true
				#base.has_one :oauth_token, :class_name => "Jive::OauthToken", :as => :owner
				#base.serialize :config, Hash
				#base.after_create :fetch_oauth_token
			end

			# Requests installation with a service
			def install(server_install_url, client_install_url, client_uninstall_url = "")
				require "open-uri"
				require "net/http"
				require "openssl"

				uri = URI.parse(server_install_url.to_s)
				http = Net::HTTP.new(uri.host, uri.port)
				http.use_ssl = true if uri.scheme == "https"

				request = Net::HTTP::Post.new(uri.request_uri)
				request["Content-Type"] = "application/json"
				request.body = {
					install_url: client_install_url,
					uninstall_url: client_uninstall_url
				}.to_json

				response = http.request(request)

				# Failed to register with external service
				if !response.kind_of? Net::HTTPSuccess
					raise ::MicroService::Server::InstallError
				end
			end
		end
	end
end