module Waddup

  # Denotes an event obtained from a source
  class Event

    attr_accessor :label, :at, :until, :source

    def initialize
      yield self if block_given?
    end

  end

end
