# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cs-rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cs-rails"
  s.version     = CsRails::VERSION
  s.authors     = ["Kadu Diógenes"]
  s.email       = ["kadu.diogenes@fnix.com.br"]
  s.homepage    = "https://github.com/fnix/cs-rails"
  s.summary     = "Not Counter-Strike, country and states for Rails."
  s.description = "Country and state selects for Rails, inspired by carmen-rails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 4.2"
  
  s.add_runtime_dependency "coffee-rails", ">= 4.1"
  s.add_runtime_dependency "countries", ">= 1.2"
  
  s.add_development_dependency "pg", "~> 0.18"
  s.add_development_dependency "haml-rails", "~> 0.9"
  s.add_development_dependency "rspec-rails", "~> 3.4"
end
