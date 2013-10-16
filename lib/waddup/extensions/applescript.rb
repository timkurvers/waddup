module Waddup

  module Extension::AppleScript
    include Waddup::Extension::System

    # Runs given AppleScript
    def applescript(script)
    end

    # Whether AppleScript is available
    def applescript?
      osx? && begin
        run('osalang', :quietly => true).include? 'AppleScript'
      end
    end

  end

end
