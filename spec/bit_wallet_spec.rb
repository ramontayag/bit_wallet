require 'spec_helper'

describe BitWallet do

  describe "#min_conf" do
    it "can be set" do
      described_class.min_conf = 2
      expect(described_class.min_conf).to eq 2
    end

    context "it is nil" do
      it "is 0" do
        described_class.min_conf = nil
        expect(described_class.min_conf).to eq 0
      end
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
