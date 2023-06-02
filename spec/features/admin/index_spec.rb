require "rails_helper"

RSpec.describe "Admin Dashboard Index Page" do
  before(:each) do
    @customer_1 = create(:customer) # 6 successful transactions
    @customer_2 = create(:customer) # 5 successful transactions
    @customer_3 = create(:customer) # 4 successful transactions
    @customer_4 = create(:customer) # 3 successful transactions
    @customer_5 = create(:customer) # 2 successful transactions
    @customer_6 = create(:customer) # 1 successful transactions
    @customer_7 = create(:customer) # 0 successful transactions

    @invoice_1 = @customer_1.invoices.create!(status: 1)
    @invoice_2 = @customer_2.invoices.create!(status: 1)
    @invoice_3 = @customer_3.invoices.create!(status: 1)
    @invoice_4 = @customer_4.invoices.create!(status: 1)
    @invoice_5 = @customer_5.invoices.create!(status: 1)
    @invoice_6 = @customer_6.invoices.create!(status: 1)
    @invoice_7 = @customer_7.invoices.create!(status: 1)

    @transaction_1 = @invoice_1.transactions.create!(result: "success")
    @transaction_2 = @invoice_1.transactions.create!(result: "success")
    @transaction_3 = @invoice_1.transactions.create!(result: "success")
    @transaction_4 = @invoice_1.transactions.create!(result: "success")
    @transaction_5 = @invoice_1.transactions.create!(result: "success")
    @transaction_6 = @invoice_1.transactions.create!(result: "success")
    @transaction_7 = @invoice_2.transactions.create!(result: "success")
    @transaction_8 = @invoice_2.transactions.create!(result: "success")
    @transaction_9 = @invoice_2.transactions.create!(result: "success")
    @transaction_10 = @invoice_2.transactions.create!(result: "success")
    @transaction_11 = @invoice_2.transactions.create!(result: "success")
    @transaction_12 = @invoice_3.transactions.create!(result: "success")
    @transaction_13 = @invoice_3.transactions.create!(result: "success")
    @transaction_14 = @invoice_3.transactions.create!(result: "success")
    @transaction_15 = @invoice_3.transactions.create!(result: "success")
    @transaction_16 = @invoice_4.transactions.create!(result: "success")
    @transaction_17 = @invoice_4.transactions.create!(result: "success")
    @transaction_18 = @invoice_4.transactions.create!(result: "success")
    @transaction_19 = @invoice_5.transactions.create!(result: "success")
    @transaction_20 = @invoice_5.transactions.create!(result: "success")
    @transaction_21 = @invoice_6.transactions.create!(result: "success")
    @transaction_22 = @invoice_7.transactions.create!(result: "failed")
  end

  describe "Admin Dashboard Display" do
    # User Story 19
    it "displays a header indicating that it is the admin dashboard" do
      visit admin_path

      expect(page).to have_content("Admin Dashboard")
    end

    # User Story 20
    it "displays a link to the admin merchants index page" do
      visit admin_path

      expect(page).to have_link("Merchants", href: admin_merchants_path)
      click_link("Merchants")
      expect(page).to have_current_path(admin_merchants_path)
    end

    it "displays a link to the admin invoices index page" do
      visit admin_path

      expect(page).to have_link("Invoices", href: admin_invoices_path)
      click_link("Invoices")
      expect(page).to have_current_path(admin_invoices_path)
    end
  end

  describe "Admin Dashboard Statistics" do
    # User Story 21
    it "displays the names and # of successful transactions for the top five costumers" do
      visit admin_path
      
      within("#top-five-customers") do
        expect(page).to have_content("Top Customers")

        expect(page).to have_content("1. #{@customer_1.first_name} #{@customer_1.last_name} - 6 purchases")
        expect(page).to have_content("2. #{@customer_2.first_name} #{@customer_2.last_name} - 5 purchases")
        expect(page).to have_content("3. #{@customer_3.first_name} #{@customer_3.last_name} - 4 purchases")
        expect(page).to have_content("4. #{@customer_4.first_name} #{@customer_4.last_name} - 3 purchases")
        expect(page).to have_content("5. #{@customer_5.first_name} #{@customer_5.last_name} - 2 purchases")
        expect(page).to_not have_content("#{@customer_6.first_name} #{@customer_6.last_name}")
        expect(page).to_not have_content("#{@customer_7.first_name} #{@customer_7.last_name}")

        expect(@customer_1.last_name).to appear_before(@customer_2.last_name)
        expect(@customer_2.last_name).to appear_before(@customer_3.last_name)
        expect(@customer_3.last_name).to appear_before(@customer_4.last_name)
        expect(@customer_4.last_name).to appear_before(@customer_5.last_name)
      end
    end
  end
end