require 'spec_helper'

describe(Tildone::List) do
    it 'can open noop tasks file' do
      File.stub(:exists?).with('noop').and_return(true)
      expect(Tildone::List.new({'file' => 'noop'})).to be_a Tildone::List
    end
end
