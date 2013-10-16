module Waddup

  # Denotes an event obtained from a source
  class Event

    attr_accessor :at, :until, :source, :subject

    def initialize
      yield self if block_given?
    end

  end

end
