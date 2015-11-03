require 'rails_helper'

describe "admin/profiles/_profile_details.html.haml", type: :view do
  let(:profile) { admin_user.profile }

  before do
    assign(:profile, profile)
  end

  context "regular admin" do
    let(:admin_user) { create(:admin_user) }

    it do
      render
      expect(rendered).to have_link("My Employees", href: admin_users_path)
    end
  end

  context "super admin" do
    let(:admin_user) { create(:super_admin_user) }

    it do
      render
      expect(rendered).to have_content("My Employees")
      expect(rendered).not_to have_link(admin_users_path)
    end
  end
end
