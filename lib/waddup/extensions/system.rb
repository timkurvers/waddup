module Waddup

  module Extension::System

    # Runs given system command
    #
    # Options:
    #
    #   :quietly (supresses output)
    #
    def run(command, options = {})
      command << ' 2>&1' if options[:quietly]
      `#{command}`.chomp
    end

  end

end
