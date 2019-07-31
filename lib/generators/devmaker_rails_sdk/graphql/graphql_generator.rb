module DevmakerRailsSdk
  module Generators
    class GraphqlGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def generate_graphql
        puts "-------------------------------------------------"
        puts "add gem graphql"
        gem "graphql"
        `bundle install`

        puts "-------------------------------------------------"
        puts "generate public schema"
        `bin/rails generate graphql:install --schema=PublicSchema`

        `rm app/controllers/graphql_controller.rb`
        `rm -r app/graphql/`
        directory "concerns/", "app/controllers/concerns"
        directory "public/", "app/controllers/public"
        directory "graphql/", "app/graphql"

        gsub_file "Gemfile", "gem 'graphiql-rails', group: :development", "gem 'graphiql-rails'"

        puts "-------------------------------------------------"
        puts "change graphql routes"
        `bundle install`

        gsub_file "config/routes.rb", 'if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"', 'mount(GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql") unless Rails.env.production?
  post "/graphql", to: "public/graphql#execute"'

        directory "admin/", "app/views/admin/"
        route 'get "redirect", action: :redirect, controller: "admin"'
      end
    end
  end
end
