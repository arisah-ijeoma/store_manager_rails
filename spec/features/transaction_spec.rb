require 'rails_helper'

describe "Transactions", type: :feature do
  let(:admin) { create(:admin_user) }
  let(:employee) { create(:user, first_name: 'Angel', admin_user: admin) }
  let!(:item) { create(:item, name: 'Fish Fillets', admin_user: admin) }

  scenario "quantity sold is shown for seller" do
    visit root_path
    login employee

    when_employee_sells
    then_sales_should_be_recorded

    click_on 'Log Out'
    click_on 'Log in as Admin'
    admin_login admin

    when_admin_sells
    then_transaction_should_be_updated
  end

  def when_employee_sells
    click_on 'Sell'
    fill_in 'Quantity Sold', with: 1
    click_on 'Sold'
  end

  def then_sales_should_be_recorded
    expect(page).to have_content("You just sold 1 piece(s) of Fish Fillets")
  end

  def when_admin_sells
    click_on 'Sell'
    fill_in 'Quantity Sold', with: 2
    click_on 'Sold'
  end

  def then_transaction_should_be_updated
    click_on "View Today's Transactions"
    expect(page).to have_content(item.name)
    expect(page).to have_content('Angel')
    expect(page).to have_content(admin.first_name)
    expect(page).to have_content(1)
    expect(page).to have_content(2)
  end
end
