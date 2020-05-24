require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []
    doc.css("div.roster-cards-container").each do |card|
      card.css("div.student-card").each do |student|
        student_profile_link = "#{student.attribute('href')}"
        student_name = student.css(".student_name").text
        student_location = student.css(".student_location").text
        scraped_students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end 
    end 
    scraped_students

  end

  def self.scrape_profile_page(profile_url)

  end

end
