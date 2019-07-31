module DevmakerRailsSdk
  module Generators
    class SetupDeviseGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def setup_devise
        puts "-------------------------------------------------"
        puts "add gem devise"

        gem "devise"
        `spring stop`
        `bundle install`

        puts "-------------------------------------------------"
        puts "run devise install"
        `rails generate devise:install`

        inject_into_file "config/environments/development.rb", after: "config.file_watcher = ActiveSupport::EventedFileUpdateChecker\n" do
          "  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }\n"
        end

        puts "-------------------------------------------------"
        puts "running devise generate user"

        `rails generate devise user`

        puts "-------------------------------------------------"
        p "generate migrations to add coluns to user and admin"

        timestamp1 = (Time.now + 3.hours + 1.seconds).strftime("%Y%m%d%H%M%S")
        template "migrate/add_owner_coluns_to_user.rb", "db/migrate/#{timestamp1}_add_owner_coluns_to_user.rb"

        timestamp2 = (Time.now + 3.hours + 2.seconds).strftime("%Y%m%d%H%M%S")
        template "migrate/create_admins.rb", "db/migrate/#{timestamp2}_create_admins_table.rb"

        `rails db:migrate`

        `rm app/models/user.rb`

        directory "models/", "app/models/"

        gem "devise-i18n"
        `bundle install`
        puts "-------------------------------------------------"
      end
    end
  end
end
