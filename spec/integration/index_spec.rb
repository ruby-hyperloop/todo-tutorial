require 'spec_helper'

describe 'the todo app', :js => true do

    it 'shows the active todos as checked' do
      3.times { FactoryGirl.create(:todo, completed: false) }
      1.times { FactoryGirl.create(:todo, completed: true) }
      visit "/todos"
      Todo.all.each do |todo|
        page.should have_content(todo.title)
      end
      page.all(":checked").count.should eq(1)
      sleep(2)
    end

    it "displays the active todos in the footer" do
      3.times { FactoryGirl.create(:todo, completed: false) }
      1.times { FactoryGirl.create(:todo, completed: true) }
      visit "/todos"
      page.should have_content("3 items left")
      sleep(2)
    end

    it "can add a new todo" do
      visit "/todos"
      2.times do |i|
        input = find(".edit")
        input.set("new todo - #{i}")
        input.native.send_keys(:return)
        wait_for_ajax
      end

      Todo.all.count.should eq(2)
      Todo.all.last.title.should eq("new todo - 1")
      page.should have_content("new todo - 1")
      page.should have_content("2 items left")
      sleep(2)
    end

    it "changes scope when the user clicks a link" do
      3.times { FactoryGirl.create(:todo, completed: false) }
      1.times { FactoryGirl.create(:todo, completed: true) }
      visit "/todos"
      find("a", text: "Completed").click
      sleep(2)
      page.all("li.todo-item").count.should eq(1)
      find("a", text: "Active").click
      sleep(2)
      page.all("li.todo-item").count.should eq(3)
      find("a", text: "All").click
      sleep(2)
      page.all("li.todo-item").count.should eq(4)
    end

end
