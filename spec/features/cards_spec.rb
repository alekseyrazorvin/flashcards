require 'rails_helper'


describe 'Card' do
  
  before(:all) do
    @card = create(:card)
  end
  
  describe '#home' do
    
    before(:each) do
      visit root_path
    end

    it "Shows link to train" do
      expect(page).to have_content "Флэшкарточкер"
    end

    it "Shows link to all cards" do
      expect(page).to have_content "Все карточки"
    end

    it "Shows link to add card" do
      expect(page).to have_content "Добавить карточку"
    end
  end

  

  describe '#index' do
    it "Can see all card" do
      visit root_path
      click_link "Все карточки"
      expect(page).to have_content "Все карточки"
      expect(page).to have_content @card.original_text
      expect(page).to have_content @card.translated_text
      expect(page).to have_content "Редактировать"
      expect(page).to have_content "Удалить"
    end
  end

  describe '#new' do
    before do
      visit root_path
      click_link "Добавить карточку"
      fill_in "card_original_text", with: @card.original_text
      fill_in "card_translated_text", with: @card.translated_text
      click_button "Create Card"
    end

    it "show new card" do
      expect(page).to have_content @card.original_text
      expect(page).to have_content @card.translated_text
    end
  end

   describe '#edit' do
    before do
      visit root_path
      click_link "Все карточки"
      first('.col-md-4').click_link "Редактировать"
      fill_in "card_original_text", with: @card.original_text
      fill_in "card_translated_text", with: @card.translated_text
      click_button "Update Card"
    end

    it "show edit card" do
      expect(page).to have_content @card.original_text
      expect(page).to have_content @card.translated_text
    end
  end

  
  describe '#destroy' do
    before do
      visit root_path
      click_link "Все карточки"
      first('.col-md-4').click_link "Удалить"
    end

    it "show all cards witout destroy card" do
      expect(page).to_not have_content @card.original_text
      expect(page).to_not have_content @card.translated_text
    end
  end

  describe '#train' do
    it "Shows translated_text card" do
      visit root_path
      expect(page).to have_content @card.translated_text
    end
  end

  describe "#check_answer" do

    context "when answer equals original text" do 
      before do
        visit root_path
        fill_in "q", with: @card.original_text
        click_button "Перевести"
      end

      it "shows ок" do
        expect(page).to have_content "Отлично! Ты знаешь это слово. Повтори через 3 дня"
      end
    end

    context "when answer not equals original text" do
      before(:each) do
        visit root_path
        fill_in "q", with: "абырвалг"
        click_button "Перевести"
      end

      it "shows not ok" do
        expect(page).to have_content "Это слово нужно повторить"
      end
    end

  end



end
