module Waddup

  class Source::AppleCalendar < Waddup::Source
    extend Waddup::Extension::AppleScript

    ALIAS = 'ical'

    def events(from, to)
      []
    end

    # Requires AppleScript to be available
    def self.usable?
      applescript?
    end

  end

end
