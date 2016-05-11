require 'spec_helper'

describe 'Footer', :js => true do

  it 'has the correct links' do
    mount "Footer", incomplete_count: 9, current_filter: :all
    page.should have_css("a.selected", text: "All")
    page.should have_css("a", text: "Completed")
    page.should have_css("a", text: "Active")
    page.save_screenshot "./spec/screen_shots/footer.png"
    sleep(4)
  end

  (0..2).each do |count|
    it "displays the pluralized incomplete count for #{count}" do
      mount "Footer", incomplete_count: count
      page.should have_content("#{count} #{'item'.pluralize(count)}")
      sleep(2)
    end
  end

  [:all, :completed, :active].each do |filter|
    it "highlights the #{filter} link" do
      mount "Footer", current_filter: filter
      page.should have_selector('a.selected', text: /#{filter}/i)
      sleep(2)
    end
  end

end
