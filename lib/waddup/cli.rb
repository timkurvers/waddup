require "chronic"

module Waddup

  class CLI
    alias run! initialize

    attr_reader :sources, :from, :to

    def run! arguments
      @sources, @from, @to = parse arguments
    end

    # Parse the given string.
    #
    # string - A String describing a source and a time span.
    #
    # Returns an Array describing sources, from and to.
    def parse string
      sources = string[/with (.+) from/, 1]
      from    = string[/from (.+) through/, 1]
      to      = string[/through (.+)/, 1]

      from = Chronic.parse from
      to   = Chronic.parse to

      [sources, from, to]
    end

  end

end
