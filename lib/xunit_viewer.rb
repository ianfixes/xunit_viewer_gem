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

    # @param input_filenames [Array<String>] The JUnit/XUnit report filenames to render in the HTML report
    # @param title [String] the report title
    # @param brand_logo_url [String] the URL to a brand logo
    # @param favicon_url [String] the URL to a favicon
    def initialize(input_filenames, title: nil, brand_logo_url: nil, favicon_url: nil)
      @filenames = input_filenames
      @title = title
      @brand_logo_url = brand_logo_url
      @favicon_url = favicon_url

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
