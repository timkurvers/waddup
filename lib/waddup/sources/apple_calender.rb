module Waddup

  class Source::AppleCalendar < Waddup::Source
    extend Waddup::Extension::AppleScript

    # Requires AppleScript to be available
    def self.usable?
      applescript?
    end

  end

end
