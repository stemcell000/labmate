# -*- encoding: utf-8 -*-
# stub: countries 3.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "countries"
  s.version = "3.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Josh Robinson", "Joe Corcoran", "Russell Osborne"]
  s.date = "2020-02-11"
  s.description = "All sorts of useful information about every country packaged as pretty little country objects. It includes data from ISO 3166"
  s.email = ["hexorx@gmail.com", "russell@burningpony.com"]
  s.homepage = "http://github.com/hexorx/countries"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "Gives you a country object full of all sorts of useful information."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<i18n_data>, ["~> 0.10.0"])
      s.add_runtime_dependency(%q<unicode_utils>, ["~> 1.4"])
      s.add_runtime_dependency(%q<sixarm_ruby_unaccent>, ["~> 1.1"])
      s.add_development_dependency(%q<rspec>, [">= 3"])
      s.add_development_dependency(%q<activesupport>, [">= 3"])
      s.add_development_dependency(%q<nokogiri>, [">= 1.8"])
    else
      s.add_dependency(%q<i18n_data>, ["~> 0.10.0"])
      s.add_dependency(%q<unicode_utils>, ["~> 1.4"])
      s.add_dependency(%q<sixarm_ruby_unaccent>, ["~> 1.1"])
      s.add_dependency(%q<rspec>, [">= 3"])
      s.add_dependency(%q<activesupport>, [">= 3"])
      s.add_dependency(%q<nokogiri>, [">= 1.8"])
    end
  else
    s.add_dependency(%q<i18n_data>, ["~> 0.10.0"])
    s.add_dependency(%q<unicode_utils>, ["~> 1.4"])
    s.add_dependency(%q<sixarm_ruby_unaccent>, ["~> 1.1"])
    s.add_dependency(%q<rspec>, [">= 3"])
    s.add_dependency(%q<activesupport>, [">= 3"])
    s.add_dependency(%q<nokogiri>, [">= 1.8"])
  end
end
