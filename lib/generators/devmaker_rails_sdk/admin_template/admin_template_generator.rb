module DevmakerRailsSdk
  module Generators
    class AdminTemplateGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def admin_template
        p "--------------------------------------------------------------"

        p "add template dependencies to gemfile"

        gem "bootstrap_form", ">= 4.0.0.alpha1"
        gem "jquery-rails"

        p "--------------------------------------------------------------"

        append_to_file "config/initializers/assets.rb" do
          "\nRails.application.config.assets.precompile += %w( admin.js admin.css blank.css blank.js pages/authentication.css )
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets')\n"
        end

        p "--------------------------------------------------------------"

        p "add assets folder to vendor"
        directory "assets/", "vendor/assets/"

        p "--------------------------------------------------------------"

        p "add layouts to admin"
        directory "layout_admin/", "app/views/layouts/admin"

        `rm app/views/layouts/application.html.erb`

        directory "layouts/", "app/views/layouts/"

        p "--------------------------------------------------------------"

        p "add dependencies to package.json"

        `npm i --save jquery popper.js`
        `rm package-lock.json`

        `yarn add bootstrap@4.1.1`
        `yarn add bootstrap-multiselect@0.9.13-1`
        `yarn add bootstrap-select@1.13.1`
        `yarn add bootstrap-table@1.12.1`
        `yarn add jquery.growl@1.3.5`
        `yarn add perfect-scrollbar@1.4.0`
        `yarn add select2@4.0.6-rc.1`

        p "--------------------------------------------------------------"

        p "run bundle install and yarn install"

        `bundle install`
        `yarn install`

        p "--------------------------------------------------------------"
        p "Create blank.js and blank.css"
        template "blank.js", "app/assets/javascripts/blank.js"
        template "blank.css", "app/assets/stylesheets/blank.css"

        p "--------------------------------------------------------------"

        p "Create Admin.js and Admin.css and Menu.js"
        template "menu.js", "app/assets/javascripts/admin/menu.js"
        template "layout_admin.js", "app/assets/javascripts/admin.js"
        template "layout_admin.css", "app/assets/stylesheets/admin.css"
      end
    end
  end
end
