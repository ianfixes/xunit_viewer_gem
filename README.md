# `xunit_viewer` Ruby Gem
[![Gem Version](https://badge.fury.io/rb/xunit_viewer.svg)](https://rubygems.org/gems/xunit_viewer)
[![Documentation](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](http://www.rubydoc.info/gems/xunit_viewer/0.0.1)

Ruby wrapper for creating [lukejpreston/xunit-viewer](https://github.com/lukejpreston/xunit-viewer) HTML reports of sets of JUnit files.  This project is not affiliated with that one, it just provides a way to generate the HTML files from Ruby.

## Usage

```ruby
  output = XunitViewer::Renderer.new(
    Dir["reports/*.xml"],
    title: "My Giant Report Title",            # probably your repository name
    brand_logo_url: "http://site.com/img.png", # or omit completely for default logo
    favicon_url:    "http://site.com/fav.ico", # or omit completely
  ).result

  File.write("my_report.html", output)
```
