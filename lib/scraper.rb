require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    doc.css(div.roster-cards-container).text

  end

  def self.scrape_profile_page(profile_url)

  end

end
