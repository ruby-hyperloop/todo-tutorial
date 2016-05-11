require 'spec_helper'

describe 'EditItem', :js => true do

  before(:each) do
    @todo = FactoryGirl.create(:todo)
    mount "EditItem", todo: @todo
  end

  it 'can change the todo title' do
    input = find(".edit")
    input.set("new capybara title")
    input.native.send_keys(:return)
    wait_for_ajax
    @todo.reload.title.should eq("new capybara title")
  end

  it 'raises the save event when the title changes' do
    input = find(".edit")
    input.set("new capybara title")
    input.native.send_keys(:return)
    event_history_for(:save).count.should eq(1)
    event_history_for(:cancel).count.should eq(0)
  end

  it 'raises the cancel event if the changes are abandonded' do
    input = find(".edit")
    input.set("not going to really change this")
    page.find('body').click
    event_history_for(:save).count.should eq(0)
    event_history_for(:cancel).count.should eq(1)
  end

end
