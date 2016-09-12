require 'rails_helper'

describe User do

  let!(:user) { create :user }


  context 'action before login' do

    before(:each) do
      visit root_path
      click_link "Выйти"
    end

    describe '#before login' do
      it 'guest user dont see nav link train, cards, deck' do
        expect(page).to_not have_content "Тренироваться Все карточки Добавить карточку Все колоды"
      end
    end

    describe '#registration' do
      it 'show notice registration' do
        #visit root_path
        click_link "Регистрироваться"
        fill_in "user[email]", with: "new@new.com"
        fill_in "user_password", with: "1234"
        fill_in "user_password_confirmation", with: "1234"
        click_button "Create User"
        expect(page).to have_content "Ты зарегался на нашем сервисе"
      end
    end

    describe '#login' do
      it 'show notice login' do
        #visit root_path
        click_link "Войти"
        fill_in "email", with: user.email
        fill_in "password", with: "1234"
        click_button "Login"
        expect(page).to have_content 'Вы в системе. Начните тренировку'
      end
    end
  end

  context 'action before Github login' do

    describe '#github registration' do
      it 'show notice registration with githib'do

      end
    end

    describe '#github login'do
      it 'show notice login with github' do

      end
    end
  end

  context 'action when login'
    before(:each) do
      visit root_path
      click_link "Войти"
      fill_in "email", with: user.email
      fill_in "password", with: "1234"
      click_button "Login"
    end

    describe '#update' do
      it 'show notice update' do
        click_link user.email
        fill_in "user[email]", with: user.email
        fill_in "user_password", with: "12345"
        fill_in "user_password_confirmation", with: "12345"
        click_button "Update User"
        expect(page).to have_content "Данные обновлены"
      end
    end

    describe "#logout" do
      it 'show notice logout' do
        click_link "Выйти"
        expect(page).to have_content "Зарегестрируйтесь у нас. Или залогинтесь. И запоминайте слова."
      end
    end


end