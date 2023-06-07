require "rails_helper"

RSpec.describe "Merchant Items Index Page" do
  describe "Merchant Items Index Display", type: :feature do
    before(:each) do 
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1, status: :enabled)
      @item_2 = create(:item, merchant: @merchant_1, status: :disabled)
      @item_3 = create(:item, merchant: @merchant_1, status: :disabled)
      @item_4 = create(:item, merchant: @merchant_1, status: :enabled)
      @item_5 = create(:item, merchant: @merchant_2, status: :disabled)
      @item_6 = create(:item, merchant: @merchant_2, status: :enabled)
      @item_7 = create(:item, merchant: @merchant_2, status: :disabled)
      @item_8 = create(:item, merchant: @merchant_2, status: :enabled)
    end
    # User Story 6
    it "displays a list of the names of all my items" do
      visit merchant_items_path(@merchant_1) 
      expect(page).to have_content("My Items")
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      # expect(page).to_not have_content(@item_3.name)
    end
    #User Story 7
    it "display link of items name, redirects to merchant items show page" do
    visit merchant_items_path(@merchant_1)

    click_link @item_1.name

    expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
    end

    #User Story 9
    it "displays next to each item name a button to disable or enable the item" do
      visit merchant_items_path(@merchant_2)
      
        expect(page).to have_button("Disable")
        expect(page).to have_button("Enable")
    end
    
    it "when user clicks button they are redirected back to the items index, see items status change" do
      visit merchant_items_path(@merchant_2)
      
      within "#disabled_items" do
        click_button("Enable", id: "enable_button#{@item_5.id}")

        expect(current_path).to eq(merchant_items_path(@merchant_2))
        expect(page).to have_content("disabled")
      end
    

      visit merchant_items_path(@merchant_1)
      
      within "#enabled_items" do
        click_button("Disable", id: "disable_button#{@item_1.id}")
      
        expect(current_path).to eq(merchant_items_path(@merchant_1))
        expect(page).to have_content("enabled")
      end
    end
  end

    #US 10 
  describe "Merchant items grouped by status" do
    before(:each) do 
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1, status: :enabled)
      @item_2 = create(:item, merchant: @merchant_1, status: :disabled)
      @item_3 = create(:item, merchant: @merchant_1, status: :disabled)
      @item_4 = create(:item, merchant: @merchant_1, status: :enabled)
    end 
    it "displays two sections, 'Enabled Items' and 'Disabled Items'" do

      visit merchant_items_path(@merchant_1)
    
      within "#enabled_items" do
        expect(page).to have_button("Disable")
        
        click_button("Disable", id: "disable_button#{@item_1.id}")
        expect(current_path).to eq(merchant_items_path(@merchant_1))
      end

      within "#disabled_items" do
        expect(page).to have_button("Enable")

        click_button("Enable", id: "enable_button#{@item_3.id}")
        expect(current_path).to eq(merchant_items_path(@merchant_1))
      end
    end
  end

  #US 11
  describe "new item link" do
    before(:each) do 
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1, status: :enabled)
      @item_2 = create(:item, merchant: @merchant_1, status: :disabled)
      @item_3 = create(:item, merchant: @merchant_1, status: :disabled)
      @item_4 = create(:item, merchant: @merchant_1, status: :enabled)
    end 
    it "displays a link to create a new item" do
      visit merchant_items_path(@merchant_1)
      
      within "#new_item_link" do
        expect(page).to have_link("New Item")
      end
    end
    
    it "user clicks link and sent to new item page" do
      visit merchant_items_path(@merchant_1)
      
      within "#new_item_link" do
        click_link("New Item")
        expect(current_path).to eq(new_merchant_item_path(@merchant_1))
      end
    end
  end

  # describe "new created item" do
  #   it "displays the newly created item in the list of items" do
  #     visit new_merchant_item_path(@merchant_2)
      
  #     fill_in "Name", with: "Cool Beans"
  #     fill_in "Description", with: "nice"
  #     fill_in "Current Price", with: "8888"
      
  #     click_button("Submit")
  #     save_and_open_page

  #     expect(current_path).to eq(merchant_items_path(@merchant_2))
  #     expect(page).to have_content("Cool Beans")
  #   end
  # end
end