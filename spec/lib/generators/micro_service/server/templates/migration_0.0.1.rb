class AddMicroServiceServer001Migration < ActiveRecord::Migration
	def self.up
		create_table :micro_service_servers do |t|
			t.string :client_id
			t.string :secret
			t.string :url
			t.integer :timestamp
			t.boolean :uninstalled
			t.integer :attempt

			t.timestamps null: false
		end
	end

	def self.down
		drop_table :micro_service_servers
	end
end