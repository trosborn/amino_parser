require 'rubygems'
require 'nokogiri'

page = Nokogiri::HTML(open('Protein.html'))

page.css("tr").each do |t|
  if t.css("td[class='noborbot']")
    puts t.css("td[class='noborbot']").text
    aminos = t.css("td[class='aminoAmount']")
    acids = {}
    acids[:histidine] = aminos[0].text
    puts acids
  end
end
