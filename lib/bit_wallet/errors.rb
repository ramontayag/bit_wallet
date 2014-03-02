module BitWallet
  class StandardError < ::StandardError; end
  class InsufficientFunds < StandardError; end
  class InvalidAmount < StandardError; end
  class InvalidAddress < StandardError; end
end
