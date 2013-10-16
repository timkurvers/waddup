require 'spec_helper'

describe Waddup::Source::Git do

  describe '#author' do
    it 'obtains author from git-config' do
      subject.stub(:run).and_return('John Doe')
      expect(subject.author).to eq 'John Doe'
    end
  end

  describe '#repos' do
    context 'when initialized as-is' do
      it 'collects repos under current working directory' do
        expect(Dir).to receive(:[]).with("#{Dir.pwd}/**/.git").and_call_original
        expect(subject.repos.length).to eq 1
      end
    end

    context 'when initialized with base-path' do
      before do
        subject.base_path = '/projects'
      end

      it 'collects repos under given base-path' do
        expect(Dir).to receive(:[]).with('/projects/**/.git')
        subject.repos
      end
    end
  end

  describe '#events' do
    it 'delegates event aggregation to #events_for_repo' do
      subject.stub(:repos).and_return(['/projects/1.git', '/projects/2.git'])
      expect(subject).to receive(:events_for_repo).with(nil, nil, '/projects/1.git')
      expect(subject).to receive(:events_for_repo).with(nil, nil, '/projects/2.git')
      subject.events nil, nil
    end
  end

  describe '#events_for_repo' do
    it 'aggregates events for given repo'
  end

  describe '::usable?' do
    it { should be_usable }
  end

end
