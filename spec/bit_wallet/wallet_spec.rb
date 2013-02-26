require 'spec_helper'

describe BitWallet::Wallet do

  describe '#accounts' do
    it 'should return array of BitWallet::Accounts' do
      wallet = build(:wallet)
      wallet.accounts.should be_kind_of(BitWallet::Accounts)
    end
  end

end
