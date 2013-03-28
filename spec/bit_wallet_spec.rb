require 'spec_helper'

describe BitWallet, vcr: true do

  describe '.config' do
    it 'should be a configurable object' do
      described_class.config.min_conf = 22
      described_class.config.min_conf.should == 22
    end
  end

  describe '.at' do
    it 'should wrap the a wallet wrapping the Bitcoin client' do
      wallet = double
      BitWallet::Wallet.should_receive(:new).with(args: 'a').and_return(wallet)
      described_class.at(args: 'a').should == wallet
    end
  end

end
