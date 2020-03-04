# -*- encoding: utf-8 -*-
# stub: bootstrap-popover-rails 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "bootstrap-popover-rails".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://rubygems.org" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["\u0141ukasz W\u00F3jcik".freeze]
  s.bindir = "exe".freeze
  s.date = "2015-12-18"
  s.description = "This gem provides easy way to use twitter bootstrap popover with your Rails application".freeze
  s.email = ["sonar0007@hotmail.com".freeze]
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Bootstrap popover for Rails applications".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.10"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.10"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end
