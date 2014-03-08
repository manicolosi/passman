require_relative '../../lib/passman/query'

module Passman
  describe Query do
    Record = Struct.new(:identifier, :category, :login)

    subject { described_class.new(query, records).run }

    let(:record_1) { Record.new 'record-1', 'cat-1', 'tom' }
    let(:record_2) { Record.new 'record-2', 'cat-1', 'dick' }
    let(:record_3) { Record.new 'record-3', 'cat-2', 'harry' }

    let(:records) { [record_1, record_2, record_3] }

    describe "with an identifer" do
      context 'not matching' do
        let(:query) { 'record-nonexistent' }
        it { should be_empty }
      end

      context "matching" do
        let(:query) { 'record-1' }
        it { should == [record_1] }
      end

      context "partial matching" do
        let(:query) { 'record' }
        it { should == records }
      end
    end

    describe "with a category" do
      context 'not matching' do
        let(:query) { 'cat-nonexistent' }
        it { should be_empty }
      end

      context "matching" do
        let(:query) { 'cat-1' }
        it { should == [record_1, record_2] }
      end

      context "partial matching" do
        let(:query) { 'cat' }
        it { should == records }
      end
    end

    describe "with an identifeir and category" do
      context 'not matching' do
        let(:query) { 'cat-nonexistent/record-nonexistent' }
        it { should be_empty }
      end

      context "matching" do
        let(:query) { 'cat-1/record-2' }
        it { should == [record_2] }
      end

      context "partial matching" do
        let(:query) { 'cat/record' }
        it { should == records }
      end
    end

    describe "case sensitivity" do
      let(:record_1) { Record.new 'record-1', 'cat-1', 'tom' }
      let(:record_2) { Record.new 'Record-2', 'cat-1', 'dick' }
      let(:record_3) { Record.new 'Record-3', 'cat-2', 'harry' }

      context "with all lowercase" do
        let(:query) { 'record' }
        it { should == records }
      end

      context "with a capital letter" do
        let(:query) { 'Record' }
        it { should == [record_2, record_3] }
      end
    end
  end
end
