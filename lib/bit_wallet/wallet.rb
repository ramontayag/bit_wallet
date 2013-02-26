module BitWallet
  class Wallet

    def initialize(config={})
      @config = config
    end

    def accounts
      @accounts ||= Accounts.new(self)
    end

    private

    def client
      @client ||= Bitcoin::Client.new(@config[:username],
                                      @config[:password],
                                      @config.slice(:port))
    end

  end
end
