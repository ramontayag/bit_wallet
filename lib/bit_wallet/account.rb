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
    rescue RestClient::InternalServerError => e
      parse_error e.response
    end

    def total_received
      client.getreceivedbyaccount(self.name, BitWallet.config.min_conf)
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
