require 'rails_helper'

describe "Transactions", type: :feature do
  let(:admin) { create(:admin_user) }
  let(:employee) { create(:user, first_name: 'Angel', admin_user: admin) }
  let(:employee_2) { create(:user, first_name: 'Mia', admin_user: admin) }
  let!(:item) { create(:item, name: 'Fish Fillets', admin_user: admin) }
  let!(:old_transaction) { create(:transaction, admin_user: admin, user: employee_2, updated_at: 'Mon, 8 Aug 2016 18:27:52 UTC +00:00') }

  scenario "quantity sold is shown for seller" do
    who_sold_what
  end

  scenario "daily transaction view doesn't show old transactions" do
    who_sold_what
    expect(page).not_to have_content('Mia')

    click_on 'View All Transactions'
    expect(page).to have_content('Mia')
  end

  def who_sold_what
    visit root_path
    login employee

    when_employee_sells
    then_sales_should_be_recorded

    click_on 'Log Out'
    click_on 'Log in as Admin'
    admin_login admin

    when_admin_sells
    then_daily_transaction_should_be_updated
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

  def then_daily_transaction_should_be_updated
    click_on "View Today's Transactions"
    expect(page).to have_content(item.name)
    expect(page).to have_content('Angel')
    expect(page).to have_content(admin.first_name)
    expect(page).to have_content(1)
    expect(page).to have_content(2)
  end
end
