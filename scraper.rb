#! /home/matt/.rvm/rubies/ruby-2.4.1/bin/ruby

require 'nokogiri'
require 'open-uri'
require 'json'

#doc = File.open("example.html") { |f| Nokogiri::HTML(f) }
doc = Nokogiri::HTML(open('http://marlboroughrealestate.co.nz/real-estate-licensed-salesperson-reaa-2008/michael-rea-8692/list-res', "Accept-Encoding" => "none"))

listings = []

doc.css('.listing').each do |l|
  link = l.css('.lazy').map { |link| link['href'] }
  desc = l.css('.desc h2 a').first.content
  l.search('.bed').any? ? bed = l.css('.bed').first.content : bed = ""
  l.search('.bath').any? ? bath = l.css('.bath').first.content : bath = ""
  l.search('.car').any? ? car = l.css('.car').first.content : car = ""
  l.search('.land').any? ? land = l.css('.land').first.content : land = ""
  if l.search('.price').any?
    price = l.css('.price').first.content
  elsif l.search('.auction-dt').any?
    price = l.css('.auction-dt').first.content
  end

  img = l.css('.lazy').map { |link| link['data-src']}

  # img.each do |style|
  #   v = style[:style].scan /(https)(.*)(.jpg)/
  #   @v = v.join
  # end

  listing = { "link": link, "image": img, "address": desc, "bed": bed, "bath": bath, "car": car, "land": land, "price": price }
  listings << listing
end

File.open( 'listings.json', 'w') do |f|
  f.puts listings.to_json
  #  f.puts l.to_json
  #end
end
