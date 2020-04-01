# -*- encoding: utf-8 -*-
# stub: hitimes 2.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "hitimes"
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jeremy Hinegardner"]
  s.date = "2019-09-23"
  s.description = "A fast, high resolution timer library for recording peformance metrics. * (http://github.com/copiousfreetime/hitimes) * (http://github.com/copiousfreetime/hitimes) * email jeremy at copiousfreetime dot org * `git clone url git://github.com/copiousfreetime/hitimes.git`"
  s.email = "jeremy@copiousfreetime.org"
  s.extra_rdoc_files = ["CONTRIBUTING.md", "HISTORY.md", "Manifest.txt", "README.md"]
  s.files = ["CONTRIBUTING.md", "HISTORY.md", "Manifest.txt", "README.md"]
  s.homepage = "http://github.com/copiousfreetime/hitimes"
  s.licenses = ["ISC"]
  s.rdoc_options = ["--main", "README.md", "--markup", "tomdoc"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.2")
  s.rubygems_version = "2.5.1"
  s.summary = "A fast, high resolution timer library for recording peformance metrics."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, ["~> 12.3"])
      s.add_development_dependency(%q<minitest>, ["~> 5.5"])
      s.add_development_dependency(%q<rdoc>, ["~> 6.2"])
      s.add_development_dependency(%q<json>, ["~> 2.2"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.17"])
    else
      s.add_dependency(%q<rake>, ["~> 12.3"])
      s.add_dependency(%q<minitest>, ["~> 5.5"])
      s.add_dependency(%q<rdoc>, ["~> 6.2"])
      s.add_dependency(%q<json>, ["~> 2.2"])
      s.add_dependency(%q<simplecov>, ["~> 0.17"])
    end
  else
    s.add_dependency(%q<rake>, ["~> 12.3"])
    s.add_dependency(%q<minitest>, ["~> 5.5"])
    s.add_dependency(%q<rdoc>, ["~> 6.2"])
    s.add_dependency(%q<json>, ["~> 2.2"])
    s.add_dependency(%q<simplecov>, ["~> 0.17"])
  end
end
