require 'rails_helper'

describe "admin/users/show.html.haml", type: :view do
  let(:admin_user) { create(:admin_user) }
  let(:user) { create(:user, first_name: "Nicki", last_name: "Minaj", admin_user: admin_user) }

  before do
    assign(:user, user)
  end

  it do
    render
    expect(rendered).to have_content("Nicki Minaj's Profile")
  end
end
