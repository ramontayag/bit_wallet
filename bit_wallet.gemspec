# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bit_wallet/version'

Gem::Specification.new do |gem|
  gem.name          = "bit_wallet"
  gem.version       = BitWallet::VERSION
  gem.authors       = ["TODO: Write your name"]
  gem.email         = ["TODO: Write your email address"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'bitcoin-client', '0.0.1'
  gem.add_dependency 'activesupport', '3.2.11'
  gem.add_development_dependency 'rspec', '2.12.0'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'factory_girl', '4.2.0'
end
