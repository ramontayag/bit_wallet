require 'spec_helper'

describe BitWallet::Transaction, vcr: {record: :once}, bitcoin_cleaner: true do

  describe 'on initialization' do
    it 'should be able to take a bitcoind hash' do
      wallet = build(:wallet)
      account = wallet.accounts.new('numba')
      address = account.addresses.new('mi3G43CcN')
      args = {"account" => 'numba',
              "address" => "mi3G43CcN",
              "category" => "receive",
              "amount" => 1.5,
              "confirmations" => 0,
              "txid" => "a363e027",
              "time" => 1362239334,
              "timereceived" => 1362239346}
      transaction = described_class.new(wallet, args)
      transaction.account.should == account
      transaction.address.should == address
      transaction.category.should == 'receive'
      transaction.amount.should == 1.5
      transaction.confirmations.should == 0
      transaction.id.should == 'a363e027'
      transaction.occurred_at.to_i.should == 1362239334
      transaction.received_at.to_i.should == 1362239346
    end
  end

end
