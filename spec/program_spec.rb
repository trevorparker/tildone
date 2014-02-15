require 'spec_helper'
require 'yaml'

describe(Tildone::List) do
  include FakeFS::SpecHelpers

  let(:tasks_file) do
    "
    - Task one:
        complete: true
        items:
          - ItemA
          - ItemB
          - ItemC
    - Task two:
        due: December 31, 2000
        items:
    "
  end

  let(:tasks_file_reconstituted) do
    list.to_yaml
  end

  let(:list) do
    File.open('.tildone', 'w') { |f| f << tasks_file }
    Tildone::List.new('file' => '.tildone')
  end

  let(:list_reconstituted) do
    File.open('.tildone', 'w') { |f| f << tasks_file_reconstituted }
    Tildone::List.new('file' => '.tildone')
  end

  it 'can open a tasks file' do
    expect(list).to be_a Tildone::List
  end

  it 'can enumerate tasks' do
    [list, list_reconstituted].each do |l|
      task_summaries = l.tasks.map { |t| t.summary }
      expect(task_summaries).to eq ['Task one', 'Task two']
    end
  end

  it 'can enumerate items' do
    [list, list_reconstituted].each do |l|
      task_items = l.tasks.map { |t| t.items }
      expect(task_items).to eq [%w{ItemA ItemB ItemC}, nil]
    end
  end

  it 'can tell if a task is complete' do
    [list, list_reconstituted].each do |l|
      task_completed = l.tasks.map { |t| t.complete? }
      expect(task_completed).to eq [true, false]
    end
  end

  it 'can tell if a task is due' do
    [list, list_reconstituted].each do |l|
      task_due = l.tasks.map { |t| t.due? }
      expect(task_due).to eq [false, true]
    end
  end

  it 'can tell if there are task items' do
    [list, list_reconstituted].each do |l|
      task_items = l.tasks.map { |t| t.items? }
      expect(task_items).to eq [true, false]
    end
  end
end
