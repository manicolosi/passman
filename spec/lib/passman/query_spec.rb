require_relative '../../../lib/passman/query'
require_relative '../../../lib/passman/record'

module Passman
  describe Query do
    def create_record(identifier, category, login)
      Record.new(identifier: identifier, category: category, login: login)
    end

    subject { described_class.new(queries, records).run }

    let(:record_1) { create_record 'record-1', 'cat-1', 'tom' }
    let(:record_2) { create_record 'record-2', 'cat-1', 'dick' }
    let(:record_3) { create_record 'record-3', 'cat-2', 'harry' }

    let(:records) { [record_1, record_2, record_3] }

    let(:queries) { [query] }

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

    describe "with an identifier and category" do
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

    describe "with multiple args" do
      context 'both matching identifier and category' do
        let(:queries) { %w[record-1 cat-1] }
        it { should == [record_1] }
      end

      context 'both matching identifier' do
        let(:queries) { %w[record 1] }
        it { should == [record_1, record_2] }
      end

      context 'one matching' do
        let(:queries) { %w[record-1 cat-2] }
        it { should be_empty }
      end
    end

    describe "substring match on field value" do
      context "exact field value" do
        let(:query) { 'login:tom' }
        it { should == [record_1] }
      end

      context "partial field value" do
        let(:query) { 'login:d' }
        it { should == [record_2] }
      end
    end

    describe "case sensitivity" do
      let(:record_1) { create_record 'record-1', 'cat-1', 'tom' }
      let(:record_2) { create_record 'Record-2', 'cat-1', 'dick' }
      let(:record_3) { create_record 'Record-3', 'cat-2', 'harry' }

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
