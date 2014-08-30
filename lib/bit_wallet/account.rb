module BitWallet
  class Account

    attr_reader :wallet, :name
    delegate :client, to: :wallet

    def initialize(wallet, name)
      @wallet = wallet
      @name = name
      fail ArgumentError, "account name cannot be nil" if name.nil?
      self.addresses.new
    end

    def addresses
      @addresses ||= Addresses.new(self)
    end

    def balance(min_conf=BitWallet.min_conf)
      client.getbalance(self.name, min_conf)
    end

    def send_amount(amount, options={})
      if options[:to]
        options[:to] = options[:to].address if options[:to].is_a?(Address)
      else
        fail ArgumentError, 'address must be specified'
      end

      client.sendfrom(self.name,
                      options[:to],
                      amount,
                      BitWallet.min_conf)
    rescue Bitcoin::Errors::RPCError => e
      parse_error e.message
    end

    def total_received
      client.getreceivedbyaccount(self.name, BitWallet.min_conf)
    end

    def ==(other_account)
      self.name == other_account.name
    end

    def recent_transactions(options={})
      count = options.delete(:limit) || 10
      # FIXME: come up with adapters to abstract the differences between
      # bitcoind and blockchain.info API
      api_result = client.listtransactions(self.name, count)
      txs = api_result
      if api_result.is_a?(Hash)
        txs = api_result.with_indifferent_access.fetch(:transactions)
      end
      txs.map do |hash|
        Transaction.new self.wallet, hash
      end
    end

    def send_many(account_values={})
      addresses_values = {}
      account_values.each do |key, value|
        address = key.respond_to?(:address) ? key.address : key
        addresses_values[address] = value
      end

      txid = client.send_many(self.name,
                              addresses_values,
                              BitWallet.min_conf)
      txid
    rescue => e
      parse_error e.message
    end

    private

    def parse_error(message)
      HandlesError.from(message)
    end

  end
end
