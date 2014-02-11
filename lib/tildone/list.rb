module Tildone
  class List
    def initialize(options = {})
      @file = options['file'] || File.join(Dir.home, '.tildone')

      if !File.exists?(@file)
        raise ArgumentError.new("File #{@file} does not exist")
      end
    end
  end
end
