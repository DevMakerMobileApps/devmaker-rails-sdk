module DevmakerRailsSdk
  module Generators
    class AdminsCrudGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def generate_admin_crud
        puts "Create admins files"

        template "admin_controller.rb", "app/controllers/admin_controller.rb"
        directory "admin/", "app/controllers/admin/"
        directory "views/", "app/views/"

        puts "-------------------------------------------------"
        p "add gem kaminari"
        gem "kaminari"

        puts "-------------------------------------------------"
        p "add routes to admin"
        route "root 'admin/dashboard#index'"

        route "namespace :admin do
      resources :admins
    end\n"

        puts "-------------------------------------------------"
        p "generate kaminari views"

        `rails g kaminari:views bootstrap4`
        `bundle install`

        puts "-------------------------------------------------"
        p "add li to menu"

        inject_into_file "app/views/layouts/admin/_menu.html.erb", before: "</ul>\n" do <<-'RUBY'
        <li class="sidenav-item<%= current_page?(admin_admins_path) ? ' active' : '' %>">
          <%= link_to admin_admins_path, class: "sidenav-link" do %><i class="sidenav-icon fas fa-user-tie"></i><div>Admins</div><% end %>
        </li>
      RUBY         end

        puts "-------------------------------------------------"
        p "add custom login page and image background"

        directory "images/", "app/assets/images/"
        directory "devise/sessions", "app/views/devise/sessions"

        puts "-------------------------------------------------"
        p "add admin seed"

        append_to_file "db/seeds.rb" do
          'Admin.create!({
  name: "Administrador",
  user_attributes: {
    email: "admin@teste.com",
    password: "123456",
  },
})
    '
        end

        `rails db:seed`

        puts "-------------------------------------------------"
        p "add gem test"

        `rm -r test`

        gem_group :development, :test do
          gem "rspec-rails", "~> 3.8"
          gem "factory_bot_rails"
        end

        `bundle install`

        directory "spec/", "spec/"

        template "bin/rspec", "bin/rspec"
        template ".rspec", ".rspec"

        `chmod -R 777 bin/rspec`

        `bundle binstubs bundler --force`
      end
    end
  end
end
