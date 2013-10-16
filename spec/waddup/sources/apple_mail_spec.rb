require 'spec_helper'

describe Waddup::Source::AppleMail do

  describe '::usable?' do
    if described_class.osx?
      it { should be_usable }
    else
      it { should_not be_usable }
    end
  end

end
