require 'spec_helper'

describe BitWallet::Address do

  let(:account) { build(:account) }
  subject { build(:address, account: account) }

  its(:account) { should == account }

  describe 'on initialization' do
    context 'no address is given' do
      it 'should create an address' do
        address = described_class.new(account)
        address.address.should_not be_blank
      end
    end

    context 'address given already exists' do
      it 'should not create an address' do
        described_class.new(account, 'addr')
        expect {
          described_class.new(account, 'addr')
        }.to_not change(account.addresses, :count)
      end
    end
  end

end
