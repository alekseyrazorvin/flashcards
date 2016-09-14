require 'rails_helper'

describe Card do

  let!(:user) { create :user }
  let!(:card) { create(:card, user: user) }

  before(:each) do
    visit root_path
    click_link "Войти"
    fill_in "email", with: user.email
    fill_in "password", with: "1234"
    click_button "Login"
    visit root_path
  end

  describe '#index' do
    it "Can see all cards" do
      click_link "Все карточки"
      expect(page).to have_content card.original_text
      expect(page).to have_content card.translated_text
      expect(page).to have_content "Редактировать"
      expect(page).to have_content "Удалить"
    end
  end

  describe '#new' do
    before do
      click_link "Добавить карточку"
      fill_in "card_original_text", with: card.original_text
      fill_in "card_translated_text", with: card.translated_text
      click_button "Create Card"
    end

    it "show new card" do
      expect(page).to have_content card.original_text
      expect(page).to have_content card.translated_text
    end
  end

  describe '#edit' do
    before do
      click_link "Все карточки"
      click_link "Редактировать"
      fill_in "card_original_text", with: "I"
      fill_in "card_translated_text", with: "Я"
      click_button "Update Card"
    end

    it "show edit card" do
      expect(page).to have_content "I"
      expect(page).to have_content "Я"
    end
  end

  describe '#destroy' do
    it "show all cards witout destroy card" do
      click_link "Все карточки"
      click_link "Удалить"
      expect(page).to_not have_content card.original_text
      expect(page).to_not have_content card.translated_text
    end
  end

  describe '#train' do
    it "Shows translated_text card" do
      expect(page).to have_content card.translated_text
    end
  end
end
