require "spec_helper"

describe Waddup::CLI do
  let(:cli) { cli = Waddup::CLI.new }

  context "given a text that describes sources and time" do
    before do
      cli.run! "with mail from monday through friday"
    end

    it "should derive sources" do
      expect(cli.sources).to eq "mail"
    end

    it "should derive when to start" do
      expect(cli.from).to eq Chronic.parse "monday"
    end

    it "should derive when to stop" do
      expect(cli.to).to eq Chronic.parse "friday"
    end
  end
end
