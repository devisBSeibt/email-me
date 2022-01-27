# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "email_me/version"

Gem::Specification.new do |s|
  s.name        = "email_me"
  s.version     = EmailMe::VERSION
  s.authors     = ["Annie Huddleston"]
  s.email       = ["ahuddleston@devis.com"]
  s.homepage    = "https://github.com/devis/email-me"
  s.summary     = "User customizable emails shared between the apps"
  s.description = "Simple email customization with Markdown and Liquid"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.required_ruby_version = '>= 2.2.4'

  s.add_dependency "rails", ">= 4.2.6"
  s.add_dependency "ace-rails-ap", "~> 4.0.2"
  s.add_dependency "redcarpet", "~> 3.3.4"
  s.add_dependency "liquid", "~> 3.0.6"

  s.add_development_dependency "sqlite3", "~> 1.3.11"
  s.add_development_dependency "minitest", "~> 5.8"
  s.add_development_dependency "simple_form", "~> 3.2.1"
end
