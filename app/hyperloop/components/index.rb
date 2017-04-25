module Components
  class App < Hyperloop::Router

    history :browser

    state :new_todo  # new_todo will always hold an empty unsaved todo

    before_mount do
      # initialize our state/stores
      state.new_todo! Todo.new(completed: false)
    end

    route do
      section.todo_app do
        header.header do
          h1 { "Todos" }
          # Display an EditItem component in the header, and
          # as each Todo is saved, update the value of the new_todo state
          EditItem(todo: state.new_todo).
          on(:save) { state.new_todo! Todo.new(completed: false) }
        end
        Route('/', exact: true) { Redirect('/all') }
        Route('/:filter', mounts: Index) # maybe pass block to validate here...
        # pass the current value of filter, and the active todo count down to the footer
        Footer incomplete_count: Todo.active.count
      end
    end
  end

  class Index < Hyperloop::Router::Component
    # We will call our top level component Index following rails tradition.
    render(UL, class: 'todo-list') do
      # send the current filter name to the Todo class to get the
      # current todos for that scope
      Todo.send(match.params[:filter]).each do |todo|
        TodoItem todo: todo
      end
    end
  end
end
