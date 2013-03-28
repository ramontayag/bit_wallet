module BitWallet
  class Transaction

    attr_reader(:account,
                :amount,
                :category,
                :confirmations,
                :id,
                :occurred_at,
                :received_at,
                :address_str)

    def initialize(wallet, args)
      args = args.with_indifferent_access
      @wallet = wallet
      @account = wallet.accounts.new(args[:account])
      @id = args[:txid]
      @address_str = args[:address]
      @amount = args[:amount]
      @confirmations = args[:confirmations]
      @occurred_at = Time.at(args[:time])
      @received_at = Time.at(args[:timereceived])
      @category = args[:category]
    end

    def address
      @address ||= @account.addresses.find do |address|
        address.address == @address_str
      end
    end

  end
end
