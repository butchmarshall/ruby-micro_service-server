require "generators/micro_service/server/add_on_generator"
require "generators/micro_service/server/next_migration_version"
require "rails/generators/migration"
require "rails/generators/active_record"

# Extend the HasDynamicColumnsGenerator so that it creates an AR migration
module MicroService
	class Server < ::ActiveRecord::Base
		class ActiveRecordGenerator < ::Jive::AddOn::Generator
			include Rails::Generators::Migration
			extend NextMigrationVersion

			source_paths << File.join(File.dirname(__FILE__), "templates")

			def create_migration_file
				migration_template "migration_0.0.1.rb", "db/migrate/add_micro_service_server_0_0_1_migration.rb"
			end

			def self.next_migration_number(dirname)
				::ActiveRecord::Generators::Base.next_migration_number dirname
			end
		end
	end
end