# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bit_wallet/version'

Gem::Specification.new do |gem|
  gem.name          = "bit_wallet"
  gem.version       = BitWallet::VERSION
  gem.authors       = ["Ramon Tayag"]
  gem.email         = ["ramon.tayag@gmail.com"]
  gem.description   = %q{Ruby-esque handling of Bitcoin wallet}
  gem.summary       = %q{Ruby-esque handling of Bitcoin wallet.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'bitcoin-client', '0.0.1'
  gem.add_dependency 'activesupport', '~> 3.0'
  gem.add_development_dependency 'rspec', '2.12.0'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'factory_girl', '4.2.0'
  gem.add_development_dependency 'bitcoin_testnet', '0.4.0'
  gem.add_development_dependency 'vcr', '2.4.0'
  gem.add_development_dependency 'webmock', '1.9.0'
end
