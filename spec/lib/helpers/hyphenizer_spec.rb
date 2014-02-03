require_relative '../../../lib/passman/helpers/hyphenizer'

describe Passman::Helpers::Hyphenizer do
  subject { described_class.hyphenize name }

  context "one word is downcased" do
    let(:name) { 'Word' }

    it { should == 'word' }
  end

  context "multiple words are hyphenized" do
    let(:name) { 'MultipleWords' }

    it { should == 'multiple-words' }
  end

  context "out modules are stripped" do
    let(:name) { 'OuterModule::InnerModule' }

    it { should == 'inner-module' }
  end
end
