# -*- encoding: utf-8 -*-
# stub: vagrant_cloud 3.0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "vagrant_cloud".freeze
  s.version = "3.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["HashiCorp".freeze, "Cargo Media".freeze]
  s.date = "2021-07-22"
  s.description = "Ruby library for the HashiCorp Vagrant Cloud API".freeze
  s.email = "vagrant@hashicorp.com".freeze
  s.homepage = "https://github.com/hashicorp/vagrant_cloud".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Vagrant Cloud API Library".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<excon>.freeze, ["~> 0.73"])
    s.add_runtime_dependency(%q<log4r>.freeze, ["~> 1.1.10"])
    s.add_runtime_dependency(%q<rexml>.freeze, ["~> 3.2.5"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 12.3"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<webmock>.freeze, ["~> 3.0"])
  else
    s.add_dependency(%q<excon>.freeze, ["~> 0.73"])
    s.add_dependency(%q<log4r>.freeze, ["~> 1.1.10"])
    s.add_dependency(%q<rexml>.freeze, ["~> 3.2.5"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.3"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<webmock>.freeze, ["~> 3.0"])
  end
end
