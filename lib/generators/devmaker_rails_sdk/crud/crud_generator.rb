module DevmakerRailsSdk
  module Generators
    class CrudGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)
      argument :params, :type => :array, :default => [], banner: "field:type field:type"

      def generate_crud
        puts "-------------------------------------------------"
        puts "create model #{name.underscore}"

        # `rails g model #{name.underscore} #{params.join(" ")}`
        generate "model  #{name.underscore} #{params.join(" ")}"

        puts "-------------------------------------------------"
        puts "create controller #{name.underscore}"

        template "crud_controller.rb.tt", "app/controllers/admin/#{name.underscore.pluralize}_controller.rb"

        puts "-------------------------------------------------"
        puts "add search for to #{name.underscore}  model"

        inject_into_file "app/models/#{name.underscore.singularize}.rb", before: /^end/ do
          "\n       scope :search_for, -> (string) do
    s = '%\#{string}%'
          where('#{params.split(":")[0]} ilike ?', s) if string.present?
    end \n"
        end

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

      private

      def name_downcase
        name.underscore
      end

      def model_name
        name.singularize.camelize
      end
    end
  end
end
