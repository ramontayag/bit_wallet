FactoryGirl.define do

  factory :wallet, class: BitWallet::Wallet do
    initialize_with { BitWallet::Wallet.new(Config.slice(:username,
                                                         :password,
                                                         :port)) }
  end

  factory :account, class: BitWallet::Account do
    ignore do
      wallet { build(:wallet) }
      name { 'name' }
    end
    initialize_with { BitWallet::Account.new(wallet, name) }
  end

  factory :address, class: BitWallet::Address do
    ignore do
      account { build(:account) }
    end
    initialize_with { BitWallet::Address.new(account) }
  end

end
