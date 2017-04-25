module Components
  class Footer < Hyperloop::Component

    include HyperRouter::ComponentMethods

    param :incomplete_count, type: Integer

    def render
      footer(class: :footer) do # render a footer tag
        # display the todo count
        #   notice we can shorten span(class: 'todo-count') haml style
        span.todo_count do
          "#{params.incomplete_count} item#{'s' unless params.incomplete_count == 1} left"
        end
        # then display an unsorted list of the three footer links.
        #   again we pass the 'filter' class 'haml style'
        ul.filters do
          li { NavLink('/all', active_class: :selected) { 'All' }}
          li { NavLink('/completed', active_class: :selected)  { 'Completed' }}
          li { NavLink('/active', active_class: :selected) { 'Active' }}
        end
      end
    end
  end
end
