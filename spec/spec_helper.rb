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
require 'bitcoin_testnet'

Config = {}
yaml_config_file = File.open(File.join(File.dirname(__FILE__), 'config.yml'))
yaml_config = YAML.load(yaml_config_file).with_indifferent_access
Config[:username] = yaml_config[:rpcuser]
Config[:port] = yaml_config[:rpcport]
Config[:password] = yaml_config[:rpcpassword]

BitcoinTestnet.configure_rspec!
BitcoinTestnet.dir = File.join(File.dirname(__FILE__), 'testnet')

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:each) do
    BitWallet.config.min_conf = 0
  end
end
