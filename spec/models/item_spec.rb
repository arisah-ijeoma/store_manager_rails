require 'rails_helper'

describe Item, type: :model do
  context 'valid items' do
    describe 'has a category' do
      it do
        item = create(:item)
        expect(item.category).to eq('Music')
      end
    end

    describe 'capitalizes' do
      it do
        item = create(:valid_item_name_case)
        expect(item.name).to eq('My Item Name')
      end
    end

    describe 'captilizing does not affect acronyms' do
      it do
        item = create(:valid_item_name_case)
        expect(item.brand).to eq('DMX')
      end
    end

    context 'brands' do
      describe 'no brand' do
        it do
          item = create(:item)
          expect(item.brand).to eq('--')
        end
      end

      describe 'empty brand' do
        it do
          item = create(:valid_item_empty_brand)
          expect(item.brand).to eq('--')
        end
      end
    end
  end

  context 'invalid items' do
    describe  'invalid characters' do
      it 'raises an error' do
        expect{
          create(:invalid_item_value)
        }.to raise_error('Validation failed: Quantity is not a number')
      end
    end

    describe 'duplicate item name' do
      let(:admin) { create(:admin_user) }
      let!(:item) { create(:item, admin_user: admin) }

      it 'raises an error' do
        expect{
          create(:item, admin_user: admin, name: 'cassette')
        }.to raise_error('Validation failed: Name This item already exists')
      end
    end

    describe '#min_qty_reached?' do
      let(:item) { create(:item, quantity: 1) }

      it do
        expect(item.min_qty_reached?).to be true
      end
    end
  end
end
