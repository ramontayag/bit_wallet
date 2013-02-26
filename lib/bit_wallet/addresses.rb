module BitWallet
  class Addresses < Array

    attr_reader :account

    def initialize(account)
      @account = account
    end

    def new(address_str=nil)
      address = Address.new(@account, address_str)
      self << address
      address
    end

  end
end
