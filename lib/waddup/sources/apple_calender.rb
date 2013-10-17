module Waddup

  class Source::AppleCalendar < Waddup::Source
    extend Waddup::Extension::AppleScript

    ALIAS = 'ical'

    # Requires AppleScript to be available
    def self.usable?
      applescript?
    end

  end

end
