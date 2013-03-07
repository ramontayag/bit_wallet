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
      if options[:to]
        options[:to] = options[:to].address if options[:to].is_a?(Address)
      else
        fail ArgumentError, 'address must be specified'
      end

      client.sendfrom(self.name,
                      options[:to],
                      amount,
                      BitWallet.config.min_conf)
    rescue RestClient::InternalServerError => e
      parse_error e.response
    end

    def total_received
      client.getreceivedbyaccount(self.name, BitWallet.config.min_conf)
    end

    def ==(other_account)
      self.name == other_account.name
    end

    def recent_transactions(options={})
      count = options.delete(:limit) || 10
      client.listtransactions(self.name, count).map do |hash|
        Transaction.new self.wallet, hash
      end
    end

    private

    def parse_error(response)
      json_response = JSON.parse(response)
      hash = json_response.with_indifferent_access
      error = if hash[:error]
                case hash[:error][:code]
                when -6
                  InsufficientFunds.new("cannot send an amount more than what this account (#{self.name}) has")
                end
              end
      fail error if error
    end

  end
end
