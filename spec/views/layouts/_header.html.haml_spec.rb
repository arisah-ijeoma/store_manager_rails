require 'rails_helper'

describe "layouts/_header.html.haml", type: :view do

  let(:admin_user) { create(:admin_user, first_name: "Matthew", last_name: "Lawrence") }
  let(:user) { create(:user, nick: "Big Jackson") }

  context "admin log in" do

    before do
      allow(view).to receive(:current_admin_user) { admin_user }
    end

    it do
      render
      expect(rendered).to have_content("Hi, Matthew Lawrence")
    end
  end

  context "user log in" do
    before do
      allow(view).to receive(:current_user) { user }
    end

    it do
      render
      expect(rendered).to have_content("Hi, Big Jackson")
    end
  end
end
