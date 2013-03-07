require 'spec_helper'

describe BitWallet::Address, vcr: true do

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

  describe '#total_received' do
    it 'should return the total amount received by the address' do
      subject.client.stub(:getreceivedbyaddress).
        with(subject.address, BitWallet.config.min_conf).
        and_return(2.1)
      subject.total_received.should == 2.1
    end
  end

end
