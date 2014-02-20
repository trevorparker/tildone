module Tildone
  # An individual Tildone task
  class Task
    attr_accessor :summary, :complete, :due, :items

    def initialize(args = {})
      @task = args[:task]
      @summary = @task.keys[0]
      @body = @task.values[0]
      @body.each do |k, v|
        instance_variable_set("@#{k}", v)
      end
    end

    def complete?
      @complete ? true : false
    end

    def due?
      @due && DateTime.parse(@due).to_time.to_i < Time.now.to_i ? true : false
    end

    def items?
      @items && @items.size ? true : false
    end

    def to_s
      task_string = [summary]
      task_string << "due #{due}" if due
      task_string.join(' - ')
    end

    def to_hash
      hash = {}
      instance_variables.each do |iv|
        hash[iv.to_s.delete('@')] = instance_variable_get(iv)
      end
      hash
    end
  end
end
