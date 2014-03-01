require 'spec_helper'

describe BitWallet::Accounts, vcr: {record: :once} do

  let(:wallet) do
    build(:wallet)
  end

  subject do
    BitWallet::Accounts.new(wallet)
  end

  its(:wallet) { should == wallet }

  describe '#new' do
    it 'should create a new BitWallet::Account with a default address' do
      account = wallet.accounts.new('accountname')
      account.should be_kind_of(BitWallet::Account)
      account.addresses.count.should == 1
    end
  end

  describe '#includes_account_name?(account)' do
    it 'should return true if the array includes the account' do
      account = subject.new('accountname')
      subject.includes_account_name?('accountname').should == true
    end
  end

  describe '.with_balance' do
    it 'should return accounts with a balance > 0' do
      default_account = subject.new('')
      account_1 = subject.new('nomoney')
      account_2 = subject.new('moneyd')

      default_account.send_amount 10, to: account_2.addresses.first

      accounts_with_balance = subject.with_balance
      accounts_with_balance.should include(default_account)
      accounts_with_balance.should_not include(account_1)
      accounts_with_balance.should include(account_2)
    end
  end

end
