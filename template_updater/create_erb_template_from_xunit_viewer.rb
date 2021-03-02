require 'shellwords'

# Make sure output filename is specified
if ARGV.empty?
  puts "Must specify the name of the output ERB file to write"
  exit(1)
end

CONTAINER_NAME = "xunit_viewer_extractor:latest".freeze
REPORT_NAME    = "rrrreport_template.html".freeze
DOCKER_FILE    = File.expand_path("./extraction.Dockerfile", __dir__).freeze

safe_dir = __dir__.shellescape

system("rm -f #{REPORT_NAME}")
system("docker build -t #{CONTAINER_NAME} --build-arg OUTPUT_HTML_NAME=#{REPORT_NAME} -f #{DOCKER_FILE.shellescape} #{safe_dir}")
system("docker run --rm #{CONTAINER_NAME} cat #{REPORT_NAME} > #{REPORT_NAME}")

File.open(ARGV.first, "w") do |out|
  File.open(REPORT_NAME).each do |line|
    # stuff to just remove
    next if line.include?('<meta name="description" content="1 passed"')

    {
      BLARG_TITLE:   "title",
      BLARG_BRAND:   "brand_logo_url",
      BLARG_FAVICON: "favicon_url"
    }.each { |find, varname| line.gsub!(find.to_s, "<%= @#{varname} %>") }

    if line.include?('window.files = [{"file":"/blarg.xml"')
      ruby_code = "@filenames.map { |n| {file: n, contents: Base64.strict_encode64(LZUTF8.compress(IO.read(n)))} }.to_json "
      line = "        window.files = <%= #{ruby_code} %> // blarg"
    end

    out.puts(line)
  end
end

system("rm #{REPORT_NAME}")
