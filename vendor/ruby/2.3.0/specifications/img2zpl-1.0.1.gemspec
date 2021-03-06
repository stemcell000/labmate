# -*- encoding: utf-8 -*-
# stub: img2zpl 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "img2zpl".freeze
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Michael King".freeze]
  s.date = "2019-11-05"
  s.description = "Ruby library to convert images to usable & printable ZPL code".freeze
  s.email = "mtking1123@gmail.com".freeze
  s.homepage = "https://github.com/mtking2/img2zpl".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.6".freeze
  s.summary = "Convert images to ZPL".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mini_magick>.freeze, ["~> 4.9"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 13"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.9"])
    else
      s.add_dependency(%q<mini_magick>.freeze, ["~> 4.9"])
      s.add_dependency(%q<rake>.freeze, ["~> 13"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.9"])
    end
  else
    s.add_dependency(%q<mini_magick>.freeze, ["~> 4.9"])
    s.add_dependency(%q<rake>.freeze, ["~> 13"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.9"])
  end
end
