$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "devmaker_rails_sdk/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "devmaker_rails_sdk"
  s.version = DevmakerRailsSdk::VERSION
  s.authors = ["Rudiney Franceschi"]
  s.email = ["rudi.atp@gmail.com"]
  s.homepage = "https://bitbucket.org/RudineyFranceschi/devmaker_rails_sdk"
  s.summary = "DevmakerRailsSdk"
  s.description = "DevmakerRailsSdk"
  s.license = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.1"

  s.add_development_dependency "sqlite3"
end
