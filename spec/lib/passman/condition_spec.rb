require_relative '../../../lib/passman/condition'

describe Passman::Condition do
  subject { condition.evaluate(record) }
  let(:conditions) { { a: 'foo', b: 'bar' } }

  describe "And Condition" do
    let(:condition) { described_class.and_condition(conditions) }

    context "evaulates to true when all conditions are equal" do
      let(:record) { double 'record', a: 'foo', b: 'bar' }

      it { should be_true }
    end

    context "evaulates to false when all conditions are equal" do
      let(:record) { double 'record', a: 'foo', b: 'not-bar' }

      it { should be_false }
    end
  end

  describe "Or Condition" do
    let(:condition) { described_class.or_condition(conditions) }

    context "evaulates to true when any conditions are equal" do
      let(:record) { double 'record', a: 'foo', b: 'not-bar' }

      it { should be_true }
    end

    context "evaulates to false when all conditions are not equal" do
      let(:record) { double 'record', a: 'not-foo', b: 'not-bar' }

      it { should be_false }
    end
  end
end
