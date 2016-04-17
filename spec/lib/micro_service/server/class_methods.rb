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
		end
	end
end