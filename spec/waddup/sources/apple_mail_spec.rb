require 'spec_helper'

describe Waddup::Source::AppleMail do

  describe '::usable?' do
    context 'when on OSX' do
      before do
        described_class.stub(:osx?).and_return true
      end

      context 'when AppleScript is available' do
        before do
          described_class.stub_shell 'osalang 2>&1', output: 'AppleScript'
        end

        it { should be_usable }
      end

      context 'when AppleScript is unavailable' do
        before do
          described_class.stub_shell 'osalang 2>&1', exitstatus: 1
        end

        it { should_not be_usable }
      end
    end

    context 'when on other platforms' do
      before do
        described_class.stub(:osx?).and_return false
      end

      it { should_not be_usable }
    end
  end

end
