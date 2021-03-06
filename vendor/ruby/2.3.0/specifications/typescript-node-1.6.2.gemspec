# -*- encoding: utf-8 -*-
# stub: typescript-node 1.6.2 ruby lib

Gem::Specification.new do |s|
  s.name = "typescript-node".freeze
  s.version = "1.6.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["KAWACHI Takashi".freeze]
  s.date = "2015-09-30"
  s.description = "TypeScript ruby interface using Node.js".freeze
  s.email = ["tkawachi@gmail.com".freeze]
  s.homepage = "https://github.com/typescript-ruby/typescript-node-ruby".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "3.0.6".freeze
  s.summary = "TypeScript ruby interface using Node.js".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<typescript-src>.freeze, ["~> 1.6.2"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<typescript-src>.freeze, ["~> 1.6.2"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<typescript-src>.freeze, ["~> 1.6.2"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
