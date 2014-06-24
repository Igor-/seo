$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "redde_seo/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "redde_seo"
  s.version     = ReddeSeo::VERSION
  s.authors     = ["Oleg Bovykin"]
  s.email       = ["oleg.bovykin@gmail.com"]
  s.homepage    = "https://github.com/redde/seo"
  s.summary     = "SEO for redde rails projects"
  s.description = "SEO for redde rails projects"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_dependency 'rails', '>= 3'

  s.add_development_dependency 'pg'
  s.add_development_dependency 'bundler', '~> 1.6'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'redde'
  s.add_development_dependency 'haml-rails'
  s.add_development_dependency 'sass'
  s.add_development_dependency 'jquery-rails'
  s.add_development_dependency 'jquery-ui-rails'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'ffaker'
end
