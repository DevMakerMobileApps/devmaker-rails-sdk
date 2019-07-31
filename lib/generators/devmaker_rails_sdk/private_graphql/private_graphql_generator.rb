module DevmakerRailsSdk
  module Generators
    class PrivateGraphqlGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)
      argument :params, :type => :array, :default => []

      def private_graphql
        if !File.exist?("./app/models/#{name.underscore}.rb")
          error_string
          puts "To generate a private graphql you need create a user_model"
          puts "run `rails g user_model #{name} example:string` to generate user model"
          puts "then run `rails g private_graphql #{name}`"
          puts "\n-------------------------------------------------"
          return
        end

        puts "-------------------------------------------------"
        puts "create controller file"
        directory "user/", "app/controllers/#{name.underscore}"
        template "user_controller.rb", "app/controllers/#{name.underscore}_controller.rb"
        gsub_file "app/controllers/#{name.underscore}_controller.rb", "DOWNUSERNAME", "#{name.underscore}"
        gsub_file "app/controllers/#{name.underscore}_controller.rb", "USERNAME", "#{name.camelize}"
        gsub_file "app/controllers/#{name.underscore}/graphql_controller.rb", "DOWNUSERNAME", "#{name.underscore}"
        gsub_file "app/controllers/#{name.underscore}/graphql_controller.rb", "USERNAME", "#{name.camelize}"

        puts "-------------------------------------------------"
        puts "create schema file"
        template "graphql/user_schema.rb", "app/graphql/#{name.underscore}_schema.rb"
        gsub_file "app/graphql/#{name.underscore}_schema.rb", "USERNAME", "#{name.camelize}"
        puts "-------------------------------------------------"

        puts "create graphiql files"
        directory "graphql/mutations/user_mutations/", "app/graphql/mutations/#{name.underscore}_mutations"
        directory "graphql/types/user/", "app/graphql/types/#{name.underscore}"
        gsub_file "app/graphql/types/#{name.underscore}/mutation_type.rb", "USERNAME", "#{name.camelize}"
        gsub_file "app/graphql/types/#{name.underscore}/query_type.rb", "DOWNUSERNAME", "#{name.underscore}"
        gsub_file "app/graphql/types/#{name.underscore}/query_type.rb", "USERNAME", "#{name.camelize}"

        template "graphql/types/models/user_type.rb", "app/graphql/types/models/#{name.underscore}_type.rb"
        gsub_file "app/graphql/types/models/#{name.underscore}_type.rb", "USERNAME", "#{name.camelize}"
        puts "-------------------------------------------------"

        puts "create route graphql"
        route "  mount(GraphiQL::Rails::Engine, at: '#{name.underscore}/graphiql', graphql_path: '/#{name.underscore}/graphql', as: :#{name.underscore}_graphiql_rails) unless Rails.env.production?
  post '/#{name.underscore}/graphql', to: '#{name.underscore}/graphql#execute'\n"
        puts "-------------------------------------------------"
      end

      private

      def error_string
        puts "\n-----------------------------------------------------------\n\n"
        puts " ██████╗██████╗ ███████╗ █████╗ ████████╗███████╗    ████████╗██╗  ██╗███████╗    ███╗   ███╗ ██████╗ ██████╗ ███████╗██╗
██╔════╝██╔══██╗██╔════╝██╔══██╗╚══██╔══╝██╔════╝    ╚══██╔══╝██║  ██║██╔════╝    ████╗ ████║██╔═══██╗██╔══██╗██╔════╝██║
██║     ██████╔╝█████╗  ███████║   ██║   █████╗         ██║   ███████║█████╗      ██╔████╔██║██║   ██║██║  ██║█████╗  ██║
██║     ██╔══██╗██╔══╝  ██╔══██║   ██║   ██╔══╝         ██║   ██╔══██║██╔══╝      ██║╚██╔╝██║██║   ██║██║  ██║██╔══╝  ██║
╚██████╗██║  ██║███████╗██║  ██║   ██║   ███████╗       ██║   ██║  ██║███████╗    ██║ ╚═╝ ██║╚██████╔╝██████╔╝███████╗███████╗
 ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝       ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚═╝     ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝"
        puts "-----------------------------------------------------------\n\n"
      end
    end
  end
end
