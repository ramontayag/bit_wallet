require 'spec_helper'

describe BitWallet::Wallet do

  describe '#accounts' do
    it 'should return array of BitWallet::Accounts' do
      wallet = build(:wallet)
      wallet.accounts.should be_kind_of(BitWallet::Accounts)
    end
  end

  describe '#recent_transactions' do
    it 'should return the most recent transactions of all accounts defaulting to 10 transactions' do
      wallet = build(:wallet)
      default_account = wallet.accounts.new('')
      account_1 = wallet.accounts.new('1')

      1.upto(11).each do |n|
        default_account.send_amount n, to: account_1.addresses.first
      end

      wallet.recent_transactions.size.should == 10
    end

    it 'should allow overriding of the transaction limit' do
      pending "Fix when bitcoin-client this is resolved: https://github.com/sinisterchipmunk/bitcoin-client/issues/4"
      wallet = build(:wallet)
      default_account = wallet.accounts.new('')
      account_1 = wallet.accounts.new('1')

      1.upto(11).each do |n|
        default_account.send_amount n, to: account_1.addresses.first
      end

      wallet.recent_transactions(limit: 5).size.should == 5
    end
  end

end
