class TodosController < ApplicationController
  def index
    render_component  # by default render_component will expect a component named 'Index'
  end
end
