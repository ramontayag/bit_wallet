module BitWallet
  class HandlesError

    def self.from(message)
      error = if message.include?("-6")
        InsufficientFunds.new("cannot send an amount more than what this account has")
              elsif message.include?("-3")
                InvalidAmount.new("amount is invalid")
              elsif message.include?("-5")
                InvalidAddress.new("bitcoin address is invalid")
      else
        ArgumentError.new("unknown error: #{message}")
      end
      fail error if error
    end

  end
end
