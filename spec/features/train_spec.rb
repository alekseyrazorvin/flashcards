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
    card.update_columns(review_date: Date.today)
    visit root_path
  end

  describe "#trainig" do

    context "do not set current deck" do
      context "cards exist" do
        context "when answer equals original text" do
          it "shows ок" do
            Card.all
            fill_in "q", with: card.original_text
            click_button "Перевести"
            expect(page).to have_content "Отлично! Ты знаешь это слово. Повтори через 3 дня"
          end
        end

        context "when answer not equals original text" do
          it "shows not ok" do
            fill_in "q", with: "абырвалг"
            click_button "Перевести"
            expect(page).to have_content "Это слово нужно повторить"
          end
        end

      end

      context "cards in all deck is not exist" do
        describe 'show notice add cards' do

        end

      end
    end

    context "set current deck " do
      context "cards in deck exist" do

      end

      context "cards in deck is not exist" do
        describe 'show notice add cards' do

        end
      end
    end


  end
end