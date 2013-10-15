require 'pathname'

class Waddup::Source::Git < Waddup::Source

  attr_accessor :author, :repos

  # Retrieves author and repositories on initialization
  #
  # Arguments
  #
  #   :base_path (defaults to current working directory)
  #
  def initialize(base_path = Dir.pwd)
    @author = `git config --get user.name`.chomp
    @repos = Dir["#{base_path}/**/.git"]
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
    log = `git log --author='#{author}' --since='#{from.iso8601}' --until='#{to.iso8601}' --format='format:#{GIT_FORMAT}'`
    log.scan(EXTRACT_PATTERN).map do |hash, datetime, subject|
      Waddup::Event.new.tap do |e|
        e.datetime = DateTime.parse(datetime)
        e.subject = subject
        e.source = self
      end
    end
  end

  # Requires Git to be installed successfully
  def self.usable?
    `git --version 2>&1 /dev/null`
    $?.success?
  end

end
