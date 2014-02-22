module BitWallet
  class HandlesError

    def self.from(message)
      error = if message.include?("-6")
        InsufficientFunds.new("cannot send an amount more than what this account has")
      end
      fail error if error
    end

  end
end