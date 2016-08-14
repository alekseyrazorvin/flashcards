require 'open-uri'
require 'nokogiri'

doc = Nokogiri::HTML(open("http://w2mem.com/words/en/1/"))
parsing_page_forms = doc.css('.row')
user = User.create(email: '007@007.com', password: '007007', password_confirmation: '007007')

parsing_page_forms.drop(3).each do |pp|
  unless pp.css('input.input-sm')[0].nil?
    user.cards.create(original_text: pp.css('input.input-sm')[0].attributes["value"].text,
                      translated_text: pp.css('input.input-sm')[1].attributes["value"].text)
  end
end


