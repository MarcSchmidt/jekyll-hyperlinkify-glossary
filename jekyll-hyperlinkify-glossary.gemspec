require_relative "lib/jekyll-hyperlinkify-glossary/version"

Gem::Specification.new do |s|
  s.name        = "jekyll-hyperlinkify-glossary"
  s.version     = JekyllHyperlinkifyGlossary::VERSION
  s.summary     = "A Jekyll gem to replace glossary entries in html with hyperlinks"
  s.description = "This plugin replaces any occurence of glossary entries in pages and documents with a hyperlink to the associated  glossary entry. For this to work the glossary needs to be a collection where each glossary entries is defined over its title."
  s.authors     = ["Marc Schmidt"]
  s.license     = "MIT"
  s.homepage    = "https://github.com/MarcSchmidt/jekyll-hyperlinkify-glossary"
  s.files       = ["lib/jekyll-hyperlinkify-glossary.rb", "lib/hooks/enrich_documents_with_glossary.rb"]
  s.required_ruby_version = ">= 2.4.0"
  s.add_dependency "jekyll", ">= 3.7"
end