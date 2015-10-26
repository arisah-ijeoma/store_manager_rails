require 'rails_helper'

describe Ability do

  context "super admin" do
    let(:super_admin_user) { create(:super_admin_user) }
    let(:ability) { Ability.new(super_admin_user) }

    it "manages everything" do
      expect(ability.can?(:manage, :all)).to be true
    end
  end

  context "regular admin" do
    describe "Item" do
      let(:admin_user) { create(:admin_user) }
      let(:ability) { Ability.new(admin_user) }

      it "can not manage everything" do
        expect(ability.can?(:manage, :all)).to be false
      end

      it "manages items" do
        expect(ability.can?(:manage, Item)).to be true
      end

      it "manages users" do
        expect(ability.can?(:manage, User)).to be true
      end
    end
  end

  context "user" do
    describe "Items" do
      let(:user) { create(:user) }
      let(:ability) { Ability.new(user) }

      it "can sell items" do
        expect(ability.can?(:sell, Item)).to be true
      end

      it "can read items" do
        expect(ability.can?(:read, Item)).to be true
      end

      it "cannot create items" do
        expect(ability.can?(:create, Item)).to be false
      end

      it "cannot update items" do
        expect(ability.can?(:update, Item)).to be false
      end

      it "can update himself" do
        expect(ability.can?(:update, User)).to be true
      end

      it "cannot create himself" do
        expect(ability.can?(:create, User)).to be false
      end
    end
  end
end
