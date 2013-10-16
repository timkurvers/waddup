module Waddup

  module Extension::AppleScript
    include Waddup::Extension::System

    # Runs given AppleScript
    def applescript(script)
    end

    # Whether AppleScript is available
    def applescript?
      (run 'osalang').include? 'AppleScript'
    end

  end

end
