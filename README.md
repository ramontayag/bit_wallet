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
    # You can also pass :port, :host, :ssl (Boolean)

    wallet.accounts.with_balance # returns array of the accounts with balance > 0
    account = wallet.accounts.new('account name')
    account.addresses.count # 1, as it already comes with an address
    account.balance # returns the balance of the account
    address = account.addresses.new
    address.address # 8hdsakdjh82d9327ccb64642c - the address hash
    account.send_amount 5.5, to: '8hdsakdjh82d9327ccb64642c' # sends 5.5 bitcoin to the address
    account.send_amount 5.5, to: address # sends 5.5 bitcoin to the BitWallet::Address#address
    account.send_many '8hdsakdjh82d9327ccb64642c' => 2.21, address => 0.332
    wallet.move 'accountname', 'toanotheraccount', 2.1
    wallet.move account_object, another_account_object, 1.1
    account.total_received # returns the total amount received by the account
    account.transactions # returns array of 10 BitWallet::Transaction
    account.transactions(limit: 5) # returns array of 5 BitWallet::Transaction
    address.total_received # returns the total amount received by the address

### Transaction

A transaction has the following methods:

- `account`: the account it belongs to
- `address`: the address it belongs to
- `amount`: how much was transferred
- `category`: returns the category value of the transaction
- `confirmations`: how many times this has been confirmed by the network
- `id`: the transaction id
- `occurred_at`: Ruby Time object for the `time` value returned by bitcoind
- `received_at`: Ruby Time object for the `timereceived` value returned by bitcoind

## Tests

- You must set up bitcoind, and it must be in the executable path. See README.txt in `spec/testnet` as to what version to install.

## Contributing

I suggest you do your development in this [Vagrant box](https://github.com/ramontayag/ruby-bitcoin-box). I use it for my development.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

If you find this useful, consider sharing some BTC love: `1PwQWijmJ39hWXk9X3CdAhEdExdkANEAPk`
