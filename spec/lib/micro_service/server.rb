require "active_support"
require "active_support/dependencies"
require "active_record"

require "micro_service/server/version"
require "micro_service/server/compatibility"
require "micro_service/server/class_methods"
require "micro_service/server/instance_methods"

module MicroService
	class Server < ::ActiveRecord::Base
	end
end

MicroService::Server.send :include, MicroService::Server::InstanceMethods
MicroService::Server.send :extend, MicroService::Server::ClassMethods