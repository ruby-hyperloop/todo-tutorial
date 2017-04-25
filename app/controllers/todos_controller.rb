class TodosController < ApplicationController
  def app
    render_component  # by default render_component will expect a component named 'App'
  end
end
