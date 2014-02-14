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

  let(:list) do
    File.open('.tildone', 'w') { |f| f << tasks_file }
    Tildone::List.new('file' => '.tildone')
  end

  it 'can open a tasks file' do
    expect(list).to be_a Tildone::List
  end

  it 'can enumerate tasks' do
    task_summaries = list.tasks.map { |t| t.summary }
    expect(task_summaries).to eq ['Task one', 'Task two']
  end

  it 'can enumerate items' do
    task_items = list.tasks.map { |t| t.items }
    expect(task_items).to eq [%w{ItemA ItemB ItemC}, nil]
  end

  it 'can tell if a task is complete' do
    task_completed = list.tasks.map { |t| t.complete? }
    expect(task_completed).to eq [true, false]
  end

  it 'can tell if a task is due' do
    task_due = list.tasks.map { |t| t.due? }
    expect(task_due).to eq [false, true]
  end

  it 'can tell if there are task items' do
    task_items = list.tasks.map { |t| t.items? }
    expect(task_items).to eq [true, false]
  end
end
