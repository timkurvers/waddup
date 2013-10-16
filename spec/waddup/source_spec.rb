require 'spec_helper'

describe Waddup::Source do

  describe '#events' do
    it 'has to be implemented by subclass' do
      expect do
        subject.events nil, nil
      end.to raise_error NotImplementedError
    end
  end

  describe '#usable?' do
    it 'delegates for convenience' do
      expect(described_class).to receive :usable?
      subject.usable?
    end
  end

  describe '::usable?' do
    it 'has to be implemented by subclass' do
      expect do
        described_class.usable?
      end.to raise_error NotImplementedError
    end
  end

  describe '::usable' do
    it 'retrieves usable sources' do
      expect(described_class.usable).to be_an Array
    end
  end

end
