require 'spec_helper'

describe Waddup::Registry do

  let(:dummy)  {
    Class.new do
      extend Waddup::Registry
    end
  }
  let(:target) { Class.new(dummy) }

  describe '#registry' do
    it 'retrieves the registry' do
      expect(dummy.registry).to be_an Array
    end
  end

  describe '#register' do
    it 'registers subclasses in registry' do
      expect(dummy.registry).to include target
    end
  end

end
