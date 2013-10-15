require "chronic"

module Waddup

  class CLI
    alias run! initialize

    attr_reader :sources, :from, :to

    def run! arguments
      parse arguments
    end

    private

    # Parse the given string.
    #
    # string - A String describing a source and a time span.
    def parse string
      @sources = string[/with (.+) from/, 1]
      from     = string[/from (.+) through/, 1]
      to       = string[/through (.+)/, 1]

      @from = Chronic.parse from
      @to   = Chronic.parse to
    end

  end

end
