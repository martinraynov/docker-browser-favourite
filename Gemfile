source "https://rubygems.org"

# Jekyll configuration for Ruby 2.6 compatibility
gem "jekyll", "~> 3.9.0"
gem "jekyll-remote-theme", "~> 0.4.3"
gem "jekyll-seo-tag", "~> 2.6"
gem "kramdown", "~> 2.3"
gem "kramdown-parser-gfm", "~> 1.1"
# Webrick is required for Jekyll serve in Ruby 3.0+
gem "webrick", "~> 1.7"

# Windows and JRuby does not include zoneinfo files
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

# Performance-booster for watching directories on Windows
gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]

# Lock `http_parser.rb` gem to `v0.6.x` on JRuby builds
gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]
