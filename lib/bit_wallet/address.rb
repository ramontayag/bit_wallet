module BitWallet
  class Address

    attr_reader :account, :address
    delegate :wallet, to: :account
    delegate :client, to: :wallet

    def initialize(account, address=nil)
      @account = account
      @address = if address
                   address
                 else
                   client.getnewaddress(@account.name)
                 end
    end

  end
end
