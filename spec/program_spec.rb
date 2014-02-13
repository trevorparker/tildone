require 'spec_helper'
require 'yaml'

describe(Tildone::List) do
  include FakeFS::SpecHelpers

  let(:tasks_file) do
    "
    - Task one:
        items:
        - ItemA
        - ItemB
        - ItemC
    - Task two:
        items:
        - ItemD
        - ItemE
        - ItemF
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
    expect(task_items).to eq [%w{ItemA ItemB ItemC}, %w{ItemD ItemE ItemF}]
  end
end
