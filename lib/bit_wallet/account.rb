module BitWallet
  class Account

    attr_reader :wallet, :name
    delegate :client, to: :wallet

    def initialize(wallet, name)
      @wallet = wallet
      @name = name
      self.addresses.new
    end

    def addresses
      @addresses ||= Addresses.new(self)
    end

  end
end
