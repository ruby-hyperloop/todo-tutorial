require 'spec_helper'

describe 'chapter 1', :js => true do

  it 'todo.rb has been moved to the hyperloop/models folder (made public)' do

    # Build and mount a test component that will render the
    # todo count and the first todos title.

    # mount takes a component name, and optional component parameters, and mounting params.
    # if a block is provided, the code in the block is compiled to JS and sent to the client
    # in advance

    mount "TodoTest" do
      class TodoTest < Hyperloop::Component
        def render
          "The Todo model is #{'not' unless defined?(Todo) && (Todo < ActiveRecord::Base)} public!"
        end
      end
    end
    page.should have_content("The Todo model is public!")

  end

  it 'hyperloop models are running' do

    5.times { FactoryGirl.create(:todo) }

    mount "RRTest" do
      class RRTest < Hyperloop::Component
        def render
          "#{Todo.all.count} Todos.  First Title = #{Todo.all.first.title}"
        end
      end
    end
    page.should have_content("#{Todo.all.count} Todos.  First Title = #{Todo.all.first.title}")

  end

  it 'hyper-router has been installed' do
    mount "RouterTest" do

      class RouterTest < Hyperloop::Router
        prerender_path :url_path, default: '/'
        history :browser

        route do
          DIV do
            Route('/:react_test/:driver_id', mounts: Home)
          end
        end
      end

      class Home < Hyperloop::Router::Component
        render do
          "Testing Testing 123"
        end
      end
    end

    page.should have_content("Testing Testing 123")

  end
end
