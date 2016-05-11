module Components
  class Footer < React::Component::Base

    param :current_filter,    type: Symbol
    param :incomplete_count,  type: Integer

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
          li { FooterLink(filter: :all, current_filter: params.current_filter) }
          li { FooterLink(filter: :completed, current_filter: params.current_filter) }
          li { FooterLink(filter: :active, current_filter: params.current_filter) }
        end
      end
    end
  end
end
