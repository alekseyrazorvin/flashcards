# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
original_text = []
translated_text = []

doc = Nokogiri::HTML(open("http://w2mem.com/words/en/1/"))

# tried in rails consol
# original_text = doc.css('input.input-sm')[4].attributes["value"].text
# translated_text = doc.css('input.input-sm')[5].attributes["value"].text

parsing_page_forms = doc.css('input.input-sm')
parsing_page_forms.each_with_index {|text,i| original_text << text.attributes["value"].text if i%2 == 0}
parsing_page_forms.each_with_index {|text,i| translated_text << text.attributes["value"].text if i%2 != 0}

review_date = 3.days.from_now.to_date  
original_text.zip(translated_text).each do |original, translated|
  Card.create(original_text: original, translated_text: translated, review_date: review_date)
end

