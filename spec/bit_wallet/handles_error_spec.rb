require "spec_helper"

module BitWallet
  describe HandlesError do
    describe ".from" do
      context "error is -3" do
        it "raises InvalidAmount error" do
          expect { described_class.from("does not matter -3 meh") }.
            to raise_error(InvalidAmount, "amount is invalid")
        end
      end

      context "error is -6" do
        it "raises InsufficientFunds error" do
          expect { described_class.from("-6 message") }.
            to raise_error(InsufficientFunds, "cannot send an amount more than what this account has")
        end
      end

      context "error is unknown" do
        it "raises an ArgumentError" do
          expect { described_class.from("-99 I do not know") }.
            to raise_error(ArgumentError, "unknown error: -99 I do not know")
        end
      end
    end
  end
end