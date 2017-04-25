require 'models/todo'
module Components
  class TodoItem < Hyperloop::Component

    param :todo, type: Todo
    state editing: false

    def render
      li.todo_item do
        # change what we render depending on the state of editing
        if state.editing
          # the EditItem will emit either the save or cancel events
          # when editing completes.  We use this to stop editing
          EditItem(todo: params.todo).
          on(:save) { state.editing! false }.
          on(:cancel) { state.editing! false }
        else
          input.toggle(type: :checkbox, checked: params.todo.completed).
          on(:click) do
            # update our todo param's completed value and save it
            params.todo.completed = !params.todo.completed
            params.todo.save
          end
          # when the user double clicks on the todo tile change our state to editing
          label { params.todo.title }.on(:doubleClick) { state.editing! true }
          # and when the user clicks on the destroy anchor tag, destroy the todo
          a.destroy.on(:click) { params.todo.destroy }
        end
      end
    end
  end
end
