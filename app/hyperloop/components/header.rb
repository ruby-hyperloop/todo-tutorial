module Components
  class Header < Hyperloop::Component

    # The Header always has a new Todo ready to edit,
    # which is kept in a 'state' variable.
    # When the new Todo is saved, then it is replaced by
    # another new Todo.

    state(:new_todo) { Todo.new } # initialize when Header is mounted

    render(HEADER, class: :header) do
      H1 { "Todos" }
      # Display an EditItem component in the header, and
      # as each Todo is saved, update the value of the new_todo state
      EditItem(todo: state.new_todo)
      .on(:save) { mutate.new_todo Todo.new }
    end
  end
end
