module MicroService
	class Server < ActiveRecord::Base
		class Configuration
			attr_accessor :url

			def initialize
				@url = nil
			end
		end
	end	
end