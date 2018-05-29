require 'rails_helper'

RSpec.feature "Visitor navigates to product details page from home", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99                                
      )
    end
  end
  
  
  scenario  "They navigate" do
    # ACT
    visit root_path
    first_title = page.first('h4')
    # store name of product for later verification
    product_name = first_title.text
    first_title.click
    

    # DEBUG
    # sleep 2
    # save_screenshot
    # puts page.html
    
    # VERIFY
    expect(page).to have_css 'section.products-show', count: 1
    expect(page).to have_text product_name
  end
end
