require "spec_helper"

module BitWallet
  describe InstantiatesBitcoinClient, ".execute" do

    context "a hash config with username, password, host, port, ssl" do
      it "returns a Bitcoin::Client given a hash config" do
        client = double

        allow(Bitcoin::Client).to receive(:new).
          with("username", "password", host: "myhost", port: 8288, ssl: false).
          and_return(client)

        resulting_client = described_class.execute(
          username: "username",
          password: "password",
          host: "myhost",
          port: 8288,
          ssl: false
        )

        expect(resulting_client).to eq(client)
      end
    end

  end
end