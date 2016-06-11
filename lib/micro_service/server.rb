require "active_support"
require "active_support/dependencies"
require "active_record"

require "micro_service/signed_request/utils"

require "micro_service/server/version"
require "micro_service/server/compatibility"
require "micro_service/server/class_methods"
require "micro_service/server/instance_methods"

require "micro_service/server/exceptions"

module MicroService
	class Server < ::ActiveRecord::Base
	end
end

MicroService::Server.send :include, MicroService::Server::InstanceMethods
MicroService::Server.send :extend, MicroService::Server::ClassMethods