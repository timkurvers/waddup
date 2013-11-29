# encoding: utf-8

require 'spec_helper'

describe Waddup::Source::Git do
  let(:from) { Date.new(2013, 10, 16) }
  let(:to)   { Date.new(2013, 10, 17) }

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
      subject.stub(:repos).and_return(['/projects/1/.git', '/projects/2/.git'])
      expect(subject).to receive(:events_for_repo).with(from, to, '/projects/1/.git')
      expect(subject).to receive(:events_for_repo).with(from, to, '/projects/2/.git')
      subject.events from, to
    end
  end

  describe '#events_for_repo' do
    before do
      subject.stub_shell "git --git-dir='/waddup/.git' log --all --no-merges --author='John Doe' --since='2013-10-16' --until='2013-10-17' --format='format:%h %ai %s'",
        :output => fixture('sources/git.log')
    end

    it 'aggregates events for given repo' do
      subject.stub(:author).and_return('John Doe')
      events = subject.events_for_repo(from, to, '/waddup/.git')

      expect(events.first.label).to eq '[waddup] Spec all the things™'
      expect(events.last.label).to eq  '[waddup] Morph Git#author and Git#repos into lazy getters'

      expect(events.length).to eq 2
    end
  end

  describe '::label_for_repo' do
    context 'with no parent folder' do
      it 'returns nil' do
        expect(described_class.label_for_repo '/.git').to be_nil
      end
    end

    context 'with parent folder' do
      context 'when meaningless' do
        it 'labels with grandparent' do
          expect(described_class.label_for_repo '/project/code/.git').to eq 'project'
        end
      end

      it 'labels with parent' do
        expect(described_class.label_for_repo '/project/.git').to eq 'project'
      end
    end
  end

  describe '::usable?' do
    context 'when git is available' do
      before do
        described_class.stub_shell 'git --version 2>&1', :exitstatus => 0
      end

      it { should be_usable }
    end

    context 'when git is unavailable' do
      before do
        described_class.stub_shell 'git --version 2>&1', :exitstatus => 1
      end

      it { should_not be_usable }
    end
  end

end
