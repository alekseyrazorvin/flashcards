# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# second source of words
# doc = Nokogiri::HTML(open("http://en365.ru/top1000.htm"))

require 'open-uri'
doc = Nokogiri::HTML(open("http://w2mem.com/words/en/1/"))

# tried in rails consol
# original_text = doc.css('input.input-sm')[4].attributes["value"].text
# translated_text = doc.css('input.input-sm')[5].attributes["value"].text

parsing_page_forms = doc.css('input.input-sm')

original_text = ''; translated_text = ''

parsing_page_forms.each_with_index do |word, index|
  if (index % 2) == 0
    original_text = word.attributes["value"].text
  else
    translated_text = word.attributes["value"].text
    Card.create(original_text: original_text, translated_text: translated_text)
    original_text = ''; translated_text = ''
  end
end


