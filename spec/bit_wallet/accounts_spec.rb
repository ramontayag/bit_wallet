require 'spec_helper'

describe BitWallet::Accounts do

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

end
