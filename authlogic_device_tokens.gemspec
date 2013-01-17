# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "authlogic_device_tokens/version"

Gem::Specification.new do |s|
  s.name    = %q{authlogic_device_tokens}
  s.version = AuthlogicDeviceTokens::VERSION

  s.authors          = ["Jesus Laiz (aka zheileman)"]
  s.date             = %q{2013-01-17}
  s.description      = %q{Authlogic extension to support multiple per-device and per-user tokens.}
  s.email            = %q{jesus.laiz@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files         = Dir.glob('**/*') - Dir.glob('authlogic_device_tokens*.gem')
  s.homepage      = %q{http://github.com/zheileman/authlogic_device_tokens}
  s.rdoc_options  = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.summary       = %q{Authlogic extension to support multiple per-device and per-user tokens.}

  s.add_runtime_dependency 'authlogic', '~>3.0'

  s.add_development_dependency 'rails', '~>3.0'
  s.add_development_dependency 'sqlite3'
end
