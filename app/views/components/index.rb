module Components
  # We will call our top level component Index following rails tradition.
  class Index < React::Component::Base

    define_state :new_todo  # new_todo will always hold an empty unsaved todo
    export_state :filter    # filter will now act like a redux store

    before_mount do
      # initialize our state/stores
      state.new_todo! Todo.new(completed: false)
      Index.filter! :all
    end

    def render
      section.todo_app do
        header.header do
          h1 { "Todos" }
          # Display an EditItem component in the header, and
          # as each Todo is saved, update the value of the new_todo state
          EditItem(todo: state.new_todo).
          on(:save) { state.new_todo! Todo.new(completed: false) }
        end
        ul.todo_list do
          # send the current filter name to the Todo class to get the
          # current todos for that scope
          Todo.send(Index.filter).each do |todo|
            TodoItem todo: todo
          end
        end
        # pass the current value of filter, and the active todo count down to the footer
        Footer current_filter: Index.filter, incomplete_count: Todo.active.count
      end
    end
  end
end
