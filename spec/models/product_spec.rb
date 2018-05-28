require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    context 'with a valid Product' do
      it 'saves a valid Product successfully' do
        cat = Category.create! name: 'Things'
        cat.products.create name: 'Widget',
                            quantity: 5,
                            price: 1000

        expect(Product.count).to eq(1)
      end
    end

    context 'with an invalid Product' do
      
      it 'raises error for missing name' do
        cat = Category.create! name: 'Things'
        p = cat.products.create quantity: 5,
                                price: 1000
        expect(Product.all).to be_empty
        expect(p.errors.full_messages).to include("Name can't be blank")
      end
      
      it 'raises error for missing category' do
        p = Product.create name: 'Widget',
                                quantity: 5,
                                price: 1000
        expect(Product.all).to be_empty
        expect(p.errors.full_messages).to include("Category can't be blank")
      end

      it 'raises error for missing quantity' do
        cat = Category.create! name: 'Things'
        p = cat.products.create name: 'Widget',
                                price: 1000
        expect(Product.all).to be_empty
        expect(p.errors.full_messages).to include("Quantity can't be blank")
      end

      it 'raises error for missing price' do
        cat = Category.create! name: 'Things'
        p = cat.products.create name: 'Widget',
                                quantity: 5
        expect(Product.all).to be_empty
        expect(p.errors.full_messages).to include("Price can't be blank")
      end

      it 'raises error for non-number price' do
        cat = Category.create! name: 'Things'
        p = cat.products.create name: 'Widget',
                                quantity: 5,
                                price: 'five'
        expect(Product.all).to be_empty
        expect(p.errors.full_messages).to include("Price is not a number")
      end
    end
  end
end
