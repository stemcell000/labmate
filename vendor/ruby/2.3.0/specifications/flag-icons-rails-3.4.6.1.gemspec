# -*- encoding: utf-8 -*-
# stub: flag-icons-rails 3.4.6.1 ruby lib

Gem::Specification.new do |s|
  s.name = "flag-icons-rails"
  s.version = "3.4.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Evgeny Garlukovich"]
  s.date = "2020-03-20"
  s.description = "Gem allows to use `flag-icon-css` - a collection of all country flags in SVG - in your Rails projects"
  s.email = ["evgeny.garlukovich@gmail.com"]
  s.homepage = "https://github.com/evgenygarl/flag-icons-rails"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0")
  s.rubygems_version = "2.5.1"
  s.summary = "Gem to use `flag-icon-css` library in your Rails projects"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sass-rails>, [">= 0"])
      s.add_development_dependency(%q<railties>, ["< 6", ">= 3.2"])
      s.add_development_dependency(%q<activesupport>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<minitest>, ["~> 5.10.0"])
      s.add_development_dependency(%q<minitest-have_tag>, ["~> 0.1.0"])
      s.add_development_dependency(%q<minitest-emoji>, ["~> 2.0.0"])
      s.add_development_dependency(%q<yard>, ["~> 0.9.5"])
      s.add_development_dependency(%q<rubocop>, ["~> 0.50.0"])
    else
      s.add_dependency(%q<sass-rails>, [">= 0"])
      s.add_dependency(%q<railties>, ["< 6", ">= 3.2"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<minitest>, ["~> 5.10.0"])
      s.add_dependency(%q<minitest-have_tag>, ["~> 0.1.0"])
      s.add_dependency(%q<minitest-emoji>, ["~> 2.0.0"])
      s.add_dependency(%q<yard>, ["~> 0.9.5"])
      s.add_dependency(%q<rubocop>, ["~> 0.50.0"])
    end
  else
    s.add_dependency(%q<sass-rails>, [">= 0"])
    s.add_dependency(%q<railties>, ["< 6", ">= 3.2"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<minitest>, ["~> 5.10.0"])
    s.add_dependency(%q<minitest-have_tag>, ["~> 0.1.0"])
    s.add_dependency(%q<minitest-emoji>, ["~> 2.0.0"])
    s.add_dependency(%q<yard>, ["~> 0.9.5"])
    s.add_dependency(%q<rubocop>, ["~> 0.50.0"])
  end
end
