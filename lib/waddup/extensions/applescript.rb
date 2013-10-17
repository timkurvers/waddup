module Waddup

  module Extension::AppleScript
    include Waddup::Extension::System

    # Runs given AppleScript
    #
    # Options:
    #
    #   :args    (arguments to provide to the script)
    #   :as_ruby (whether to parse result as Ruby)
    #
    def applescript(script, options = {})
      args = options.delete(:args) || []
      arguments = args.map { |arg| " '#{arg}'" }.join
      result = run("osascript -s s -e '#{script}'#{arguments}")
      eval result if options.delete(:as_ruby)
    end

    # Whether AppleScript is available
    def applescript?
      osx? && begin
        run('osalang', :quietly => true).include? 'AppleScript'
      end
    end

  end

end
