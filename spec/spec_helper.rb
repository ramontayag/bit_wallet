require 'bundler/setup'
APP_ENV = 'test'
Bundler.require(APP_ENV)

require 'bit_wallet'
require 'ostruct'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/hash/slice'
require 'pry'
require 'factory_girl'
require_relative 'factories'
# require 'vcr'

Config = {}
yaml_config_file = File.open(File.join(File.dirname(__FILE__), 'config.yml'))
yaml_config = YAML.load(yaml_config_file).with_indifferent_access
Config[:username] = yaml_config[:rpcuser]
Config[:port] = yaml_config[:rpcport]
Config[:password] = yaml_config[:rpcpassword]

# VCR.configure do |c|
#   c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
#   c.hook_into :webmock
#   c.configure_rspec_metadata!
# end

TESTNET_DIR = File.join(File.dirname(__FILE__), 'testnet')

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    # Ensure that the testnet is running.
    bitcoin_processes = `ps -ef | grep bitcoin | grep -v grep`.split("\n")
    unless bitcoin_processes.size == 2
      fail "Please make sure the testnet has started. Run `cd #{TESTNET_DIR} && make start`"
    end
  end

  config.before(:each) do
    system("cd #{TESTNET_DIR} && make clean > /dev/null")

    # Do not wait for confirmations in tests -- too long!
    BitWallet.config.min_conf = 0
  end
end
