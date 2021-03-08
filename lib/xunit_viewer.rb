require "xunit_viewer/version"
require 'lzutf8'
require 'erb'

# XunitViewer renders JUnit/XUnit reports to HTML
#
# This is done by injecting custom data into a pre-generated report from https://github.com/lukejpreston/xunit-viewer
# which is a fully in-browser Javascript application that handles all the interactivity.
#
# @author Ian Katz <ianfixes@gmail.com>
module XunitViewer

  # A renderer for JUnit/Xunit results
  class Renderer < ERB

    # @return [String] the title of the report
    attr_accessor :title

    # @return [String] the URL to a brand logo
    attr_accessor :brand_logo_url

    # @return [String] the URL to a favicon logo
    attr_accessor :favicon_url

    # @param input_files [Mixed] Either an array of JUnit/XUnit report filenames, or hash of name => contents
    # @param title [String] the report title
    # @param brand_logo_url [String] the URL to a brand logo
    # @param favicon_url [String] the URL to a favicon
    def initialize(input_files, title: nil, brand_logo_url: nil, favicon_url: nil)
      @files = input_files.is_a?(Hash) ? input_files : input_files.each_with_object({}) { |f, acc| acc[f] = IO.read(f) }
      @title = title
      @brand_logo_url = brand_logo_url
      @favicon_url = favicon_url

      # this "filename" is from the parent class
      filename = File.expand_path("./report_template.erb", __dir__)
      template = File.read(filename)
      @filename = filename
      super(template)
    end

    # @return [String] the rendered template
    def result
      super(binding)
    end

  end

end
