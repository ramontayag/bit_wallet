module BitWallet
  class StandardError < ::StandardError; end
  class InsufficientFunds < StandardError; end
end
