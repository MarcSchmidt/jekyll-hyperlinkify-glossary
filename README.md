# Jekyll Hyperlinkify Glossary
A Jekyll gem to replace glossary entries in html with hyperlinks

[![Gem Version](https://badge.fury.io/rb/jekyll-hyperlinkify-glossary.svg)](https://badge.fury.io/rb/jekyll-hyperlinkify-glossary)

This plugin replaces any occurence of glossary entries in pages and documents with a hyperlink to the associated  glossary entry. For this to work the glossary needs to be a collection where each glossary entries is defined over its title.

## Usage
Add the gem to your site's `Gemfile`

```
gem 'jekyll-hyperlinkify-glossary'
```

To use the gem a glossary needs to be created as collection `_config.yml`

```yml
collections:
  glossary:
    output: true
```

The gem will now check all pages and documents against the glossary entries. For this the content of a page is compared against the glossary entry title. In addition the `synonyms` can be added to the frontmatter. Example of usage:

```yml
title: test
synonyms:
    - analysis
    - evaluation
    - inspection
```
## Configuration
A page can be excluded from the gem by adding `jekyll-hyperlink-glossary` to the frontmatter.

```yml
jekyll-hyperlink-glossary: false
```
## How does it work?
A hook is applied to all pages and documents in the post rendering step and does filter everything in the html body with a regex against the glossary entries. This regex does ignore the html tag for headings (e.g. \<h1>) and links (e.g. \<a>).

As custom collections are not accesible during the post rendering step a second hook aggregates in the post read step the glossary and adds it to every page in the form of a 2-dimensional array. This array does contain one entry for every glossary entry. Each of these entries is an array of the link to the glossary entry, the title and all added synonyms.
