# -*- encoding: utf-8 -*-
# stub: aws-sdk-applicationautoscaling 1.35.0 ruby lib

Gem::Specification.new do |s|
  s.name = "aws-sdk-applicationautoscaling".freeze
  s.version = "1.35.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/aws/aws-sdk-ruby/tree/master/gems/aws-sdk-applicationautoscaling/CHANGELOG.md", "source_code_uri" => "https://github.com/aws/aws-sdk-ruby/tree/master/gems/aws-sdk-applicationautoscaling" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Amazon Web Services".freeze]
  s.date = "2019-12-04"
  s.description = "Official AWS Ruby gem for Application Auto Scaling. This gem is part of the AWS SDK for Ruby.".freeze
  s.email = ["trevrowe@amazon.com".freeze]
  s.homepage = "https://github.com/aws/aws-sdk-ruby".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "AWS SDK for Ruby - Application Auto Scaling".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<aws-sdk-core>.freeze, ["~> 3", ">= 3.71.0"])
    s.add_runtime_dependency(%q<aws-sigv4>.freeze, ["~> 1.1"])
  else
    s.add_dependency(%q<aws-sdk-core>.freeze, ["~> 3", ">= 3.71.0"])
    s.add_dependency(%q<aws-sigv4>.freeze, ["~> 1.1"])
  end
end
