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

    def balance(min_conf=BitWallet.config.min_conf)
      client.getbalance(self.name, min_conf)
    end

    def send_amount(amount, options={})
      unless options[:to]
        fail ArgumentError, 'address must be specified'
      end
      client.sendfrom(self.name,
                      options[:to],
                      amount,
                      BitWallet.config.min_conf)
    end

    def total_received
      client.getreceivedbyaccount(self.name, BitWallet.config.min_conf)
    end

  end
end
