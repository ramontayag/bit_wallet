# v0.7.6

- Fix problem with `Wallet#recent_transactions` when connected to blockchain.info

# v0.7.5

- Fix bug with `Account#recent_transactions`

# v0.7.4

- `listtransactions` of blockchain.info returns a differently formatted result - work around it

# v0.7.3

- [#3](https://github.com/ramontayag/bit_wallet/issues/3): no longer fetch list of accounts during initialization

# v0.7.2

- Raise error when an account name is nil
- Use BitcoinCleaner over BitcoinTestnet to facilitate cleaning of bitcoin daemon

# v0.7.1

- Fix issue where an undefined `BitWallet.min_conf` was causing an exception to be raised. Defaults it to 0.

# v0.7.0

- `min_conf` is configurable directly via `BitWallet.min_conf` instead of `BitWallet.config.min_conf`

# v0.6.1

- Fix warning where Wallet#client was being accessed but it was private

# v0.6.0

- Handle error -6 (invalid address)

# v0.5.0

- Allow to set the host, and ssl (true/false) of Bitcoin client
- Remove version constraint on activesupport
