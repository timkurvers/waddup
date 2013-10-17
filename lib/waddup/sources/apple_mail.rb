module Waddup

  class Source::AppleMail < Waddup::Source
    extend Waddup::Extension::AppleScript

    ALIAS = 'mail'

    # Requires AppleScript to be available
    def self.usable?
      applescript?
    end

  end

end
