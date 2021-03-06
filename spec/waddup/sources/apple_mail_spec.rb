require 'spec_helper'

describe Waddup::Source::AppleMail do
  let(:from) { Date.new(2013, 10, 16) }
  let(:to)   { Date.new(2013, 10, 17) }

  describe '#events' do
    before do
      subject.stub_shell "osascript -s s '#{described_class::SENT_MAIL_SCRIPT}' '16/10/2013 00:00' '17/10/2013 00:00'",
        output: fixture('sources/apple_mail.results')
    end

    it 'aggregates events' do
      events = subject.events(from, to)

      expect(events.first.label).to eq 'E-mail regarding Waddup'
      expect(events.last.label).to eq  'Another e-mail'

      expect(events.length).to eq 2
    end
  end

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
