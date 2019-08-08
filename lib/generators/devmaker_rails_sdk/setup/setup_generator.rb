module DevmakerRailsSdk
  module Generators
    class SetupGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def generate_setup
        puts "--------------------------------------------------------------"
        puts "create database"
        `rails db:create`
        puts "--------------------------------------------------------------"
        puts "run admin_template"
        generate "admin_template"
        puts "--------------------------------------------------------------"
        puts "run devise_setup"
        generate "setup_devise"
        puts "--------------------------------------------------------------"
        puts "run admins_crud"
        generate "admins_crud"
        puts "--------------------------------------------------------------"
        puts " run `rails s` to start your local server"
        puts " then open http://localhost:3000"
        puts " sign in using credentials:"
        puts ""
        puts "     admin@teste.com"
        puts "     123456"
        puts ""
        puts "--------------------------------------------------------------"
      end
    end
  end
end
