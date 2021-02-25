require 'nokogiri'
require 'open-uri'
require 'csv'

# 対象のURL
url = "http://www.shijou-nippo.metro.tokyo.jp/JS/202003/20200316/Kak/JS_Kak_Zen.html"


charset=nil
html = open(url) do |f|
  #文字種別取得
  charset = f.charset
  #htmlを読み込み変数htmlに渡す
  f.read
end

# Nokogiriで切り分け
#htmlを解析し、オブジェクト化
#doc = Nokogiri::HTML.parse(html, nil, charset)
doc = Nokogiri::HTML.parse(open(url).read, nil, "CP932")

# テーブル各行の取得
rows = []
#html.xpath('//*/table/tbody/tr').each_with_index do |row, i|
doc.xpath('//*/table/tr').each_with_index do |row, i|
  rows[i] = {}
  row.xpath('td').each_with_index do |td, j|
    rows[i][headers[j]] = td.text.strip
  end
end
p rows
