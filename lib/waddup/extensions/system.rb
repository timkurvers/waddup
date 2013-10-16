require 'rbconfig'

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

    # Retrieves operating system
    # See: https://github.com/celluloid/celluloid/blob/master/lib/celluloid/cpu_counter.rb
    def os
      @os ||= RbConfig::CONFIG['host_os'][/^[A-Za-z]+/]
    end

    # Whether running OSX
    def osx?
      os == 'darwin'
    end

  end

end
