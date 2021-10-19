require 'jekyll'
require 'hooks/enrich_documents_with_glossary'

# Get all glossary entries from the page an replace all terms with appropriate hyperlinks
module Jekyll 
  class HyperlinkGlossaryEntries
      BODY_START_TAG = "<body"
      OPENING_BODY_TAG_REGEX = %r!<body(.*)>\s*!
      class << self
          # Replace all oocurances of glossary entries with a hyperlink.
          def hyperlinkify(document)
              @glossary_entries = document.data["glossary_entries"]
              if @glossary_entries.nil?
                  puts "This document has no glossary entries: " + document.data["title"].to_s
                  return
              end
              document.output = if document.output.include? BODY_START_TAG
                                  process_document(document)
                              else
                                  process_html_body(document.output, document.data["title"])
                              end

          end

          # Determine if the content should be processed.
          def processable?(document)
              (document.is_a?(Jekyll::Page) || document.write?) &&
              (document.output_ext == ".html" || document.permalink&.end_with?("/")) &&
              (document.data["jekyll-hyperlink-glossary"] != false)
          end

          private

          # Process html content which has an body opening tag
          def process_document(document)
              head, opener, tail = document.output.partition(OPENING_BODY_TAG_REGEX)
              body_content, *rest = tail.partition("</body>")
              
              processed_markup = process_html_body(body_content, document.data["title"])

              document.output = String.new(head) << opener << processed_markup << rest.join
          end

          # Process every word of content and replace glossary entries
          def process_html_body(html, title)
              @glossary_entries.each do |glossary_entry|   
                  if glossary_entry[1].to_s != title.to_s.downcase
                      exclude_regex="\\b(?!<(h\\d|a).*>)(?!.*<\/(h\\d|a)>)(?!.html)"
                      glossary_entry_regex = Regexp.new("\\b"+glossary_entry.drop(1).join(exclude_regex+"|")+exclude_regex, true)
                      first_half_of_hyperlink = "<a href=\"#{ glossary_entry[0] }\">"
                      html = html.gsub(glossary_entry_regex, first_half_of_hyperlink+ '\0</a>')
                  end
              end
              html
          end
      end
  end
end

Jekyll::Hooks.register %i[documents pages], :post_render do |document|
  Jekyll::HyperlinkGlossaryEntries.hyperlinkify(document) if Jekyll::HyperlinkGlossaryEntries.processable?(document)
end