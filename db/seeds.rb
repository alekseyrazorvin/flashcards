require 'open-uri'
doc = Nokogiri::HTML(open("http://w2mem.com/words/en/1/"))
parsing_page_forms = doc.css('.row')

parsing_page_forms.drop(3).each do |pp|
  unless pp.css('input.input-sm')[0].nil?
    Card.create(original_text: pp.css('input.input-sm')[0].attributes["value"].text, 
                translated_text: pp.css('input.input-sm')[1].attributes["value"].text)
  end
end


