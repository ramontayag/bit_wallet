module BitWallet
  class Wallet

    def initialize(config={})
      @config = config
    end

    def accounts
      @accounts ||= Accounts.new(self)
    end

    def recent_transactions(options={})
      count = options.delete(:limit) || 10
      client.listtransactions('*', count).map do |hash|
        Transaction.new self, hash
      end
    end

    def move(from_account,
             to_account,
             amount,
             min_conf=BitWallet.config.min_conf,
             comment=nil)

      from_account_str = if from_account.respond_to?(:name)
                           from_account.name
                         else
                           from_account
                         end
      to_account_str = if to_account.respond_to?(:name)
                           to_account.name
                         else
                           to_account
                         end
      client.move(from_account_str,
                  to_account_str,
                  amount,
                  min_conf,
                  comment)
    end

    private

    def client
      @client ||= Bitcoin::Client.new(@config[:username],
                                      @config[:password],
                                      @config.slice(:port))
    end

  end
end
