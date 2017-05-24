module Components
  class Footer < Hyperloop::Component

    include HyperRouter::ComponentMethods

    def link_item(path)
      # helper method to display a link with camelized title
      # the router NavLink component takes care of setting class
      LI { NavLink("/#{path}", active_class: :selected) { path.camelize } }
    end

    render(FOOTER, class: :footer) do # render a footer tag
      # display the todo count
      SPAN(class: 'todo-count') do
        "#{Todo.active.count} #{'item'.pluralize Todo.active.count} left"
      end
      # then display an unsorted list of the three footer links.
      UL(class: :filters) do
        link_item(:all)
        link_item(:completed)
        link_item(:active)
      end
    end
  end
end
