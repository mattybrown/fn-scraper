#! /home/matt/.rvm/rubies/ruby-2.4.1/bin/ruby

require 'nokogiri'
require 'open-uri'
require 'json'

#doc = File.open("example.html") { |f| Nokogiri::HTML(f) }
doc = Nokogiri::HTML(open('http://marlboroughrealestate.co.nz/real-estate-licensed-salesperson-reaa-2008/lorraine-barrett-8680/list-res', "Accept-Encoding" => "none"))

listings = []

doc.css('.listing').each do |l|
  link = l.css('.lazy').map { |link| link['href'] }
  desc = l.css('.desc h2 a').first.content
  bed = l.css('.bed').first.content
  bath = l.css('.bath').first.content
  car = l.css('.car').first.content
  land = l.css('.land').first.content
  price = l.css('.price').first.content
  img = l.css('.lazy').map { |link| link['data-src']}

  # img.each do |style|
  #   v = style[:style].scan /(https)(.*)(.jpg)/
  #   @v = v.join
  # end

  listing = { "Link": link, "Image": img, "Address": desc, "Bed": bed, "Bath": bath, "Car": car, "Land": land, "Price": price }
  listings << listing
end

File.open( 'listings.json', 'w') do |f|
  f.puts listings.to_json
  #  f.puts l.to_json
  #end
end
