require_relative '../../../lib/passman/helpers/variable_expander'

describe Passman::Helpers::VariableExpander do
  subject { described_class.new(lookup_table).expand string }
  let(:lookup_table) do
    {
      'USER' => 'mark',
      'HOME' => '/home/mark',
      'PWD'  => '/home/mark/Projects/passman'
    }
  end

  context "contains no variables" do
    let(:string) { 'a string' }

    it { should == 'a string' }
  end

  context "contains a variable" do
    let(:string) { 'hello $USER' }

    it { should == 'hello mark' }
  end

  context "escaped variable" do
    let(:string) { 'hello \$USER' }

    it { should == 'hello $USER' }
  end

  context "contains multiple variables" do
    let(:string) { 'home $HOME, pwd: $PWD' }

    it { should == 'home /home/mark, pwd: /home/mark/Projects/passman' }
  end
end
