require 'spec_helper'

describe EbookLibrary::Ebook do
  subject { described_class.new(path) }
  let(:path) { "whatever" }
  let(:title) { "derp" }
  before do
  end

  describe "attributes" do
    expect(subject.title).to eq title
  end
end

