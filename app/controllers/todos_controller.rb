class TodosController < ApplicationController
  def action_missing(name)
    render_component
  end
  def appdd
    render_component  # by default render_component will expect a component named 'App'
  end
end
