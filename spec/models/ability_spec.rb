require 'rails_helper'

describe Ability do

  context "super admin" do
    let(:super_admin_user) { create(:super_admin_user) }
    let(:ability) { Ability.new(super_admin_user) }

    it "should be able to manage everything" do
      expect(ability.can?(:manage, :all)).to be true
    end
  end

  context "regular admin" do
    describe "Item" do
      let(:admin_user) { create(:admin_user) }
      let(:ability) { Ability.new(admin_user) }

      it "should be able to manage items" do
        expect(ability.can?(:manage, Item)).to be true
      end
    end
  end

  context "user" do
    describe "Items" do
      let(:user) { create(:user) }
      let(:ability) { Ability.new(user) }

      it "should be able to update items" do
        expect(ability.can?(:update, Item)).to be true
      end
      it "should be able to read items" do
        expect(ability.can?(:read, Item)).to be true
      end
    end
  end
end
