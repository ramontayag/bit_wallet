require "bit_wallet/version"
require 'ostruct'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/hash/slice'
require 'active_support/core_ext/string'
require 'bitcoin'

require 'bit_wallet/wallet'
require 'bit_wallet/account'
require 'bit_wallet/accounts'
require 'bit_wallet/addresses'
require 'bit_wallet/address'
require 'bit_wallet/transaction'
require 'bit_wallet/errors'
require 'bit_wallet/instantiates_bitcoin_client'
require 'bit_wallet/handles_error'

module BitWallet

  mattr_accessor :config
  @@config = OpenStruct.new

  def self.at(*args)
    Wallet.new(*args)
  end

  def self.initialize(*args)
    Wallet.new(*args)
  end

end
