# BitWallet

BitWallet is a Ruby-esque interface to a bitcoin daemon. It uses the [bitcoin-client](https://github.com/sinisterchipmunk/bitcoin-client) gem to execute the RPC calls to the daemon.

## Installation

Add this line to your application's Gemfile:

    gem 'bit_wallet'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bit_wallet

## Usage

    wallet = BitWallet.new(:username => 'username', :password => 'password')
    account = wallet.accounts.new('account name')
    account.addresses.count # 1, as it already comes with an address
    address = account.addresses.new
    address.address # 8hdsakdjh82d9327ccb64642c - the address hash

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
