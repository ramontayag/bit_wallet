require 'spec_helper'

module BitWallet
  describe Accounts, vcr: {record: :once}, bitcoin_cleaner: true do

    let(:wallet) do
      build(:wallet)
    end

    subject do
      Accounts.new(wallet)
    end

    its(:wallet) { should == wallet }

    describe '#new' do
      it 'should create a new BitWallet::Account with a default address' do
        account = wallet.accounts.new('accountname')
        account.should be_kind_of(Account)
        account.addresses.count.should == 1
      end
    end

    describe '.with_balance' do
      it 'should return accounts with a balance > 0' do
        default_account = subject.new('')
        account_1 = subject.new('nomoney')
        account_2 = subject.new('moneyd')

        default_account.send_amount 5, to: account_2.addresses.first

        accounts_with_balance = subject.with_balance
        accounts_with_balance.should include(default_account)
        accounts_with_balance.should_not include(account_1)
        accounts_with_balance.should include(account_2)
      end
    end

  end
end
