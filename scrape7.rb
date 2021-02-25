#スクレイピングツール
require 'nokogiri'
#urlにアクセスするライブラリ
require 'open-uri'
#csv出力するライブラリ
require 'csv'
require 'date'

today = Date.today
#today_month = Date.today.month
set_today = today.strftime("%Y%m%d")
set_month = today.strftime("%Y%m")

# 対象のURL
#url = "http://www.hik.co.jp/market/"
#url = "http://61.115.113.199/pg/list_arrival.php"
url = "http://www.shijou-nippo.metro.tokyo.jp/JS/#{set_month}/#{set_today}/Kak/JS_Kak_Zen_index.html"

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
#doc = Nokogiri::HTML.parse(open(url).read, nil, "SHIFT-JIS")

#what's xpath?
#https://qiita.com/rllllho/items/cb1187cec0fb17fc650a
#p "title:"+doc.title
#p doc.text
#p doc.xpath('/html/body/center/table[3]/tbody/tr[2]/td[2]').text
#p doc.xpath('*//table//tr/td').text

#csv出力するための配列
datas = []

puts "### xpathノードを検索する"
# ドキュメント全体を検索する場合は「//をつける」
# このノード以下のすべての子要素に対して検索を行う場合は「.//」をつける
# 子要素のみを検索対象とする場合は何もつけない
#https://qiita.com/nakamurau1@github/items/e5b91117877ba366fa6b

doc.xpath('//table//tr/td').each do |node|
  puts node.content
  data = node.content
  #配列にpush
  datas.push(data)
end

#csvに出力
#CSV.open("sales_data.csv", "w") do |csv|
#  csv.puts(datas)
#csv<< datas
#end

File.open("#{set_today}.txt","w") do |text|
#  text << datas
  text.puts(datas)
end


#puts "### Search for nodes by css"
#$doc.css('table tbody tr td').each do |link|
#  puts link.content
#end
