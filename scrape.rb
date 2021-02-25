require 'nokogiri'
#urlにアクセスするライブラリ
require 'open-uri'
#csv出力するライブラリ
require 'csv'

# 対象のURL
url = "https://www.sejuku.net/blog/"
#url = "http://www.shijou-nippo.metro.tokyo.jp/JS/202003/20200316/Kak/JS_Kak_Zen_index.html"

# Nokogiriで切り分け
doc = Nokogiri::HTML(open(url))
p doc
puts "### CSSノードを検索する"
doc.css('h2').each do |link|
  puts link.content
end

#what's xpath?
#https://qiita.com/rllllho/items/cb1187cec0fb17fc650a
puts "### xpathノードを検索する"
doc.xpath('//nav//ul//li/a', '//article//h2').each do |link|
  puts link.content
end

puts "### xpathノードを検索する"
doc.xpath('//*[@id="navigation"]/div/nav/ul/li[1]/a').each do |link|
  puts link.content
end

puts "### ミックスされたノードを検索する."
doc.search('nav ul.menu li a', '//article//h2').each do |link|
  puts link.content
end
