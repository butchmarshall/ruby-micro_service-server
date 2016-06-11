require "active_record"

module MicroService
	class Server < ::ActiveRecord::Base
		# Raise if failed contact server about installation
		class InstallError < StandardError; end
	end
end
	