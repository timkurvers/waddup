module Waddup

  # Denotes an event obtained from a source
  class Event

    attr_accessor :label, :at, :until, :source

    def initialize
      yield self if block_given?
    end

    def to_json(state)
      {
        :label  => label,
        :at     => at,
        :until  => @until,
        :source => source.class::ALIAS
      }.to_json
    end

  end

end
