# `xunit_viewer` Ruby Gem
[![Gem Version](https://badge.fury.io/rb/xunit_viewer.svg)](https://rubygems.org/gems/xunit_viewer)
[![Documentation](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](http://www.rubydoc.info/gems/xunit_viewer/0.0.1)

Ruby wrapper for creating [lukejpreston/xunit-viewer](https://github.com/lukejpreston/xunit-viewer) HTML reports of sets of JUnit files.  This project is not affiliated with that one, it just provides a way to generate the HTML files from Ruby.

## Usage

If your reports exist on disk, providing an array of filenames is sufficient to generate the report:

```ruby
  output = XunitViewer::Renderer.new(
    Dir["reports/*.xml"],                      # An array of filenames
    title: "My Giant Report Title",            # probably your repository name
    brand_logo_url: "http://site.com/img.png", # or omit completely for default logo
    favicon_url:    "http://site.com/fav.ico", # or omit completely
  ).result

  File.write("my_report.html", output)
```

Alternately, if your reports exist in memory (as strings), you may pass a hash (file contents keyed on filename) to the function:


```ruby
  output = XunitViewer::Renderer.new(
    {
      "my_report.xml" => '<?xml version="1.0" encoding="UTF-8"?><testsuite> etc etc etc'
    },                                         # A hash of filename => content
    title: "My Giant Report Title",            # probably your repository name
    brand_logo_url: "http://site.com/img.png", # or omit completely for default logo
    favicon_url:    "http://site.com/fav.ico", # or omit completely
  ).result

  File.write("my_report.html", output)
```
