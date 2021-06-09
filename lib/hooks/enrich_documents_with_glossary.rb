# Enrich all documents and pages with an array of all glossary entries and their synonyms
Jekyll::Hooks.register :site, :post_read do |site|
    puts 'Enriching documents with glossary collection'
    glossary_entries = []
    site.collections["glossary"].docs.each do |item|
      next_glossary_entry = [[item.url, item.data['title']],item.data['synonyms']].compact.reduce([], :|)
      glossary_entries.push next_glossary_entry.map(&:downcase )
    end
    site.documents.each{ |document|
      document.data['glossary_entries'] = glossary_entries
    }
    site.pages.each{ |document|
      document.data['glossary_entries'] = glossary_entries
    }
end