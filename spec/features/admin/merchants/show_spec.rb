require 'rails_helper'

RSpec.describe "Admin Merchant Show Page", type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
  end

  describe "A link on the index page leads to each merchant's show page" do
    it "displays the name of a specific merchant" do
      visit admin_merchants_path
      click_link(@merchant_1.name)

      expect(current_path).to eq(admin_merchant_path(@merchant_1))
      expect(page).to have_content("#{@merchant_1.name}'s Show Page")
      expect(page).to_not have_content("#{@merchant_2.name}'s Show Page")

      visit admin_merchants_path
      click_link(@merchant_2.name)

      expect(current_path).to eq(admin_merchant_path(@merchant_2))
      expect(page).to have_content("#{@merchant_2.name}'s Show Page")
      expect(page).to_not have_content("#{@merchant_1.name}'s Show Page")
    end
  end
end