require 'spec_helper'

describe 'FooterLink', :js => true do

  it 'uses the selected class if current_filter == filter' do
    mount "FooterLink", filter: :foo, current_filter: :foo do
      ComponentHelpers.add_class(:selected, color: "#f00", font_weight: :bold)
    end
    find("a.selected").should have_content("Foo")
    sleep(3)
  end

  it 'does not use the selected class if current_filter != filter' do
    mount "FooterLink", filter: :bar, current_filter: :foo do
      ComponentHelpers.add_class(:selected, color: "#f00", font_weight: :bold)
    end
    find("a").should have_content("Bar")
    page.should_not have_selector("a.selected")
    sleep(3)
  end

end
