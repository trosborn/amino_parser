require 'rubygems'
require 'nokogiri'

page = Nokogiri::HTML(open('Protein.html'))

names = page.xpath("//td[contains(@class, 'noborbot')]/strong").collect { |node| node.text.strip }
quantity = page.xpath("//div[contains(@class, 'servingSize')]").collect { |node| node.text.strip }
quantity = quantity.select.each_with_index { |str, i| i.even? }
acids = page.xpath("//td[contains(@class, 'aminoAmount')]").collect { |node| node.text.strip }

#food = {name: "", serving_size: "", protein: 0, histidine: 0, isoleucine: 0, leucine: 0, lysine: 0, methionine_cysteine: 0, phenylalanine_tyrosine: 0, threonine: 0, tryptophan: 0, valine: 0 }
foods_array = []

i = 0
until i == 48
  food = {}
  food[:name] = names[i]
  food[:serving_size] = quantity[i].sub(/\n\t\t\t\t\t\t\t/, '')
  food[:protein] = acids[i*10]
  food[:histidine] = acids[i*10+1]
  food[:isoleucine] = acids[i*10+2]
  food[:leucine] = acids[i*10+3]
  food[:lysine] = acids[i*10+4]
  food[:methionine_cysteine] = acids[i*10+5]
  food[:phenylalanine_tyrosine] = acids[i*10+6]
  food[:threonine] = acids[i*10+7]
  food[:tryptophan] = acids[i*10+8]
  food[:valine] = acids[i*10+9]
  foods_array << food
  i += 1
end

puts foods_array
File.open('foods_hash.txt', 'w') do |f|
  foods_array.each { |element| f.puts(element) }
end
