require 'spec_helper'

describe BitWallet::Account, vcr: true do

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

  describe '#balance' do
    subject { wallet.accounts.new('nona') }

    it 'should return the balance of the account' do
      subject.balance.should ==
        subject.client.getbalance(subject.name, BitWallet.config.min_conf)
    end

    it 'should default to the config min_conf' do
      BitWallet.config.min_conf = 2
      subject.client.should_receive(:getbalance).with(subject.name, 2)
      subject.balance(2)
    end

    it 'should be able to override the min_conf' do
      subject.client.should_receive(:getbalance).with(subject.name, 'min_conf')
      subject.balance('min_conf')
    end
  end

  describe '#send_amount' do
    it 'should send money to the given address' do
      default_account = wallet.accounts.new('')
      nona_account = wallet.accounts.new('nona')
      nona_address_str = nona_account.addresses.first.address
      expected_balance = nona_account.balance + 5.5
      default_account.send_amount 5.5, to: nona_address_str
      nona_account.balance.should == expected_balance
    end

    context ':to is a BitWallet::Address' do
      it 'should send it to the #address of the given BitWallet::Address' do
        default_account = wallet.accounts.new('')
        nona_account = wallet.accounts.new('nona')
        nona_address = nona_account.addresses.first

        expected_balance = nona_account.balance + 5.2
        default_account.send_amount 5.2, to: nona_address
        nona_account.balance.should == expected_balance
      end
    end

    context 'account does not have enough money' do
      it 'should fail with the InsufficientFunds error' do
        default_account = wallet.accounts.new('')
        nona_account = wallet.accounts.new('nona')
        nona_address_str = nona_account.addresses.first.address
        expect {
          default_account.send_amount(default_account.balance+10,
                                      to: nona_address_str)
        }.to raise_error(BitWallet::InsufficientFunds, "cannot send an amount more than what this account has")
      end
    end
  end

  describe '#total_received' do
    it 'should return the total amount received by the address' do
      subject.client.stub(:getreceivedbyaccount).
        with(subject.name, BitWallet.config.min_conf).
        and_return(2.1)
      subject.total_received.should == 2.1
    end
  end

  describe '#recent_transactions' do
    it 'should default to list 10 transactions' do
      wallet = build(:wallet)
      default_account = wallet.accounts.new('')
      account_1 = wallet.accounts.new('1')

      1.upto(11).each do |n|
        default_account.send_amount n, to: account_1.addresses.first
      end

      account_1.recent_transactions.size.should == 10
    end

    context 'when transaction limit is 6' do
      it 'should list the 6 most recent transactions' do
        wallet = build(:wallet)
        default_account = wallet.accounts.new('')
        account_1 = wallet.accounts.new('1')

        1.upto(8).each do |n|
          default_account.send_amount n, to: account_1.addresses.first
        end

        transactions = account_1.recent_transactions(limit: 6)
        transactions.size.should == 6
      end
    end
  end

  describe '#send_many' do
    it 'should send the amounts of money to the specified accounts' do
      default_account = wallet.accounts.new('')
      account_1 = wallet.accounts.new('account_1')
      account_1_address_str = account_1.addresses.first.address
      account_2 = wallet.accounts.new('account_2')
      account_2_address = account_2.addresses.first

      default_account.send_many(account_1_address_str => 0.4,
                                account_2_address => 2.323)

      account_1.balance.should == 0.4
      account_2.balance.should == 2.323
    end
  end

end
