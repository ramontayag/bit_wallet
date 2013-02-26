require 'spec_helper'

describe BitWallet::Account do

  let(:wallet) { build(:wallet) }
  subject { described_class.new(wallet, 'name') }

  its(:wallet) {should == wallet}
  its(:addresses) { should be_kind_of(BitWallet::Addresses) }

  describe 'on initialization' do
    it 'should have a default name' do
      subject.name.should_not be_blank
      subject.name.should be_kind_of(String)
    end

    it 'should be assigned that name' do
      wallet = BitWallet::Wallet.new(Config.slice(:username,
                                                  :port,
                                                  :password))
      account = wallet.accounts.new('nona')

      wallet.accounts.includes_account_name?('nona').should be_true
    end

    context 'when the account name already exists' do
      it 'should return that same address' do
        wallet = BitWallet::Wallet.new(Config.slice(:username,
                                                    :port,
                                                    :password))
        account = wallet.accounts.new('nona')

        expect {
          wallet.accounts.new('nona')
        }.to_not change(wallet.accounts, :size)
      end
    end
  end

end
