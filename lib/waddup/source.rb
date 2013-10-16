module Waddup

  class Source
    extend Waddup::Registry

    # Aggregates events from this source
    #
    # Arguments:
    #
    #   :from (datetime)
    #   :to   (datetime)
    #
    def events(from, to)
      raise NotImplementedError
    end

    class << self

      # Whether this source is usable
      def usable?
        raise NotImplementedError
      end

      # Only usable sources
      def usable
        registry.select &:usable?
      end

    end

  end

end
