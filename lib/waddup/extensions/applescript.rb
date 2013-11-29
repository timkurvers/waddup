module Waddup

  module Extension::AppleScript
    include Waddup::Extension::System

    # Runs given AppleScript on disk
    #
    # Options:
    #
    #   :args    (arguments to provide to the script)
    #   :as_ruby (whether to eval results as Ruby)
    #
    def applescript(script, options = {})
      args = options.delete(:args) || []
      arguments = args.map { |arg| " '#{arg}'" }.join
      results = run("osascript -s s '#{script}'#{arguments}")

      # TODO: This is very scary, find alternatives!
      eval "[#{results[1...-1]}]" if options.delete(:as_ruby)
    end

    # Whether AppleScript is available
    def applescript?
      osx? && begin
        run('osalang', quietly: true).include? 'AppleScript'
      end
    end

  end

end
