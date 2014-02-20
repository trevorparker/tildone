require 'yaml'

module Tildone
  # A Tildone task list
  class List
    def initialize(options = {})
      @file = options['file'] || File.join(Dir.home, '.tildone')

      unless File.exists? @file
        fail ArgumentError, "File #{@file} does not exist"
      end

      @tasks_raw = YAML.load_file @file
    end

    def tasks
      @tasks ||= @tasks_raw.map { |t| Tildone::Task.new task: t }
    end

    def to_yaml
      task_structure = tasks.map do |t|
        details = t.to_hash.select { |k, v| k != 'summary' }
        { t.summary => details }
      end
      task_structure.to_yaml
    end
  end
end
