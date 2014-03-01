module BitWallet
  class InstantiatesBitcoinClient

    def self.execute(config)
      Bitcoin::Client.new(config.fetch(:username),
                          config.fetch(:password),
                          config.slice(:host, :port, :ssl))
    end
  end
end