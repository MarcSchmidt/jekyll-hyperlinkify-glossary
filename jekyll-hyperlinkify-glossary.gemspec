require_relative "lib/jekyll-hyperlinkify-glossary/version"

Gem::Specification.new do |s|
  s.name        = 'jekyll-hyperlinkify-glossary'
  s.version     = JekyllHyperlinkifyGlossary::VERSION
  s.summary     = "A Jekyll gem to replace glossary entries in html with hyperlinks"
  s.description = "A Jekyll gem to replace glossary entries in html with hyperlinks"
  s.authors     = ["Marc Schmidt"]
  s.license       = 'MIT'
  s.files       = ["lib/jekyll-hyperlinkify-glossary.rb"]
  s.required_ruby_version = ">= 2.4.0"
  s.add_dependency "jekyll", ">= 3.7"
end