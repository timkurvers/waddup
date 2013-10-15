require "chronic"

module Waddup

  class CLI
    THROUGH_ALIASES = %w[through upto until uptil to]

    alias run! initialize

    attr_reader :sources, :from, :to

    def run! arguments
      parse arguments
    end

    private

    # Parse the given string into sources and a time span.
    #
    # string - A String describing sources and a time span.
    #
    # Examples:
    #
    #   "with mail from monday through friday"
    #   "with mail, git and calendar from monday to friday"
    def parse string
      matches = string.match /with (.+) from (.+) (?:#{THROUGH_ALIASES.join "|"}) (.+)/

      sources, from, to = matches[1..3]

      @sources = sources.split /, ?| ?and ?/
      @from    = Chronic.parse from
      @to      = Chronic.parse to
    end

  end

end
