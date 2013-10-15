require 'pathname'

class Waddup::Source::Git < Waddup::Source

  attr_accessor :author, :repos

  # Retrieves author and repositories on initialization
  #
  # Arguments
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

  # Aggregates events for given repository
  #
  # Arguments:
  #
  #   :from (datetime)
  #   :to   (datetime)
  #   :repo (path)
  #
  def events_for_repo(from, to, repo)
    # `git log --author='#{author}' --since=#{from.iso8601} --until=#{to.iso8601} --format='format:%h %s %t'`
  end

  # Requires Git to be installed successfully
  def self.usable?
    `git --version 2>&1 /dev/null`
    $?.success?
  end

end
