require 'nokogiri'
require 'open-uri'

# Fetch and parse HTML document
doc = Nokogiri::HTML(open('https://ja.wikipedia.org/wiki/%E5%86%85%E9%96%A3%E7%B7%8F%E7%90%86%E5%A4%A7%E8%87%A3%E3%81%AE%E4%B8%80%E8%A6%A7'))

puts "### Search for nodes by css"
doc.css('table tr td a').each do |link|
  puts link.content
end
