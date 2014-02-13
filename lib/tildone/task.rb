module Tildone
  # An individual Tildone task
  class Task
    attr_reader :summary, :items

    def initialize(args = {})
      @task = args[:task]
      @summary = @task.keys[0]
      @body = @task.values[0]
      @body.each do |k, v|
        instance_variable_set("@#{k}", v)
      end
    end

    def to_s
      "#{summary} - items #{items.join(', ')}"
    end
  end
end
