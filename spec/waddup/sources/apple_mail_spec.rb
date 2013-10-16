require 'spec_helper'

describe Waddup::Source::AppleMail do

  describe '::usable?' do
    # TODO: For now, let's assume those who run specs are on OSX
    it { should be_usable }
  end

end
