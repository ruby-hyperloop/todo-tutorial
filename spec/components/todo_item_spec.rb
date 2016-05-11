require 'spec_helper'

describe 'TodoItem', :js => true do

  before(:each) do
    @todo = FactoryGirl.create(:todo)
    mount "TodoItem", todo: @todo
  end

  it 'displays the title' do
    page.should have_content(@todo.title)
    sleep(4)
  end

  it 'can mark the todo as completed' do
    find("[type=checkbox]").click
    wait_for_ajax
    @todo.reload.completed.should be_truthy
    sleep(3)
  end

  it 'can delete the todo' do
    find(".destroy").click
    wait_for_ajax
    expect(Todo.all).to be_empty
    sleep(3)
  end

  it 'can change the todo title' do
    find("label").double_click
    input = find(".edit")
    input.set("new capybara title")
    input.native.send_keys(:return)
    page.should have_content("new capybara title")
    wait_for_ajax
    @todo.reload.title.should eq("new capybara title")
    sleep(3)
  end

end
