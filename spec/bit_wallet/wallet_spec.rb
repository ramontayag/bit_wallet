require 'spec_helper'

module BitWallet
  describe Wallet, vcr: {record: :once}, bitcoin_cleaner: true do

    describe '#accounts' do
      it 'should return array of BitWallet::Accounts' do
        wallet = build(:wallet)
        wallet.accounts.should be_kind_of(Accounts)
      end
    end

    describe '#recent_transactions' do
      it 'should return the most recent transactions of all accounts defaulting to 10 transactions' do
        wallet = build(:wallet)
        default_account = wallet.accounts.new('')
        account_1 = wallet.accounts.new('1')

        1.upto(11).each do |n|
          default_account.send_amount 0.1, to: account_1.addresses.first
        end

        wallet.recent_transactions.size.should == 10
      end

      it 'should allow overriding of the transaction limit' do
        wallet = build(:wallet)
        default_account = wallet.accounts.new('')
        account_1 = wallet.accounts.new('1')

        1.upto(11).each do |n|
          default_account.send_amount 0.1, to: account_1.addresses.first
        end

        wallet.recent_transactions(limit: 5).size.should == 5
      end
    end

    describe '#move' do
      it 'should move funds from one account to another' do
        wallet = build(:wallet)
        default_account = wallet.accounts.new('')
        account_1 = wallet.accounts.new('1')
        wallet.move '', '1', 1.1
        wallet.move default_account, account_1, 0.5
        account_1.balance.should == 1.6
      end
    end

    describe "#client" do
      it "returns the client created by InstantiatesBitcoinClient" do
        client = double
        config = {some: "config"}
        allow(InstantiatesBitcoinClient).
          to receive(:execute).with(config).
          and_return(client)

        wallet = described_class.new(config)

        expect(wallet.client).to eq(client)
      end
    end

  end
end
