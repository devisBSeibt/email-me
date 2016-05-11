# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "email_me/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "email_me"
  s.version     = EmailMe::VERSION
  s.authors     = ["Annie Huddleston"]
  s.email       = ["ahuddleston@devis.com"]
  s.homepage    = "https://www.devis.com"
  s.summary     = "User customizable emails shared between the apps"
  s.description = "Fun email customization"
  s.license     = "MIT"

  # s.files         = `git ls-files`.split("\n")
  s.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.6"
  s.add_dependency "ace-rails-ap", "~> 4.0.2"
  s.add_dependency "redcarpet", "~> 3.3.4"
  s.add_dependency "liquid", "~> 3.0.6"

  s.add_development_dependency "sqlite3"
end
