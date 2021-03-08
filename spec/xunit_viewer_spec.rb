require 'spec_helper'
require 'json'
require 'base64'

RSpec.describe XunitViewer do
  context "gem" do
    it "has a version number" do
      expect(XunitViewer::VERSION).not_to be nil
    end
  end

  context "rendering" do
    it "renders a full report from filenames" do
      my_filenames = Dir[File.expand_path("./data", __dir__) + "/**/*"].select { |p| File.file?(p) }
      expect(my_filenames.class).to eq(Array)
      expect(my_filenames).not_to be_empty

      output = XunitViewer::Renderer.new(
        my_filenames,
        title: "Bogus Title"
      ).result

      expect(output.length).to be > 10000

      File.write(File.expand_path("../demo_array.html", __FILE__), output)
    end

    it "renders a full report from file hashes" do
      my_filenames = Dir[File.expand_path("./data", __dir__) + "/**/*"].select { |p| File.file?(p) }
      my_files = my_filenames.each_with_object({}) { |f, acc| acc[f] = IO.read(f) }
      expect(my_files.class).to eq(Hash)
      expect(my_files).not_to be_empty

      output = XunitViewer::Renderer.new(
        my_files,
        title: "Bogus Title Hash"
      ).result

      expect(output.length).to be > 10000

      File.write(File.expand_path("../demo_hash.html", __FILE__), output)
    end

  end
end
