module BitWallet
  class Accounts < Array

    attr_reader :wallet
    delegate :client, to: :wallet

    def with_balance
      self.select { |account| account.balance > 0 }
    end

    def initialize(wallet)
      @wallet = wallet
    end

    def new(name)
      account = self.find {|a| a.name == name}
      return account if account
      account = BitWallet::Account.new(wallet, name)
      self << account
      account
    end

  end
end
