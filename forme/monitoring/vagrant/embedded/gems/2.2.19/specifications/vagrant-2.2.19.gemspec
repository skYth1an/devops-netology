# -*- encoding: utf-8 -*-
# stub: vagrant 2.2.19 ruby lib

Gem::Specification.new do |s|
  s.name = "vagrant".freeze
  s.version = "2.2.19"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mitchell Hashimoto".freeze, "John Bender".freeze]
  s.date = "2021-11-05"
  s.description = "Vagrant is a tool for building and distributing virtualized development environments.".freeze
  s.email = ["mitchell.hashimoto@gmail.com".freeze, "john.m.bender@gmail.com".freeze]
  s.executables = ["vagrant".freeze]
  s.files = ["bin/vagrant".freeze]
  s.homepage = "https://www.vagrantup.com".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new([">= 2.6".freeze, "< 3.1".freeze])
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Build and distribute virtualized development environments.".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<bcrypt_pbkdf>.freeze, ["~> 1.1"])
    s.add_runtime_dependency(%q<childprocess>.freeze, ["~> 4.1.0"])
    s.add_runtime_dependency(%q<ed25519>.freeze, ["~> 1.2.4"])
    s.add_runtime_dependency(%q<erubi>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<hashicorp-checkpoint>.freeze, ["~> 0.1.5"])
    s.add_runtime_dependency(%q<i18n>.freeze, ["~> 1.8"])
    s.add_runtime_dependency(%q<listen>.freeze, ["~> 3.6"])
    s.add_runtime_dependency(%q<log4r>.freeze, ["~> 1.1.9", "< 1.1.11"])
    s.add_runtime_dependency(%q<mime-types>.freeze, ["~> 3.3"])
    s.add_runtime_dependency(%q<net-ssh>.freeze, [">= 6.1.0", "< 6.2"])
    s.add_runtime_dependency(%q<net-sftp>.freeze, ["~> 3.0"])
    s.add_runtime_dependency(%q<net-scp>.freeze, ["~> 3.0.0"])
    s.add_runtime_dependency(%q<rb-kqueue>.freeze, ["~> 0.2.0"])
    s.add_runtime_dependency(%q<rexml>.freeze, ["~> 3.2"])
    s.add_runtime_dependency(%q<rubyzip>.freeze, ["~> 2.0"])
    s.add_runtime_dependency(%q<vagrant_cloud>.freeze, ["~> 3.0.5"])
    s.add_runtime_dependency(%q<wdm>.freeze, ["~> 0.1.0"])
    s.add_runtime_dependency(%q<winrm>.freeze, [">= 2.3.4", "< 3.0"])
    s.add_runtime_dependency(%q<winrm-elevated>.freeze, [">= 1.2.1", "< 2.0"])
    s.add_runtime_dependency(%q<winrm-fs>.freeze, [">= 1.3.4", "< 2.0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.10.0"])
    s.add_development_dependency(%q<rspec-its>.freeze, ["~> 1.3.0"])
    s.add_development_dependency(%q<fake_ftp>.freeze, ["~> 0.1.1"])
    s.add_development_dependency(%q<webrick>.freeze, ["~> 1.7.0"])
  else
    s.add_dependency(%q<bcrypt_pbkdf>.freeze, ["~> 1.1"])
    s.add_dependency(%q<childprocess>.freeze, ["~> 4.1.0"])
    s.add_dependency(%q<ed25519>.freeze, ["~> 1.2.4"])
    s.add_dependency(%q<erubi>.freeze, [">= 0"])
    s.add_dependency(%q<hashicorp-checkpoint>.freeze, ["~> 0.1.5"])
    s.add_dependency(%q<i18n>.freeze, ["~> 1.8"])
    s.add_dependency(%q<listen>.freeze, ["~> 3.6"])
    s.add_dependency(%q<log4r>.freeze, ["~> 1.1.9", "< 1.1.11"])
    s.add_dependency(%q<mime-types>.freeze, ["~> 3.3"])
    s.add_dependency(%q<net-ssh>.freeze, [">= 6.1.0", "< 6.2"])
    s.add_dependency(%q<net-sftp>.freeze, ["~> 3.0"])
    s.add_dependency(%q<net-scp>.freeze, ["~> 3.0.0"])
    s.add_dependency(%q<rb-kqueue>.freeze, ["~> 0.2.0"])
    s.add_dependency(%q<rexml>.freeze, ["~> 3.2"])
    s.add_dependency(%q<rubyzip>.freeze, ["~> 2.0"])
    s.add_dependency(%q<vagrant_cloud>.freeze, ["~> 3.0.5"])
    s.add_dependency(%q<wdm>.freeze, ["~> 0.1.0"])
    s.add_dependency(%q<winrm>.freeze, [">= 2.3.4", "< 3.0"])
    s.add_dependency(%q<winrm-elevated>.freeze, [">= 1.2.1", "< 2.0"])
    s.add_dependency(%q<winrm-fs>.freeze, [">= 1.3.4", "< 2.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.10.0"])
    s.add_dependency(%q<rspec-its>.freeze, ["~> 1.3.0"])
    s.add_dependency(%q<fake_ftp>.freeze, ["~> 0.1.1"])
    s.add_dependency(%q<webrick>.freeze, ["~> 1.7.0"])
  end
end
