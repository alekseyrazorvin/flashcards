require 'rails_helper'

describe Deck do

  let!(:user) { create :user }
  let!(:deck) { create(:deck, user: user) }

  before(:each) do
    visit root_path
    click_link "Войти"
    fill_in "email", with: user.email
    fill_in "password", with: "1234"
    click_button "Login"
  end

  describe '#index' do
    it "Can see all decks" do
      click_link "Все колоды"
      expect(page).to have_content deck.title
      expect(page).to have_content "Изменить название"
      expect(page).to have_content "Удалить"
    end
  end


  describe '#new' do
    it 'can add new deck' do
      visit root_path
      click_link "Все колоды"
      click_link "Новая колода"
      fill_in "deck_title", with: deck.title
      click_button "Save"
      expect(page).to have_content deck.title
    end
  end

  describe '#edit' do
    it 'can edit title deck' do
      visit root_path
      click_link "Все колоды"
      click_link "Изменить название"
      fill_in "deck_title", with: "абырвалг"
      click_button "Save"
      expect(page).to have_content "абырвалг"
    end
  end

  describe '#destroy' do
    it 'can destroy deck' do
      visit root_path
      click_link "Все колоды"
      click_link "Удалить"
      expect(page).to_not have_content "Фрукты"
    end
  end


  describe '#set current deck' do
    it "title current deck show bold" do
      visit root_path
      click_link "Все колоды"
      click_link "Сделать колоду текущей"
      expect(page).to_not have_css("col-md-7 b", :text => "Фрукты")
    end
  end

  describe "#reset current deck" do
    it 'title unselected deck' do
      visit root_path
      click_link "Все колоды"
      click_link "Сделать колоду текущей"
      click_link "Не использовать колоду"
      expect(page).to_not have_css("col-md-7 b")
    end
  end


end