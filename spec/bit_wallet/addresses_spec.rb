require 'spec_helper'

describe BitWallet::Addresses, vcr: true do

  let(:account) { build(:account) }
  subject { BitWallet::Addresses.new(account) }

  its(:account) { should == account }
  its(:new) { should be_kind_of(BitWallet::Address) }

  describe '#new' do
    context 'without any address string given' do
      it 'should return an Address that points to the same account' do
        subject.new.account.should == account
      end
    end

    context 'with address string given' do
      it 'should return an Address with the given address string' do
        subject.new('myaddress').address.should == 'myaddress'
      end
    end
  end

end
