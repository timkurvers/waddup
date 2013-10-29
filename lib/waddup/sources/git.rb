require 'pathname'

module Waddup

  class Source::Git < Waddup::Source
    include Waddup::Extension::System
    extend Waddup::Extension::System

    ALIAS = 'git'

    attr_accessor :base_path

    # Retrieves author and repositories on initialization
    #
    # Arguments
    #
    #   :base_path (defaults to current working directory)
    #
    def initialize(base_path = Dir.pwd)
      @base_path = base_path
    end

    # Obtains author from git-config
    def author
      @author ||= run 'git config --get user.name'
    end

    # Collects repositories under base-path
    def repos
      @repos ||= Dir["#{base_path}/**/.git"]
    end

    # Aggregates events from all repositories
    #
    # Arguments:
    #
    #   :from (datetime)
    #   :to   (datetime)
    #
    def events(from, to)
      events = repos.map do |repo|
        events_for_repo from, to, repo
      end
      events.flatten!
    end

    # See: https://www.kernel.org/pub/software/scm/git/docs/git-log.html#_pretty_formats
    GIT_FORMAT = '%h %ai %s'

    # Pattern to extract from the above format
    EXTRACT_PATTERN = /([0-9a-f]{7}) ([-0-9: ]+\+\d{4}) (.+)/i

    # Aggregates events for given repository
    #
    # Arguments:
    #
    #   :from (datetime)
    #   :to   (datetime)
    #   :repo (path)
    #
    def events_for_repo(from, to, repo)
      repo_label = self.class.label_for_repo repo

      results = run "git --git-dir='#{repo}' log --author='#{author}' --since='#{from.iso8601}' --until='#{to.iso8601}' --format='format:#{GIT_FORMAT}'"
      results.scan(EXTRACT_PATTERN).map do |hash, datetime, subject|
        Waddup::Event.new do |e|
          e.label  = "[#{repo_label}] #{subject}"
          e.at     = DateTime.parse(datetime)
          e.source = self
        end
      end
    end

    # Generates label for given repo path
    def self.label_for_repo(repo)
      path = Pathname.new(repo)
      parent = path.parent

      case parent.basename.to_s
      when 'code', 'design'
        parent = parent.parent
      end

      return nil if parent.root?

      parent.basename.to_s
    end

    # Requires Git to be installed successfully
    def self.usable?
      run 'git --version', :quietly => true
      $?.success?
    end

  end

end
