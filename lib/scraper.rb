require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []
    doc.css("div.roster-cards-container").each do |card|
      card.css("div.student-card").each do |student|
        student_profile_link = "#{student.css('a').attribute('href').value}"
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        scraped_students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    scraped_students

  end

  def self.scrape_profile_page(profile_url)
    student = {}
    profile = Nokogiri::HTML(open(profile_url))
    profile.css("div.main_wrapper profile").each do |element|
      element.css("div.vitals_container").each do |vital|
        vital.css("div.social-icon-container").each do |social|
          if social.css('a').attribute('href').value.include?('twitter')
            student[:twitter] = social.css('a').attribute("href").value
          elsif social.css('a').attribute('href').value.include?('linkedin')
            student[:linkedin] = social.css('a').attribute('href').value
          elsif social.css('a').attribute('href').value.include?('github')
            student[:github] = social.css('a').attribute('href').value
          else
            student[:blog] = social.css('a').attribute('href').value
          end 
        end 
      end 
    end 
    student
    
  end

end
