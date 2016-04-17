module MicroService
	class Server < ::ActiveRecord::Base
		module InstanceMethods
			def self.included(base)
				base.table_name = "micro_service_servers"
			end
		end
	end
end