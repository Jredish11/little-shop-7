require "rails_helper"

RSpec.describe "Merchant Items New Page" do
  describe "Merchant Items New Item Creatation", type: :feature do
    before(:each) do 
      @merchant_1 = create(:merchant)
      # @item_1 = create(:item, merchant: @merchant_1, status: :enabled)
    end

    #US 11
    it "displays an empty form to create a new item" do
      visit new_merchant_item_path(@merchant_1)
      save_and_open_page

      expect(page).to have_content("Create New Item")
      expect(page).to have_field("Name")
      expect(page).to have_field("Description")
      expect(page).to have_field("Current Price")
      expect(page).to have_button("Submit")
    end

    it "user can fill out form to create a new item, click submit redirecting to the items index page" do

    end
  end
end