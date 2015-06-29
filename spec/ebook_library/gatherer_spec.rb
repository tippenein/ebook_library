require 'spec_helper'

describe EbookLibrary::Gatherer do
  subject { described_class.new }
  let(:books) do
    [{ :author => "derp",
       :title => "town",
       :format => "mobi"
    }]
  end
  let(:metadatas) { [] }
  let(:dir_exists?) { true }

  before do
    allow(subject).to receive(:gather_metadatas).and_return metadatas
    allow(File).to receive(:exist?).and_return dir_exists?
  end

  describe "init" do
    context "valid path" do
      let(:dir_exists?) { true }
      it "has a default path" do
        expect(described_class.new.path).not_to be_nil
      end

      it "can set new path" do
        expect(described_class.new("/herp/derp").path).to eq "/herp/derp"
      end
    end

    context "invalid path" do
      let(:dir_exists?) { false}
      it "can't set invalid path" do
        expect{described_class.new("/herp/derp")}.to raise_error
      end
    end
  end

  describe "#gather" do
    it "gathers metadata from books"
      # expect(subject.gather).to eq({:books => books })
  end
end
