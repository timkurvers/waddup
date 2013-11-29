require 'pathname'

module Waddup

  module Extension::FileSystem

    # Resolves folder for given path
    def folder_of(path)
      Pathname.new(path).dirname
    end

  end

end
