require 'spec_helper'

describe Waddup::Extension::System do

  let(:dummy) {
    Class.new do
      extend Waddup::Extension::System
    end
  }

  describe '#os' do
    it 'identifies the operating system' do
      stub_const('RbConfig::CONFIG', 'host_os' => 'linux')
      expect(dummy.os).to eq 'linux'
    end

    it 'is cached' do
      stub_const('RbConfig::CONFIG', 'host_os' => 'foo')
      expect(dummy.os).to eq 'foo'

      stub_const('RbConfig::CONFIG', 'host_os' => 'foobar')
      expect(dummy.os).to eq 'foo'
    end
  end

  describe '#osx?' do
    context 'when on OSX' do
      it 'returns true' do
        stub_const('RbConfig::CONFIG', 'host_os' => 'darwin')
        expect(dummy).to be_osx
      end
    end

    context 'when on other operating systems' do
      it 'returns false' do
        stub_const('RbConfig::CONFIG', 'host_os' => 'linux')
        expect(dummy).not_to be_osx
      end
    end
  end

end
