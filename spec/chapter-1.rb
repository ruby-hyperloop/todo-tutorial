require 'spec_helper'

describe 'chapter 1', :js => true do

  it 'todo.rb has been moved to the models/public folder (made public)' do

    # Build and mount a test component that will render the
    # todo count and the first todos title.

    # mount takes a component name, and optional component parameters, and mounting params.
    # if a block is provided, the code in the block is compiled to JS and sent to the client
    # in advance

    mount "TodoTest" do
      class TodoTest < React::Component::Base
        def render
          "The Todo model is #{'not' unless defined?(Todo) && (Todo < ActiveRecord::Base)} public!"
        end
      end
    end
    page.should have_content("The Todo model is public!")

  end

  it 'reactive-record has been installed' do

    5.times { FactoryGirl.create(:todo) }

    mount "RRTest" do
      class RRTest < React::Component::Base
        def render
          "#{Todo.all.count} Todos.  First Title = #{Todo.all.first.title}"
        end
      end
    end

    page.should have_content("#{Todo.all.count} Todos.  First Title = #{Todo.all.first.title}")

  end

  it 'reactive-router has been installed' do
    mount "RouterTest" do

      class RouterTest
        include React::Router

        routes(path: "/:react_test/:driver_id") do
          route(path: "test", name: :test, handler: Test)
          redirect(from: "/:react_test/:driver_id", to: :test)
        end

        def show
          route_handler
        end
      end

      class Test < React::Component::Base
        def render
          "Testing Testing 123"
        end
      end

    end

    page.should have_content("Testing Testing 123")

  end
end
