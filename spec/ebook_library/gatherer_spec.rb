require 'spec_helper'

describe EbookLibrary::Gatherer do
  subject { described_class.new }
  let(:metadatas) { [] }
  let(:dir_exists?) { true }
  let(:ebook_paths) { ['/path/to/ebook/'] }

  before do
    allow(subject).to receive(:gather_ebooks).and_return ebook_paths
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
    let(:ebook) { double(to_hash: {title: 'blub'}) }
    before do
      allow(EbookLibrary::Ebook).to receive(:new).with(ebook_paths.first).and_return ebook
    end
    it "gathers books into a hash" do
      expect(subject.gather).to eq ({books: [ebook.to_hash]})
    end
  end
end
