require 'bundler/setup'
APP_ENV = 'test'
Bundler.require(:default, APP_ENV)

require 'bit_wallet'
require 'ostruct'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/hash/slice'
require 'pry'
require 'factory_girl'
require_relative 'factories'
require 'bitcoin_cleaner'
require 'vcr'
require 'webmock'

Config = {}
yaml_config_file = File.open(File.join(File.dirname(__FILE__), 'config.yml'))
yaml_config = YAML.load(yaml_config_file).with_indifferent_access
Config[:username] = yaml_config[:rpcuser]
Config[:port] = yaml_config[:rpcport]
Config[:password] = yaml_config[:rpcpassword]

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

BitcoinCleaner.configure_with_rspec_and_vcr!
BitcoinCleaner.dir = yaml_config.fetch(:bitcoin_dir)

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:each) do
    BitWallet.min_conf = 0
  end

  config.order = "random"
end
