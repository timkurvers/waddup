module Waddup

  class Source::AppleMail < Waddup::Source
    extend Waddup::Extension::AppleScript

    # Requires AppleScript to be available
    def self.usable?
      applescript?
    end

  end

end
