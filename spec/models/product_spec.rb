require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    context 'with a valid Product' do
      it 'saves a valid Product successfully' do
        cat = Category.create! name: 'Things'
        cat.products.create name: 'Widget',
                            description: 'This is a widget',
                            quantity: 5,
                            price: 1000

        expect(Product.count).to eq(1)
      end
    end

    context 'with an invalid Product' do
      # pending 'raises error for invalid name'
    end
  end
end
