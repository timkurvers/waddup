require "spec_helper"

describe Waddup::CLI do
  context "given a text that describes sources and time" do
    before do
      subject.run! "with mail, git and calendar from monday through friday"
    end

    it "should derive sources" do
      expect(subject.sources).to include "mail", "git", "calendar"
    end

    it "should derive when to start" do
      expect(subject.from).to eq Chronic.parse "monday"
    end

    it "should derive when to stop" do
      expect(subject.to).to eq Chronic.parse "friday"
    end
  end
end
