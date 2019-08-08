module DevmakerRailsSdk
  module Generators
    class UserModelGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)
      argument :params, :type => :array, :default => []

      def user_model
        puts "-------------------------------------------------"
        puts "create model #{name.underscore}"

        `rails g model #{name.underscore} #{params.join(" ")}`

        `rm app/models/#{name.underscore}.rb`

        template "model.rb", "app/models/#{name.underscore}.rb"
        gsub_file "app/models/#{name.underscore}.rb", "MODELNAME", "#{model_name}"

        puts "-------------------------------------------------"
        puts "add relation on user model"

        inject_into_file "app/models/user.rb", before: /^end/ do
          "  def #{name.underscore}?
       owner&.is_a?(#{model_name})
    end
  "
        end

        inject_into_file "app/models/user.rb", after: 'scope :admins, -> { where(owner_type: "Admin") }' do
          "\n  scope :#{name.underscore.pluralize}, -> { where(owner_type: '#{model_name}') }"
        end

        puts "-------------------------------------------------"
        puts "add test to user_spec.rb"

        inject_into_file "spec/models/user_spec.rb", before: /^end/ do
          "
    it 'has a #{name.underscore}? scope' do
      #{name.underscore} = FactoryBot.create(:#{name.underscore})
      #{name.underscore} = FactoryBot.create(:user, owner: #{name.underscore})

      expect(#{name.underscore}).to be_#{name.underscore}
      expect(User.#{name.underscore.pluralize}).to include(#{name.underscore})
    end\n"
        end

        puts "-------------------------------------------------"
        if yes?("Would you like to list this user on admin panel? y or n (default n)")
          puts "create controller #{name.underscore}"

          template "crud_controller.rb.tt", "app/controllers/admin/#{name.underscore.pluralize}_controller.rb"

          puts "-------------------------------------------------"
          puts "add routes to  #{name}"

          inject_into_file "config/routes.rb", after: "namespace :admin do" do
            "\n       resources :#{name.underscore.pluralize}"
          end

          puts "-------------------------------------------------"
          puts "add #{name} to menu"

          inject_into_file "app/views/layouts/admin/_menu.html.erb", before: "</ul>\n" do
            "  <li class=\"sidenav-item<%= current_page?(admin_#{name.underscore.pluralize}_path) ? ' active' : '' %>\">
            <%= link_to admin_#{name.underscore.pluralize}_path, class: \"sidenav-link\" do %><i class=\"sidenav-icon fas fa-align-justify\"></i><div>#{name.titleize.pluralize}</div><% end %>
        </li>"
          end

          puts "-------------------------------------------------"
          puts "create views to #{name}"

          template "crud_views/index.html.erb.tt", "app/views/admin/#{name.underscore.pluralize}/index.html.erb"
          template "crud_views/_form.html.erb.tt", "app/views/admin/#{name.underscore.pluralize}/_form.html.erb"
          template "crud_views/new.html.erb.tt", "app/views/admin/#{name.underscore.pluralize}/new.html.erb"
          template "crud_views/edit.html.erb.tt", "app/views/admin/#{name.underscore.pluralize}/edit.html.erb"
          template "crud_views/show.html.erb.tt", "app/views/admin/#{name.underscore.pluralize}/show.html.erb"
        end
      end

      private

      def model_name
        name.camelize
      end

      def name_downcase
        name.underscore
      end
    end
  end
end
